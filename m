From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Mar 2014 10:20:26 +0000
Subject: [PATCH RFC 2/4] arm64: add PSCI CPU_SUSPEND based cpu_suspend support
In-Reply-To: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1395138028-19630-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the cpu_suspend cpu operations method through
the PSCI CPU_SUSPEND API. The PSCI implementation translates the idle state
index passed by the cpu_suspend core call into a valid PSCI state according to
the PSCI states initialized at boot by the PSCI protocol backend.

Entry point is set to cpu_resume physical address, that represents the
default kernel execution address following a CPU reset.

Idle state index 0 is initialized to power state standby WFI so that if called
by the idle driver it provides the default behaviour.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/psci.h   |  6 +++
 arch/arm64/kernel/idle_states.c |  1 +
 arch/arm64/kernel/psci.c        | 84 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
index e5312ea..b8ec598 100644
--- a/arch/arm64/include/asm/psci.h
+++ b/arch/arm64/include/asm/psci.h
@@ -14,6 +14,12 @@
 #ifndef __ASM_PSCI_H
 #define __ASM_PSCI_H
 
+struct idle_state;
+
 int psci_init(void);
 
+int __init psci_register_idle_states(struct cpumask *cpumask,
+				     struct idle_state *idle_states,
+				     unsigned int count);
+
 #endif /* __ASM_PSCI_H */
diff --git a/arch/arm64/kernel/idle_states.c b/arch/arm64/kernel/idle_states.c
index 0386cff..eb1e912 100644
--- a/arch/arm64/kernel/idle_states.c
+++ b/arch/arm64/kernel/idle_states.c
@@ -31,6 +31,7 @@ struct protocol_init {
 };
 
 static const struct protocol_init protocols[] __initconst = {
+	{"arm,psci", psci_register_idle_states},
 	{}
 };
 
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 4f97db3..fe01589 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -18,12 +18,15 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/slab.h>
 
 #include <asm/compiler.h>
 #include <asm/cpu_ops.h>
 #include <asm/errno.h>
+#include <asm/idle_states.h>
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
@@ -176,6 +192,59 @@ static const struct of_device_id psci_of_match[] __initconst = {
 	{},
 };
 
+int __init psci_register_idle_states(struct cpumask *cpumask,
+				     struct idle_state *idle_states,
+				     unsigned int count)
+{
+	int cpu, i;
+	struct psci_power_state *psci_states;
+	const struct cpu_operations *cpu_ops_ptr;
+
+	if (!idle_states)
+		return -EINVAL;
+	/*
+	 * This is belt-and-braces: make sure that if the idle
+	 * specified protocol is psci, the cpu_ops have been
+	 * initialized to psci operations. Anything else is
+	 * a recipe for mayhem.
+	 */
+	for_each_cpu(cpu, cpumask) {
+		cpu_ops_ptr = cpu_ops[cpu];
+		if (WARN_ON(!cpu_ops_ptr || strcmp(cpu_ops_ptr->name, "psci")))
+			return -EOPNOTSUPP;
+	}
+
+	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+
+	if (!psci_states) {
+		pr_warn("psci idle state allocation failed\n");
+		return -ENOMEM;
+	}
+
+	for_each_cpu(cpu, cpumask) {
+		if (per_cpu(psci_power_state, cpu)) {
+			pr_warn("idle states already initialized on cpu %u\n",
+				cpu);
+			continue;
+		}
+		per_cpu(psci_power_state, cpu) = psci_states;
+	}
+
+	/*
+	 * Index 0 is always considered as standby wfi
+	 */
+	psci_states[0].type = PSCI_POWER_STATE_TYPE_STANDBY;
+
+	for (i = 1; i < count; i++) {
+		pr_debug("psci-power-state %#x index %u\n",
+			 idle_states[i].state->param, i);
+		psci_power_state_unpack(idle_states[i].state->param,
+					&psci_states[i]);
+	}
+
+	return 0;
+}
+
 int __init psci_init(void)
 {
 	struct device_node *np;
@@ -282,6 +351,18 @@ static void cpu_psci_cpu_die(unsigned int cpu)
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
@@ -291,6 +372,9 @@ const struct cpu_operations cpu_psci_ops = {
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
