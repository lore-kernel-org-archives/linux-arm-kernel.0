From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Jul 2015 18:13:36 +0800
Subject: [PATCH 3/4] firmware: psci: move cpu_suspend handling to generic code
In-Reply-To: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
References: <1436350417-6712-1-git-send-email-jszhang@marvell.com>
Message-ID: <1436350417-6712-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions implemented on arm64 to suspend cpu and translates the idle
state index passed by the cpu_suspend core call to a valid PSCI state
are not arm64 specific and should be moved to generic code so that they
can be reused on arm systems too.

This patch moves these functions to generic PSCI firmware layer code.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/kernel/psci.c | 95 ------------------------------------------------
 drivers/firmware/psci.c  | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/psci.h     |  2 +
 3 files changed, 97 insertions(+), 95 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4be5972..06e5c9a 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -20,7 +20,6 @@
 #include <linux/smp.h>
 #include <linux/delay.h>
 #include <linux/psci.h>
-#include <linux/slab.h>
 
 #include <uapi/linux/psci.h>
 
@@ -28,73 +27,6 @@
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
 #include <asm/smp_plat.h>
-#include <asm/suspend.h>
-
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int __maybe_unused cpu_psci_cpu_init_idle(unsigned int cpu)
-{
-	int i, ret, count = 0;
-	u32 *psci_states;
-	struct device_node *state_node, *cpu_node;
-
-	cpu_node = of_get_cpu_node(cpu, NULL);
-	if (!cpu_node)
-		return -ENODEV;
-
-	/*
-	 * If the PSCI cpu_suspend function hook has not been initialized
-	 * idle states must not be enabled, so bail out
-	 */
-	if (!psci_ops.cpu_suspend)
-		return -EOPNOTSUPP;
-
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
-	}
-
-	if (!count)
-		return -ENODEV;
-
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
-	if (!psci_states)
-		return -ENOMEM;
-
-	for (i = 0; i < count; i++) {
-		u32 state;
-
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
-
-		ret = of_property_read_u32(state_node,
-					   "arm,psci-suspend-param",
-					   &state);
-		if (ret) {
-			pr_warn(" * %s missing arm,psci-suspend-param property\n",
-				state_node->full_name);
-			of_node_put(state_node);
-			goto free_mem;
-		}
-
-		of_node_put(state_node);
-		pr_debug("psci-power-state %#x index %d\n", state, i);
-		if (!psci_power_state_is_valid(state)) {
-			pr_warn("Invalid PSCI power state %#x\n", state);
-			ret = -EINVAL;
-			goto free_mem;
-		}
-		psci_states[i] = state;
-	}
-	/* Idle states parsed correctly, initialize per-cpu pointer */
-	per_cpu(psci_power_state, cpu) = psci_states;
-	return 0;
-
-free_mem:
-	kfree(psci_states);
-	return ret;
-}
 
 #ifdef CONFIG_SMP
 
@@ -181,33 +113,6 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 #endif
 #endif
 
-static int psci_suspend_finisher(unsigned long index)
-{
-	u32 *state = __this_cpu_read(psci_power_state);
-
-	return psci_ops.cpu_suspend(state[index - 1],
-				    virt_to_phys(cpu_resume));
-}
-
-static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
-{
-	int ret;
-	u32 *state = __this_cpu_read(psci_power_state);
-	/*
-	 * idle state index 0 corresponds to wfi, should never be called
-	 * from the cpu_suspend operations
-	 */
-	if (WARN_ON_ONCE(!index))
-		return -EINVAL;
-
-	if (!psci_power_state_loses_context(state[index - 1]))
-		ret = psci_ops.cpu_suspend(state[index - 1], 0);
-	else
-		ret = cpu_suspend(index, psci_suspend_finisher);
-
-	return ret;
-}
-
 const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
 #ifdef CONFIG_CPU_IDLE
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 2f5d611..5da8aa2 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -20,12 +20,14 @@
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
+#include <linux/slab.h>
 
 #include <uapi/linux/psci.h>
 
 #include <asm/cputype.h>
 #include <asm/system_misc.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
@@ -81,6 +83,8 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static u32 psci_cpu_suspend_feature;
 
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -217,6 +221,97 @@ static void psci_sys_poweroff(void)
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
 }
 
+int cpu_psci_cpu_init_idle(unsigned int cpu)
+{
+	int i, ret, count = 0;
+	u32 *psci_states;
+	struct device_node *state_node, *cpu_node;
+
+	cpu_node = of_get_cpu_node(cpu, NULL);
+	if (!cpu_node)
+		return -ENODEV;
+
+	/*
+	 * If the PSCI cpu_suspend function hook has not been initialized
+	 * idle states must not be enabled, so bail out
+	 */
+	if (!psci_ops.cpu_suspend)
+		return -EOPNOTSUPP;
+
+	/* Count idle states */
+	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
+					      count))) {
+		count++;
+		of_node_put(state_node);
+	}
+
+	if (!count)
+		return -ENODEV;
+
+	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	if (!psci_states)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		u32 state;
+
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+
+		ret = of_property_read_u32(state_node,
+					   "arm,psci-suspend-param",
+					   &state);
+		if (ret) {
+			pr_warn(" * %s missing arm,psci-suspend-param property\n",
+				state_node->full_name);
+			of_node_put(state_node);
+			goto free_mem;
+		}
+
+		of_node_put(state_node);
+		pr_debug("psci-power-state %#x index %d\n", state, i);
+		if (!psci_power_state_is_valid(state)) {
+			pr_warn("Invalid PSCI power state %#x\n", state);
+			ret = -EINVAL;
+			goto free_mem;
+		}
+		psci_states[i] = state;
+	}
+	/* Idle states parsed correctly, initialize per-cpu pointer */
+	per_cpu(psci_power_state, cpu) = psci_states;
+	return 0;
+
+free_mem:
+	kfree(psci_states);
+	return ret;
+}
+
+static int psci_suspend_finisher(unsigned long index)
+{
+	u32 *state = __this_cpu_read(psci_power_state);
+
+	return psci_ops.cpu_suspend(state[index - 1],
+				    virt_to_phys(cpu_resume));
+}
+
+int cpu_psci_cpu_suspend(unsigned long index)
+{
+	int ret;
+	u32 *state = __this_cpu_read(psci_power_state);
+	/*
+	 * idle state index 0 corresponds to wfi, should never be called
+	 * from the cpu_suspend operations
+	 */
+	if (WARN_ON_ONCE(!index))
+		return -EINVAL;
+
+	if (!psci_power_state_loses_context(state[index - 1]))
+		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+	else
+		ret = cpu_suspend(index, psci_suspend_finisher);
+
+	return ret;
+}
+
 static int __init psci_features(u32 psci_func_id)
 {
 	return invoke_psci_fn(PSCI_1_0_FN_PSCI_FEATURES,
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 12c4865..cbb49a3 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -23,6 +23,8 @@
 bool psci_tos_resident_on(int cpu);
 bool psci_power_state_loses_context(u32 state);
 bool psci_power_state_is_valid(u32 state);
+int cpu_psci_cpu_init_idle(unsigned int cpu);
+int cpu_psci_cpu_suspend(unsigned long index);
 
 struct psci_operations {
 	int (*cpu_suspend)(u32 state, unsigned long entry_point);
-- 
2.1.4
