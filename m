From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon,  1 Sep 2014 16:28:41 +0100
Subject: [PATCH v8 5/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
In-Reply-To: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1409585324-3678-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the cpu_suspend cpu operations method through
the PSCI CPU SUSPEND API. The PSCI implementation translates the idle state
index passed by the cpu_suspend core call into a valid PSCI state according to
the PSCI states initialized at boot through the cpu_init_idle() CPU
operations hook.

The PSCI CPU suspend operation hook checks if the PSCI state is a
standby state. If it is, it calls the PSCI suspend implementation
straight away, without saving any context. If the state is a power
down state the kernel calls the __cpu_suspend API (that saves the CPU
context) and passed the PSCI suspend finisher as a parameter so that PSCI
can be called by the __cpu_suspend implementation after saving and flushing
the context as last function before power down.

For power down states, entry point is set to cpu_resume physical address,
that represents the default kernel execution address following a CPU reset.

Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/psci.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 5539547..866c1c8 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -21,6 +21,7 @@
 #include <linux/reboot.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <uapi/linux/psci.h>
 
 #include <asm/compiler.h>
@@ -28,6 +29,7 @@
 #include <asm/errno.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/system_misc.h>
 
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
@@ -65,6 +67,8 @@ enum psci_function {
 	PSCI_FN_MAX,
 };
 
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
+
 static u32 psci_function_id[PSCI_FN_MAX];
 
 static int psci_to_linux_errno(int errno)
@@ -93,6 +97,18 @@ static u32 psci_power_state_pack(struct psci_power_state state)
 		 & PSCI_0_2_POWER_STATE_AFFL_MASK);
 }
 
+static void psci_power_state_unpack(u32 power_state,
+				    struct psci_power_state *state)
+{
+	state->id = (power_state & PSCI_0_2_POWER_STATE_ID_MASK) >>
+			PSCI_0_2_POWER_STATE_ID_SHIFT;
+	state->type = (power_state & PSCI_0_2_POWER_STATE_TYPE_MASK) >>
+			PSCI_0_2_POWER_STATE_TYPE_SHIFT;
+	state->affinity_level =
+			(power_state & PSCI_0_2_POWER_STATE_AFFL_MASK) >>
+			PSCI_0_2_POWER_STATE_AFFL_SHIFT;
+}
+
 /*
  * The following two functions are invoked via the invoke_psci_fn pointer
  * and will not be inlined, allowing us to piggyback on the AAPCS.
@@ -199,6 +215,63 @@ static int psci_migrate_info_type(void)
 	return err;
 }
 
+static int __maybe_unused cpu_psci_cpu_init_idle(struct device_node *cpu_node,
+						 unsigned int cpu)
+{
+	int i, ret, count = 0;
+	struct psci_power_state *psci_states;
+	struct device_node *state_node;
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
+		u32 psci_power_state;
+
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+
+		ret = of_property_read_u32(state_node,
+					   "arm,psci-suspend-param",
+					   &psci_power_state);
+		if (ret) {
+			pr_warn(" * %s missing arm,psci-suspend-param property\n",
+				state_node->full_name);
+			of_node_put(state_node);
+			goto free_mem;
+		}
+
+		of_node_put(state_node);
+		pr_debug("psci-power-state %#x index %d\n", psci_power_state,
+							    i);
+		psci_power_state_unpack(psci_power_state, &psci_states[i]);
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
 static int get_set_conduit_method(struct device_node *np)
 {
 	const char *method;
@@ -436,8 +509,39 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 #endif
 #endif
 
+static int psci_suspend_finisher(unsigned long index)
+{
+	struct psci_power_state *state = __get_cpu_var(psci_power_state);
+
+	return psci_ops.cpu_suspend(state[index - 1],
+				    virt_to_phys(cpu_resume));
+}
+
+static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
+{
+	int ret;
+	struct psci_power_state *state = __get_cpu_var(psci_power_state);
+	/*
+	 * idle state index 0 corresponds to wfi, should never be called
+	 * from the cpu_suspend operations
+	 */
+	if (WARN_ON_ONCE(!index))
+		return -EINVAL;
+
+	if (state->type == PSCI_POWER_STATE_TYPE_STANDBY)
+		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+	else
+		ret = __cpu_suspend(index, psci_suspend_finisher);
+
+	return ret;
+}
+
 const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
+#ifdef CONFIG_CPU_IDLE
+	.cpu_init_idle	= cpu_psci_cpu_init_idle,
+	.cpu_suspend	= cpu_psci_cpu_suspend,
+#endif
 #ifdef CONFIG_SMP
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
-- 
1.9.1
