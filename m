From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:01:57 -0700
Subject: [PATCH 07/14] arm/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-8-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ad5e90ab165c..dc7b372872ff 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -932,18 +932,19 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 {
 	current_thread_info()->syscall = scno;
 
-	/* Do the secure computing check first; failures should be fast. */
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
+
+	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 	if (secure_computing(NULL) == -1)
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
-	secure_computing_strict(scno);
+	secure_computing_strict(current_thread_info()->syscall);
 #endif
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
-
+	/* Tracer or seccomp may have changed syscall. */
 	scno = current_thread_info()->syscall;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-- 
2.7.4
