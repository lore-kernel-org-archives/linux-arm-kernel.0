From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 16 Jan 2012 09:07:44 -0800
Subject: [PATCH] ARM: Print BUG instead of undefined instruction on BUG_ON()
Message-ID: <1326733664-4095-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM kernel uses undefined instructions to implement
BUG/BUG_ON(). This leads to problems where people don't read one
line above the Oops message and see the "kernel BUG at ..."
message and so they wrongly assume the kernel has hit an
undefined instruction.

Instead of printing:

 Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP

print

 Internal error: Oops - BUG: 0 [#1] PREEMPT SMP

This should prevent people from thinking the BUG_ON was an
undefined instruction when it was actually intentional.

Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/traps.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 99a5727..f84dfe6 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -266,6 +266,7 @@ void die(const char *str, struct pt_regs *regs, int err)
 {
 	struct thread_info *thread = current_thread_info();
 	int ret;
+	enum bug_trap_type bug_type = BUG_TRAP_TYPE_NONE;
 
 	oops_enter();
 
@@ -273,7 +274,9 @@ void die(const char *str, struct pt_regs *regs, int err)
 	console_verbose();
 	bust_spinlocks(1);
 	if (!user_mode(regs))
-		report_bug(regs->ARM_pc, regs);
+		bug_type = report_bug(regs->ARM_pc, regs);
+	if (bug_type != BUG_TRAP_TYPE_NONE)
+		str = "Oops - BUG";
 	ret = __die(str, err, thread, regs);
 
 	if (regs && kexec_should_crash(thread->task))
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
