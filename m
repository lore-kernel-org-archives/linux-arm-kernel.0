From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Jan 2015 11:35:55 +0000
Subject: [PATCH RFC 2/2] ARM64: psci: implement system suspend using PSCI v0.2
 CPU SUSPEND
In-Reply-To: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
References: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1421840155-18990-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PSCI specifications upto v0.2 and the related kernel back-end
implementation lack a method to enter system wide suspend state.

This patch implements suspend to RAM support for all ARM64 systems
with PSCIv0.2 support using CPU SUSPEND and the new system state DT
bindings.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/psci.c | 83 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index f1dbca7d5c96..8be464747dd6 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -22,6 +22,7 @@
 #include <linux/pm.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <uapi/linux/psci.h>
 
 #include <asm/compiler.h>
@@ -304,6 +305,75 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
+static int psci_suspend_finisher(unsigned long arg)
+{
+	return psci_ops.cpu_suspend(*(struct psci_power_state *)arg,
+				    virt_to_phys(cpu_resume));
+}
+
+#ifdef CONFIG_SUSPEND
+static struct psci_power_state psci_system_suspend_state;
+
+static int psci_system_suspend_enter(suspend_state_t state)
+{
+	if (state != PM_SUSPEND_MEM)
+		return 0;
+
+	/*
+	 * TODO remove pack/unpacking of power_state to do away with
+	 * these ugly type conversions
+	 */
+	return __cpu_suspend((unsigned long)&psci_system_suspend_state,
+			     psci_suspend_finisher);
+}
+
+static const struct platform_suspend_ops psci_suspend_ops = {
+	.valid		= suspend_valid_only_mem,
+	.enter		= psci_system_suspend_enter,
+};
+
+static void __init psci_0_2_system_suspend_init(void)
+{
+	int ret;
+	u32 psci_power_state;
+	const char *entry_method;
+	struct device_node *node;
+
+	if (!psci_ops.cpu_suspend)
+		return; /* -EOPNOTSUPP */
+
+	node = of_find_compatible_node(NULL, NULL, "arm,system-suspend");
+	if (!node || !of_device_is_available(node))
+		return; /* -EOPNOTSUPP */
+
+	if (of_property_read_string(node, "entry-method", &entry_method)) {
+		pr_warn(" * %s missing entry-method property\n", node->full_name);
+		goto exit;
+	}
+
+	if (strcmp(entry_method, "arm,psci"))
+		goto exit; /* out of PSCI scope ignore */
+
+	ret = of_property_read_u32(node, "arm,psci-suspend-param",
+				   &psci_power_state);
+	if (ret) {
+		pr_warn(" * %s missing arm,psci-suspend-param property\n",
+			node->full_name);
+		goto exit;
+	}
+
+	pr_debug("psci-power-state for system suspend %#x\n", psci_power_state);
+
+	psci_power_state_unpack(psci_power_state, &psci_system_suspend_state);
+
+	suspend_set_ops(&psci_suspend_ops);
+exit:
+	of_node_put(node);
+}
+#else
+static void __init psci_0_2_system_suspend_init(void) { }
+#endif
+
 /*
  * PSCI Function IDs for v0.2+ are well defined so use
  * standard values.
@@ -361,6 +431,8 @@ static int __init psci_0_2_init(struct device_node *np)
 
 	pm_power_off = psci_sys_poweroff;
 
+	psci_0_2_system_suspend_init();
+
 out_put_node:
 	of_node_put(np);
 	return err;
@@ -509,14 +581,6 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 #endif
 #endif
 
-static int psci_suspend_finisher(unsigned long index)
-{
-	struct psci_power_state *state = __this_cpu_read(psci_power_state);
-
-	return psci_ops.cpu_suspend(state[index - 1],
-				    virt_to_phys(cpu_resume));
-}
-
 static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 {
 	int ret;
@@ -531,7 +595,8 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (state[index - 1].type == PSCI_POWER_STATE_TYPE_STANDBY)
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
-		ret = __cpu_suspend(index, psci_suspend_finisher);
+		ret = __cpu_suspend((unsigned long)&state[index - 1],
+				    psci_suspend_finisher);
 
 	return ret;
 }
-- 
1.9.1
