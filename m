From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  6 May 2014 19:04:41 +0100
Subject: [PATCH RFC v3 4/6] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
In-Reply-To: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1399399483-17112-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the cpu_suspend cpu operations method through
the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
index passed by the cpu_suspend core call into a valid PSCI state according to
the PSCI states initialized at boot by the PSCI suspend backend.

Entry point is set to cpu_resume physical address, that represents the
default kernel execution address following a CPU reset.

Idle state indices missing a DT node description are initialized to power
state standby WFI so that if called by the idle driver they provide the
default behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/psci.h |   4 ++
 arch/arm64/kernel/psci.c      | 102 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index d15ab8b4..9a4b663 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,10 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
+struct cpuidle_driver;
 void psci_init(void);
 
+int __init psci_dt_register_idle_states(struct cpuidle_driver *,
+					struct device_node *[]);
+
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ea4828a..0e32ab4 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,15 +15,18 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/cpuidle.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/slab.h>
 
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
 #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
@@ -54,6 +57,8 @@ enum psci_function {
 	PSCI_FN_MAX,
 };
 
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
+
 static u32 psci_function_id[PSCI_FN_MAX];
 
 #define PSCI_RET_SUCCESS		0
@@ -94,6 +99,17 @@ static u32 psci_power_state_pack(struct psci_power_state state)
 			<< PSCI_POWER_STATE_AFFL_SHIFT);
 }
 
+static void psci_power_state_unpack(u32 power_state,
+				    struct psci_power_state *state)
+{
+	state->id = (power_state >> PSCI_POWER_STATE_ID_SHIFT)
+			& PSCI_POWER_STATE_ID_MASK;
+	state->type = (power_state >> PSCI_POWER_STATE_TYPE_SHIFT)
+			& PSCI_POWER_STATE_TYPE_MASK;
+	state->affinity_level = (power_state >> PSCI_POWER_STATE_AFFL_SHIFT)
+			& PSCI_POWER_STATE_AFFL_MASK;
+}
+
 /*
  * The following two functions are invoked via the invoke_psci_fn pointer
  * and will not be inlined, allowing us to piggyback on the AAPCS.
@@ -176,6 +192,77 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
+int __init psci_dt_register_idle_states(struct cpuidle_driver *drv,
+					struct device_node *state_nodes[])
+{
+	int cpu, i;
+	struct psci_power_state *psci_states;
+	const struct cpu_operations *cpu_ops_ptr;
+
+	if (!state_nodes)
+		return -EINVAL;
+	/*
+	 * This is belt-and-braces: make sure that if the idle
+	 * specified protocol is psci, the cpu_ops have been
+	 * initialized to psci operations. Anything else is
+	 * a recipe for mayhem.
+	 */
+	for_each_cpu(cpu, drv->cpumask) {
+		cpu_ops_ptr = cpu_ops[cpu];
+		if (WARN_ON(!cpu_ops_ptr || strcmp(cpu_ops_ptr->name, "psci")))
+			return -EOPNOTSUPP;
+	}
+
+	psci_states = kcalloc(drv->state_count, sizeof(*psci_states),
+			      GFP_KERNEL);
+
+	if (!psci_states) {
+		pr_warn("psci idle state allocation failed\n");
+		return -ENOMEM;
+	}
+
+	for_each_cpu(cpu, drv->cpumask) {
+		if (per_cpu(psci_power_state, cpu)) {
+			pr_warn("idle states already initialized on cpu %u\n",
+				cpu);
+			continue;
+		}
+		per_cpu(psci_power_state, cpu) = psci_states;
+	}
+
+
+	for (i = 0; i < drv->state_count; i++) {
+		u32 psci_power_state;
+
+		if (!state_nodes[i]) {
+			/*
+			 * An index with a missing node pointer falls back to
+			 * simple STANDBYWFI
+			 */
+			psci_states[i].type = PSCI_POWER_STATE_TYPE_STANDBY;
+			continue;
+		}
+
+		if (of_property_read_u32(state_nodes[i], "entry-method-param",
+					 &psci_power_state)) {
+			pr_warn(" * %s missing entry-method-param property\n",
+				state_nodes[i]->full_name);
+			/*
+			 * If entry-method-param property is missing, fall
+			 * back to STANDBYWFI state
+			 */
+			psci_states[i].type = PSCI_POWER_STATE_TYPE_STANDBY;
+			continue;
+		}
+
+		pr_debug("psci-power-state %#x index %u\n",
+			 psci_power_state, i);
+		psci_power_state_unpack(psci_power_state, &psci_states[i]);
+	}
+
+	return 0;
+}
+
 void __init psci_init(void)
 {
 	struct device_node *np;
@@ -279,6 +366,18 @@ static void cpu_psci_cpu_die(unsigned int cpu)
 }
 #endif
 
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+static int cpu_psci_cpu_suspend(unsigned long index)
+{
+	struct psci_power_state *state = __get_cpu_var(psci_power_state);
+
+	if (!state)
+		return -EOPNOTSUPP;
+
+	return psci_ops.cpu_suspend(state[index], virt_to_phys(cpu_resume));
+}
+#endif
+
 const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
 	.cpu_init	= cpu_psci_cpu_init,
@@ -288,6 +387,9 @@ const struct cpu_operations cpu_psci_ops = {
 	.cpu_disable	= cpu_psci_cpu_disable,
 	.cpu_die	= cpu_psci_cpu_die,
 #endif
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+	.cpu_suspend	= cpu_psci_cpu_suspend,
+#endif
 };
 
 #endif
-- 
1.8.4
