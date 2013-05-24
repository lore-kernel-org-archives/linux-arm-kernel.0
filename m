From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Fri, 24 May 2013 16:01:14 +0530
Subject: [RESEND PATCH 1/5] clk: samsung: Use clk->base instead of directly
 using clk->con0 for PLL3xxx
In-Reply-To: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
References: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1369391478-7665-2-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yadwinder Singh Brar <yadi.brar@samsung.com>

To factor out possible common code, this patch unifies the clk strutures used
for PLL35xx & PLL36xx and usues clk->base instead of clk->con0.

Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c    |   10 ++++---
 drivers/clk/samsung/clk-exynos5250.c |   14 ++++-----
 drivers/clk/samsung/clk-pll.c        |   54 ++++++++++++++++++----------------
 drivers/clk/samsung/clk-pll.h        |    4 +--
 4 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index d0940e6..cf7d4e7 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -97,12 +97,14 @@
 #define GATE_IP_PERIL		0xc950
 #define E4210_GATE_IP_PERIR	0xc960
 #define GATE_BLOCK		0xc970
+#define E4X12_MPLL_LOCK		0x10008
 #define E4X12_MPLL_CON0		0x10108
 #define SRC_DMC			0x10200
 #define SRC_MASK_DMC		0x10300
 #define DIV_DMC0		0x10500
 #define DIV_DMC1		0x10504
 #define GATE_IP_DMC		0x10900
+#define APLL_LOCK		0x14000
 #define APLL_CON0		0x14100
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
@@ -1019,13 +1021,13 @@ void __init exynos4_clk_init(struct device_node *np, enum exynos4_soc exynos4_so
 					reg_base + VPLL_CON0, pll_4650c);
 	} else {
 		apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-					reg_base + APLL_CON0);
+					reg_base + APLL_LOCK);
 		mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-					reg_base + E4X12_MPLL_CON0);
+					reg_base + E4X12_MPLL_LOCK);
 		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-					reg_base + EPLL_CON0);
+					reg_base + EPLL_LOCK);
 		vpll = samsung_clk_register_pll36xx("fout_vpll", "fin_pll",
-					reg_base + VPLL_CON0);
+					reg_base + VPLL_LOCK);
 	}
 
 	samsung_clk_add_lookup(apll, fout_apll);
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 5c97e75..687b580 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -491,19 +491,19 @@ void __init exynos5250_clk_init(struct device_node *np)
 			ext_clk_match);
 
 	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
-			reg_base + 0x100);
+			reg_base);
 	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-			reg_base + 0x4100);
+			reg_base + 0x4000);
 	bpll = samsung_clk_register_pll35xx("fout_bpll", "fin_pll",
-			reg_base + 0x20110);
+			reg_base + 0x20010);
 	gpll = samsung_clk_register_pll35xx("fout_gpll", "fin_pll",
-			reg_base + 0x10150);
+			reg_base + 0x10050);
 	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
-			reg_base + 0x10120);
+			reg_base + 0x10020);
 	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-			reg_base + 0x10130);
+			reg_base + 0x10030);
 	vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
-			reg_base + 0x10140);
+			reg_base + 0x10040);
 
 	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_clks));
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 89135f6..01f17cf 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -13,9 +13,24 @@
 #include "clk.h"
 #include "clk-pll.h"
 
+struct samsung_clk_pll {
+	struct clk_hw		hw;
+	const void __iomem	*base;
+};
+
+#define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
+
+#define pll_readl(pll, offset)						\
+		__raw_readl((void __iomem *)(pll->base + (offset)));
+#define pll_writel(pll, val, offset)					\
+		__raw_writel(val, (void __iomem *)(pll->base + (offset)));
+
 /*
  * PLL35xx Clock Type
  */
+#define PLL35XX_LOCK_OFFSET             0x0
+#define PLL35XX_CON0_OFFSET             0x100
+#define PLL35XX_CON1_OFFSET             0x104
 
 #define PLL35XX_MDIV_MASK       (0x3FF)
 #define PLL35XX_PDIV_MASK       (0x3F)
@@ -24,21 +39,14 @@
 #define PLL35XX_PDIV_SHIFT      (8)
 #define PLL35XX_SDIV_SHIFT      (0)
 
