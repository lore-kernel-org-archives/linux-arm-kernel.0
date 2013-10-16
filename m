From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 13:08:15 +0200
Subject: [PATCH 6/9] clk: samsung: s3c64xx: Move suspend/resume handling to SoC
 driver
In-Reply-To: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
References: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381921698-5060-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there are multiple differences in how suspend/resume of particular
Exynos SoCs must be handled, SoC driver is better place for
suspend/resume handlers and so this patch moves them.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-s3c64xx.c | 79 +++++++++++++++++++++++++++++++++------
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index 7d2c842..3189101 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/syscore_ops.h>
 
 #include <dt-bindings/clock/samsung,s3c64xx-clock.h>
 
@@ -61,6 +62,13 @@ enum s3c64xx_plls {
 	apll, mpll, epll,
 };
 
+static void __iomem *reg_base;
+static bool is_s3c6400;
+
+#ifdef CONFIG_PM_SLEEP
+static struct samsung_clk_reg_dump *s3c64xx_save_common;
+static struct samsung_clk_reg_dump *s3c64xx_save_soc;
+
 /*
  * List of controller registers to be saved and restored during
  * a suspend/resume cycle.
@@ -87,6 +95,60 @@ static unsigned long s3c6410_clk_regs[] __initdata = {
 	MEM0_GATE,
 };
 
+static int s3c64xx_clk_suspend(void)
+{
+	samsung_clk_save(reg_base, s3c64xx_save_common,
+				ARRAY_SIZE(s3c64xx_clk_regs));
+
+	if (!is_s3c6400)
+		samsung_clk_save(reg_base, s3c64xx_save_soc,
+					ARRAY_SIZE(s3c6410_clk_regs));
+
+	return 0;
+}
+
+static void s3c64xx_clk_resume(void)
+{
+	samsung_clk_restore(reg_base, s3c64xx_save_common,
+				ARRAY_SIZE(s3c64xx_clk_regs));
+
+	if (!is_s3c6400)
+		samsung_clk_restore(reg_base, s3c64xx_save_soc,
+					ARRAY_SIZE(s3c6410_clk_regs));
+}
+
+static struct syscore_ops s3c64xx_clk_syscore_ops = {
+	.suspend = s3c64xx_clk_suspend,
+	.resume = s3c64xx_clk_resume,
+};
+
+static void s3c64xx_clk_sleep_init(void)
+{
+	s3c64xx_save_common = samsung_clk_alloc_reg_dump(s3c64xx_clk_regs,
+						ARRAY_SIZE(s3c64xx_clk_regs));
+	if (!s3c64xx_save_common)
+		goto err_warn;
+
+	if (!is_s3c6400) {
+		s3c64xx_save_soc = samsung_clk_alloc_reg_dump(s3c6410_clk_regs,
+						ARRAY_SIZE(s3c6410_clk_regs));
+		if (!s3c64xx_save_soc)
+			goto err_soc;
+	}
+
+	register_syscore_ops(&s3c64xx_clk_syscore_ops);
+	return;
+
+err_soc:
+	kfree(s3c64xx_save_common);
+err_warn:
+	pr_warn("%s: failed to allocate sleep save data, no sleep support!\n",
+		__func__);
+}
+#else
+static void s3c64xx_clk_sleep_init(void) {}
+#endif
+
 /* List of parent clocks common for all S3C64xx SoCs. */
 PNAME(spi_mmc_p)	= { "mout_epll", "dout_mpll", "fin_pll", "clk27m" };
 PNAME(uart_p)		= { "mout_epll", "dout_mpll" };
@@ -391,11 +453,11 @@ static void __init s3c64xx_clk_register_fixed_ext(unsigned long fin_pll_f,
 
 /* Register s3c64xx clocks. */
 void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
-			     unsigned long xusbxti_f, bool is_s3c6400,
-			     void __iomem *reg_base)
+			     unsigned long xusbxti_f, bool s3c6400,
+			     void __iomem *base)
 {
-	unsigned long *soc_regs = NULL;
-	unsigned long nr_soc_regs = 0;
+	reg_base = base;
+	is_s3c6400 = s3c6400;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -403,13 +465,7 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	if (!is_s3c6400) {
-		soc_regs = s3c6410_clk_regs;
-		nr_soc_regs = ARRAY_SIZE(s3c6410_clk_regs);
-	}
-
-	samsung_clk_init(np, reg_base, NR_CLKS, s3c64xx_clk_regs,
-			ARRAY_SIZE(s3c64xx_clk_regs), soc_regs, nr_soc_regs);
+	samsung_clk_init(np, reg_base, NR_CLKS, NULL, 0, NULL, 0);
 
 	/* Register external clocks. */
 	if (!np)
@@ -452,6 +508,7 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 
 	samsung_clk_register_alias(s3c64xx_clock_aliases,
 					ARRAY_SIZE(s3c64xx_clock_aliases));
+	s3c64xx_clk_sleep_init();
 
 	pr_info("%s clocks: apll = %lu, mpll = %lu\n"
 		"\tepll = %lu, arm_clk = %lu\n",
-- 
1.8.3.2
