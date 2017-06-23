From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jun 2017 14:55:34 +0530
Subject: [PATCH V3 5/5] arch_topology: Get rid of cap_parsing_done
In-Reply-To: <cover.1498209817.git.viresh.kumar@linaro.org>
References: <cover.1498209817.git.viresh.kumar@linaro.org>
Message-ID: <7199675116c3b27cec234b8bd50d94e88b26032a.1498209817.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to check for cap_parsing_done flag anymore as
!raw_capacity flag alone is enough for us. Remove the (now) useless flag
cap_parsing_done.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 9e4d2107f4fa..74043ead9da1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -167,7 +167,6 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
-static bool cap_parsing_done;
 static void parsing_done_workfn(struct work_struct *work);
 static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
@@ -179,7 +178,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (!raw_capacity || cap_parsing_done)
+	if (!raw_capacity)
 		return 0;
 
 	if (val != CPUFREQ_NOTIFY)
@@ -201,7 +200,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		topology_normalize_cpu_scale();
 		free_raw_capacity();
 		pr_debug("cpu_capacity: parsing done\n");
-		cap_parsing_done = true;
 		schedule_work(&parsing_done_work);
 	}
 
-- 
2.13.0.71.gd7076ec9c9cb