-struct samsung_clk_pll35xx {
-	struct clk_hw		hw;
-	const void __iomem	*con_reg;
-};
-
-#define to_clk_pll35xx(_hw) container_of(_hw, struct samsung_clk_pll35xx, hw)
-
 static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
-	struct samsung_clk_pll35xx *pll = to_clk_pll35xx(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = pll_readl(pll, PLL35XX_CON0_OFFSET);
 	mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
 	pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
 	sdiv = (pll_con >> PLL35XX_SDIV_SHIFT) & PLL35XX_SDIV_MASK;
@@ -54,9 +62,9 @@ static const struct clk_ops samsung_pll35xx_clk_ops = {
 };
 
 struct clk * __init samsung_clk_register_pll35xx(const char *name,
-			const char *pname, const void __iomem *con_reg)
+			const char *pname, const void __iomem *base)
 {
-	struct samsung_clk_pll35xx *pll;
+	struct samsung_clk_pll *pll;
 	struct clk *clk;
 	struct clk_init_data init;
 
@@ -73,7 +81,7 @@ struct clk * __init samsung_clk_register_pll35xx(const char *name,
 	init.num_parents = 1;
 
 	pll->hw.init = &init;
-	pll->con_reg = con_reg;
+	pll->base = base;
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
@@ -91,6 +99,9 @@ struct clk * __init samsung_clk_register_pll35xx(const char *name,
 /*
  * PLL36xx Clock Type
  */
+#define PLL36XX_LOCK_OFFSET             0x0
+#define PLL36XX_CON0_OFFSET             0x100
+#define PLL36XX_CON1_OFFSET             0x104
 
 #define PLL36XX_KDIV_MASK	(0xFFFF)
 #define PLL36XX_MDIV_MASK	(0x1FF)
@@ -100,22 +111,15 @@ struct clk * __init samsung_clk_register_pll35xx(const char *name,
 #define PLL36XX_PDIV_SHIFT	(8)
 #define PLL36XX_SDIV_SHIFT	(0)
 
-struct samsung_clk_pll36xx {
-	struct clk_hw		hw;
-	const void __iomem	*con_reg;
-};
-
-#define to_clk_pll36xx(_hw) container_of(_hw, struct samsung_clk_pll36xx, hw)
-
 static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
-	struct samsung_clk_pll36xx *pll = to_clk_pll36xx(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, kdiv, pll_con0, pll_con1;
 	u64 fvco = parent_rate;
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con1 = __raw_readl(pll->con_reg + 4);
+	pll_con0 = pll_readl(pll, PLL36XX_CON0_OFFSET);
+	pll_con1 = pll_readl(pll, PLL36XX_CON1_OFFSET);
 	mdiv = (pll_con0 >> PLL36XX_MDIV_SHIFT) & PLL36XX_MDIV_MASK;
 	pdiv = (pll_con0 >> PLL36XX_PDIV_SHIFT) & PLL36XX_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL36XX_SDIV_SHIFT) & PLL36XX_SDIV_MASK;
@@ -133,9 +137,9 @@ static const struct clk_ops samsung_pll36xx_clk_ops = {
 };
 
 struct clk * __init samsung_clk_register_pll36xx(const char *name,
-			const char *pname, const void __iomem *con_reg)
+			const char *pname, const void __iomem *base)
 {
-	struct samsung_clk_pll36xx *pll;
+	struct samsung_clk_pll *pll;
 	struct clk *clk;
 	struct clk_init_data init;
 
@@ -152,7 +156,7 @@ struct clk * __init samsung_clk_register_pll36xx(const char *name,
 	init.num_parents = 1;
 
 	pll->hw.init = &init;
-	pll->con_reg = con_reg;
+	pll->base = base;
 
 	clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index f33786e..1329522 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -25,9 +25,9 @@ enum pll46xx_type {
 };
 
 extern struct clk * __init samsung_clk_register_pll35xx(const char *name,
-			const char *pname, const void __iomem *con_reg);
+			const char *pname, const void __iomem *base);
 extern struct clk * __init samsung_clk_register_pll36xx(const char *name,
-			const char *pname, const void __iomem *con_reg);
+			const char *pname, const void __iomem *base);
 extern struct clk * __init samsung_clk_register_pll45xx(const char *name,
 			const char *pname, const void __iomem *con_reg,
 			enum pll45xx_type type);
-- 
1.7.9.5
