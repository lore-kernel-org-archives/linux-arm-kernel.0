From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 17 Nov 2016 19:35:36 +0100
Subject: [PATCH 15/20] ARM/hw_breakpoint: Convert to hotplug state machine
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
Message-ID: <20161117183541.8588-16-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

smp_call_function_single() has been removed because the function is already
invoked on the target CPU.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/kernel/hw_breakpoint.c | 44 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b8df45883cf7..51cff5a8feff 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -925,9 +925,9 @@ static bool core_has_os_save_restore(void)
 	}
 }
 
-static void reset_ctrl_regs(void *unused)
+static void reset_ctrl_regs(unsigned int cpu)
 {
-	int i, raw_num_brps, err = 0, cpu = smp_processor_id();
+	int i, raw_num_brps, err = 0;
 	u32 val;
 
 	/*
@@ -1020,25 +1020,20 @@ static void reset_ctrl_regs(void *unused)
 		cpumask_or(&debug_err_mask, &debug_err_mask, cpumask_of(cpu));
 }
 
-static int dbg_reset_notify(struct notifier_block *self,
-				      unsigned long action, void *cpu)
+static int dbg_reset_online(unsigned int cpu)
 {
-	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
-		smp_call_function_single((int)cpu, reset_ctrl_regs, NULL, 1);
-
-	return NOTIFY_OK;
+	local_irq_disable();
+	reset_ctrl_regs(cpu);
+	local_irq_enable();
+	return 0;
 }
 
-static struct notifier_block dbg_reset_nb = {
-	.notifier_call = dbg_reset_notify,
-};
-
 #ifdef CONFIG_CPU_PM
 static int dbg_cpu_pm_notify(struct notifier_block *self, unsigned long action,
 			     void *v)
 {
 	if (action == CPU_PM_EXIT)
-		reset_ctrl_regs(NULL);
+		reset_ctrl_regs(smp_processor_id());
 
 	return NOTIFY_OK;
 }
@@ -1059,6 +1054,8 @@ static inline void pm_init(void)
 
 static int __init arch_hw_breakpoint_init(void)
 {
+	int ret;
+
 	debug_arch = get_debug_arch();
 
 	if (!debug_arch_supported()) {
@@ -1072,8 +1069,6 @@ static int __init arch_hw_breakpoint_init(void)
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
-	cpu_notifier_register_begin();
-
 	/*
 	 * We need to tread carefully here because DBGSWENABLE may be
 	 * driven low on this core and there isn't an architected way to
@@ -1082,15 +1077,18 @@ static int __init arch_hw_breakpoint_init(void)
 	register_undef_hook(&debug_reg_hook);
 
 	/*
-	 * Reset the breakpoint resources. We assume that a halting
-	 * debugger will leave the world in a nice state for us.
+	 * Register CPU notifier which resets the breakpoint resources. We
+	 * assume that a halting debugger will leave the world in a nice state
+	 * for us.
 	 */
-	on_each_cpu(reset_ctrl_regs, NULL, 1);
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "arm/hw_breakpoint:online",
+				dbg_reset_online, NULL);
 	unregister_undef_hook(&debug_reg_hook);
-	if (!cpumask_empty(&debug_err_mask)) {
+	if (WARN_ON(ret < 0) || !cpumask_empty(&debug_err_mask)) {
 		core_num_brps = 0;
 		core_num_wrps = 0;
-		cpu_notifier_register_done();
+		if (ret > 0)
+			cpuhp_remove_state_nocalls(ret);
 		return 0;
 	}
 
@@ -1109,11 +1107,7 @@ static int __init arch_hw_breakpoint_init(void)
 	hook_ifault_code(FAULT_CODE_DEBUG, hw_breakpoint_pending, SIGTRAP,
 			TRAP_HWBKPT, "breakpoint debug exception");
 
-	/* Register hotplug and PM notifiers. */
-	__register_cpu_notifier(&dbg_reset_nb);
-
-	cpu_notifier_register_done();
-
+	/* Register PM notifiers. */
 	pm_init();
 	return 0;
 }
-- 
2.10.2
