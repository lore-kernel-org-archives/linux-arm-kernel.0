From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:01:59 -0700
Subject: [PATCH 09/14] MIPS/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-10-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips at linux-mips.org
---
 arch/mips/kernel/ptrace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index c50af846ecf9..6103b24d1bfc 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -888,17 +888,16 @@ long arch_ptrace(struct task_struct *child, long request,
  */
 asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 {
-	long ret = 0;
 	user_exit();
 
 	current_thread_info()->syscall = syscall;
 
-	if (secure_computing(NULL) == -1)
-		return -1;
-
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
 	    tracehook_report_syscall_entry(regs))
-		ret = -1;
+		return -1;
+
+	if (secure_computing(NULL) == -1)
+		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->regs[2]);
-- 
2.7.4
