From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 19:48:15 +0200
Subject: [PATCH 15/19] cpufreq: s5pv210: Make the driver multiplatform aware
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404496099-26708-16-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm at vger.kernel.org
---
 drivers/cpufreq/s5pv210-cpufreq.c | 131 +++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 19a10b8..9a68225 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -16,11 +16,70 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/cpufreq.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/regulator/consumer.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
+static void __iomem *clk_base;
+static void __iomem *dmc_base[2];
+
+#define S5P_CLKREG(x)		(clk_base + (x))
+
+#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
+#define S5P_APLL_CON		S5P_CLKREG(0x100)
+#define S5P_CLK_SRC0		S5P_CLKREG(0x200)
+#define S5P_CLK_SRC2		S5P_CLKREG(0x208)
+#define S5P_CLK_DIV0		S5P_CLKREG(0x300)
+#define S5P_CLK_DIV2		S5P_CLKREG(0x308)
+#define S5P_CLK_DIV6		S5P_CLKREG(0x318)
+#define S5P_CLKDIV_STAT0	S5P_CLKREG(0x1000)
+#define S5P_CLKDIV_STAT1	S5P_CLKREG(0x1004)
+#define S5P_CLKMUX_STAT0	S5P_CLKREG(0x1100)
+#define S5P_CLKMUX_STAT1	S5P_CLKREG(0x1104)
+
+#define S5P_ARM_MCS_CON		S5P_CLKREG(0x6100)
+
+/* CLKSRC0 */
+#define S5P_CLKSRC0_MUX200_SHIFT	(16)
+#define S5P_CLKSRC0_MUX200_MASK		(0x1 << S5P_CLKSRC0_MUX200_SHIFT)
+#define S5P_CLKSRC0_MUX166_MASK		(0x1<<20)
+#define S5P_CLKSRC0_MUX133_MASK		(0x1<<24)
+
+/* CLKSRC2 */
+#define S5P_CLKSRC2_G3D_SHIFT           (0)
+#define S5P_CLKSRC2_G3D_MASK            (0x3 << S5P_CLKSRC2_G3D_SHIFT)
+#define S5P_CLKSRC2_MFC_SHIFT           (4)
+#define S5P_CLKSRC2_MFC_MASK            (0x3 << S5P_CLKSRC2_MFC_SHIFT)
+
+/* CLKDIV0 */
+#define S5P_CLKDIV0_APLL_SHIFT		(0)
+#define S5P_CLKDIV0_APLL_MASK		(0x7 << S5P_CLKDIV0_APLL_SHIFT)
+#define S5P_CLKDIV0_A2M_SHIFT		(4)
+#define S5P_CLKDIV0_A2M_MASK		(0x7 << S5P_CLKDIV0_A2M_SHIFT)
+#define S5P_CLKDIV0_HCLK200_SHIFT	(8)
+#define S5P_CLKDIV0_HCLK200_MASK	(0x7 << S5P_CLKDIV0_HCLK200_SHIFT)
+#define S5P_CLKDIV0_PCLK100_SHIFT	(12)
+#define S5P_CLKDIV0_PCLK100_MASK	(0x7 << S5P_CLKDIV0_PCLK100_SHIFT)
+#define S5P_CLKDIV0_HCLK166_SHIFT	(16)
+#define S5P_CLKDIV0_HCLK166_MASK	(0xF << S5P_CLKDIV0_HCLK166_SHIFT)
+#define S5P_CLKDIV0_PCLK83_SHIFT	(20)
+#define S5P_CLKDIV0_PCLK83_MASK		(0x7 << S5P_CLKDIV0_PCLK83_SHIFT)
+#define S5P_CLKDIV0_HCLK133_SHIFT	(24)
+#define S5P_CLKDIV0_HCLK133_MASK	(0xF << S5P_CLKDIV0_HCLK133_SHIFT)
+#define S5P_CLKDIV0_PCLK66_SHIFT	(28)
+#define S5P_CLKDIV0_PCLK66_MASK		(0x7 << S5P_CLKDIV0_PCLK66_SHIFT)
+
+/* CLKDIV2 */
+#define S5P_CLKDIV2_G3D_SHIFT           (0)
+#define S5P_CLKDIV2_G3D_MASK            (0xF << S5P_CLKDIV2_G3D_SHIFT)
+#define S5P_CLKDIV2_MFC_SHIFT           (4)
+#define S5P_CLKDIV2_MFC_MASK            (0xF << S5P_CLKDIV2_MFC_SHIFT)
+
+/* CLKDIV6 */
+#define S5P_CLKDIV6_ONEDRAM_SHIFT       (28)
+#define S5P_CLKDIV6_ONEDRAM_MASK        (0xF << S5P_CLKDIV6_ONEDRAM_SHIFT)
 
 static struct clk *dmc0_clk;
 static struct clk *dmc1_clk;
