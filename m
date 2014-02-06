From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 06 Feb 2014 19:16:52 +0100
Subject: [PATCH v2 5/9] clk: samsung: exynos5420: Move suspend/resume handling
 to SoC driver
In-Reply-To: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
References: <1391710616-14226-1-git-send-email-t.figa@samsung.com>
Message-ID: <1391710616-14226-6-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there are multiple differences in how suspend/resume of particular
Exynos SoCs must be handled, SoC driver is better place for
suspend/resume handlers and so this patch moves them.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos5420.c | 49 ++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index ab4f2f7..8ce0780 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -16,6 +16,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/syscore_ops.h>
 
 #include "clk.h"
 
@@ -108,6 +109,11 @@ enum exynos5420_plls {
 	nr_plls			/* number of PLLs */
 };
 
+static void __iomem *reg_base;
+
+#ifdef CONFIG_PM_SLEEP
+static struct samsung_clk_reg_dump *exynos5420_save;
+
 /*
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
@@ -174,6 +180,41 @@ static unsigned long exynos5420_clk_regs[] __initdata = {
 	DIV_KFC0,
 };
 
+static int exynos5420_clk_suspend(void)
+{
+	samsung_clk_save(reg_base, exynos5420_save,
+				ARRAY_SIZE(exynos5420_clk_regs));
+
+	return 0;
+}
+
+static void exynos5420_clk_resume(void)
+{
+	samsung_clk_restore(reg_base, exynos5420_save,
+				ARRAY_SIZE(exynos5420_clk_regs));
+}
+
+static struct syscore_ops exynos5420_clk_syscore_ops = {
+	.suspend = exynos5420_clk_suspend,
+	.resume = exynos5420_clk_resume,
+};
+
+static void exynos5420_clk_sleep_init(void)
+{
+	exynos5420_save = samsung_clk_alloc_reg_dump(exynos5420_clk_regs,
+					ARRAY_SIZE(exynos5420_clk_regs));
+	if (!exynos5420_save) {
+		pr_warn("%s: failed to allocate sleep save data, no sleep support!\n",
+			__func__);
+		return;
+	}
+
+	register_syscore_ops(&exynos5420_clk_syscore_ops);
+}
+#else
+static void exynos5420_clk_sleep_init(void) {}
+#endif
+
 /* list of all parent clocks */
 PNAME(mspll_cpu_p)	= { "sclk_cpll", "sclk_dpll",
 				"sclk_mpll", "sclk_spll" };
@@ -737,8 +778,6 @@ static struct of_device_id ext_clk_match[] __initdata = {
 /* register exynos5420 clocks */
 static void __init exynos5420_clk_init(struct device_node *np)
 {
-	void __iomem *reg_base;
-
 	if (np) {
 		reg_base = of_iomap(np, 0);
 		if (!reg_base)
@@ -747,9 +786,7 @@ static void __init exynos5420_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	samsung_clk_init(np, reg_base, CLK_NR_CLKS,
-			exynos5420_clk_regs, ARRAY_SIZE(exynos5420_clk_regs),
-			NULL, 0);
+	samsung_clk_init(np, reg_base, CLK_NR_CLKS, NULL, 0, NULL, 0);
 	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
 			ext_clk_match);
@@ -765,5 +802,7 @@ static void __init exynos5420_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5420_div_clks));
 	samsung_clk_register_gate(exynos5420_gate_clks,
 			ARRAY_SIZE(exynos5420_gate_clks));
+
+	exynos5420_clk_sleep_init();
 }
 CLK_OF_DECLARE(exynos5420_clk, "samsung,exynos5420-clock", exynos5420_clk_init);
-- 
1.8.5.2
