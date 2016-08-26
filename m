From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 11:35:57 +0100
Subject: [RFC PATCH 1/2] arm64: hw_breakpoint: convert CPU hotplug notifier to
 new infrastructure
Message-ID: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 hw_breakpoint implementation uses a CPU hotplug notifier to
reset the {break,watch}point registers when CPUs come online.

This patch converts the code to the new hotplug mechanism, whilst moving
the invocation earlier to remove the need to disable IRQs explicitly in
the driver (which could cause havok if we trip a watchpoint in an IRQ
handler whilst restoring the debug register state).

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 48 +++++++++++++--------------------------
 arch/arm64/kernel/suspend.c       | 10 ++++----
 include/linux/cpuhotplug.h        |  1 +
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 26a6bf77d272..948b73148d56 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -857,7 +857,7 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
 /*
  * CPU initialisation.
  */
-static void hw_breakpoint_reset(void *unused)
+static int hw_breakpoint_reset(unsigned int cpu)
 {
 	int i;
 	struct perf_event **slots;
@@ -888,28 +888,14 @@ static void hw_breakpoint_reset(void *unused)
 			write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
 		}
 	}
-}
 
-static int hw_breakpoint_reset_notify(struct notifier_block *self,
-						unsigned long action,
-						void *hcpu)
-{
-	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE) {
-		local_irq_disable();
-		hw_breakpoint_reset(NULL);
-		local_irq_enable();
-	}
-	return NOTIFY_OK;
+	return 0;
 }
 
-static struct notifier_block hw_breakpoint_reset_nb = {
-	.notifier_call = hw_breakpoint_reset_notify,
-};
-
 #ifdef CONFIG_CPU_PM
-extern void cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *));
+extern void cpu_suspend_set_dbg_restorer(int (*hw_bp_restore)(unsigned int));
 #else
-static inline void cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
+static inline void cpu_suspend_set_dbg_restorer(int (*hw_bp_restore)(unsigned int))
 {
 }
 #endif
@@ -919,36 +905,34 @@ static inline void cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
  */
 static int __init arch_hw_breakpoint_init(void)
 {
+	int ret;
+
 	core_num_brps = get_num_brps();
 	core_num_wrps = get_num_wrps();
 
 	pr_info("found %d breakpoint and %d watchpoint registers.\n",
 		core_num_brps, core_num_wrps);
 
-	cpu_notifier_register_begin();
-
-	/*
-	 * Reset the breakpoint resources. We assume that a halting
-	 * debugger will leave the world in a nice state for us.
-	 */
-	smp_call_function(hw_breakpoint_reset, NULL, 1);
-	hw_breakpoint_reset(NULL);
-
 	/* Register debug fault handlers. */
 	hook_debug_fault_code(DBG_ESR_EVT_HWBP, breakpoint_handler, SIGTRAP,
 			      TRAP_HWBKPT, "hw-breakpoint handler");
 	hook_debug_fault_code(DBG_ESR_EVT_HWWP, watchpoint_handler, SIGTRAP,
 			      TRAP_HWBKPT, "hw-watchpoint handler");
 
-	/* Register hotplug notifier. */
-	__register_cpu_notifier(&hw_breakpoint_reset_nb);
-
-	cpu_notifier_register_done();
+	/*
+	 * Reset the breakpoint resources. We assume that a halting
+	 * debugger will leave the world in a nice state for us.
+	 */
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
+			  "CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING",
+			  hw_breakpoint_reset, NULL);
+	if (ret)
+		pr_err("failed to register CPU hotplug notifier: %d\n", ret);
 
 	/* Register cpu_suspend hw breakpoint restore hook */
 	cpu_suspend_set_dbg_restorer(hw_breakpoint_reset);
 
-	return 0;
+	return ret;
 }
 arch_initcall(arch_hw_breakpoint_init);
 
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index b616e365cee3..ad734142070d 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -23,8 +23,8 @@ unsigned long *sleep_save_stash;
  * time the notifier runs debug exceptions might have been enabled already,
  * with HW breakpoints registers content still in an unknown state.
  */
-static void (*hw_breakpoint_restore)(void *);
-void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
+static int (*hw_breakpoint_restore)(unsigned int);
+void __init cpu_suspend_set_dbg_restorer(int (*hw_bp_restore)(unsigned int))
 {
 	/* Prevent multiple restore hook initializations */
 	if (WARN_ON(hw_breakpoint_restore))
@@ -34,6 +34,8 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
 
 void notrace __cpu_suspend_exit(void)
 {
+	unsigned int cpu = smp_processor_id();
+
 	/*
 	 * We are resuming from reset with the idmap active in TTBR0_EL1.
 	 * We must uninstall the idmap and restore the expected MMU
@@ -45,7 +47,7 @@ void notrace __cpu_suspend_exit(void)
 	 * Restore per-cpu offset before any kernel
 	 * subsystem relying on it has a chance to run.
 	 */
-	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+	set_my_cpu_offset(per_cpu_offset(cpu));
 
 	/*
 	 * Restore HW breakpoint registers to sane values
@@ -53,7 +55,7 @@ void notrace __cpu_suspend_exit(void)
 	 * through local_dbg_restore.
 	 */
 	if (hw_breakpoint_restore)
-		hw_breakpoint_restore(NULL);
+		hw_breakpoint_restore(cpu);
 }
 
 /*
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 242bf530edfc..3758fe6d5968 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -45,6 +45,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_METAG_STARTING,
 	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
+	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
-- 
2.1.4
