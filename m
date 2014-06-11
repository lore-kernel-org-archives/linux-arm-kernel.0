From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 11 Jun 2014 17:18:38 +0100
Subject: [PATCH v4 4/6] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
In-Reply-To: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1402503520-8611-5-git-send-email-lorenzo.pieralisi@arm.com>
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

Reviewed-by: Sebastian Capella <sebcape@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/psci.h |   4 ++
 arch/arm64/kernel/psci.c      | 103 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index e5312ea..16c1351 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,10 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
+struct cpuidle_driver;
 int psci_init(void);
 
+int __init psci_dt_register_idle_states(struct cpuidle_driver *,
+					struct device_node *[]);
+
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 9e9798f..f708bcc 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -15,12 +15,14 @@
 
 #define pr_fmt(fmt) "psci: " fmt
 
+#include <linux/cpuidle.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
 #include <linux/reboot.h>
 #include <linux/pm.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include <uapi/linux/psci.h>
 
 #include <asm/compiler.h>
@@ -28,6 +30,7 @@
 #include <asm/errno.h>
 #include <asm/psci.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/system_misc.h>
 
 #define PSCI_POWER_STATE_TYPE_STANDBY		0
@@ -65,6 +68,8 @@ enum psci_function {
 	PSCI_FN_MAX,
 };
 
+static DEFINE_PER_CPU_READ_MOSTLY(struct psci_power_state *, psci_power_state);
+
 static u32 psci_function_id[PSCI_FN_MAX];
 
 static int psci_to_linux_errno(int errno)
@@ -93,6 +98,18 @@ static u32 psci_power_state_pack(struct psci_power_state state)
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
@@ -199,6 +216,77 @@ static int psci_migrate_info_type(void)
 	return err;
 }
 
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
+		pr_debug("psci-power-state %#x index %u\n", psci_power_state,
+							    i);
+		psci_power_state_unpack(psci_power_state, &psci_states[i]);
+	}
+
+	return 0;
+}
+
 static int get_set_conduit_method(struct device_node *np)
 {
 	const char *method;
@@ -435,6 +523,18 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
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
@@ -445,6 +545,9 @@ const struct cpu_operations cpu_psci_ops = {
 	.cpu_die	= cpu_psci_cpu_die,
 	.cpu_kill	= cpu_psci_cpu_kill,
 #endif
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+	.cpu_suspend	= cpu_psci_cpu_suspend,
+#endif
 };
 
 #endif
-- 
1.8.4
