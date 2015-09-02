From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 02 Sep 2015 18:47:56 +0200
Subject: [PATCH v2] cpufreq-dt: add suspend frequency support
Message-ID: <1441212476-21316-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend frequency support and set it to the boot frequency,
this matches what the old exynos-cpufreq driver has been doing.

This patch fixes suspend/resume support on Exynos4412 based
Trats2 board and reboot hang on Exynos4412 based Odroid U3
board.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
This patch supersedes "[PATCH] ARM: dts: exynos4412-odroid-*: add
workaround for CPUfreq/reboot issue" one from yesterday.

v2:
- remove superfluous ";"

 drivers/cpufreq/cpufreq-dt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index c3583cd..c9138c7 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -329,6 +329,10 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = priv;
 
 	policy->clk = cpu_clk;
+
+	/* capture boot frequency */
+	policy->suspend_freq = clk_get_rate(cpu_clk) / 1000;
+
 	ret = cpufreq_table_validate_and_show(policy, freq_table);
 	if (ret) {
 		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
@@ -419,6 +423,9 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
+#ifdef CONFIG_PM
+	.suspend = cpufreq_generic_suspend,
+#endif
 };
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
-- 
1.9.1
