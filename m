From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jul 2015 17:43:37 +0200
Subject: [PATCH v2 3/7] cpufreq-dt: add turbo modes support
In-Reply-To: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1436456621-29839-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add turbo modes (from opp-v2 bindings) support using
existing cpufreq 'boost' mode infrastructure:
- add boost_supported field to struct cpufreq_dt_platform_data
- set dt_cpufreq_driver.boost_supported in dt_cpufreq_probe()

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq-dt.c | 7 ++++++-
 include/linux/cpufreq-dt.h   | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 60d98fb..9024205 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -408,6 +408,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 
 static int dt_cpufreq_probe(struct platform_device *pdev)
 {
+	struct cpufreq_dt_platform_data *pd;
 	struct device *cpu_dev;
 	struct regulator *cpu_reg;
 	struct clk *cpu_clk;
@@ -428,7 +429,11 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	if (!IS_ERR(cpu_reg))
 		regulator_put(cpu_reg);
 
-	dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
+	pd = dev_get_platdata(&pdev->dev);
+	dt_cpufreq_driver.driver_data = pd;
+
+	if (pd)
+		dt_cpufreq_driver.boost_supported = pd->boost_supported;
 
 	ret = cpufreq_register_driver(&dt_cpufreq_driver);
 	if (ret)
diff --git a/include/linux/cpufreq-dt.h b/include/linux/cpufreq-dt.h
index 0414009..483ca1b 100644
--- a/include/linux/cpufreq-dt.h
+++ b/include/linux/cpufreq-dt.h
@@ -17,6 +17,7 @@ struct cpufreq_dt_platform_data {
 	 * clock.
 	 */
 	bool independent_clocks;
+	bool boost_supported;
 };
 
 #endif /* __CPUFREQ_DT_H__ */
-- 
1.9.1
