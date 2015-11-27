From: dawei.chien@mediatek.com (Dawei Chien)
Date: Fri, 27 Nov 2015 17:32:07 +0800
Subject: [PATCH v4 3/3] thermal: mediatek: Add cpu dynamic power cooling model.
In-Reply-To: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 cpufreq driver use of_cpufreq_power_cooling_register registering
cooling devices with dynamic power coefficient.

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
This patch is base on patchset:
https://lkml.org/lkml/2015/11/17/251
---
 drivers/cpufreq/mt8173-cpufreq.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 83001dc..4d39468 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -263,24 +263,34 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 	return 0;
 }
 
+#define DYNAMIC_POWER "dynamic-power-coefficient"
+
 static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 	struct device_node *np = of_node_get(info->cpu_dev->of_node);
+	u32 capacitance;
 
 	if (WARN_ON(!np))
 		return;
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		info->cdev = of_cpufreq_cooling_register(np,
-							 policy->related_cpus);
+		if (!info->cdev) {
+			of_property_read_u32(np, DYNAMIC_POWER, &capacitance);
+
+			info->cdev = of_cpufreq_power_cooling_register(np,
+							policy->related_cpus,
+							capacitance,
+							NULL);
 
-		if (IS_ERR(info->cdev)) {
-			dev_err(info->cpu_dev,
-				"running cpufreq without cooling device: %ld\n",
-				PTR_ERR(info->cdev));
+			if (IS_ERR(info->cdev)) {
+				dev_err(info->cpu_dev,
+					"running cpufreq without cooling device: %ld\n",
+					PTR_ERR(info->cdev));
 
-			info->cdev = NULL;
+				info->cdev = NULL;
+			}
 		}
 	}
 
@@ -460,7 +470,9 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 
-	cpufreq_cooling_unregister(info->cdev);
+	if (info->cdev)
+		cpufreq_cooling_unregister(info->cdev);
+
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
 	mtk_cpu_dvfs_info_release(info);
 	kfree(info);
-- 
1.7.9.5
