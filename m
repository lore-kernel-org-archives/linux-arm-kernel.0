From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:54 +0000
Subject: [PATCH 6/9] arm64: mm: Rework unhandled user pagefaults to call
 arm64_force_sig_info
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reporting unhandled user pagefaults via arm64_force_sig_info means
that __do_user_fault can be drastically simplified, since it no longer
has to worry about printing the fault information and can consequently
just take the siginfo as a parameter.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 87 +++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index fd5928afd9cd..49dfb08a6c4d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -43,6 +43,7 @@
 #include <asm/system_misc.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
+#include <asm/traps.h>
 
 #include <acpi/ghes.h>
 
@@ -289,58 +290,31 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	do_exit(SIGKILL);
 }
 
-static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
-			    unsigned int esr, unsigned int sig, int code,
-			    struct pt_regs *regs, int fault)
+static void __do_user_fault(struct siginfo *info, unsigned int esr)
 {
-	struct siginfo si;
-	const struct fault_info *inf;
-	unsigned int lsb = 0;
-
-	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
-		inf = esr_to_fault_info(esr);
-		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x",
-			tsk->comm, task_pid_nr(tsk), inf->name, sig,
-			addr, esr);
-		print_vma_addr(KERN_CONT ", in ", regs->pc);
-		pr_cont("\n");
-		__show_regs(regs);
-	}
-
-	tsk->thread.fault_address = addr;
-	tsk->thread.fault_code = esr;
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	/*
-	 * Either small page or large page may be poisoned.
-	 * In other words, VM_FAULT_HWPOISON_LARGE and
-	 * VM_FAULT_HWPOISON are mutually exclusive.
-	 */
-	if (fault & VM_FAULT_HWPOISON_LARGE)
-		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-	else if (fault & VM_FAULT_HWPOISON)
-		lsb = PAGE_SHIFT;
-	si.si_addr_lsb = lsb;
-
-	force_sig_info(sig, &si, tsk);
+	current->thread.fault_address = (unsigned long)info->si_addr;
+	current->thread.fault_code = esr;
+	arm64_force_sig_info(info, esr_to_fault_info(esr)->name, current);
 }
 
 static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
-	const struct fault_info *inf;
-
 	/*
 	 * If we are in kernel mode at this point, we have no context to
 	 * handle this fault with.
 	 */
 	if (user_mode(regs)) {
-		inf = esr_to_fault_info(esr);
-		__do_user_fault(tsk, addr, esr, inf->sig, inf->code, regs, 0);
-	} else
+		const struct fault_info *inf = esr_to_fault_info(esr);
+		struct siginfo si = {
+			.si_signo	= inf->sig,
+			.si_code	= inf->code,
+			.si_addr	= (void __user *)addr,
+		};
+
+		__do_user_fault(&si, esr);
+	} else {
 		__do_kernel_fault(addr, esr, regs);
+	}
 }
 
 #define VM_FAULT_BADMAP		0x010000
@@ -393,7 +367,8 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
-	int fault, sig, code, major = 0;
+	struct siginfo si;
+	int fault, major = 0;
 	unsigned long vm_flags = VM_READ | VM_WRITE;
 	unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
@@ -525,27 +500,37 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		return 0;
 	}
 
+	clear_siginfo(&si);
+	si.si_addr = (void __user *)addr;
+
 	if (fault & VM_FAULT_SIGBUS) {
 		/*
 		 * We had some memory, but were unable to successfully fix up
 		 * this page fault.
 		 */
-		sig = SIGBUS;
-		code = BUS_ADRERR;
-	} else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
-		sig = SIGBUS;
-		code = BUS_MCEERR_AR;
+		si.si_signo	= SIGBUS;
+		si.si_code	= BUS_ADRERR;
+	} else if (fault & VM_FAULT_HWPOISON_LARGE) {
+		unsigned int hindex = VM_FAULT_GET_HINDEX(fault);
+
+		si.si_signo	= SIGBUS;
+		si.si_code	= BUS_MCEERR_AR;
+		si.si_addr_lsb	= hstate_index_to_shift(hindex);
+	} else if (fault & VM_FAULT_HWPOISON) {
+		si.si_signo	= SIGBUS;
+		si.si_code	= BUS_MCEERR_AR;
+		si.si_addr_lsb	= PAGE_SHIFT;
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
 		 * map.
 		 */
-		sig = SIGSEGV;
-		code = fault == VM_FAULT_BADACCESS ?
-			SEGV_ACCERR : SEGV_MAPERR;
+		si.si_signo	= SIGSEGV;
+		si.si_code	= fault == VM_FAULT_BADACCESS ?
+				  SEGV_ACCERR : SEGV_MAPERR;
 	}
 
-	__do_user_fault(tsk, addr, esr, sig, code, regs, fault);
+	__do_user_fault(&si, esr);
 	return 0;
 
 no_context:
-- 
2.1.4
