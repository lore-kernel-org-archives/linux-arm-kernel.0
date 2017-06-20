From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Jun 2017 16:14:40 +0530
Subject: [PATCH] arm64: topology: Get rid of "cap_parsing_done"
Message-ID: <9e5d20e285e04341ea1a7f43c9af2ff6d6d072dd.1497955347.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can reuse "cap_parsing_failed" instead of keeping an additional
variable. Also rename cap_parsing_failed to skip_cap_parsing.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/kernel/topology.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 08243533e5ee..ab9ac10ce66e 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -101,14 +101,14 @@ subsys_initcall(register_cpu_capacity_sysctl);
 
 static u32 capacity_scale;
 static u32 *raw_capacity;
-static bool cap_parsing_failed;
+static bool skip_cap_parsing;
 
 static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
 	int ret;
 	u32 cpu_capacity;
 
-	if (cap_parsing_failed)
+	if (skip_cap_parsing)
 		return;
 
 	ret = of_property_read_u32(cpu_node,
@@ -121,7 +121,7 @@ static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 					       GFP_KERNEL);
 			if (!raw_capacity) {
 				pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
-				cap_parsing_failed = true;
+				skip_cap_parsing = true;
 				return;
 			}
 		}
@@ -135,7 +135,7 @@ static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 				cpu_node->full_name);
 			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
 		}
-		cap_parsing_failed = true;
+		skip_cap_parsing = true;
 		kfree(raw_capacity);
 	}
 }
@@ -145,7 +145,7 @@ static void normalize_cpu_capacity(void)
 	u64 capacity;
 	int cpu;
 
-	if (!raw_capacity || cap_parsing_failed)
+	if (!raw_capacity || skip_cap_parsing)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
@@ -164,7 +164,6 @@ static void normalize_cpu_capacity(void)
 
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
-static bool cap_parsing_done;
 static void parsing_done_workfn(struct work_struct *work);
 static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
@@ -176,7 +175,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (cap_parsing_failed || cap_parsing_done)
+	if (skip_cap_parsing)
 		return 0;
 
 	switch (val) {
@@ -195,8 +194,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		if (cpumask_empty(cpus_to_visit)) {
 			normalize_cpu_capacity();
 			kfree(raw_capacity);
+			skip_cap_parsing = true;
 			pr_debug("cpu_capacity: parsing done\n");
-			cap_parsing_done = true;
 			schedule_work(&parsing_done_work);
 		}
 	}
@@ -214,7 +213,7 @@ static int __init register_cpufreq_notifier(void)
 	 * until we have the necessary code to parse the cpu capacity, so
 	 * skip registering cpufreq notifier.
 	 */
-	if (!acpi_disabled || cap_parsing_failed)
+	if (!acpi_disabled || skip_cap_parsing)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
@@ -401,7 +400,7 @@ static int __init parse_dt_topology(void)
 	 */
 	map = of_get_child_by_name(cn, "cpu-map");
 	if (!map) {
-		cap_parsing_failed = true;
+		skip_cap_parsing = true;
 		goto out;
 	}
 
-- 
2.13.0.71.gd7076ec9c9cb
