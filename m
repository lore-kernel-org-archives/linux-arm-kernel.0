From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Tue, 21 Feb 2017 16:36:45 -0700
Subject: [PATCH V2] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
Message-ID: <1487720205-14594-1-git-send-email-tbaicar@codeaurora.org>
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
---
 arch/arm64/mm/fault.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 156169c..ceaa82f 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -30,6 +30,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
+#include <linux/hugetlb.h>
 
 #include <asm/bug.h>
 #include <asm/cpufeature.h>
@@ -193,9 +194,10 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
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
@@ -211,6 +213,17 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
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
 
@@ -224,7 +237,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	 * handle this fault with.
 	 */
 	if (user_mode(regs))
-		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs);
+		__do_user_fault(tsk, addr, esr, SIGSEGV, SEGV_MAPERR, regs, 0);
 	else
 		__do_kernel_fault(mm, addr, esr, regs);
 }
@@ -426,6 +439,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		sig = SIGBUS;
 		code = BUS_ADRERR;
+	} else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
+		sig = SIGBUS;
+		code = BUS_MCEERR_AR;
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -436,7 +452,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, esr, sig, code, regs);
+	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
 	return 0;
 
 no_context:
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
