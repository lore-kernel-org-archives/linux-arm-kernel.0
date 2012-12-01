From: andrew_gabbasov@mentor.com (Andrew Gabbasov)
Date: Sat,  1 Dec 2012 07:38:54 -0600
Subject: [PATCH] ARM: pass syscall return value to sys_exit tracepoint
Message-ID: <1354369134-20296-1-git-send-email-andrew_gabbasov@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sys_exit tracepoint expects the syscall return value as a second
argument, rather than syscall number.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 arch/arm/kernel/ptrace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 739db3a..4206da7 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -956,7 +956,7 @@ asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
 {
 	scno = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		trace_sys_exit(regs, scno);
+		trace_sys_exit(regs, regs->ARM_r0);
 	audit_syscall_exit(regs);
 	return scno;
 }
-- 
1.7.10.4
