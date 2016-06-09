From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:01:58 -0700
Subject: [PATCH 08/14] arm64/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-9-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/kernel/ptrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6e2cf046615d..602316c97a47 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1246,13 +1246,13 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 
+	/* Do the secure computing after ptrace; failures should be fast. */
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
 
-- 
2.7.4
