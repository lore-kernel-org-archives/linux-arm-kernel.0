From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 23 Aug 2016 22:56:11 +0800
Subject: [PATCH] ARM: imx6: add opp table when cpufreq is enabled
Message-ID: <1471964171-27480-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On those i.MX6 platforms which have no speed grading
check, opp table will NOT be created in platform code,
so cpufreq driver will have below error message:

cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)

As cpufreq driver expects opp table is supplied by
platform, so it is better to add opp table if cpufreq
is enabled.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/common.h      |  1 +
 arch/arm/mach-imx/mach-imx6q.c  | 31 ++++---------------------------
 arch/arm/mach-imx/mach-imx6sl.c |  4 +++-
 arch/arm/mach-imx/mach-imx6sx.c |  4 +++-
 arch/arm/mach-imx/mach-imx6ul.c |  4 +++-
 arch/arm/mach-imx/pm-imx6.c     | 25 +++++++++++++++++++++++++
 6 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index bcca481..b757811 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -124,6 +124,7 @@ static inline void imx6_suspend(void __iomem *ocram_vbase) {}
 #endif
 
 void imx6_pm_ccm_init(const char *ccm_compat);
+void imx6_pm_opp_init(void);
 void imx6q_pm_init(void);
 void imx6dl_pm_init(void);
 void imx6sl_pm_init(void);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 97fd251..09d295b 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -338,32 +338,6 @@ put_node:
 	of_node_put(np);
 }
 
-static void __init imx6q_opp_init(void)
-{
-	struct device_node *np;
-	struct device *cpu_dev = get_cpu_device(0);
-
-	if (!cpu_dev) {
-		pr_warn("failed to get cpu0 device\n");
-		return;
-	}
-	np = of_node_get(cpu_dev->of_node);
-	if (!np) {
-		pr_warn("failed to find cpu0 node\n");
-		return;
-	}
-
-	if (dev_pm_opp_of_add_table(cpu_dev)) {
-		pr_warn("failed to init OPP table\n");
-		goto put_node;
-	}
-
-	imx6q_opp_check_speed_grading(cpu_dev);
-
-put_node:
-	of_node_put(np);
-}
-
 static struct platform_device imx6q_cpufreq_pdev = {
 	.name = "imx6q-cpufreq",
 };
@@ -378,7 +352,10 @@ static void __init imx6q_init_late(void)
 		imx6q_cpuidle_init();
 
 	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
-		imx6q_opp_init();
+		struct device *cpu_dev = get_cpu_device(0);
+
+		imx6_pm_opp_init();
+		imx6q_opp_check_speed_grading(cpu_dev);
 		platform_device_register(&imx6q_cpufreq_pdev);
 	}
 }
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index 0408490..009bfa8 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -38,8 +38,10 @@ static void __init imx6sl_fec_init(void)
 static void __init imx6sl_init_late(void)
 {
 	/* imx6sl reuses imx6q cpufreq driver */
-	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		imx6_pm_opp_init();
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
+	}
 
 	imx6sl_cpuidle_init();
 }
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 7f52d9b..2c5b78b 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -93,8 +93,10 @@ static void __init imx6sx_init_late(void)
 {
 	imx6sx_cpuidle_init();
 
-	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		imx6_pm_opp_init();
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
+	}
 }
 
 static const char * const imx6sx_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 6bb7d9c..c2cd61c 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -80,8 +80,10 @@ static void __init imx6ul_init_irq(void)
 
 static void __init imx6ul_init_late(void)
 {
-	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ))
+	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
+		imx6_pm_opp_init();
 		platform_device_register_simple("imx6q-cpufreq", -1, NULL, 0);
+	}
 }
 
 static const char * const imx6ul_dt_compat[] __initconst = {
diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index fe708e2..9a6f34c 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <linux/suspend.h>
 #include <asm/cacheflush.h>
@@ -620,6 +621,30 @@ void __init imx6_pm_ccm_init(const char *ccm_compat)
 	writel_relaxed(val, ccm_base + CLPCR);
 }
 
+void __init imx6_pm_opp_init(void)
+{
+	struct device_node *np;
+	struct device *cpu_dev = get_cpu_device(0);
+
+	if (!cpu_dev) {
+		pr_warn("failed to get cpu0 device\n");
+		return;
+	}
+	np = of_node_get(cpu_dev->of_node);
+	if (!np) {
+		pr_warn("failed to find cpu0 node\n");
+		return;
+	}
+
+	if (dev_pm_opp_of_add_table(cpu_dev)) {
+		pr_warn("failed to init OPP table\n");
+		goto put_node;
+	}
+
+put_node:
+	of_node_put(np);
+}
+
 void __init imx6q_pm_init(void)
 {
 	imx6_pm_common_init(&imx6q_pm_data);
-- 
1.9.1
