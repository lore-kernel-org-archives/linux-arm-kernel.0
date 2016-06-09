From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:02:00 -0700
Subject: [PATCH 10/14] parisc/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-11-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc at vger.kernel.org
---
 arch/parisc/kernel/ptrace.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 8edc47c0b98e..e02d7b4d2b69 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -311,10 +311,6 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs)) {
 		/*
@@ -325,6 +321,11 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		regs->gr[20] = -1UL;
 		goto out;
 	}
+
+	/* Do the secure computing check after ptrace. */
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->gr[20]);
-- 
2.7.4
