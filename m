From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:12:20 +0100
Subject: [PATCH v2 3/4] ARM: audit: move syscall auditing until after ptrace
 SIGTRAP handling
In-Reply-To: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
References: <1339168341-29850-1-git-send-email-will.deacon@arm.com>
Message-ID: <1339168341-29850-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When auditing system calls on ARM, the audit code is called before
notifying the parent process in the case that the current task is being
ptraced. At this point, the parent (debugger) may choose to change the
system call being issued via the SET_SYSCALL ptrace request, causing
the wrong system call to be reported to the audit tools.

This patch moves the audit calls after the ptrace SIGTRAP handling code
in the syscall tracing implementation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 5700a7a..5256068 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -912,16 +912,11 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
 	unsigned long ip;
 
-	if (why)
-		audit_syscall_exit(regs);
-	else
-		audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0,
-				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
-
 	if (why == 0 && test_and_clear_thread_flag(TIF_SYSCALL_RESTARTSYS))
 		scno = __NR_restart_syscall - __NR_SYSCALL_BASE;
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return scno;
+		goto out_no_trace;
 
 	current_thread_info()->syscall = scno;
 
@@ -938,6 +933,13 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 		current_thread_info()->syscall = -1;
 
 	regs->ARM_ip = ip;
+	scno = current_thread_info()->syscall;
 
-	return current_thread_info()->syscall;
+out_no_trace:
+	if (why)
+		audit_syscall_exit(regs);
+	else
+		audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0,
+				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
+	return scno;
 }
-- 
1.7.4.1
