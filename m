From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 12:26:42 +0100
Subject: [PATCH] arm64: audit: Fix build for audit changes
Message-ID: <1405596402-23844-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Commit 3efe33f5d2 (audit: x86: drop arch from __audit_syscall_entry()
interface) removed the arch parameter from __audit_syscall_entry() and
updated the only current user in mainline but this breaks the ARMv8 audit
code that has been added in -next. Fix this by making the equivalent
update to ARMv8.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 70526cfda056..310842e3d477 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1115,8 +1115,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, regs->syscallno);
 
-	audit_syscall_entry(syscall_get_arch(), regs->syscallno,
-		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
+	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
+			    regs->regs[2], regs->regs[3]);
 
 	return regs->syscallno;
 }
-- 
2.0.1
