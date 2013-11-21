From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Nov 2013 11:24:15 +0000
Subject: [PATCH RFC v3 08/12] arm64: kernel: implement HW breakpoints CPU PM
 notifier
In-Reply-To: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1385033059-25896-9-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is shutdown either through CPU idle or suspend to RAM, the
content of HW breakpoint registers must be reset or restored to proper
values when CPU resume from low power states. This patch adds debug register
restore operations to the HW breakpoint control function and implements a
CPU PM notifier that allows to restore the content of HW breakpoint registers
to allow proper suspend/resume operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 79 ++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index e894591..bcaaac9 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -20,6 +20,7 @@
 
 #define pr_fmt(fmt) "hw-breakpoint: " fmt
 
+#include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
@@ -171,7 +172,8 @@ static enum debug_el debug_exception_level(int privilege)
 
 enum hw_breakpoint_ops {
 	HW_BREAKPOINT_INSTALL,
-	HW_BREAKPOINT_UNINSTALL
+	HW_BREAKPOINT_UNINSTALL,
+	HW_BREAKPOINT_RESTORE
 };
 
 /**
@@ -210,6 +212,10 @@ static int hw_breakpoint_slot_setup(struct perf_event **slots, int max_slots,
 				return i;
 			}
 			break;
+		case HW_BREAKPOINT_RESTORE:
+			if (*slot == bp)
+				return i;
+			break;
 		default:
 			pr_warn_once("Unhandled hw breakpoint ops %d\n", ops);
 			return -EINVAL;
@@ -256,7 +262,8 @@ static int hw_breakpoint_control(struct perf_event *bp,
 		 * level.
 		 */
 		enable_debug_monitors(dbg_el);
-
+		/* Fall through */
+	case HW_BREAKPOINT_RESTORE:
 		/* Setup the address register. */
 		write_wb_reg(val_reg, i, info->address);
 
@@ -840,18 +847,36 @@ void hw_breakpoint_thread_switch(struct task_struct *next)
 /*
  * CPU initialisation.
  */
-static void reset_ctrl_regs(void *unused)
+static void hw_breakpoint_reset(void *unused)
 {
 	int i;
-
-	for (i = 0; i < core_num_brps; ++i) {
-		write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
-		write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+	struct perf_event **slots;
+	/*
+	 * When a CPU goes through cold-boot, it does not have any installed
+	 * slot, so it is safe to share the same function for restoring and
+	 * resetting breakpoints; when a CPU is hotplugged in, it goes
+	 * through the slots, which are all empty, hence it just resets control
+	 * and value for debug registers.
+	 * When this function is triggered on warm-boot through a CPU PM
+	 * notifier some slots might be initialized; if so they are
+	 * reprogrammed according to the debug slots content.
+	 */
+	for (slots = this_cpu_ptr(bp_on_reg), i = 0; i < core_num_brps; ++i) {
+		if (slots[i]) {
+			hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+		} else {
+			write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
+			write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+		}
 	}
 
-	for (i = 0; i < core_num_wrps; ++i) {
-		write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
-		write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+	for (slots = this_cpu_ptr(wp_on_reg), i = 0; i < core_num_wrps; ++i) {
+		if (slots[i]) {
+			hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+		} else {
+			write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
+			write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+		}
 	}
 }
 
@@ -861,7 +886,7 @@ static int hw_breakpoint_reset_notify(struct notifier_block *self,
 {
 	int cpu = (long)hcpu;
 	if (action == CPU_ONLINE)
-		smp_call_function_single(cpu, reset_ctrl_regs, NULL, 1);
+		smp_call_function_single(cpu, hw_breakpoint_reset, NULL, 1);
 	return NOTIFY_OK;
 }
 
@@ -869,6 +894,33 @@ static struct notifier_block hw_breakpoint_reset_nb = {
 	.notifier_call = hw_breakpoint_reset_notify,
 };
 
+#ifdef CONFIG_CPU_PM
+static int hw_breakpoint_cpu_pm_notify(struct notifier_block *self,
+				       unsigned long action,
+				       void *v)
+{
+	if (action == CPU_PM_EXIT) {
+		hw_breakpoint_reset(NULL);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block hw_breakpoint_cpu_pm_nb = {
+	.notifier_call = hw_breakpoint_cpu_pm_notify,
+};
+
+static void __init hw_breakpoint_pm_init(void)
+{
+	cpu_pm_register_notifier(&hw_breakpoint_cpu_pm_nb);
+}
+#else
+static inline void hw_breakpoint_pm_init(void)
+{
+}
+#endif
+
 /*
  * One-time initialisation.
  */
@@ -884,8 +936,8 @@ static int __init arch_hw_breakpoint_init(void)
 	 * Reset the breakpoint resources. We assume that a halting
 	 * debugger will leave the world in a nice state for us.
 	 */
-	smp_call_function(reset_ctrl_regs, NULL, 1);
-	reset_ctrl_regs(NULL);
+	smp_call_function(hw_breakpoint_reset, NULL, 1);
+	hw_breakpoint_reset(NULL);
 
 	/* Register debug fault handlers. */
 	hook_debug_fault_code(DBG_ESR_EVT_HWBP, breakpoint_handler, SIGTRAP,
@@ -895,6 +947,7 @@ static int __init arch_hw_breakpoint_init(void)
 
 	/* Register hotplug notifier. */
 	register_cpu_notifier(&hw_breakpoint_reset_nb);
+	hw_breakpoint_pm_init();
 
 	return 0;
 }
-- 
1.8.4
