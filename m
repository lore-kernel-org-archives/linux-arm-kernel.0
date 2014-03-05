From: broonie@kernel.org (Mark Brown)
Date: Wed,  5 Mar 2014 16:59:34 +0800
Subject: [PATCH 2/3] arm64: topology: Tell the scheduler about the relative
 power of cores
In-Reply-To: <1394009975-28655-1-git-send-email-broonie@kernel.org>
References: <1394009975-28655-1-git-send-email-broonie@kernel.org>
Message-ID: <1394009975-28655-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

In heterogeneous systems like big.LITTLE systems the scheduler will be
able to make better use of the available cores if we provide power numbers
to it indicating their relative performance. Do this by parsing the CPU
nodes in the DT.

This code currently has no effect as no information on the relative
performance of the cores is provided.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 arch/arm64/kernel/topology.c | 146 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 8e0f29a..3a80979 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -19,9 +19,33 @@
 #include <linux/nodemask.h>
 #include <linux/of.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 
 #include <asm/topology.h>
 
+/*
+ * cpu power table
+ * This per cpu data structure describes the relative capacity of each core.
+ * On a heteregenous system, cores don't have the same computation capacity
+ * and we reflect that difference in the cpu_power field so the scheduler can
+ * take this difference into account during load balance. A per cpu structure
+ * is preferred because each CPU updates its own cpu_power field during the
+ * load balance except for idle cores. One idle core is selected to run the
+ * rebalance_domains for all idle cores and the cpu_power can be updated
+ * during this sequence.
+ */
+static DEFINE_PER_CPU(unsigned long, cpu_scale);
+
+unsigned long arch_scale_freq_power(struct sched_domain *sd, int cpu)
+{
+	return per_cpu(cpu_scale, cpu);
+}
+
+static void set_power_scale(unsigned int cpu, unsigned long power)
+{
+	per_cpu(cpu_scale, cpu) = power;
+}
+
 #ifdef CONFIG_OF
 static int __init get_cpu_for_node(struct device_node *node)
 {
@@ -148,9 +172,49 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	return 0;
 }
 
+struct cpu_efficiency {
+	const char *compatible;
+	unsigned long efficiency;
+};
+
+/*
+ * Table of relative efficiency of each processors
+ * The efficiency value must fit in 20bit and the final
+ * cpu_scale value must be in the range
+ *   0 < cpu_scale < 3*SCHED_POWER_SCALE/2
+ * in order to return@most 1 when DIV_ROUND_CLOSEST
+ * is used to compute the capacity of a CPU.
+ * Processors that are not defined in the table,
+ * use the default SCHED_POWER_SCALE value for cpu_scale.
+ */
+static const struct cpu_efficiency table_efficiency[] = {
+	{ NULL, },
+};
+
+static unsigned long *__cpu_capacity;
+#define cpu_capacity(cpu)	__cpu_capacity[cpu]
+
+static unsigned long middle_capacity = 1;
+
+/*
+ * Iterate all CPUs' descriptor in DT and compute the efficiency
+ * (as per table_efficiency). Also calculate a middle efficiency
+ * as close as possible to  (max{eff_i} - min{eff_i}) / 2
+ * This is later used to scale the cpu_power field such that an
+ * 'average' CPU is of middle power. Also see the comments near
+ * table_efficiency[] and update_cpu_power().
+ */
 static int __init parse_dt_topology(void)
 {
+	const struct cpu_efficiency *cpu_eff;
 	struct device_node *cn;
+	unsigned long min_capacity = ULONG_MAX;
+	unsigned long max_capacity = 0;
+	unsigned long capacity = 0;
+	int cpu, ret;
+
+	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
+				 GFP_NOWAIT);
 
 	cn = of_find_node_by_path("/cpus");
 	if (!cn) {
@@ -165,11 +229,88 @@ static int __init parse_dt_topology(void)
 	cn = of_get_child_by_name(cn, "cpu-map");
 	if (!cn)
 		return 0;
-	return parse_cluster(cn, 0);
+
+	ret = parse_cluster(cn, 0);
+	if (ret != 0)
+		return ret;
+
+	for_each_possible_cpu(cpu) {
+		const u32 *rate;
+		int len;
+
+		/* Too early to use cpu->of_node */
+		cn = of_get_cpu_node(cpu, NULL);
+		if (!cn) {
+			pr_err("Missing device node for CPU %d\n", cpu);
+			continue;
+		}
+
+		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
+			if (of_device_is_compatible(cn, cpu_eff->compatible))
+				break;
+
+		if (cpu_eff->compatible == NULL) {
+			pr_warn("%s: Unknown CPU type\n", cn->full_name);
+			continue;
+		}
+
+		rate = of_get_property(cn, "clock-frequency", &len);
+		if (!rate || len != 4) {
+			pr_err("%s: Missing clock-frequency property\n",
+				cn->full_name);
+			continue;
+		}
+
+		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
+
+		/* Save min capacity of the system */
+		if (capacity < min_capacity)
+			min_capacity = capacity;
+
+		/* Save max capacity of the system */
+		if (capacity > max_capacity)
+			max_capacity = capacity;
+
+		cpu_capacity(cpu) = capacity;
+	}
+
+	/* If min and max capacities are equal we bypass the update of the
+	 * cpu_scale because all CPUs have the same capacity. Otherwise, we
+	 * compute a middle_capacity factor that will ensure that the capacity
+	 * of an 'average' CPU of the system will be as close as possible to
+	 * SCHED_POWER_SCALE, which is the default value, but with the
+	 * constraint explained near table_efficiency[].
+	 */
+	if (min_capacity == max_capacity)
+		return 0;
+	else if (4 * max_capacity < (3 * (max_capacity + min_capacity)))
+		middle_capacity = (min_capacity + max_capacity)
+				>> (SCHED_POWER_SHIFT+1);
+	else
+		middle_capacity = ((max_capacity / 3)
+				>> (SCHED_POWER_SHIFT-1)) + 1;
+
+}
+
+/*
+ * Look for a customed capacity of a CPU in the cpu_topo_data table during the
+ * boot. The update of all CPUs is in O(n^2) for heteregeneous system but the
+ * function returns directly for SMP system.
+ */
+static void update_cpu_power(unsigned int cpu)
+{
+	if (!cpu_capacity(cpu))
+		return;
+
+	set_power_scale(cpu, cpu_capacity(cpu) / middle_capacity);
+
+	pr_info("CPU%u: update cpu_power %lu\n",
+		cpu, arch_scale_freq_power(NULL, cpu));
 }
 
 #else
 static inline int parse_dt_topology(void) { return 0; }
+static inline void update_cpu_power(unsigned int cpuid) {}
 #endif
 
 /*
@@ -223,6 +364,7 @@ static void update_siblings_masks(unsigned int cpuid)
 void store_cpu_topology(unsigned int cpuid)
 {
 	update_siblings_masks(cpuid);
+	update_cpu_power(cpuid);
 }
 
 static void __init reset_cpu_topology(void)
@@ -238,6 +380,8 @@ static void __init reset_cpu_topology(void)
 		cpu_topo->cluster_id = -1;
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
+
+		set_power_scale(cpu, SCHED_POWER_SCALE);
 	}
 }
 
-- 
1.9.0
