From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 Apr 2016 16:58:46 +0530
Subject: [PATCH V2 8/9] cpufreq: zynq: Use generic platdev driver
In-Reply-To: <cover.1461324267.git.viresh.kumar@linaro.org>
References: <cover.1461324267.git.viresh.kumar@linaro.org>
Message-ID: <e0092fa19646f22d667a46854743076465bc5429.1461324267.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
device now, reuse that and remove similar code from platform code.

Cc: Michal Simek <michal.simek@xilinx.com>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-zynq/common.c          | 2 --
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 860ffb663f02..da876d28ccbc 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -110,7 +110,6 @@ static void __init zynq_init_late(void)
  */
 static void __init zynq_init_machine(void)
 {
-	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
 	struct device *parent = NULL;
@@ -145,7 +144,6 @@ static void __init zynq_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 
 	platform_device_register(&zynq_cpuidle_device);
-	platform_device_register_full(&devinfo);
 }
 
 static void __init zynq_timer_init(void)
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 24dde5e256d4..5ad29383e862 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -68,6 +68,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
 	{ .compatible = "ti,omap5", },
+
+	{ .compatible = "xlnx,zynq-7000", },
 };
 
 static int __init cpufreq_dt_platdev_init(void)
-- 
2.7.1.410.g6faf27b
