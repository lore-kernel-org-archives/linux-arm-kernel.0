From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Apr 2014 12:37:14 +0100
Subject: [PATCH] arm64: debug: remove noisy, pointless warning
Message-ID: <1397734634-14464-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sending a SIGTRAP to a user task after execution of a BRK instruction at
EL0 is fundamental to the way in which software breakpoints work and
doesn't deserve a warning to be logged in dmesg. Whilst the warning can
be justified from EL1, do_debug_exception will already do the right thing,
so simply remove the code altogether.

Cc: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
Reported-by: Kyrylo Tkachov <kyrylo.tkachov@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index ed3955a95747..a7fb874b595e 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -318,9 +318,6 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 	if (call_break_hook(regs, esr) == DBG_HOOK_HANDLED)
 		return 0;
 
-	pr_warn("unexpected brk exception at %lx, esr=0x%x\n",
-			(long)instruction_pointer(regs), esr);
-
 	if (!user_mode(regs))
 		return -EFAULT;
 
-- 
1.9.1
