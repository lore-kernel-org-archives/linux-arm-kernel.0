From: keescook@chromium.org (Kees Cook)
Date: Thu,  9 Jun 2016 14:02:03 -0700
Subject: [PATCH 13/14] tile/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
Message-ID: <1465506124-21866-14-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Close the hole where ptrace can change a syscall out from under seccomp.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/tile/kernel/ptrace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/tile/kernel/ptrace.c b/arch/tile/kernel/ptrace.c
index 8c6d2f2fefa3..d89b7011667c 100644
--- a/arch/tile/kernel/ptrace.c
+++ b/arch/tile/kernel/ptrace.c
@@ -255,14 +255,15 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 work = ACCESS_ONCE(current_thread_info()->flags);
 
-	if (secure_computing(NULL) == -1)
+	if ((work & _TIF_SYSCALL_TRACE) &&
+	    tracehook_report_syscall_entry(regs)) {
+		regs->regs[TREG_SYSCALL_NR] = -1;
 		return -1;
-
-	if (work & _TIF_SYSCALL_TRACE) {
-		if (tracehook_report_syscall_entry(regs))
-			regs->regs[TREG_SYSCALL_NR] = -1;
 	}
 
+	if (secure_computing(NULL) == -1)
+		return -1;
+
 	if (work & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_enter(regs, regs->regs[TREG_SYSCALL_NR]);
 
-- 
2.7.4
