From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Jul 2017 16:42:42 -0500
Subject: [PATCH] arm64: Convert to using %pOF instead of full_name
Message-ID: <20170718214339.7774-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/kernel/cpu_ops.c  |  4 ++--
 arch/arm64/kernel/smp.c      | 12 ++++++------
 arch/arm64/kernel/topology.c | 22 +++++++++++-----------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index e137ceaf5016..d16978213c5b 100644
--- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -82,8 +82,8 @@ static const char *__init cpu_read_enable_method(int cpu)
 			 * Don't warn spuriously.
 			 */
 			if (cpu != 0)
-				pr_err("%s: missing enable-method property\n",
-					dn->full_name);
+				pr_err("%pOF: missing enable-method property\n",
+					dn);
 		}
 	} else {
 		enable_method = acpi_get_enable_method(cpu);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 321119881abf..dc66e6ec3a99 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -469,7 +469,7 @@ static u64 __init of_get_cpu_mpidr(struct device_node *dn)
 	 */
 	cell = of_get_property(dn, "reg", NULL);
 	if (!cell) {
-		pr_err("%s: missing reg property\n", dn->full_name);
+		pr_err("%pOF: missing reg property\n", dn);
 		return INVALID_HWID;
 	}

@@ -478,7 +478,7 @@ static u64 __init of_get_cpu_mpidr(struct device_node *dn)
 	 * Non affinity bits must be set to 0 in the DT
 	 */
 	if (hwid & ~MPIDR_HWID_BITMASK) {
-		pr_err("%s: invalid reg property\n", dn->full_name);
+		pr_err("%pOF: invalid reg property\n", dn);
 		return INVALID_HWID;
 	}
 	return hwid;
@@ -627,8 +627,8 @@ static void __init of_parse_and_init_cpus(void)
 			goto next;

 		if (is_mpidr_duplicate(cpu_count, hwid)) {
-			pr_err("%s: duplicate cpu reg properties in the DT\n",
-				dn->full_name);
+			pr_err("%pOF: duplicate cpu reg properties in the DT\n",
+				dn);
 			goto next;
 		}

@@ -640,8 +640,8 @@ static void __init of_parse_and_init_cpus(void)
 		 */
 		if (hwid == cpu_logical_map(0)) {
 			if (bootcpu_valid) {
-				pr_err("%s: duplicate boot cpu reg property in DT\n",
-					dn->full_name);
+				pr_err("%pOF: duplicate boot cpu reg property in DT\n",
+					dn);
 				goto next;
 			}

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 79244c75eaec..8d48b233e6ce 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -45,7 +45,7 @@ static int __init get_cpu_for_node(struct device_node *node)
 		}
 	}

-	pr_crit("Unable to find CPU node for %s\n", cpu_node->full_name);
+	pr_crit("Unable to find CPU node for %pOF\n", cpu_node);

 	of_node_put(cpu_node);
 	return -1;
@@ -71,8 +71,8 @@ static int __init parse_core(struct device_node *core, int cluster_id,
 				cpu_topology[cpu].core_id = core_id;
 				cpu_topology[cpu].thread_id = i;
 			} else {
-				pr_err("%s: Can't get CPU for thread\n",
-				       t->full_name);
+				pr_err("%pOF: Can't get CPU for thread\n",
+				       t);
 				of_node_put(t);
 				return -EINVAL;
 			}
@@ -84,15 +84,15 @@ static int __init parse_core(struct device_node *core, int cluster_id,
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
 		if (!leaf) {
-			pr_err("%s: Core has both threads and CPU\n",
-			       core->full_name);
+			pr_err("%pOF: Core has both threads and CPU\n",
+			       core);
 			return -EINVAL;
 		}

 		cpu_topology[cpu].cluster_id = cluster_id;
 		cpu_topology[cpu].core_id = core_id;
 	} else if (leaf) {
-		pr_err("%s: Can't get CPU for leaf core\n", core->full_name);
+		pr_err("%pOF: Can't get CPU for leaf core\n", core);
 		return -EINVAL;
 	}

@@ -137,8 +137,8 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			has_cores = true;

 			if (depth == 0) {
-				pr_err("%s: cpu-map children should be clusters\n",
-				       c->full_name);
+				pr_err("%pOF: cpu-map children should be clusters\n",
+				       c);
 				of_node_put(c);
 				return -EINVAL;
 			}
@@ -146,8 +146,8 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 			if (leaf) {
 				ret = parse_core(c, cluster_id, core_id++);
 			} else {
-				pr_err("%s: Non-leaf cluster with core %s\n",
-				       cluster->full_name, name);
+				pr_err("%pOF: Non-leaf cluster with core %s\n",
+				       cluster, name);
 				ret = -EINVAL;
 			}

@@ -159,7 +159,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
 	} while (c);

 	if (leaf && !has_cores)
-		pr_warn("%s: empty cluster\n", cluster->full_name);
+		pr_warn("%pOF: empty cluster\n", cluster);

 	if (leaf)
 		cluster_id++;
--
2.11.0
