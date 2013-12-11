From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 20:00:29 +0000
Subject: [PATCH 3/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1386792029-23148-1-git-send-email-broonie@kernel.org>
References: <1386792029-23148-1-git-send-email-broonie@kernel.org>
Message-ID: <1386792029-23148-3-git-send-email-broonie@kernel.org>
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
 arch/arm64/kernel/topology.c | 130 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index c88970b1b863..83d6919d4e0a 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -79,6 +79,121 @@ static unsigned long *__cpu_capacity;
 #define cpu_capacity(cpu)	__cpu_capacity[cpu]
 
 static unsigned long middle_capacity = 1;
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
+			if (cpu) {
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
+static void __init parse_cluster(struct device_node *cluster)
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
+			parse_cluster(c);
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
 
 /*
  * Iterate all CPUs' descriptor in DT and compute the efficiency
@@ -100,6 +215,21 @@ static void __init parse_dt_topology(void)
 	alloc_size = nr_cpu_ids * sizeof(*__cpu_capacity);
 	__cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);
 
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
+	parse_cluster(cn);
+
 	for_each_possible_cpu(cpu) {
 		const u32 *rate;
 		int len;
-- 
1.8.5.1
