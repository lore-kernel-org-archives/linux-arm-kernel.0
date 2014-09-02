From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 02 Sep 2014 21:05:38 +0530
Subject: [PATCH v2 2/7] clk: samsung: Factor out the common code to clk.c
In-Reply-To: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409672143-8574-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While adding clock support for Exynos5260, the infrastructure to
register multiple clock controllers was introduced. Factor out the
support for registering multiple clock controller from Exynos5260
clock code to common samsung clock code so that it can be used by
other Exynos SoC which have multiple clock controllers.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/samsung/clk-exynos5260.c |  183 +++++-----------------------------
 drivers/clk/samsung/clk.c            |   95 ++++++++++++++++++
 drivers/clk/samsung/clk.h            |   34 +++++++
 3 files changed, 155 insertions(+), 157 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
index ce3de97..d72c982 100644
--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -11,10 +11,8 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
-#include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/syscore_ops.h>
 
 #include "clk-exynos5260.h"
 #include "clk.h"
@@ -22,39 +20,6 @@
 
 #include <dt-bindings/clock/exynos5260-clk.h>
 
-static LIST_HEAD(clock_reg_cache_list);
-
-struct exynos5260_clock_reg_cache {
-	struct list_head node;
-	void __iomem *reg_base;
-	struct samsung_clk_reg_dump *rdump;
-	unsigned int rd_num;
-};
-
-struct exynos5260_cmu_info {
-	/* list of pll clocks and respective count */
-	struct samsung_pll_clock *pll_clks;
-	unsigned int nr_pll_clks;
-	/* list of mux clocks and respective count */
-	struct samsung_mux_clock *mux_clks;
-	unsigned int nr_mux_clks;
-	/* list of div clocks and respective count */
-	struct samsung_div_clock *div_clks;
-	unsigned int nr_div_clks;
-	/* list of gate clocks and respective count */
-	struct samsung_gate_clock *gate_clks;
-	unsigned int nr_gate_clks;
-	/* list of fixed clocks and respective count */
-	struct samsung_fixed_rate_clock *fixed_clks;
-	unsigned int nr_fixed_clks;
-	/* total number of clocks with IDs assigned*/
-	unsigned int nr_clk_ids;
-
-	/* list and number of clocks registers */
-	unsigned long *clk_regs;
-	unsigned int nr_clk_regs;
-};
-
 /*
  * Applicable for all 2550 Type PLLS for Exynos5260, listed below
  * DISP_PLL, EGL_PLL, KFC_PLL, MEM_PLL, BUS_PLL, MEDIA_PLL, G3D_PLL.
@@ -115,102 +80,6 @@ static struct samsung_pll_rate_table pll2650_24mhz_tbl[] __initdata = {
 
 #ifdef CONFIG_PM_SLEEP
 
-static int exynos5260_clk_suspend(void)
-{
-	struct exynos5260_clock_reg_cache *cache;
-
-	list_for_each_entry(cache, &clock_reg_cache_list, node)
-		samsung_clk_save(cache->reg_base, cache->rdump,
-				cache->rd_num);
-
-	return 0;
-}
-
-static void exynos5260_clk_resume(void)
-{
-	struct exynos5260_clock_reg_cache *cache;
-
-	list_for_each_entry(cache, &clock_reg_cache_list, node)
-		samsung_clk_restore(cache->reg_base, cache->rdump,
-				cache->rd_num);
-}
-
-static struct syscore_ops exynos5260_clk_syscore_ops = {
-	.suspend = exynos5260_clk_suspend,
-	.resume = exynos5260_clk_resume,
-};
-
-static void exynos5260_clk_sleep_init(void __iomem *reg_base,
-			unsigned long *rdump,
-			unsigned long nr_rdump)
-{
-	struct exynos5260_clock_reg_cache *reg_cache;
-
-	reg_cache = kzalloc(sizeof(struct exynos5260_clock_reg_cache),
-			GFP_KERNEL);
-	if (!reg_cache)
-		panic("could not allocate register cache.\n");
-
-	reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);
-
-	if (!reg_cache->rdump)
-		panic("could not allocate register dump storage.\n");
-
-	if (list_empty(&clock_reg_cache_list))
-		register_syscore_ops(&exynos5260_clk_syscore_ops);
-
-	reg_cache->rd_num = nr_rdump;
-	reg_cache->reg_base = reg_base;
-	list_add_tail(&reg_cache->node, &clock_reg_cache_list);
-}
-
-#else
-static void exynos5260_clk_sleep_init(void __iomem *reg_base,
-			unsigned long *rdump,
-			unsigned long nr_rdump){}
-#endif
-
-/*
- * Common function which registers plls, muxes, dividers and gates
- * for each CMU. It also add CMU register list to register cache.
- */
-
-void __init exynos5260_cmu_register_one(struct device_node *np,
-			struct exynos5260_cmu_info *cmu)
-{
-	void __iomem *reg_base;
-	struct samsung_clk_provider *ctx;
-
-	reg_base = of_iomap(np, 0);
-	if (!reg_base)
-		panic("%s: failed to map registers\n", __func__);
-
-	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
-	if (!ctx)
-		panic("%s: unable to alllocate ctx\n", __func__);
-
-	if (cmu->pll_clks)
-		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
-			reg_base);
-	if (cmu->mux_clks)
-		samsung_clk_register_mux(ctx,  cmu->mux_clks,
-			cmu->nr_mux_clks);
-	if (cmu->div_clks)
-		samsung_clk_register_div(ctx, cmu->div_clks, cmu->nr_div_clks);
-	if (cmu->gate_clks)
-		samsung_clk_register_gate(ctx, cmu->gate_clks,
-			cmu->nr_gate_clks);
-	if (cmu->fixed_clks)
-		samsung_clk_register_fixed_rate(ctx, cmu->fixed_clks,
-			cmu->nr_fixed_clks);
-	if (cmu->clk_regs)
-		exynos5260_clk_sleep_init(reg_base, cmu->clk_regs,
-			cmu->nr_clk_regs);
-
-	samsung_clk_of_add_provider(np, ctx);
-}
-
-
 /* CMU_AUD */
 
 static unsigned long aud_clk_regs[] __initdata = {
@@ -268,7 +137,7 @@ struct samsung_gate_clock aud_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_aud_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = aud_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(aud_mux_clks);
@@ -280,7 +149,7 @@ static void __init exynos5260_clk_aud_init(struct device_node *np)
 	cmu.clk_regs = aud_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(aud_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_aud, "samsung,exynos5260-clock-aud",
@@ -458,7 +327,7 @@ struct samsung_gate_clock disp_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_disp_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = disp_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(disp_mux_clks);
@@ -470,7 +339,7 @@ static void __init exynos5260_clk_disp_init(struct device_node *np)
 	cmu.clk_regs = disp_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(disp_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_disp, "samsung,exynos5260-clock-disp",
@@ -522,7 +391,7 @@ static struct samsung_pll_clock egl_pll_clks[] __initdata = {
 
 static void __init exynos5260_clk_egl_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.pll_clks = egl_pll_clks;
 	cmu.nr_pll_clks =  ARRAY_SIZE(egl_pll_clks);
@@ -534,7 +403,7 @@ static void __init exynos5260_clk_egl_init(struct device_node *np)
 	cmu.clk_regs = egl_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(egl_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_egl, "samsung,exynos5260-clock-egl",
@@ -624,7 +493,7 @@ struct samsung_gate_clock fsys_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_fsys_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = fsys_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(fsys_mux_clks);
@@ -634,7 +503,7 @@ static void __init exynos5260_clk_fsys_init(struct device_node *np)
 	cmu.clk_regs = fsys_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(fsys_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_fsys, "samsung,exynos5260-clock-fsys",
@@ -713,7 +582,7 @@ struct samsung_gate_clock g2d_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_g2d_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = g2d_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(g2d_mux_clks);
@@ -725,7 +594,7 @@ static void __init exynos5260_clk_g2d_init(struct device_node *np)
 	cmu.clk_regs = g2d_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(g2d_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_g2d, "samsung,exynos5260-clock-g2d",
@@ -774,7 +643,7 @@ static struct samsung_pll_clock g3d_pll_clks[] __initdata = {
 
 static void __init exynos5260_clk_g3d_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.pll_clks = g3d_pll_clks;
 	cmu.nr_pll_clks =  ARRAY_SIZE(g3d_pll_clks);
@@ -788,7 +657,7 @@ static void __init exynos5260_clk_g3d_init(struct device_node *np)
 	cmu.clk_regs = g3d_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(g3d_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_g3d, "samsung,exynos5260-clock-g3d",
@@ -909,7 +778,7 @@ struct samsung_gate_clock gscl_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_gscl_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = gscl_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(gscl_mux_clks);
@@ -921,7 +790,7 @@ static void __init exynos5260_clk_gscl_init(struct device_node *np)
 	cmu.clk_regs = gscl_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(gscl_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_gscl, "samsung,exynos5260-clock-gscl",
@@ -1028,7 +897,7 @@ struct samsung_gate_clock isp_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_isp_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = isp_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(isp_mux_clks);
@@ -1040,7 +909,7 @@ static void __init exynos5260_clk_isp_init(struct device_node *np)
 	cmu.clk_regs = isp_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(isp_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_isp, "samsung,exynos5260-clock-isp",
@@ -1092,7 +961,7 @@ static struct samsung_pll_clock kfc_pll_clks[] __initdata = {
 
 static void __init exynos5260_clk_kfc_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.pll_clks = kfc_pll_clks;
 	cmu.nr_pll_clks =  ARRAY_SIZE(kfc_pll_clks);
@@ -1104,7 +973,7 @@ static void __init exynos5260_clk_kfc_init(struct device_node *np)
 	cmu.clk_regs = kfc_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(kfc_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_kfc, "samsung,exynos5260-clock-kfc",
@@ -1148,7 +1017,7 @@ struct samsung_gate_clock mfc_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_mfc_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = mfc_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(mfc_mux_clks);
@@ -1160,7 +1029,7 @@ static void __init exynos5260_clk_mfc_init(struct device_node *np)
 	cmu.clk_regs = mfc_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(mfc_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_mfc, "samsung,exynos5260-clock-mfc",
@@ -1295,7 +1164,7 @@ static struct samsung_pll_clock mif_pll_clks[] __initdata = {
 
 static void __init exynos5260_clk_mif_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.pll_clks = mif_pll_clks;
 	cmu.nr_pll_clks =  ARRAY_SIZE(mif_pll_clks);
@@ -1309,7 +1178,7 @@ static void __init exynos5260_clk_mif_init(struct device_node *np)
 	cmu.clk_regs = mif_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(mif_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_mif, "samsung,exynos5260-clock-mif",
@@ -1503,7 +1372,7 @@ struct samsung_gate_clock peri_gate_clks[] __initdata = {
 
 static void __init exynos5260_clk_peri_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.mux_clks = peri_mux_clks;
 	cmu.nr_mux_clks = ARRAY_SIZE(peri_mux_clks);
@@ -1515,7 +1384,7 @@ static void __init exynos5260_clk_peri_init(struct device_node *np)
 	cmu.clk_regs = peri_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(peri_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_peri, "samsung,exynos5260-clock-peri",
@@ -1959,7 +1828,7 @@ static struct samsung_pll_clock top_pll_clks[] __initdata = {
 
 static void __init exynos5260_clk_top_init(struct device_node *np)
 {
-	struct exynos5260_cmu_info cmu = {0};
+	struct exynos_cmu_info cmu = {0};
 
 	cmu.pll_clks = top_pll_clks;
 	cmu.nr_pll_clks =  ARRAY_SIZE(top_pll_clks);
@@ -1975,7 +1844,7 @@ static void __init exynos5260_clk_top_init(struct device_node *np)
 	cmu.clk_regs = top_clk_regs;
 	cmu.nr_clk_regs = ARRAY_SIZE(top_clk_regs);
 
-	exynos5260_cmu_register_one(np, &cmu);
+	exynos_cmu_register_one(np, &cmu);
 }
 
 CLK_OF_DECLARE(exynos5260_clk_top, "samsung,exynos5260-clock-top",
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index deab84d..a043654 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -14,6 +14,8 @@
 #include <linux/syscore_ops.h>
 #include "clk.h"
 
+static LIST_HEAD(clock_reg_cache_list);
+
 void samsung_clk_save(void __iomem *base,
 				    struct samsung_clk_reg_dump *rd,
 				    unsigned int num_regs)
@@ -313,3 +315,96 @@ unsigned long _get_rate(const char *clk_name)
 
 	return clk_get_rate(clk);
 }
+
+#ifdef CONFIG_PM_SLEEP
+static int exynos_clk_suspend(void)
+{
+	struct exynos_clock_reg_cache *reg_cache;
+
+	list_for_each_entry(reg_cache, &clock_reg_cache_list, node)
+		samsung_clk_save(reg_cache->reg_base, reg_cache->rdump,
+				reg_cache->rd_num);
+	return 0;
+}
+
+static void exynos_clk_resume(void)
+{
+	struct exynos_clock_reg_cache *reg_cache;
+
+	list_for_each_entry(reg_cache, &clock_reg_cache_list, node)
+		samsung_clk_restore(reg_cache->reg_base, reg_cache->rdump,
+				reg_cache->rd_num);
+}
+
+static struct syscore_ops exynos_clk_syscore_ops = {
+	.suspend = exynos_clk_suspend,
+	.resume = exynos_clk_resume,
+};
+
+static void exynos_clk_sleep_init(void __iomem *reg_base,
+		const unsigned long *rdump,
+		unsigned long nr_rdump)
+{
+	struct exynos_clock_reg_cache *reg_cache;
+
+	reg_cache = kzalloc(sizeof(struct exynos_clock_reg_cache),
+			GFP_KERNEL);
+	if (!reg_cache)
+		panic("could not allocate register reg_cache.\n");
+	reg_cache->rdump = samsung_clk_alloc_reg_dump(rdump, nr_rdump);
+
+	if (!reg_cache->rdump)
+		panic("could not allocate register dump storage.\n");
+
+	if (list_empty(&clock_reg_cache_list))
+		register_syscore_ops(&exynos_clk_syscore_ops);
+
+	reg_cache->reg_base = reg_base;
+	reg_cache->rd_num = nr_rdump;
+	list_add_tail(&reg_cache->node, &clock_reg_cache_list);
+}
+
+#else
+static void exynos_clk_sleep_init(void __iomem *reg_base,
+		const unsigned long *rdump,
+		unsigned long nr_rdump) {}
+#endif
+
+/*
+ * Common function which registers plls, muxes, dividers and gates
+ * for each CMU. It also add CMU register list to register cache.
+ */
+void __init exynos_cmu_register_one(struct device_node *np,
+			struct exynos_cmu_info *cmu)
+{
+	void __iomem *reg_base;
+	struct samsung_clk_provider *ctx;
+
+	reg_base = of_iomap(np, 0);
+	if (!reg_base)
+		panic("%s: failed to map registers\n", __func__);
+
+	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
+	if (!ctx)
+		panic("%s: unable to alllocate ctx\n", __func__);
+
+	if (cmu->pll_clks)
+		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks,
+			reg_base);
+	if (cmu->mux_clks)
+		samsung_clk_register_mux(ctx, cmu->mux_clks,
+			cmu->nr_mux_clks);
+	if (cmu->div_clks)
+		samsung_clk_register_div(ctx, cmu->div_clks, cmu->nr_div_clks);
+	if (cmu->gate_clks)
+		samsung_clk_register_gate(ctx, cmu->gate_clks,
+			cmu->nr_gate_clks);
+	if (cmu->fixed_clks)
+		samsung_clk_register_fixed_rate(ctx, cmu->fixed_clks,
+			cmu->nr_fixed_clks);
+	if (cmu->clk_regs)
+		exynos_clk_sleep_init(reg_base, cmu->clk_regs,
+			cmu->nr_clk_regs);
+
+	samsung_clk_of_add_provider(np, ctx);
+}
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 66ab36b..552d155 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -324,6 +324,37 @@ struct samsung_pll_clock {
 	__PLL(_typ, _id, NULL, _name, _pname, CLK_GET_RATE_NOCACHE,	\
 		_lock, _con, _rtable, _alias)
 
+struct exynos_clock_reg_cache {
+	struct list_head node;
+	void __iomem *reg_base;
+	struct samsung_clk_reg_dump *rdump;
+	unsigned int rd_num;
+};
+
+struct exynos_cmu_info {
+	/* list of pll clocks and respective count */
+	struct samsung_pll_clock *pll_clks;
+	unsigned int nr_pll_clks;
+	/* list of mux clocks and respective count */
+	struct samsung_mux_clock *mux_clks;
+	unsigned int nr_mux_clks;
+	/* list of div clocks and respective count */
+	struct samsung_div_clock *div_clks;
+	unsigned int nr_div_clks;
+	/* list of gate clocks and respective count */
+	struct samsung_gate_clock *gate_clks;
+	unsigned int nr_gate_clks;
+	/* list of fixed clocks and respective count */
+	struct samsung_fixed_rate_clock *fixed_clks;
+	unsigned int nr_fixed_clks;
+	/* total number of clocks with IDs assigned*/
+	unsigned int nr_clk_ids;
+
+	/* list and number of clocks registers */
+	unsigned long *clk_regs;
+	unsigned int nr_clk_regs;
+};
+
 extern struct samsung_clk_provider *__init samsung_clk_init(
 			struct device_node *np, void __iomem *base,
 			unsigned long nr_clks);
@@ -362,6 +393,9 @@ extern void __init samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 			struct samsung_pll_clock *pll_list,
 			unsigned int nr_clk, void __iomem *base);
 
+extern void __init exynos_cmu_register_one(struct device_node *,
+			struct exynos_cmu_info *);
+
 extern unsigned long _get_rate(const char *clk_name);
 
 extern void samsung_clk_save(void __iomem *base,
-- 
1.7.9.5
