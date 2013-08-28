From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:36:03 +0100
Subject: [RFC PATCH 11/14] arm64: kernel: implement HW breakpoints CPU PM
 notifier
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-12-git-send-email-lorenzo.pieralisi@arm.com>
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
 arch/arm64/kernel/hw_breakpoint.c | 63 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 84d1e62..59afa21 100644
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
 
@@ -869,6 +876,57 @@ static struct notifier_block hw_breakpoint_reset_nb = {
 	.notifier_call = hw_breakpoint_reset_notify,
 };
 
+#ifdef CONFIG_CPU_PM
+static void hw_breakpoint_restore(void)
+{
+	int i;
+	struct perf_event **slots;
+
+	for (slots = __get_cpu_var(bp_on_reg), i = 0; i < core_num_brps; ++i) {
+		if (slots[i]) {
+			hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+		} else {
+			write_wb_reg(AARCH64_DBG_REG_BCR, i, 0UL);
+			write_wb_reg(AARCH64_DBG_REG_BVR, i, 0UL);
+		}
+	}
+
+	for (slots = __get_cpu_var(wp_on_reg), i = 0; i < core_num_wrps; ++i) {
+		if (slots[i]) {
+			hw_breakpoint_control(slots[i], HW_BREAKPOINT_RESTORE);
+		} else {
+			write_wb_reg(AARCH64_DBG_REG_WCR, i, 0UL);
+			write_wb_reg(AARCH64_DBG_REG_WVR, i, 0UL);
+		}
+	}
+}
+
+static int hw_breakpoint_cpu_pm_notify(struct notifier_block *self,
+				       unsigned long action,
+				       void *v)
+{
+	if (action == CPU_PM_EXIT) {
+		hw_breakpoint_restore();
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
@@ -895,6 +953,7 @@ static int __init arch_hw_breakpoint_init(void)
 
 	/* Register hotplug notifier. */
 	register_cpu_notifier(&hw_breakpoint_reset_nb);
+	hw_breakpoint_pm_init();
 
 	return 0;
 }
-- 
1.8.3.4
