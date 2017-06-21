From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 Jun 2017 10:16:44 +0530
Subject: [PATCH V2 5/5] arch_topology: Localize cap_parsing_failed to
 topology_parse_cpu_capacity()
In-Reply-To: <cover.1498019799.git.viresh.kumar@linaro.org>
References: <cover.1498019799.git.viresh.kumar@linaro.org>
Message-ID: <49121c2925a65bc5a0f2be2542abf9a4be9becef.1498019799.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cap_parsing_failed is only required in topology_parse_cpu_capacity() to
know if we have already tried to allocate raw_capacity and failed, or if
at least one of the cpu_node didn't had the required
"capacity-dmips-mhz" property.

All other users can use raw_capacity instead of cap_parsing_failed.

Make sure we set raw_capacity to NULL after we free it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index ff8713b83090..d8923f89724f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -95,14 +95,21 @@ subsys_initcall(register_cpu_capacity_sysctl);
 
 static u32 capacity_scale;
 static u32 *raw_capacity;
-static bool cap_parsing_failed;
+
+static int __init free_raw_capacity(void)
+{
+	kfree(raw_capacity);
+	raw_capacity = NULL;
+
+	return 0;
+}
 
 void topology_normalize_cpu_scale(void)
 {
 	u64 capacity;
 	int cpu;
 
-	if (!raw_capacity || cap_parsing_failed)
+	if (!raw_capacity)
 		return;
 
 	pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
@@ -121,6 +128,7 @@ void topology_normalize_cpu_scale(void)
 
 int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
+	static bool cap_parsing_failed;
 	int ret;
 	u32 cpu_capacity;
 
@@ -151,7 +159,7 @@ int __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
 		}
 		cap_parsing_failed = true;
-		kfree(raw_capacity);
+		free_raw_capacity();
 	}
 
 	return ret;
@@ -170,7 +178,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (cap_parsing_failed)
+	if (!raw_capacity)
 		return 0;
 
 	if (val != CPUFREQ_NOTIFY)
@@ -190,9 +198,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
-		kfree(raw_capacity);
+		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
-		cap_parsing_failed = true;
 		schedule_work(&parsing_done_work);
 	}
 
@@ -232,11 +239,5 @@ static void parsing_done_workfn(struct work_struct *work)
 }
 
 #else
-static int __init free_raw_capacity(void)
-{
-	kfree(raw_capacity);
-
-	return 0;
-}
 core_initcall(free_raw_capacity);
 #endif
-- 
2.13.0.71.gd7076ec9c9cb