@@ -142,9 +201,9 @@ static void s5pv210_set_refresh(enum s5pv210_dmc_port ch, unsigned long freq)
 	void __iomem *reg = NULL;
 
 	if (ch == DMC0) {
-		reg = (S5P_VA_DMC0 + 0x30);
+		reg = (dmc_base[0] + 0x30);
 	} else if (ch == DMC1) {
-		reg = (S5P_VA_DMC1 + 0x30);
+		reg = (dmc_base[1] + 0x30);
 	} else {
 		printk(KERN_ERR "Cannot find DMC port\n");
 		return;
@@ -472,7 +531,7 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 	 * check_mem_type : This driver only support LPDDR & LPDDR2.
 	 * other memory type is not supported.
 	 */
-	mem_type = check_mem_type(S5P_VA_DMC0);
+	mem_type = check_mem_type(dmc_base[0]);
 
 	if ((mem_type != LPDDR) && (mem_type != LPDDR2)) {
 		printk(KERN_ERR "CPUFreq doesn't support this memory type\n");
@@ -481,10 +540,10 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	/* Find current refresh counter and frequency each DMC */
-	s5pv210_dram_conf[0].refresh = (__raw_readl(S5P_VA_DMC0 + 0x30) * 1000);
+	s5pv210_dram_conf[0].refresh = (__raw_readl(dmc_base[0] + 0x30) * 1000);
 	s5pv210_dram_conf[0].freq = clk_get_rate(dmc0_clk);
 
-	s5pv210_dram_conf[1].refresh = (__raw_readl(S5P_VA_DMC1 + 0x30) * 1000);
+	s5pv210_dram_conf[1].refresh = (__raw_readl(dmc_base[1] + 0x30) * 1000);
 	s5pv210_dram_conf[1].freq = clk_get_rate(dmc1_clk);
 
 	policy->suspend_freq = SLEEP_FREQ;
@@ -527,8 +586,55 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
 	.notifier_call = s5pv210_cpufreq_reboot_notifier_event,
 };
 
-static int __init s5pv210_cpufreq_init(void)
+static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 {
+	struct device_node *np;
+	int id;
+
+	/*
+	 * HACK: This is a temporary workaround to get access to clock
+	 * and DMC controller registers directly and remove static mappings
+	 * and dependencies on platform headers. It is necessary to enable
+	 * S5PV210 multi-platform support and will be removed together with
+	 * this whole driver as soon as S5PV210 gets migrated to use
+	 * cpufreq-cpu0 driver.
+	 */
+	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
+	if (!np) {
+		pr_err("%s: failed to find clock controller DT node\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	clk_base = of_iomap(np, 0);
+	if (!clk_base) {
+		pr_err("%s: failed to map clock registers\n", __func__);
+		return -EFAULT;
+	}
+
+	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
+		id = of_alias_get_id(np, "dmc");
+		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
+			pr_err("%s: failed to get alias of dmc node '%s'\n",
+				__func__, np->name);
+			return id;
+		}
+
+		dmc_base[id] = of_iomap(np, 0);
+		if (!dmc_base[id]) {
+			pr_err("%s: failed to map dmc%d registers\n",
+				__func__, id);
+			return -EFAULT;
+		}
+	}
+
+	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
+		if (!dmc_base[id]) {
+			pr_err("%s: failed to find dmc%d node\n", __func__, id);
+			return -ENODEV;
+		}
+	}
+
 	arm_regulator = regulator_get(NULL, "vddarm");
 	if (IS_ERR(arm_regulator)) {
 		pr_err("failed to get regulator vddarm");
@@ -547,4 +653,11 @@ static int __init s5pv210_cpufreq_init(void)
 	return cpufreq_register_driver(&s5pv210_driver);
 }
 
-late_initcall(s5pv210_cpufreq_init);
+static struct platform_driver s5pv210_cpufreq_platdrv = {
+	.driver = {
+		.name	= "s5pv210-cpufreq",
+		.owner	= THIS_MODULE,
+	},
+	.probe = s5pv210_cpufreq_probe,
+};
+module_platform_driver(s5pv210_cpufreq_platdrv);
-- 
1.9.3
