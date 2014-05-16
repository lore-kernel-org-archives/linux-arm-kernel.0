From: jhbird.choi@samsung.com (Jonghwan Choi)
Date: Fri, 16 May 2014 16:58:24 +0900
Subject: [PATCH v2] cpufreq: exynos:  Fix the compile error
Message-ID: <000001cf70dc$9ccfe4e0$d66faea0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7da83a80 ("ARM: EXYNOS: Migrate Exynos specific macros from plat to mach")
which lands in samsung tree causes build breakage for cpufreq-exynos like following:
drivers/cpufreq/exynos-cpufreq.c: In function 'exynos_cpufreq_probe':
drivers/cpufreq/exynos-cpufreq.c:166:2: error: implicit declaration of function 'soc_is_exynos4210'
[-Werror=implicit-function-declaration]
drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of function 'soc_is_exynos4212'
[-Werror=implicit-function-declaration]
drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of function 'soc_is_exynos4412'
[-Werror=implicit-function-declaration]
drivers/cpufreq/exynos-cpufreq.c:170:2: error: implicit declaration of function 'soc_is_exynos5250'
[-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
make[2]: *** Waiting for unfinished jobs....
drivers/cpufreq/exynos4x12-cpufreq.c: In function 'exynos4x12_set_clkdiv':
drivers/cpufreq/exynos4x12-cpufreq.c:118:2: error: implicit declaration of function 'soc_is_exynos4212'
[-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors
make[2]: *** [drivers/cpufreq/exynos4x12-cpufreq.o] Error 1
make[1]: *** [drivers/cpufreq] Error 2
This fixes above error with getting SoC information via DT instead of soc_is_exynosXXXX().

Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
---
 .../devicetree/bindings/cpufreq/cpufreq-exynos.txt |   18 ++++++++
 drivers/cpufreq/Kconfig.arm                        |    4 +-
 drivers/cpufreq/exynos-cpufreq.c                   |   47 +++++++++++++++++---
 drivers/cpufreq/exynos-cpufreq.h                   |    8 ++++
 drivers/cpufreq/exynos4x12-cpufreq.c               |   11 ++---
 5 files changed, 72 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
new file mode 100644
index 0000000..f5e8ac6
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-exynos.txt
@@ -0,0 +1,18 @@
+
+Exynos cpufreq driver
+-------------------
+
+Exynos4210/4212/4412/5250 SoC cpufreq driver for CPU frequency scaling.
+
+Required properties:
+  - compatible: value should be either of the following.
+      (a) "samsung, exynos4210-cpufreq", for Exynos4210.
+      (b) "samsung, exynos4212-cpufreq", for Exynos4212.
+      (c) "samsung, exynos4412-cpufreq", for Exynos4412.
+      (d) "samsung, exynos5250-cpufreq", for Exynos5250.
+
+Example:
+--------
+	cpufreq at 10030000 {
+		compatible = "samsung,exynos4210-cpufreq";
+	};
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 5805035..9606f90 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -27,6 +27,8 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 
 config ARM_EXYNOS_CPUFREQ
 	bool
+	depends on HAVE_CLK && OF
+	select PM_OPP
 
 config ARM_EXYNOS4210_CPUFREQ
 	bool "SAMSUNG EXYNOS4210"
@@ -64,8 +66,6 @@ config ARM_EXYNOS5250_CPUFREQ
 config ARM_EXYNOS5440_CPUFREQ
 	bool "SAMSUNG EXYNOS5440"
 	depends on SOC_EXYNOS5440
-	depends on HAVE_CLK && OF
-	select PM_OPP
 	default y
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5440
diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index f99cfe2..cfc8c75 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -16,7 +16,10 @@
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <linux/cpufreq.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/of_device.h>
 
 #include <plat/cpu.h>
 
@@ -155,19 +158,44 @@ static struct cpufreq_driver exynos_driver = {
 #endif
 };
 
+static const struct of_device_id exynos_cpufreq_match[] = {
+	{ .compatible = "samsung,exynos4210-cpufreq",	.data = (void*)EXYNOS_SOC_4210 },
+	{ .compatible = "samsung,exynos4212-cpufreq",	.data = (void*)EXYNOS_SOC_4212 },
+	{ .compatible = "samsung,exynos4412-cpufreq",	.data = (void*)EXYNOS_SOC_4412 },
+	{ .compatible = "samsung,exynos5250-cpufreq",	.data = (void*)EXYNOS_SOC_5250 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, exynos_cpufreq_match);
+
 static int exynos_cpufreq_probe(struct platform_device *pdev)
 {
 	int ret = -EINVAL;
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	np =  pdev->dev.of_node;
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_device(exynos_cpufreq_match, &pdev->dev);
+	if (!match) {
+		pr_err("%s: Unknown device mode\n", __func__);
+		goto err_put_node;
+	}
 
 	exynos_info = kzalloc(sizeof(*exynos_info), GFP_KERNEL);
-	if (!exynos_info)
-		return -ENOMEM;
+	if (!exynos_info) {
+		ret = -ENOMEM;
+		goto err_put_node;
+	}
+
+	exynos_info->type = (long)match->data;
 
-	if (soc_is_exynos4210())
+	if (exynos_info->type == EXYNOS_SOC_4210)
 		ret = exynos4210_cpufreq_init(exynos_info);
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
+	else if (exynos_info->type == EXYNOS_SOC_4212 || exynos_info->type == EXYNOS_SOC_4412)
 		ret = exynos4x12_cpufreq_init(exynos_info);
-	else if (soc_is_exynos5250())
+	else if (exynos_info->type == EXYNOS_SOC_5250)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	else
 		return 0;
@@ -189,20 +217,25 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	/* Done here as we want to capture boot frequency */
 	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
 
-	if (!cpufreq_register_driver(&exynos_driver))
+	if (!cpufreq_register_driver(&exynos_driver)) {
+		of_node_put(np);
 		return 0;
+	}
 
 	pr_err("%s: failed to register cpufreq driver\n", __func__);
 	regulator_put(arm_regulator);
 err_vdd_arm:
 	kfree(exynos_info);
-	return -EINVAL;
+err_put_node:
+	of_node_put(np);
+	return ret;
 }
 
 static struct platform_driver exynos_cpufreq_platdrv = {
 	.driver = {
 		.name	= "exynos-cpufreq",
 		.owner	= THIS_MODULE,
+		.of_match_table = exynos_cpufreq_match,
 	},
 	.probe = exynos_cpufreq_probe,
 };
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 3ddade8..f189547 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -17,6 +17,13 @@ enum cpufreq_level_index {
 	L20,
 };
 
+enum exynos_soc_type {
+	EXYNOS_SOC_4210,
+	EXYNOS_SOC_4212,
+	EXYNOS_SOC_4412,
+	EXYNOS_SOC_5250,
+};
+
 #define APLL_FREQ(f, a0, a1, a2, a3, a4, a5, a6, a7, b0, b1, b2, m, p, s) \
 	{ \
 		.freq = (f) * 1000, \
@@ -34,6 +41,7 @@ struct apll_freq {
 };
 
 struct exynos_dvfs_info {
+	enum exynos_soc_type type;
 	unsigned long	mpll_freq_khz;
 	unsigned int	pll_safe_idx;
 	struct clk	*cpu_clk;
diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 466c76a..63a3907 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -100,7 +100,6 @@ static struct apll_freq apll_freq_4412[] = {
 static void exynos4x12_set_clkdiv(unsigned int div_index)
 {
 	unsigned int tmp;
-	unsigned int stat_cpu1;
 
 	/* Change Divider - CPU0 */
 
@@ -115,13 +114,11 @@ static void exynos4x12_set_clkdiv(unsigned int div_index)
 	tmp = apll_freq_4x12[div_index].clk_div_cpu1;
 
 	__raw_writel(tmp, EXYNOS4_CLKDIV_CPU1);
-	if (soc_is_exynos4212())
-		stat_cpu1 = 0x11;
-	else
-		stat_cpu1 = 0x111;
 
-	while (__raw_readl(EXYNOS4_CLKDIV_STATCPU1) & stat_cpu1)
+	do {
 		cpu_relax();
+		tmp = __raw_readl(EXYNOS4_CLKDIV_STATCPU1);
+	} while (tmp != 0x0);
 }
 
 static void exynos4x12_set_apll(unsigned int index)
@@ -184,7 +181,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 	if (IS_ERR(mout_apll))
 		goto err_mout_apll;
 
-	if (soc_is_exynos4212())
+	if (info->type == EXYNOS_SOC_4212)
 		apll_freq_4x12 = apll_freq_4212;
 	else
 		apll_freq_4x12 = apll_freq_4412;
-- 
1.7.10.4
