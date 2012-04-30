From: jcm@jonmasters.org (Jon Masters)
Date: Sun, 29 Apr 2012 21:57:08 -0400
Subject: [PATCH] ARM: Fix restoration of IP scratch register when auditing
 syscalls [v2]
Message-ID: <1335751028-15466-1-git-send-email-jcm@jonmasters.org>
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

The fix is simply to have an additional out when not ptracing. This
second version merges the two existing if statements following useful
Google+ feedback from Ralph, but keeps the out jump as a reminder to
those who will otherwise fail to restore the IP in future patches.

Signed-off-by: Jon Masters <jcm@jonmasters.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Eric Paris <eparis@redhat.com>
Cc: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: stable at vger.kernel.org
---
 arch/arm/kernel/ptrace.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ede6443..e8388d7 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -928,10 +928,10 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return scno;
-	if (!(current->ptrace & PT_PTRACED))
-		return scno;
+	/* If e.g. doing audit (not also ptrace) restore user IP and return */
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) ||
+	    !(current->ptrace & PT_PTRACED))
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
