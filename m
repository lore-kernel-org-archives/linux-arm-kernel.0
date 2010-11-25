From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Nov 2010 17:08:17 +0000
Subject: [PATCH 2/4] ARM: hw_breakpoint: reset control registers in hotplug
	path
In-Reply-To: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
References: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
Message-ID: <1290704899-13051-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv7 debug architecture doesn't make any guarantees about the
contents of debug control registers following a debug logic reset.

This patch ensures that we reset the control registers when a cpu
comes ONLINE (for example, with hotplug) so that when we enable
monitor mode while inserting a breakpoint we won't exhibit random
behaviour.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 793959e..515a3c4 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -764,7 +764,7 @@ out:
 /*
  * One-time initialisation.
  */
-static void __init reset_ctrl_regs(void *unused)
+static void reset_ctrl_regs(void *unused)
 {
 	int i;
 
@@ -799,6 +799,18 @@ static void __init reset_ctrl_regs(void *unused)
 	}
 }
 
+static int __cpuinit dbg_reset_notify(struct notifier_block *self,
+				      unsigned long action, void *cpu)
+{
+	if (action == CPU_ONLINE)
+		smp_call_function_single((int)cpu, reset_ctrl_regs, NULL, 1);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block __cpuinitdata dbg_reset_nb = {
+	.notifier_call = dbg_reset_notify,
+};
+
 static int __init arch_hw_breakpoint_init(void)
 {
 	int ret = 0;
@@ -846,6 +858,8 @@ static int __init arch_hw_breakpoint_init(void)
 	hook_ifault_code(2, hw_breakpoint_pending, SIGTRAP, TRAP_HWBKPT,
 			"breakpoint debug exception");
 
+	/* Register hotplug notifier. */
+	register_cpu_notifier(&dbg_reset_nb);
 out:
 	return ret;
 }
-- 
1.7.0.4
