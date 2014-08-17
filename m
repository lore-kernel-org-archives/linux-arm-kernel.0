From: broonie@kernel.org (Mark Brown)
Date: Sun, 17 Aug 2014 09:26:37 -0500
Subject: [PATCH] arm64: audit: Fix build for audit changes
Message-ID: <1408285597-30913-1-git-send-email-broonie@kernel.org>
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

Now -rc1 is out this should be applied to the audit tree (or squashed
into the commit above) - the arm64 audit support is in mainline now and
-next is failing to build arm64 due to this.

 arch/arm64/kernel/ptrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 0310811..159251f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1116,8 +1116,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 		trace_sys_enter(regs, regs->syscallno);
 
 #ifdef CONFIG_AUDITSYSCALL
-	audit_syscall_entry(syscall_get_arch(), regs->syscallno,
-		regs->orig_x0, regs->regs[1], regs->regs[2], regs->regs[3]);
+	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
+			    regs->regs[2], regs->regs[3]);
 #endif
 
 	return regs->syscallno;
-- 
2.1.0.rc1
