From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Fri, 24 May 2013 16:01:15 +0530
Subject: [RESEND PATCH 2/5] clk: samsung: Add support to register rate_table
 for PLL3xxx
In-Reply-To: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
References: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1369391478-7665-3-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yadwinder Singh Brar <yadi.brar@samsung.com>

This patch defines a common rate_table which will contain recommended p, m, s
and k values for supported rates that needs to be changed for changing
corresponding PLL's rate.
It also sorts the rate table while registering the PLL rate table.
So that this sorted table can be used for making the searching of "required
rate" efficient.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c    |    8 ++++----
 drivers/clk/samsung/clk-exynos5250.c |   14 +++++++-------
 drivers/clk/samsung/clk-pll.c        |   35 ++++++++++++++++++++++++++++++++--
 drivers/clk/samsung/clk-pll.h        |   27 ++++++++++++++++++++++++--
 4 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index cf7d4e7..beff8a1 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1021,13 +1021,13 @@ void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc exynos4_so
 					reg_base + VPLL_CON0, pll_4650c);
 	} else {
 		apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-					reg_base + APLL_LOCK);
+					reg_base + APLL_LOCK, NULL, 0);
 		mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-					reg_base + E4X12_MPLL_LOCK);
+					reg_base + E4X12_MPLL_LOCK, NULL, 0);
 		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-					reg_base + EPLL_LOCK);
+					reg_base + EPLL_LOCK, NULL, 0);
 		vpll = samsung_clk_register_pll36xx("fout_vpll", "fin_pll",
-					reg_base + VPLL_LOCK);
+					reg_base + VPLL_LOCK, NULL, 0);
 	}
 
 	samsung_clk_add_lookup(apll, fout_apll);
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 687b580..ddf10ca 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -491,19 +491,19 @@ void __init exynos5250_clk_init(struct device_node *np)
 			ext_clk_match);
 
 	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-			reg_base);
+			reg_base, NULL, 0);
 	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-			reg_base + 0x4000);
+			reg_base + 0x4000, NULL, 0);
 	bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
-			reg_base + 0x20010);
+			reg_base + 0x20010, NULL, 0);
 	gpll = samsung_clk_register_pll35xx("fout_gpll", "fin_pll",
-			reg_base + 0x10050);
+			reg_base + 0x10050, NULL, 0);
 	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
-			reg_base + 0x10020);
+			reg_base + 0x10020, NULL, 0);
 	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-			reg_base + 0x10030);
+			reg_base + 0x10030, NULL, 0);
 	vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
-			reg_base + 0x10040);
+			reg_base + 0x10040, NULL, 0);
 
 	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_clks));
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 01f17cf..b8c0260 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -10,12 +10,15 @@
 */
 
 #include <linux/errno.h>
+#include <linux/sort.h>
 #include "clk.h"
 #include "clk-pll.h"
 
 struct samsung_clk_pll {
 	struct clk_hw		hw;
 	const void __iomem	*base;
+	struct samsung_pll_rate_table *rate_table;
+	unsigned int rate_count;
 };
 
 #define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
@@ -25,6 +28,14 @@ struct samsung_clk_pll {
 #define pll_writel(pll, val, offset)					\
 		__raw_writel(val, (void __iomem *)(pll->base + (offset)));
 
+static int samsung_compare_rate(const void *_a, const void *_b)
+{
+	const struct samsung_pll_rate_table *a = _a;
+	const struct samsung_pll_rate_table *b = _b;
+
+	return a->rate - b->rate;
+}
+
 /*
  * PLL35xx Clock Type
  */
@@ -62,7 +73,9 @@ static const struct clk_ops samsung_pll35xx_clk_ops = {
 };
 
 struct clk * __init samsung_clk_register_pll35xx(const char *name,
-			const char *pname, const void __iomem *base)
+			const char *pname, const void __iomem *base,
+			struct samsung_pll_rate_table *rate_table,
+			const unsigned int rate_count)
 {
 	struct samsung_clk_pll *pll;
 	struct clk *clk;
@@ -82,6 +95,14 @@ struct clk * __init samsung_clk_register_pll35xx(const char *name,
 
 	pll->hw.init = &init;
 	pll->base = base;
+	pll->rate_table = rate_table;
+	pll->rate_count = rate_count;
+
+	if (pll->rate_table && pll->rate_count) {
+		sort(pll->rate_table, pll->rate_count,
+			sizeof(struct samsung_pll_rate_table),
+			samsung_compare_rate, NULL);
+	}
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
@@ -137,7 +158,9 @@ static const struct clk_ops samsung_pll36xx_clk_ops = {
 };
 
 struct clk * __init samsung_clk_register_pll36xx(const char *name,
-			const char *pname, const void __iomem *base)
+			const char *pname, const void __iomem *base,
+			struct samsung_pll_rate_table *rate_table,
+			const unsigned int rate_count)
 {
 	struct samsung_clk_pll *pll;
 	struct clk *clk;
@@ -157,6 +180,14 @@ struct clk * __init samsung_clk_register_pll36xx(const char *name,
 
 	pll->hw.init = &init;
 	pll->base = base;
+	pll->rate_table = rate_table;
+	pll->rate_count = rate_count;
+
+	if (pll->rate_table && pll->rate_count) {
+		sort(pll->rate_table, pll->rate_count,
+			sizeof(struct samsung_pll_rate_table),
+			samsung_compare_rate, NULL);
+	}
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 1329522..b5e12430 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -12,6 +12,25 @@
 #ifndef __SAMSUNG_CLK_PLL_H
 #define __SAMSUNG_CLK_PLL_H
 
+#define PLL_35XX_RATE(_rate, _m, _p, _s)			\
+	{							\
+		.rate = _rate,					\
+		.pll_con0 = ((_m) << 16 | (_p) << 8 | (_s)),	\
+	}
+
+#define PLL_36XX_RATE(_rate, _m, _p, _s, _k)			\
+	{							\
+		.rate = _rate,					\
+		.pll_con0 = ((_m) << 16 | (_p) << 8 | (_s)),	\
+		.pll_con1 = _k,					\
+	}
+
+struct samsung_pll_rate_table {
+	unsigned  int rate;
+	u32 pll_con0;
+	u32 pll_con1;
+};
+
 enum pll45xx_type {
 	pll_4500,
 	pll_4502,
@@ -25,9 +44,13 @@ enum pll46xx_type {
 };
 
 extern struct clk * __init samsung_clk_register_pll35xx(const char *name,
-			const char *pname, const void __iomem *base);
+			const char *pname, const void __iomem *base,
+			struct samsung_pll_rate_table *rate_table,
+			const unsigned int rate_count);
 extern struct clk * __init samsung_clk_register_pll36xx(const char *name,
-			const char *pname, const void __iomem *base);
+			const char *pname, const void __iomem *base,
+			struct samsung_pll_rate_table *rate_table,
+			const unsigned int rate_count);
 extern struct clk * __init samsung_clk_register_pll45xx(const char *name,
 			const char *pname, const void __iomem *con_reg,
 			enum pll45xx_type type);
-- 
1.7.9.5
