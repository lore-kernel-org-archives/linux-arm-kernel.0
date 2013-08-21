From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 21 Aug 2013 02:33:21 +0200
Subject: [PATCH] clk: samsung: pll: Use new registration method for PLL6552
 and PLL6553
In-Reply-To: <20130820002258.4443.34197@quantum>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <158901ce9b34$c0ac8720$42059560$@org> <20130820002258.4443.34197@quantum>
Message-ID: <1856348.DCxTucbm8V@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies PLL6552 and PLL6553 clock drivers to use recently
added common Samsung PLL registration method.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/clk/samsung/clk-pll.c | 105 +++++-------------------------------------
 drivers/clk/samsung/clk-pll.h |   6 +--
 2 files changed, 13 insertions(+), 98 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 0775554..7572d1d 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -441,9 +441,6 @@ struct clk * __init samsung_clk_register_pll46xx(const char *name,
  * PLL6552 Clock Type
  */
 
-#define PLL6552_LOCK_REG	0x00
-#define PLL6552_CON_REG		0x0c
-
 #define PLL6552_MDIV_MASK	0x3ff
 #define PLL6552_PDIV_MASK	0x3f
 #define PLL6552_SDIV_MASK	0x7
@@ -451,21 +448,14 @@ struct clk * __init samsung_clk_register_pll46xx(const char *name,
 #define PLL6552_PDIV_SHIFT	8
 #define PLL6552_SDIV_SHIFT	0
 
-struct samsung_clk_pll6552 {
-	struct clk_hw hw;
-	void __iomem *reg_base;
-};
-
-#define to_clk_pll6552(_hw) container_of(_hw, struct samsung_clk_pll6552, hw)
-
 static unsigned long samsung_pll6552_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	struct samsung_clk_pll6552 *pll = to_clk_pll6552(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->reg_base + PLL6552_CON_REG);
+	pll_con = __raw_readl(pll->con_reg);
 	mdiv = (pll_con >> PLL6552_MDIV_SHIFT) & PLL6552_MDIV_MASK;
 	pdiv = (pll_con >> PLL6552_PDIV_SHIFT) & PLL6552_PDIV_MASK;
 	sdiv = (pll_con >> PLL6552_SDIV_SHIFT) & PLL6552_SDIV_MASK;
@@ -480,48 +470,10 @@ static const struct clk_ops samsung_pll6552_clk_ops = {
 	.recalc_rate = samsung_pll6552_recalc_rate,
 };
 
-struct clk * __init samsung_clk_register_pll6552(const char *name,
-					const char *pname, void __iomem *base)
-{
-	struct samsung_clk_pll6552 *pll;
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
-	init.ops = &samsung_pll6552_clk_ops;
-	init.parent_names = &pname;
-	init.num_parents = 1;
-
-	pll->hw.init = &init;
-	pll->reg_base = base;
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
  * PLL6553 Clock Type
  */
 
-#define PLL6553_LOCK_REG	0x00
-#define PLL6553_CON0_REG	0x0c
-#define PLL6553_CON1_REG	0x10
-
 #define PLL6553_MDIV_MASK	0xff
 #define PLL6553_PDIV_MASK	0x3f
 #define PLL6553_SDIV_MASK	0x7
@@ -531,22 +483,15 @@ struct clk * __init samsung_clk_register_pll6552(const char *name,
 #define PLL6553_SDIV_SHIFT	0
 #define PLL6553_KDIV_SHIFT	0
 
-struct samsung_clk_pll6553 {
-	struct clk_hw hw;
-	void __iomem *reg_base;
-};
-
-#define to_clk_pll6553(_hw) container_of(_hw, struct samsung_clk_pll6553, hw)
-
 static unsigned long samsung_pll6553_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
-	struct samsung_clk_pll6553 *pll = to_clk_pll6553(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, kdiv, pll_con0, pll_con1;
 	u64 fvco = parent_rate;
 
-	pll_con0 = __raw_readl(pll->reg_base + PLL6553_CON0_REG);
-	pll_con1 = __raw_readl(pll->reg_base + PLL6553_CON1_REG);
+	pll_con0 = __raw_readl(pll->con_reg);
+	pll_con1 = __raw_readl(pll->con_reg + 0x4);
 	mdiv = (pll_con0 >> PLL6553_MDIV_SHIFT) & PLL6553_MDIV_MASK;
 	pdiv = (pll_con0 >> PLL6553_PDIV_SHIFT) & PLL6553_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL6553_SDIV_SHIFT) & PLL6553_SDIV_MASK;
@@ -563,40 +508,6 @@ static const struct clk_ops samsung_pll6553_clk_ops = {
 	.recalc_rate = samsung_pll6553_recalc_rate,
 };
 
-struct clk * __init samsung_clk_register_pll6553(const char *name,
-					const char *pname, void __iomem *base)
-{
-	struct samsung_clk_pll6553 *pll;
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
-	init.ops = &samsung_pll6553_clk_ops;
-	init.parent_names = &pname;
-	init.num_parents = 1;
-
-	pll->hw.init = &init;
-	pll->reg_base = base;
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
  * PLL2550x Clock Type
  */
@@ -732,6 +643,12 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 		else
 			init.ops = &samsung_pll36xx_clk_ops;
 		break;
+	case pll_6552:
+		init.ops = &samsung_pll6552_clk_ops;
+		break;
+	case pll_6553:
+		init.ops = &samsung_pll6553_clk_ops;
+		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
 			__func__, pll_clk->name);
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 2f70e88..cd11037 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -17,6 +17,8 @@ enum samsung_pll_type {
 	pll_36xx,
 	pll_2550,
 	pll_2650,
+	pll_6552,
+	pll_6553,
 };
 
 #define PLL_35XX_RATE(_rate, _m, _p, _s)			\
@@ -64,10 +66,6 @@ extern struct clk * __init samsung_clk_register_pll45xx(const char *name,
 extern struct clk * __init samsung_clk_register_pll46xx(const char *name,
 			const char *pname, const void __iomem *con_reg,
 			enum pll46xx_type type);
-extern struct clk *samsung_clk_register_pll6552(const char *name,
-			const char *pname, void __iomem *base);
-extern struct clk *samsung_clk_register_pll6553(const char *name,
-			const char *pname, void __iomem *base);
 extern struct clk * __init samsung_clk_register_pll2550x(const char *name,
 			const char *pname, const void __iomem *reg_base,
 			const unsigned long offset);
-- 
1.8.3.2
