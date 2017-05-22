From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Mon, 22 May 2017 12:45:53 +0100
Subject: [PATCH 1/2] arm64: mm: print out correct page table entries
Message-ID: <1495453554-9412-1-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we take a fault that can't be handled, we print out the page table
entries associated with the faulting address. In some cases we currently
print out the wrong entries. For a faulting TTBR1 address, we sometimes
print out TTBR0 table entries instead, and for a faulting TTBR0 address
we sometimes print out TTBR1 table entries. Fix this by choosing the
tables based on the faulting address.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/system_misc.h |  2 +-
 arch/arm64/mm/fault.c                | 30 ++++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index bc812435bc76..d0beefeb6d25 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -40,7 +40,7 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 			   int sig, int code, const char *name);
 
 struct mm_struct;
-extern void show_pte(struct mm_struct *mm, unsigned long addr);
+extern void show_pte(unsigned long addr);
 extern void __show_regs(struct pt_regs *);
 
 extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 37b95dff0b07..0c32f34fb4af 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -80,14 +80,25 @@ static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
 #endif
 
 /*
- * Dump out the page tables associated with 'addr' in mm 'mm'.
+ * Dump out the page tables associated with 'addr' in the currently active mm.
  */
-void show_pte(struct mm_struct *mm, unsigned long addr)
+void show_pte(unsigned long addr)
 {
+	unsigned long ttbr_mask = ~0UL << VA_BITS;
+	struct mm_struct *mm;
 	pgd_t *pgd;
 
-	if (!mm)
+	if (!(addr & ttbr_mask)) {
+		/* TTBR0 */
+		mm = current->active_mm;
+	} else if ((addr & ttbr_mask) == ttbr_mask) {
+		/* TTBR1 */
 		mm = &init_mm;
+	} else {
+		/* Between TTBR0 and TTBR1, no table to walk */
+		pr_alert("[%08lx] address between TTBR ranges\n", addr);
+		return;
+	}
 
 	pr_alert("pgd = %p\n", mm->pgd);
 	pgd = pgd_offset(mm, addr);
@@ -196,8 +207,8 @@ static inline bool is_permission_fault(unsigned int esr, struct pt_regs *regs,
 /*
  * The kernel tried to access some page that wasn't present.
  */
-static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
-			      unsigned int esr, struct pt_regs *regs)
+static void __do_kernel_fault(unsigned long addr, unsigned int esr,
+			      struct pt_regs *regs)
 {
 	const char *msg;
 
@@ -227,7 +238,7 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
 	pr_alert("Unable to handle kernel %s at virtual address %08lx\n", msg,
 		 addr);
 
-	show_pte(mm, addr);
+	show_pte(addr);
 	die("Oops", regs, esr);
 	bust_spinlocks(0);
 	do_exit(SIGKILL);
@@ -249,7 +260,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
 			tsk->comm, task_pid_nr(tsk), inf->name, sig,
 			addr, esr);
-		show_pte(tsk->mm, addr);
+		show_pte(addr);
 		show_regs(regs);
 	}
 
@@ -265,7 +276,6 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
-	struct mm_struct *mm = tsk->active_mm;
 	const struct fault_info *inf;
 
 	/*
@@ -276,7 +286,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		inf = esr_to_fault_info(esr);
 		__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs);
 	} else
-		__do_kernel_fault(mm, addr, esr, regs);
+		__do_kernel_fault(addr, esr, regs);
 }
 
 #define VM_FAULT_BADMAP		0x010000
@@ -475,7 +485,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	return 0;
 
 no_context:
-	__do_kernel_fault(mm, addr, esr, regs);
+	__do_kernel_fault(addr, esr, regs);
 	return 0;
 }
 
-- 
2.1.4
