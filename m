From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu,  8 Jun 2017 18:25:27 +0100
Subject: [PATCH v3 2/4] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE] handling
In-Reply-To: <20170608172529.11986-1-punit.agrawal@arm.com>
References: <20170608172529.11986-1-punit.agrawal@arm.com>
Message-ID: <20170608172529.11986-3-punit.agrawal@arm.com>
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
(fix new __do_user_fault call-site)
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Steve Capper <steve.capper@arm.com>
Tested-by: Manoj Iyer <manoj.iyer@canonical.com>
---
 arch/arm64/mm/fault.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 37b95dff0b07..a85b44343ac6 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -31,6 +31,7 @@
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
+#include <linux/hugetlb.h>
 
 #include <asm/bug.h>
 #include <asm/cpufeature.h>
@@ -239,10 +240,11 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
  */
 static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 			    unsigned int esr, unsigned int sig, int code,
-			    struct pt_regs *regs)
+			    struct pt_regs *regs, int fault)
 {
 	struct siginfo si;
 	const struct fault_info *inf;
+	unsigned int lsb = 0;
 
 	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
 		inf = esr_to_fault_info(esr);
@@ -259,6 +261,17 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
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
 
@@ -274,7 +287,7 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	 */
 	if (user_mode(regs)) {
 		inf = esr_to_fault_info(esr);
-		__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs);
+		__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs, 0);
 	} else
 		__do_kernel_fault(mm, addr, esr, regs);
 }
@@ -461,6 +474,9 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		sig = SIGBUS;
 		code = BUS_ADRERR;
+	} else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
+		sig = SIGBUS;
+		code = BUS_MCEERR_AR;
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -471,7 +487,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 			SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, esr, sig, code, regs);
+	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
 	return 0;
 
 no_context:
-- 
2.11.0
