From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:07:03 +0100
Subject: [RFC PATCH 5/8] ARM: audit: move syscall auditing until after ptrace
 SIGTRAP handling
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377626-17075-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When auditing system calls on ARM, the audit code is called before
notifying the parent process in the case that the current task is being
ptraced. At this point, the parent (debugger) may choose to change the
system call being issued via the SET_SYSCALL ptrace request, causing
the wrong system call to be reported to the audit tools.

This patch moves the audit calls after the ptrace SIGTRAP handling code
in the syscall tracing implementation.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/ptrace.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 14e3826..592a39d 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -911,14 +911,8 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
 	unsigned long ip;
 
-	if (why)
-		audit_syscall_exit(regs);
-	else
-		audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0,
-				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
-
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return scno;
+		goto out_no_trace;
 
 	current_thread_info()->syscall = scno;
 
@@ -935,6 +929,13 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
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
