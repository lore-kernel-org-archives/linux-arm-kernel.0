From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 19:31:38 +0200
Subject: [PATCH 11/16] clk: samsung: pll: Use new registration method for
 PLL46xx
In-Reply-To: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377019903-14614-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies PLL46xx support code and its users to use the
recently introduced common PLL registration helper.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 13 +++-------
 drivers/clk/samsung/clk-pll.c     | 52 +++++----------------------------------
 drivers/clk/samsung/clk-pll.h     | 14 +++--------
 3 files changed, 14 insertions(+), 65 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 6036fdf..42a4001 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -994,6 +994,10 @@ static struct __initdata samsung_pll_clock exynos4210_plls[nr_plls] = {
 		APLL_CON0, "fout_apll", NULL),
 	[mpll] = PLL_A(pll_4508, fout_mpll, "fout_mpll", "fin_pll",
 		E4210_MPLL_LOCK, E4210_MPLL_CON0, "fout_mpll", NULL),
+	[epll] = PLL_A(pll_4600, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
+		EPLL_CON0, "fout_epll", NULL),
+	[vpll] = PLL_A(pll_4650c, fout_vpll, "fout_vpll", "mout_vpllsrc",
+		VPLL_LOCK, VPLL_CON0, "fout_vpll", NULL),
 };
 
 static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
@@ -1012,8 +1016,6 @@ static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc exynos4_soc,
 				    void __iomem *reg_base, unsigned long xom)
 {
-	struct clk *epll, *vpll;
-
 	reg_base = of_iomap(np, 0);
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
@@ -1036,13 +1038,6 @@ static void __init exynos4_clk_init(struct device_node *np,
 	if (exynos4_soc == EXYNOS4210) {
 		samsung_clk_register_pll(exynos4210_plls,
 					ARRAY_SIZE(exynos4210_plls), reg_base);
-		epll = samsung_clk_register_pll46xx("fout_epll", "fin_pll",
-					reg_base + EPLL_CON0, pll_4600);
-		vpll = samsung_clk_register_pll46xx("fout_vpll", "mout_vpllsrc",
-					reg_base + VPLL_CON0, pll_4650c);
-
-		samsung_clk_add_lookup(epll, fout_epll);
-		samsung_clk_add_lookup(vpll, fout_vpll);
 	} else {
 		samsung_clk_register_pll(exynos4x12_plls,
 					ARRAY_SIZE(exynos4x12_plls), reg_base);
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index cb971cb..8a008ca 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -422,18 +422,10 @@ static const struct clk_ops samsung_pll45xx_clk_min_ops = {
 #define PLL4650C_KDIV_MASK	(0xFFF)
 #define PLL46XX_KDIV_SHIFT	(0)
 
-struct samsung_clk_pll46xx {
-	struct clk_hw		hw;
-	enum pll46xx_type	type;
-	const void __iomem	*con_reg;
-};
-
-#define to_clk_pll46xx(_hw) container_of(_hw, struct samsung_clk_pll46xx, hw)
-
 static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
-	struct samsung_clk_pll46xx *pll = to_clk_pll46xx(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, kdiv, pll_con0, pll_con1, shift;
 	u64 fvco = parent_rate;
 
@@ -457,43 +449,6 @@ static const struct clk_ops samsung_pll46xx_clk_ops = {
 	.recalc_rate = samsung_pll46xx_recalc_rate,
 };
 
-struct clk * __init samsung_clk_register_pll46xx(const char *name,
-			const char *pname, const void __iomem *con_reg,
-			enum pll46xx_type type)
-{
-	struct samsung_clk_pll46xx *pll;
-	struct clk *clk;
-	struct clk_init_data init;
-
-	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
-	if (!pll) {
-		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
-		return NULL;
-	}
-
-	init.name = name;
-	init.ops = &samsung_pll46xx_clk_ops;
-	init.flags = CLK_GET_RATE_NOCACHE;
-	init.parent_names = &pname;
-	init.num_parents = 1;
-
-	pll->hw.init = &init;
-	pll->con_reg = con_reg;
-	pll->type = type;
-
-	clk = clk_register(NULL, &pll->hw);
-	if (IS_ERR(clk)) {
-		pr_err("%s: failed to register pll clock %s\n", __func__,
-				name);
-		kfree(pll);
-	}
-
-	if (clk_register_clkdev(clk, name, NULL))
-		pr_err("%s: failed to register lookup for %s", __func__, name);
-
-	return clk;
-}
-
 /*
  * PLL6552 Clock Type
  */
@@ -799,6 +754,11 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 		else
 			init.ops = &samsung_pll36xx_clk_ops;
 		break;
+	case pll_4600:
+	case pll_4650:
+	case pll_4650c:
+		init.ops = &samsung_pll46xx_clk_ops;
+		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
 			__func__, pll_clk->name);
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index aa8cc15..7de5e3e 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -19,7 +19,10 @@ enum samsung_pll_type {
 	pll_2650,
 	pll_4500,
 	pll_4502,
-	pll_4508
+	pll_4508,
+	pll_4600,
+	pll_4650,
+	pll_4650c,
 };
 
 #define PLL_35XX_RATE(_rate, _m, _p, _s)			\
@@ -59,15 +62,6 @@ struct samsung_pll_rate_table {
 	unsigned int afc;
 };
 
-enum pll46xx_type {
-	pll_4600,
-	pll_4650,
-	pll_4650c,
-};
-
-extern struct clk * __init samsung_clk_register_pll46xx(const char *name,
-			const char *pname, const void __iomem *con_reg,
-			enum pll46xx_type type);
 extern struct clk *samsung_clk_register_pll6552(const char *name,
 			const char *pname, void __iomem *base);
 extern struct clk *samsung_clk_register_pll6553(const char *name,
-- 
1.8.3.2
