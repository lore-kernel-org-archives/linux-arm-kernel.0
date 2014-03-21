From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Mar 2014 17:27:59 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1395422881-10029-1-git-send-email-broonie@kernel.org>
References: <1395422881-10029-1-git-send-email-broonie@kernel.org>
Message-ID: <1395422881-10029-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Add support for parsing the explicit topology bindings to discover the
topology of the system.

Since it is not currently clear how to map multi-level clusters for the
scheduler all leaf clusters are presented to the scheduler at the same
level. This should be enough to provide good support for current systems.

Signed-off-by: Mark Brown <broonie@linaro.org>
---

 - Discard the DT data if any CPUs are omitted from the topology.
 - Call of_node_put() where required.

 arch/arm64/kernel/topology.c | 192 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 186 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index ff662b23af5f..d0cb687fb7f5 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -17,10 +17,183 @@
 #include <linux/percpu.h>
 #include <linux/node.h>
 #include <linux/nodemask.h>
+#include <linux/of.h>
 #include <linux/sched.h>
 
 #include <asm/topology.h>
 
+static int __init get_cpu_for_node(struct device_node *node)
+{
+	struct device_node *cpu_node;
+	int cpu;
+
+	cpu_node = of_parse_phandle(node, "cpu", 0);
+	if (!cpu_node)
+		return -1;
+
+	for_each_possible_cpu(cpu) {
+		if (of_get_cpu_node(cpu, NULL) == cpu_node)
+			return cpu;
+	}
+
+	pr_crit("Unable to find CPU node for %s\n", cpu_node->full_name);
+	return -1;
+}
+
+static int __init parse_core(struct device_node *core, int cluster_id,
+			     int core_id)
+{
+	char name[10];
+	bool leaf = true;
+	int i = 0;
+	int cpu;
+	struct device_node *t;
+
+	do {
+		snprintf(name, sizeof(name), "thread%d", i);
+		t = of_get_child_by_name(core, name);
+		if (t) {
+			leaf = false;
+			cpu = get_cpu_for_node(t);
+			if (cpu >= 0) {
+				cpu_topology[cpu].cluster_id = cluster_id;
+				cpu_topology[cpu].core_id = core_id;
+				cpu_topology[cpu].thread_id = i;
+			} else {
+				pr_err("%s: Can't get CPU for thread\n",
+				       t->full_name);
+				return -EINVAL;
+			}
+			of_node_put(t);
+		}
+		i++;
+	} while (t);
+
+	cpu = get_cpu_for_node(core);
+	if (cpu >= 0) {
+		if (!leaf) {
+			pr_err("%s: Core has both threads and CPU\n",
+			       core->full_name);
+			return -EINVAL;
+		}
+
+		cpu_topology[cpu].cluster_id = cluster_id;
+		cpu_topology[cpu].core_id = core_id;
+	} else if (leaf) {
+		pr_err("%s: Can't get CPU for leaf core\n", core->full_name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int __init parse_cluster(struct device_node *cluster, int depth)
+{
+	char name[10];
+	bool leaf = true;
+	bool has_cores = false;
+	struct device_node *c;
+	static int cluster_id __initdata;
+	int core_id = 0;
+	int i, ret;
+
+	/*
+	 * First check for child clusters; we currently ignore any
+	 * information about the nesting of clusters and present the
+	 * scheduler with a flat list of them.
+	 */
+	i = 0;
+	do {
+		snprintf(name, sizeof(name), "cluster%d", i);
+		c = of_get_child_by_name(cluster, name);
+		if (c) {
+			ret = parse_cluster(c, depth + 1);
+			if (ret != 0)
+				return ret;
+			leaf = false;
+			of_node_put(c);
+		}
+		i++;
+	} while (c);
+
+	/* Now check for cores */
+	i = 0;
+	do {
+		snprintf(name, sizeof(name), "core%d", i);
+		c = of_get_child_by_name(cluster, name);
+		if (c) {
+			has_cores = true;
+
+			if (depth == 0)
+				pr_err("%s: cpu-map children should be clusters\n",
+				       c->full_name);
+
+			if (leaf) {
+				ret = parse_core(c, cluster_id, core_id++);
+				if (ret != 0)
+					return ret;
+			} else {
+				pr_err("%s: Non-leaf cluster with core %s\n",
+				       cluster->full_name, name);
+				return -EINVAL;
+			}
+			of_node_put(c);
+		}
+		i++;
+	} while (c);
+
+	if (leaf && !has_cores)
+		pr_warn("%s: empty cluster\n", cluster->full_name);
+
+	if (leaf)
+		cluster_id++;
+
+	return 0;
+}
+
+static int __init parse_dt_topology(void)
+{
+	struct device_node *cn, *map;
+	int ret = 0;
+	int cpu;
+
+	cn = of_find_node_by_path("/cpus");
+	if (!cn) {
+		pr_err("No CPU information found in DT\n");
+		return 0;
+	}
+
+	/*
+	 * When topology is provided cpu-map is essentially a root
+	 * cluster with restricted subnodes.
+	 */
+	map = of_get_child_by_name(cn, "cpu-map");
+	if (!map)
+		goto out;
+
+	ret = parse_cluster(map, 0);
+	if (ret != 0)
+		goto out;
+
+	of_node_put(map);
+
+	/*
+	 * Check that all cores are in the topology; the SMP code will
+	 * only mark cores described in the DT as possible.
+	 */
+	for_each_possible_cpu(cpu) {
+		if (cpu_topology[cpu].cluster_id == -1) {
+			pr_err("CPU%d: No topology information specified\n",
+			       cpu);
+			ret = -EINVAL;
+		}
+	}
+
+out:
+	of_node_put(cn);
+	return ret;
+}
+
 /*
  * cpu topology table
  */
@@ -71,15 +244,10 @@ void store_cpu_topology(unsigned int cpuid)
 	update_siblings_masks(cpuid);
 }
 
-/*
- * init_cpu_topology is called at boot when only one cpu is running
- * which prevent simultaneous write access to cpu_topology array
- */
-void __init init_cpu_topology(void)
+static void __init reset_cpu_topology(void)
 {
 	unsigned int cpu;
 
-	/* init core mask and power*/
 	for_each_possible_cpu(cpu) {
 		struct cpu_topology *cpu_topo = &cpu_topology[cpu];
 
@@ -93,3 +261,15 @@ void __init init_cpu_topology(void)
 		cpumask_set_cpu(cpu, &cpu_topo->thread_sibling);
 	}
 }
+
+void __init init_cpu_topology(void)
+{
+	reset_cpu_topology();
+
+	/*
+	 * Discard anything that was parsed if we hit an error so we
+	 * don't use partial information.
+	 */
+	if (parse_dt_topology())
+		reset_cpu_topology();
+}
-- 
1.9.1
