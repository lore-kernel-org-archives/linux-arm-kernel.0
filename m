From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jun 2017 14:55:31 +0530
Subject: [PATCH V3 2/5] arch_topology: Convert switch block to if block
In-Reply-To: <cover.1498209817.git.viresh.kumar@linaro.org>
References: <cover.1498209817.git.viresh.kumar@linaro.org>
Message-ID: <7b5f25af1e0f1365ec6b3996cc31848f529322cd.1498209817.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only need to take care of one case here (CPUFREQ_NOTIFY) and there is
no need to add an extra level of indentation to the case specific code
by using a switch block. Use an if block instead.

Also add some blank lines to make the code look better.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0ad79b5cd56d..a3cd7c869c3e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -174,26 +174,29 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	if (cap_parsing_failed || cap_parsing_done)
 		return 0;
 
-	switch (val) {
-	case CPUFREQ_NOTIFY:
-		pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
-				cpumask_pr_args(policy->related_cpus),
-				cpumask_pr_args(cpus_to_visit));
-		cpumask_andnot(cpus_to_visit, cpus_to_visit,
-			       policy->related_cpus);
-		for_each_cpu(cpu, policy->related_cpus) {
-			raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
-					    policy->cpuinfo.max_freq / 1000UL;
-			capacity_scale = max(raw_capacity[cpu], capacity_scale);
-		}
-		if (cpumask_empty(cpus_to_visit)) {
-			topology_normalize_cpu_scale();
-			kfree(raw_capacity);
-			pr_debug("cpu_capacity: parsing done\n");
-			cap_parsing_done = true;
-			schedule_work(&parsing_done_work);
-		}
+	if (val != CPUFREQ_NOTIFY)
+		return 0;
+
+	pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
+		 cpumask_pr_args(policy->related_cpus),
+		 cpumask_pr_args(cpus_to_visit));
+
+	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
+				    policy->cpuinfo.max_freq / 1000UL;
+		capacity_scale = max(raw_capacity[cpu], capacity_scale);
 	}
+
+	if (cpumask_empty(cpus_to_visit)) {
+		topology_normalize_cpu_scale();
+		kfree(raw_capacity);
+		pr_debug("cpu_capacity: parsing done\n");
+		cap_parsing_done = true;
+		schedule_work(&parsing_done_work);
+	}
+
 	return 0;
 }
 
-- 
2.13.0.71.gd7076ec9c9cb
