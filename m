From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 16 May 2013 12:06:34 +0100
Subject: [PATCH] ARM: remove the .vm_mm value from gate_vma.
Message-ID: <1368702394-1737-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If one reads /proc/$PID/smaps, the mmap_sem belonging to the
address space of the task being examined is locked for reading.
All the pages of the vmas belonging to the task's address space
are then walked with this lock held.

If a gate_vma is present in the architecture, it too is examined
by the fs/proc/task_mmu.c code. As gate_vma doesn't belong to the
address space of the task though, its pages are not walked.

A recent cleanup (commit f6604efe) of the gate_vma initialisation
code set the vm_mm value to &init_mm. Unfortunately a non-NULL
vm_mm value in the gate_vma will cause the task_mmu code to attempt
to walk the pages of the gate_vma (with no mmap-sem lock held). If
one enables Transparent Huge Page support and vm debugging, this
will then cause OOPses as pmd_trans_huge_lock is called without
mmap_sem being locked.

This patch removes the .vm_mm value from gate_vma, restoring the
original behaviour of the task_mmu code.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index f219703..282de48 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -411,7 +411,6 @@ static struct vm_area_struct gate_vma = {
 	.vm_start	= 0xffff0000,
 	.vm_end		= 0xffff0000 + PAGE_SIZE,
 	.vm_flags	= VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYEXEC,
-	.vm_mm		= &init_mm,
 };
 
 static int __init gate_vma_init(void)
-- 
1.8.1.4
