From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 Jun 2017 10:16:42 +0530
Subject: [PATCH V2 3/5] arch_topology: Covert switch block to if block
In-Reply-To: <cover.1498019799.git.viresh.kumar@linaro.org>
References: <cover.1498019799.git.viresh.kumar@linaro.org>
Message-ID: <f89ae3636581c7746d617627b352f17f033dcb9e.1498019799.git.viresh.kumar@linaro.org>
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
index 2f1d9921ee54..07784ba666a7 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -173,26 +173,29 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	if (cap_parsing_failed)
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
-			cap_parsing_failed = true;
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
+		cap_parsing_failed = true;
+		schedule_work(&parsing_done_work);
+	}
+
 	return 0;
 }
 
-- 
2.13.0.71.gd7076ec9c9cb
