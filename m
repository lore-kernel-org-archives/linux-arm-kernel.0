From: jcm@jonmasters.org (Jon Masters)
Date: Sun, 29 Apr 2012 02:38:24 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls
In-Reply-To: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
References: <1335681504-4609-1-git-send-email-jcm@jonmasters.org>
Message-ID: <1335681504-4609-2-git-send-email-jcm@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audit subsystem builds upon ptrace to record system calls. This is done
in a couple of places (on return from fork into a new task, on exit from
the SWI vector), using calls to syscall_trace. The latter function abuses
the userspace intra-procedure scratch register (regs->ARM_ip, aka r12),
and intends to restore it prior to return to userspace. Unfortunately,
there are cases where we will return to userspace without restoring.

If we are in fact not ptracing but are merely auditing calls, we will
happily trash the content of ip but will exit to userspace without
restoring the value. It just so happens that GLIBC uses ip as a
storage for the TLS thread pointer info, and bad things result.

The fix is simply to have an additional out when not ptracing.

Signed-off-by: Jon Masters <jcm@jonmasters.org>
---
 arch/arm/kernel/ptrace.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ede6443..7b05b6e 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -928,10 +928,10 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return scno;
+	if (!test_thread_flag(TIF_SYSCALL_TRACE)) 
+		goto out_no_ptrace;
 	if (!(current->ptrace & PT_PTRACED))
-		return scno;
+		goto out_no_ptrace;
 
 	current_thread_info()->syscall = scno;
 
@@ -951,4 +951,8 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 	regs->ARM_ip = ip;
 
 	return current_thread_info()->syscall;
+
+out_no_ptrace:
+	regs->ARM_ip = ip;
+	return scno;
 }
-- 
1.7.7.4
