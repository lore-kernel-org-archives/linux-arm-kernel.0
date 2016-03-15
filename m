From: dawei.chien@mediatek.com (Dawei Chien)
Date: Tue, 15 Mar 2016 16:10:35 +0800
Subject: [RESEND][PATCH 1/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1458029437-12846-2-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 cpufreq driver select of_cpufreq_power_cooling_register registering
cooling devices with dynamic power coefficient.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
This patch is base on patchset:
https://lkml.org/lkml/2015/11/17/251
---
 drivers/cpufreq/mt8173-cpufreq.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 1efba34..d8ad406 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -309,17 +309,24 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+#define DYNAMIC_POWER "dynamic-power-coefficient"
+
 static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 	struct device_node *np = of_node_get(info->cpu_dev->of_node);
+	u32 capacitance = 0;
 
 	if (WARN_ON(!np))
 		return;
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		info->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		of_property_read_u32(np, DYNAMIC_POWER, &capacitance);
+
+		info->cdev = of_cpufreq_power_cooling_register(np,
+						policy->related_cpus,
+						capacitance,
+						NULL);
 
 		if (IS_ERR(info->cdev)) {
 			dev_err(info->cpu_dev,
-- 
1.7.9.5
