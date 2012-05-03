From: will.deacon@arm.com (Will Deacon)
Date: Thu,  3 May 2012 18:42:59 +0100
Subject: [PATCH 5/6] ARM: audit: move syscall auditing until after ptrace
 SIGTRAP handling
In-Reply-To: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
References: <1336066980-24000-1-git-send-email-will.deacon@arm.com>
Message-ID: <1336066980-24000-6-git-send-email-will.deacon@arm.com>
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
 arch/arm/kernel/ptrace.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 9650c14..e7d687e 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -910,16 +910,10 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
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
 	if (!(current->ptrace & PT_PTRACED))
-		return scno;
+		goto out_no_trace;
 
 	current_thread_info()->syscall = scno;
 
@@ -943,7 +937,15 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
+
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
