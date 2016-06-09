From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:02:01 -0700
Subject: [PATCH 11/14] s390/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-12-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390 at vger.kernel.org
---
 arch/s390/kernel/ptrace.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index c238e9958c2a..cea17010448f 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -821,15 +821,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	long ret = 0;
-
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL)) {
-		/* seccomp failures shouldn't expose any additional code. */
-		ret = -1;
-		goto out;
-	}
-
 	/*
 	 * The sysc_tracesys code in entry.S stored the system
 	 * call number to gprs[2].
@@ -843,7 +834,13 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		 * the system call and the system call restart handling.
 		 */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
-		ret = -1;
+		return -1;
+	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL)) {
+		/* seccomp failures shouldn't expose any additional code. */
+		return -1;
 	}
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
@@ -852,8 +849,8 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	audit_syscall_entry(regs->gprs[2], regs->orig_gpr2,
 			    regs->gprs[3], regs->gprs[4],
 			    regs->gprs[5]);
-out:
-	return ret ?: regs->gprs[2];
+
+	return regs->gprs[2];
 }
 
 asmlinkage void do_syscall_trace_exit(struct pt_regs *regs)
-- 
2.7.4
