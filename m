From: broonie@kernel.org (Mark Brown)
Date: Wed,  8 Jan 2014 19:12:08 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1389208330-12495-1-git-send-email-broonie@kernel.org>
References: <1389208330-12495-1-git-send-email-broonie@kernel.org>
Message-ID: <1389208330-12495-2-git-send-email-broonie@kernel.org>
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
 arch/arm64/kernel/topology.c | 150 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 20eef01a4707..e77c6b0844be 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -17,10 +17,157 @@
 #include <linux/percpu.h>
 #include <linux/node.h>
 #include <linux/nodemask.h>
+#include <linux/of.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 
 #include <asm/topology.h>
 
+#ifdef CONFIG_OF
+static int cluster_id;
+
+static int __init get_cpu_for_node(struct device_node *node)
+{
+	struct device_node *cpu_node;
+	int cpu;
+
+	cpu_node = of_parse_phandle(node, "cpu", 0);
+	if (!cpu_node) {
+		pr_crit("%s: Unable to parse CPU phandle\n", node->full_name);
+		return -1;
+	}
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
+static void __init parse_core(struct device_node *core, int core_id)
+{
+	char name[10];
+	bool leaf = true;
+	int i, cpu;
+	struct device_node *t;
+
+	i = 0;
+	do {
+		snprintf(name, sizeof(name), "thread%d", i);
+		t = of_get_child_by_name(core, name);
+		if (t) {
+			leaf = false;
+			cpu = get_cpu_for_node(t);
+			if (cpu >= 0) {
+				pr_info("CPU%d: socket %d core %d thread %d\n",
+					cpu, cluster_id, core_id, i);
+				cpu_topology[cpu].socket_id = cluster_id;
+				cpu_topology[cpu].core_id = core_id;
+				cpu_topology[cpu].thread_id = i;
+			} else {
+				pr_err("%s: Can't get CPU for thread\n",
+				       t->full_name);
+			}
+		}
+		i++;
+	} while (t);
+
+	cpu = get_cpu_for_node(core);
+	if (cpu >= 0) {
+		if (!leaf) {
+			pr_err("%s: Core has both threads and CPU\n",
+			       core->full_name);
+			return;
+		}
+
+		pr_info("CPU%d: socket %d core %d\n",
+			cpu, cluster_id, core_id);
+		cpu_topology[cpu].socket_id = cluster_id;
+		cpu_topology[cpu].core_id = core_id;
+	} else if (leaf) {
+		pr_err("%s: Can't get CPU for leaf core\n", core->full_name);
+	}
+}
+
+static void __init parse_cluster(struct device_node *cluster, int depth)
+{
+	char name[10];
+	bool leaf = true;
+	bool has_cores = false;
+	struct device_node *c;
+	int core_id = 0;
+	int i;
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
+			parse_cluster(c, depth + 1);
+			leaf = false;
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
+			if (leaf)
+				parse_core(c, core_id++);
+			else
+				pr_err("%s: Non-leaf cluster with core %s\n",
+				       cluster->full_name, name);
+		}
+		i++;
+	} while (c);
+
+	if (leaf && !has_cores)
+		pr_warn("%s: empty cluster\n", cluster->full_name);
+
+	if (leaf)
+		cluster_id++;
+}
+
+static void __init parse_dt_topology(void)
+{
+	struct device_node *cn;
+
+	cn = of_find_node_by_path("/cpus");
+	if (!cn) {
+		pr_err("No CPU information found in DT\n");
+		return;
+	}
+
+	/*
+	 * If topology is provided as a cpu-map it is essentially a
+	 * root cluster.
+	 */
+	cn = of_find_node_by_name(cn, "cpu-map");
+	if (!cn)
+		return;
+	parse_cluster(cn, 0);
+}
+
+#else
+static inline void parse_dt_topology(void) {}
+#endif
+
 /*
  * cpu topology table
  */
@@ -87,5 +234,8 @@ void __init init_cpu_topology(void)
 		cpumask_clear(&cpu_topo->core_sibling);
 		cpumask_clear(&cpu_topo->thread_sibling);
 	}
+
+	parse_dt_topology();
+
 	smp_wmb();
 }
-- 
1.8.5.2
