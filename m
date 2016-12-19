From: maninder1.s@samsung.com (Maninder Singh)
Date: Mon, 19 Dec 2016 16:07:12 +0530
Subject: [PATCH 1/1] mm: call force_sig_info before prints
Message-ID: <1482143832-11158-1-git-send-email-maninder1.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

prints can delay queuing of signal, so better to print
after force_sig_info.

Let's say process generated SIGSEGV , and some other thread sends
SIGKILL to crashing process and it gets queued before SIGSEGV becuase
of little delay due to prints so in this case coredump might not generate.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Amit Nagal <amit.nagal@samsung.com>
Reviewed-by: Ajeet Yadav <ajeet.y@samsung.com>
---
 arch/arm/mm/fault.c   | 18 +++++++++---------
 arch/arm64/mm/fault.c | 16 ++++++++--------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 3a2e678..f92f90b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -163,6 +163,15 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 {
 	struct siginfo si;
 
+	tsk->thread.address = addr;
+	tsk->thread.error_code = fsr;
+	tsk->thread.trap_no = 14;
+	si.si_signo = sig;
+	si.si_errno = 0;
+	si.si_code = code;
+	si.si_addr = (void __user *)addr;
+	force_sig_info(sig, &si, tsk);
+
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -172,15 +181,6 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
 		show_regs(regs);
 	}
 #endif
-
-	tsk->thread.address = addr;
-	tsk->thread.error_code = fsr;
-	tsk->thread.trap_no = 14;
-	si.si_signo = sig;
-	si.si_errno = 0;
-	si.si_code = code;
-	si.si_addr = (void __user *)addr;
-	force_sig_info(sig, &si, tsk);
 }
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a78a5c4..eb5d0e3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -197,14 +197,6 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 {
 	struct siginfo si;
 
-	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
-			tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
-			addr, esr);
-		show_pte(tsk->mm, addr);
-		show_regs(regs);
-	}
-
 	tsk->thread.fault_address = addr;
 	tsk->thread.fault_code = esr;
 	si.si_signo = sig;
@@ -212,6 +204,14 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	si.si_code = code;
 	si.si_addr = (void __user *)addr;
 	force_sig_info(sig, &si, tsk);
+
+	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
+		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
+			tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
+			addr, esr);
+		show_pte(tsk->mm, addr);
+		show_regs(regs);
+	}
 }
 
 static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *regs)
-- 
1.9.1
