From: manjeet.p@samsung.com (Manjeet Pawar)
Date: Fri,  5 Oct 2018 10:15:57 +0530
Subject: [PATCH] traps:Recover undefined user instruction on ARM
References: <CGME20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba@epcas5p3.samsung.com>
Message-ID: <20181005045237epcas5p3bc0ab07cfb8c25ef81188b4614b978ba~anUhv_CDP0965009650epcas5p34@epcas5p3.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rohit Thapliyal <r.thapliyal@samsung.com> 

During user undefined instruction exception, the arm exception
handler currently results in application crash through SIGILL.
The bad instruction can be due to ddr/hardware issue.
For such cases, exception trap handler could try to recover the corrupted
text by clearing pagetable entry of undefined instruction pc and trying to fetch
the instruction opcode by generating major page fault.
Resulting in loading the page with correct instruction from mapped file.
If there is no error in root filesystem i.e. the opcode is intact
in file, then filemap fault shall be able to recover
the instruction and continue execution normally instead of crashing.

Signed-off-by: Rohit Thapliyal <r.thapliyal@samsung.com>
Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
---
 arch/arm/kernel/traps.c | 100 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index badf02c..d971834 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -29,6 +29,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/irq.h>
+#include <linux/rmap.h>
 
 #include <linux/atomic.h>
 #include <asm/cacheflush.h>
@@ -51,6 +52,9 @@
 };
 
 void *vectors_page;
+#define MAX_UNDEF_RECOVERY_ATTEMPT     NR_CPUS
+static DEFINE_RATELIMIT_STATE(undef_recov_rs, 10 * HZ, NR_CPUS);
+static int undef_recovery_attempt;
 
 #ifdef CONFIG_DEBUG_USER
 unsigned int user_debug;
@@ -435,14 +439,9 @@ int call_undef_hook(struct pt_regs *regs, unsigned int instr)
 	return fn ? fn(regs, instr) : 1;
 }
 
-asmlinkage void do_undefinstr(struct pt_regs *regs)
+static unsigned int getInstr(void __user *pc, struct pt_regs *regs)
 {
-	unsigned int instr;
-	siginfo_t info;
-	void __user *pc;
-
-	clear_siginfo(&info);
-	pc = (void __user *)instruction_pointer(regs);
+	unsigned int instr = 0;
 
 	if (processor_mode(regs) == SVC_MODE) {
 #ifdef CONFIG_THUMB2_KERNEL
@@ -472,11 +471,32 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 			goto die_sig;
 		instr = __mem_to_opcode_arm(instr);
 	}
+die_sig:
+	return instr;
+}
+
+asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
+{
+	unsigned int instr, instr2;
+	siginfo_t info;
+	void __user *pc;
+	unsigned long addr;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	spinlock_t *ptl;
+	clear_siginfo(&info);
 
-	if (call_undef_hook(regs, instr) == 0)
+	pc = (void __user *)instruction_pointer(regs);
+
+	instr = getInstr(pc, regs);
+
+	if (instr && call_undef_hook(regs, instr) == 0)
 		return;
 
-die_sig:
 #ifdef CONFIG_DEBUG_USER
 	if (user_debug & UDBG_UNDEFINED) {
 		pr_info("%s (%d): undefined instruction: pc=%p\n",
@@ -485,7 +505,67 @@ asmlinkage void do_undefinstr(struct pt_regs *regs)
 		dump_instr(KERN_INFO, regs);
 	}
 #endif
-
+	/* Trying to recover an invalid userspace instruction from here */
+	if ((undef_recovery_attempt < MAX_UNDEF_RECOVERY_ATTEMPT) && __ratelimit(&undef_recov_rs)) {
+		addr = (unsigned long) pc;
+		if (processor_mode(regs) == USR_MODE) {
+			struct page *page = NULL;
+
+			mm = current->mm;
+			vma = find_vma(mm, (unsigned long)pc);
+			if (!vma)
+				goto fail_recovery;
+
+			if (!vma->vm_file)
+				goto fail_recovery;
+
+			dump_instr(KERN_ALERT, regs);
+			down_write(&mm->mmap_sem);
+			/* Check first, just in case, recovery already done by some other thread simultaneously */
+			flush_cache_range(vma, vma->vm_start, vma->vm_end);
+			instr2 = getInstr(pc, regs);
+			if (instr != instr2) {
+				up_write(&mm->mmap_sem);
+				return;
+			}
+			pgd = pgd_offset(vma->vm_mm, addr);
+			pud = pud_offset(pgd, addr);
+			if (!pud_present(*pud)) {
+				up_write(&mm->mmap_sem);
+				goto fail_recovery;
+			}
+			pmd = pmd_offset(pud, addr);
+			if (!pmd_present(*pmd)) {
+				up_write(&mm->mmap_sem);
+				goto fail_recovery;
+			}
+			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			if (!pte_present(*pte)) {
+				pte_unmap_unlock(pte, ptl);
+				up_write(&mm->mmap_sem);
+				goto fail_recovery;
+			}
+			page = pte_page(*pte);
+
+			pte_clear(mm, address, pte);
+			pte_unmap_unlock(pte, ptl);
+			pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
+			page_remove_rmap(page, false);
+			put_page(page);
+			pte_unmap_unlock(pte, ptl);
+
+			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
+			up_write(&mm->mmap_sem);
+
+			instr2 = getInstr(pc, regs);
+			dump_instr(KERN_ALERT, regs);
+			if (instr != instr2) {
+				undef_recovery_attempt++;
+				return;
+			}
+		}
+	}
+fail_recovery:
 	info.si_signo = SIGILL;
 	info.si_errno = 0;
 	info.si_code  = ILL_ILLOPC;
-- 
1.9.1
