From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:02:04 -0700
Subject: [PATCH 14/14] um/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-15-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel at lists.sourceforge.net
---
 arch/um/kernel/skas/syscall.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 9c5570f0f397..ef4b8f949b51 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -20,12 +20,12 @@ void handle_syscall(struct uml_pt_regs *r)
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
 
-	/* Do the secure computing check first; failures should be fast. */
-	if (secure_computing(NULL) == -1)
+	if (syscall_trace_enter(regs))
 		return;
 
-	if (syscall_trace_enter(regs))
-		goto out;
+	/* Do the seccomp check after ptrace; failures should be fast. */
+	if (secure_computing(NULL) == -1)
+		return;
 
 	/* Update the syscall number after orig_ax has potentially been updated
 	 * with ptrace.
@@ -37,6 +37,5 @@ void handle_syscall(struct uml_pt_regs *r)
 		PT_REGS_SET_SYSCALL_RETURN(regs,
 				EXECUTE_SYSCALL(syscall, regs));
 
-out:
 	syscall_trace_leave(regs);
 }
-- 
2.7.4
