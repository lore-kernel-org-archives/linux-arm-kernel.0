From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed,  5 Apr 2017 14:37:21 +0100
Subject: [PATCH v2 8/9] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <20170405133722.6406-1-punit.agrawal@arm.com>
References: <20170405133722.6406-1-punit.agrawal@arm.com>
Message-ID: <20170405133722.6406-9-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

Add VM_FAULT_HWPOISON[_LARGE] handling to the arm64 page fault
handler. Handling of VM_FAULT_HWPOISON[_LARGE] is very similar
to VM_FAULT_OOM, the only difference is that a different si_code
(BUS_MCEERR_AR) is passed to user space and si_addr_lsb field is
initialized.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/mm/fault.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4bf899fb451b..212c862b2fd0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
+#include <linux/hugetlb.h>
 
 #include <asm/bug.h>
 #include <asm/cpufeature.h>
@@ -194,9 +195,10 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
  */
 static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 			    unsigned int esr, unsigned int sig, int code,
-			    struct pt_regs *regs)
+			    struct pt_regs *regs, int fault)
 {
 	struct siginfo si;
+	unsigned int lsb = 0;
 
 	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
 		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
@@ -212,6 +214,17 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	si.si_errno = 0;
 	si.si_code = code;
 	si.si_addr = (void __user *)addr;
+	/*
+	 * Either small page or large page may be poisoned.
+	 * In other words, VM_FAULT_HWPOISON_LARGE and
+	 * VM_FAULT_HWPOISON are mutually exclusive.
+	 */
+	if (fault & VM_FAULT_HWPOISON_LARGE)
+		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+	else if (fault & VM_FAULT_HWPOISON)
+		lsb = PAGE_SHIFT;
+	si.si_addr_lsb = lsb;
+
 	force_sig_info(sig, &si, tsk);
 }
 
@@ -225,7 +238,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	 * handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs);
+		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs, 0);
 	else
 		__do_kernel_fault(mm, addr, esr, regs);
 }
@@ -427,6 +440,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		sig = SIGBUS;
 		code = BUS_ADRERR;
+	} else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
+		sig = SIGBUS;
+		code = BUS_MCEERR_AR;
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -437,7 +453,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, esr, sig, code, regs);
+	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
 	return 0;
 
 no_context:
-- 
2.11.0
