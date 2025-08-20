/*
  Warnings:

  - A unique constraint covering the columns `[labAssistantId]` on the table `LabAssistant` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[labAssistantId]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `slotType` to the `TimeSlot` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "public"."SlotType" AS ENUM ('Lab', 'Lecture', 'Tutorial');

-- DropForeignKey
ALTER TABLE "public"."ScheduleAssignment" DROP CONSTRAINT "ScheduleAssignment_labAssistantId_fkey";

-- AlterTable
ALTER TABLE "public"."TimeSlot" ADD COLUMN     "slotType" "public"."SlotType" NOT NULL,
ALTER COLUMN "isActive" SET DEFAULT true;

-- CreateIndex
CREATE UNIQUE INDEX "LabAssistant_labAssistantId_key" ON "public"."LabAssistant"("labAssistantId");

-- CreateIndex
CREATE UNIQUE INDEX "User_labAssistantId_key" ON "public"."User"("labAssistantId");

-- AddForeignKey
ALTER TABLE "public"."ScheduleAssignment" ADD CONSTRAINT "ScheduleAssignment_labAssistantId_fkey" FOREIGN KEY ("labAssistantId") REFERENCES "public"."LabAssistant"("labAssistantId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."User" ADD CONSTRAINT "User_labAssistantId_fkey" FOREIGN KEY ("labAssistantId") REFERENCES "public"."LabAssistant"("labAssistantId") ON DELETE SET NULL ON UPDATE CASCADE;
