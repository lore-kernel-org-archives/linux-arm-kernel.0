From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 29 Apr 2013 18:54:46 +0530
Subject: [PATCH 3/5] cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if
 clock-latency isn't found
In-Reply-To: <cover.1367241503.git.viresh.kumar@linaro.org>
References: <cover.1367241503.git.viresh.kumar@linaro.org>
Message-ID: <7103baee30f84c26eb6080e407a9f91d219a54c0.1367241503.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If "/cpus" node isn't found or "clock-latency" isn't defined we are returning
error currently. Lets return CPUFREQ_ETERNAL instead, so that we don't fail.

Flag appropriate messages to user in such cases.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little_dt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index d5ae4d2..173ed05 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -66,8 +66,8 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 
 	parent = of_find_node_by_path("/cpus");
 	if (!parent) {
-		pr_err("failed to find OF /cpus\n");
-		return -ENOENT;
+		pr_info("Failed to find OF /cpus. Use CPUFREQ_ETERNAL transition latency\n");
+		return CPUFREQ_ETERNAL;
 	}
 
 	for_each_child_of_node(parent, np) {
@@ -81,7 +81,8 @@ static int dt_get_transition_latency(struct device *cpu_dev)
 		return transition_latency;
 	}
 
-	return -ENODEV;
+	pr_info("clock-latency isn't found, use CPUFREQ_ETERNAL transition latency\n");
+	return CPUFREQ_ETERNAL;
 }
 
 static struct cpufreq_arm_bL_ops dt_bL_ops = {
-- 
1.7.12.rc2.18.g61b472e
