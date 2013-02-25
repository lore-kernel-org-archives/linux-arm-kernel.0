From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:15:56 +0000
Subject: [PATCH] ARM: hw_breakpoint: reset debug logic on secondary CPUs in
 s2ram resume
Message-ID: <1361805356-8554-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dietmar Eggemann <Dietmar.Eggemann@arm.com>

We must mask out the CPU_TASKS_FROZEN bit so that reset_ctrl_regs is
also called on a secondary CPU during s2ram resume, where only the boot
CPU will receive the PM_EXIT notification.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 5eae53e..96093b7 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -1023,7 +1023,7 @@ out_mdbgen:
 static int __cpuinit dbg_reset_notify(struct notifier_block *self,
 				      unsigned long action, void *cpu)
 {
-	if (action == CPU_ONLINE)
+	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
 		smp_call_function_single((int)cpu, reset_ctrl_regs, NULL, 1);
 
 	return NOTIFY_OK;
-- 
1.8.0
