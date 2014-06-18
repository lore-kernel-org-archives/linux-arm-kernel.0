From: keescook@chromium.org (Kees Cook)
Date: Wed, 18 Jun 2014 13:27:48 -0700
Subject: [PATCH] arm: ptrace: fix syscall modification under
 PTRACE_O_TRACESECCOMP
Message-ID: <20140618202748.GA9022@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An x86 tracer wanting to change the syscall uses PTRACE_SETREGS
(stored to regs->orig_ax), and an ARM tracer uses PTRACE_SET_SYSCALL
(stored to current_thread_info()->syscall). When this happens, the
syscall can change across the call to secure_computing(), since it may
block on tracer notification, and the tracer can then make changes
to the process, before we return from secure_computing(). This
means the code must respect the changed syscall after the
secure_computing() call in syscall_trace_enter(). The same is true
for tracehook_report_syscall_entry() which may also block and change
the syscall.

The x86 code handles this (it expects orig_ax to always be the
desired syscall). In the ARM case, this means we should not be touching
current_thread_info()->syscall after its initial assignment. All failures
should result in a -1 syscall, though.

Based on patch by Ricky Zhou.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Ricky Zhou <rickyz@google.com>
Cc: stable at vger.kernel.org
---
 arch/arm/kernel/ptrace.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 0dd3b79b15c3..97bd95f6aa01 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -911,6 +911,7 @@ enum ptrace_syscall_dir {
 static int tracehook_report_syscall(struct pt_regs *regs,
 				    enum ptrace_syscall_dir dir)
 {
+	int ret = 0;
 	unsigned long ip;
 
 	/*
@@ -923,30 +924,35 @@ static int tracehook_report_syscall(struct pt_regs *regs,
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
 	else if (tracehook_report_syscall_entry(regs))
-		current_thread_info()->syscall = -1;
+		ret = -1;
 
 	regs->ARM_ip = ip;
-	return current_thread_info()->syscall;
+	return ret;
 }
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 {
+	int ret = 0;
+
+	/* set up syscall, which may be changed in secure_computing */
 	current_thread_info()->syscall = scno;
 
 	/* Do the secure computing check first; failures should be fast. */
 	if (secure_computing(scno) == -1)
 		return -1;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		scno = tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER))
+		ret = -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, scno);
+		trace_sys_enter(regs, current_thread_info()->syscall);
 
-	audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0, regs->ARM_r1,
+	audit_syscall_entry(AUDIT_ARCH_ARM, current_thread_info()->syscall,
+			    regs->ARM_r0, regs->ARM_r1,
 			    regs->ARM_r2, regs->ARM_r3);
 
-	return scno;
+	return ret ?: current_thread_info()->syscall;
 }
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
