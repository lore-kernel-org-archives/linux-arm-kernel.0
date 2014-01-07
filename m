From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 07 Jan 2014 18:28:59 +0530
Subject: [PATCH V2 01/10] clk/exynos5410: move suspend/resume handling to SoC
 driver
In-Reply-To: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1389099548-14649-2-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend/resume handling is already moved for all other Exynos
SoCs other than Exynos5420 which is addressed in this patch.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/clk/samsung/clk-exynos5410.c |   49 ++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 858b3ff..f94c493 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -16,6 +16,7 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/syscore_ops.h>
 
 #include "clk.h"
 
@@ -60,6 +61,11 @@ enum exynos5410_plls {
 	nr_plls			/* number of PLLs */
 };
 
+static void __iomem *reg_base;
+
+#ifdef CONFIG_PM_SLEEP
+static struct samsung_clk_reg_dump *exynos5410_save;
+
 /*
  * list of controller registers to be saved and restored during a
  * suspend/resume cycle.
@@ -89,6 +95,41 @@ static unsigned long exynos5410_clk_regs[] __initdata = {
 	DIV_KFC0,
 };
 
+static int exynos5410_clk_suspend(void)
+{
+	samsung_clk_save(reg_base, exynos5410_save,
+				ARRAY_SIZE(exynos5410_clk_regs));
+
+	return 0;
+}
+
+static void exynos5410_clk_resume(void)
+{
+	samsung_clk_restore(reg_base, exynos5410_save,
+				ARRAY_SIZE(exynos5410_clk_regs));
+}
+
+static struct syscore_ops exynos5410_clk_syscore_ops = {
+	.suspend = exynos5410_clk_suspend,
+	.resume = exynos5410_clk_resume,
+};
+
+static void exynos5410_clk_sleep_init(void)
+{
+	exynos5410_save = samsung_clk_alloc_reg_dump(exynos5410_clk_regs,
+					ARRAY_SIZE(exynos5410_clk_regs));
+	if (!exynos5410_save) {
+		pr_warn("%s: failed to allocate sleep save data, no sleep support!\n",
+			__func__);
+		return;
+	}
+
+	register_syscore_ops(&exynos5410_clk_syscore_ops);
+}
+#else
+static void exynos5410_clk_sleep_init(void) {}
+#endif
+
 /* list of all parent clocks */
 PNAME(apll_p)		= { "fin_pll", "fout_apll", };
 PNAME(bpll_p)		= { "fin_pll", "fout_bpll", };
@@ -214,15 +255,11 @@ static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
 /* register exynos5410 clocks */
 static void __init exynos5410_clk_init(struct device_node *np)
 {
-	void __iomem *reg_base;
-
 	reg_base = of_iomap(np, 0);
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
 
-	samsung_clk_init(np, reg_base, CLK_NR_CLKS,
-			exynos5410_clk_regs, ARRAY_SIZE(exynos5410_clk_regs),
-			NULL, 0);
+	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
 
 	samsung_clk_register_pll(exynos5410_plls, ARRAY_SIZE(exynos5410_plls),
 					reg_base);
@@ -234,6 +271,8 @@ static void __init exynos5410_clk_init(struct device_node *np)
 	samsung_clk_register_gate(exynos5410_gate_clks,
 			ARRAY_SIZE(exynos5410_gate_clks));
 
+	exynos5410_clk_sleep_init();
+
 	pr_debug("Exynos5410: clock setup completed.\n");
 }
 CLK_OF_DECLARE(exynos5410_clk, "samsung,exynos5410-clock", exynos5410_clk_init);
-- 
1.7.9.5
