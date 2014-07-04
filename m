From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Fri, 04 Jul 2014 19:22:40 +0900
Subject: [PATCH] thermal: Add missing cpumask_clear
Message-ID: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cpumasks should be cleared before using.

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/thermal/db8500_cpufreq_cooling.c        |    1 +
 drivers/thermal/imx_thermal.c                   |    1 +
 drivers/thermal/samsung/exynos_thermal_common.c |    1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
index 786d192..1fa46ff 100644
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ b/drivers/thermal/db8500_cpufreq_cooling.c
@@ -34,6 +34,7 @@ static int db8500_cpufreq_cooling_probe(struct platform_device *pdev)
 	if (!cpufreq_frequency_get_table(0))
 		return -EPROBE_DEFER;
 
+	cpumask_clear(&mask_val);
 	cpumask_set_cpu(0, &mask_val);
 	cdev = cpufreq_cooling_register(&mask_val);
 
diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index a99c631..a21acf8 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -449,6 +449,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	regmap_write(map, MISC0 + REG_SET, MISC0_REFTOP_SELBIASOFF);
 	regmap_write(map, TEMPSENSE0 + REG_SET, TEMPSENSE0_POWER_DOWN);
 
+	cpumask_clear(&clip_cpus);
 	cpumask_set_cpu(0, &clip_cpus);
 	data->cdev = cpufreq_cooling_register(&clip_cpus);
 	if (IS_ERR(data->cdev)) {
diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 3f5ad25..47efa4c 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -361,6 +361,7 @@ int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 		return -ENOMEM;
 
 	th_zone->sensor_conf = sensor_conf;
+	cpumask_clear(&mask_val);
 	/*
 	 * TODO: 1) Handle multiple cooling devices in a thermal zone
 	 *	 2) Add a flag/name in cooling info to map to specific
-- 
1.7.10.4
