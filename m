From: will.deacon@arm.com (Will Deacon)
Date: Thu,  1 Sep 2016 20:09:33 +0100
Subject: [PATCH] arm64: debug: report TRAP_TRACE instead of TRAP_HWBRPT for
 singlestep
Message-ID: <1472756973-3682-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Single-step traps to userspace (e.g. via ptrace) are expected to use
the TRAP_TRACE for the si_code field of the siginfo, as opposed to
TRAP_HWBRPT that we report currently.

Fix the reported value, which has no effect on existing and legacy
builds of GDB.

Reported-by: Yao Qi <yao.qi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 30821928106f..d97fdc1f6a38 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -236,7 +236,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 		return 0;
 
 	if (user_mode(regs)) {
-		send_user_sigtrap(TRAP_HWBKPT);
+		send_user_sigtrap(TRAP_TRACE);
 
 		/*
 		 * ptrace will disable single step unless explicitly
@@ -364,7 +364,7 @@ NOKPROBE_SYMBOL(aarch32_break_handler);
 static int __init debug_traps_init(void)
 {
 	hook_debug_fault_code(DBG_ESR_EVT_HWSS, single_step_handler, SIGTRAP,
-			      TRAP_HWBKPT, "single-step handler");
+			      TRAP_TRACE, "single-step handler");
 	hook_debug_fault_code(DBG_ESR_EVT_BRK, brk_handler, SIGTRAP,
 			      TRAP_BRKPT, "ptrace BRK handler");
 	return 0;
-- 
2.1.4
