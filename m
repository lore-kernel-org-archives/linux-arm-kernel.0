From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 10 Jul 2013 00:59:08 +0200
Subject: [PATCH v2 3/6] clk: samsung: add plls used in s3c2416 and s3c2443
In-Reply-To: <201307100057.06061.heiko@sntech.de>
References: <201307100057.06061.heiko@sntech.de>
Message-ID: <201307100059.08621.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for pll2126x, pll3000x, pll6552x and pll6553x.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/samsung/clk-pll.c |  280 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h |    8 ++
 2 files changed, 288 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 0afaec6..35c15a1 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -323,6 +323,73 @@ struct clk * __init samsung_clk_register_pll46xx(const char *name,
 }
 
 /*
+ * PLL2126x Clock Type
+ */
+
+#define PLL2126X_MDIV_MASK	(0xFF)
+#define PLL2126X_PDIV_MASK	(0x3)
+#define PLL2126X_SDIV_MASK	(0x3)
+#define PLL2126X_MDIV_SHIFT	(16)
+#define PLL2126X_PDIV_SHIFT	(8)
+#define PLL2126X_SDIV_SHIFT	(0)
+
+struct samsung_clk_pll2126x {
+	struct clk_hw		hw;
+	const void __iomem	*con_reg;
+};
+
+#define to_clk_pll2126x(_hw) container_of(_hw, struct samsung_clk_pll2126x, hw)
+
+static unsigned long samsung_pll2126x_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct samsung_clk_pll2126x *pll = to_clk_pll2126x(hw);
+	u32 pll_con, mdiv, pdiv, sdiv;
+	u64 fvco = parent_rate;
+
+	pll_con = __raw_readl(pll->con_reg);
+	mdiv = (pll_con >> PLL2126X_MDIV_SHIFT) & PLL2126X_MDIV_MASK;
+	pdiv = (pll_con >> PLL2126X_PDIV_SHIFT) & PLL2126X_PDIV_MASK;
+	sdiv = (pll_con >> PLL2126X_SDIV_SHIFT) & PLL2126X_SDIV_MASK;
+
+	fvco *= (mdiv + 8);
+	do_div(fvco, (pdiv + 2) << sdiv);
+
+	return (unsigned long)fvco;
+}
+
+static const struct clk_ops samsung_pll2126x_clk_ops = {
+	.recalc_rate = samsung_pll2126x_recalc_rate,
+};
+
+struct clk * __init samsung_clk_register_pll2126x(const char *name,
+			const char *pname, const void __iomem *con_reg)
+{
+	struct samsung_clk_pll2126x *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &samsung_pll2126x_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = &pname;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+	pll->con_reg = con_reg;
+
+	clk = samsung_register_pll(&pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
+
+/*
  * PLL2550x Clock Type
  */
 
@@ -396,3 +463,216 @@ struct clk * __init samsung_clk_register_pll2550x(const char *name,
 
 	return clk;
 }
+
+/*
+ * PLL3000x Clock Type
+ */
+
+#define PLL3000X_MDIV_MASK	(0xFF)
+#define PLL3000X_PDIV_MASK	(0x3)
+#define PLL3000X_SDIV_MASK	(0x3)
+#define PLL3000X_MDIV_SHIFT	(16)
+#define PLL3000X_PDIV_SHIFT	(8)
+#define PLL3000X_SDIV_SHIFT	(0)
+
+struct samsung_clk_pll3000x {
+	struct clk_hw		hw;
+	const void __iomem	*con_reg;
+};
+
+#define to_clk_pll3000x(_hw) container_of(_hw, struct samsung_clk_pll3000x, hw)
+
+static unsigned long samsung_pll3000x_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct samsung_clk_pll3000x *pll = to_clk_pll3000x(hw);
+	u32 pll_con, mdiv, pdiv, sdiv;
+	u64 fvco = parent_rate;
+
+	pll_con = __raw_readl(pll->con_reg);
+	mdiv = (pll_con >> PLL3000X_MDIV_SHIFT) & PLL3000X_MDIV_MASK;
+	pdiv = (pll_con >> PLL3000X_PDIV_SHIFT) & PLL3000X_PDIV_MASK;
+	sdiv = (pll_con >> PLL3000X_SDIV_SHIFT) & PLL3000X_SDIV_MASK;
+
+	fvco *= (2 * (mdiv + 8));
+	do_div(fvco, pdiv << sdiv);
+
+	return (unsigned long)fvco;
+}
+
+static const struct clk_ops samsung_pll3000x_clk_ops = {
+	.recalc_rate = samsung_pll3000x_recalc_rate,
+};
+
+struct clk * __init samsung_clk_register_pll3000x(const char *name,
+			const char *pname, const void __iomem *con_reg)
+{
+	struct samsung_clk_pll3000x *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &samsung_pll3000x_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = &pname;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+	pll->con_reg = con_reg;
+
+	clk = samsung_register_pll(&pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
+
+/*
+ * PLL6552x Clock Type
+ */
+
+#define PLL6552X_MDIV_MASK	(0x3FF)
+#define PLL6552X_PDIV_MASK	(0x3F)
+#define PLL6552X_SDIV_MASK	(0x7)
+#define PLL6552X_MDIV_SHIFT	(14)
+#define PLL6552X_PDIV_SHIFT	(5)
+#define PLL6552X_SDIV_SHIFT	(0)
+
+struct samsung_clk_pll6552x {
+	struct clk_hw		hw;
+	const void __iomem	*con_reg;
+};
+
+#define to_clk_pll6552x(_hw) container_of(_hw, struct samsung_clk_pll6552x, hw)
+
+static unsigned long samsung_pll6552x_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct samsung_clk_pll6552x *pll = to_clk_pll6552x(hw);
+	u32 pll_con, mdiv, pdiv, sdiv;
+	u64 fvco = parent_rate;
+
+	pll_con = __raw_readl(pll->con_reg);
+	mdiv = (pll_con >> PLL6552X_MDIV_SHIFT) & PLL6552X_MDIV_MASK;
+	pdiv = (pll_con >> PLL6552X_PDIV_SHIFT) & PLL6552X_PDIV_MASK;
+	sdiv = (pll_con >> PLL6552X_SDIV_SHIFT) & PLL6552X_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
+
+static const struct clk_ops samsung_pll6552x_clk_ops = {
+	.recalc_rate = samsung_pll6552x_recalc_rate,
+};
+
+struct clk * __init samsung_clk_register_pll6552x(const char *name,
+			const char *pname, const void __iomem *con_reg)
+{
+	struct samsung_clk_pll6552x *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &samsung_pll6552x_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = &pname;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+	pll->con_reg = con_reg;
+
+	clk = samsung_register_pll(&pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
+
+/*
+ * PLL6553x Clock Type
+ */
+
+#define PLL6553X_MDIV_MASK	(0x7F)
+#define PLL6553X_PDIV_MASK	(0x1F)
+#define PLL6553X_SDIV_MASK	(0x3)
+#define PLL6553X_KDIV_MASK	(0xFFFF)
+#define PLL6553X_MDIV_SHIFT	(16)
+#define PLL6553X_PDIV_SHIFT	(8)
+#define PLL6553X_SDIV_SHIFT	(0)
+
+struct samsung_clk_pll6553x {
+	struct clk_hw		hw;
+	const void __iomem	*con_reg;
+};
+
+#define to_clk_pll6553x(_hw) container_of(_hw, struct samsung_clk_pll6553x, hw)
+
+static unsigned long samsung_pll6553x_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct samsung_clk_pll6553x *pll = to_clk_pll6553x(hw);
+	u32 pll_con0, pll_con1, mdiv, pdiv, sdiv, kdiv;
+	u64 fvco = parent_rate;
+
+	pll_con0 = __raw_readl(pll->con_reg);
+	pll_con1 = __raw_readl(pll->con_reg + 4);
+	mdiv = (pll_con0 >> PLL6553X_MDIV_SHIFT) & PLL6553X_MDIV_MASK;
+	pdiv = (pll_con0 >> PLL6553X_PDIV_SHIFT) & PLL6553X_PDIV_MASK;
+	sdiv = (pll_con0 >> PLL6553X_SDIV_SHIFT) & PLL6553X_SDIV_MASK;
+	kdiv = pll_con1 & PLL6553X_KDIV_MASK;
+
+	/*
+	 * We need to multiple parent_rate by mdiv (the integer part) and kdiv
+	 * which is in 2^16ths, so shift mdiv up (does not overflow) and
+	 * add kdiv before multiplying. The use of tmp is to avoid any
+	 * overflows before shifting bac down into result when multipling
+	 * by the mdiv and kdiv pair.
+	 */
+
+	fvco *= (mdiv << 16) + kdiv;
+	do_div(fvco, (pdiv << sdiv));
+	fvco >>= 16;
+
+	return (unsigned long)fvco;
+}
+
+static const struct clk_ops samsung_pll6553x_clk_ops = {
+	.recalc_rate = samsung_pll6553x_recalc_rate,
+};
+
+struct clk * __init samsung_clk_register_pll6553x(const char *name,
+			const char *pname, const void __iomem *con_reg)
+{
+	struct samsung_clk_pll6553x *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &samsung_pll6553x_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = &pname;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+	pll->con_reg = con_reg;
+
+	clk = samsung_register_pll(&pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index f33786e..465ee6f 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -34,8 +34,16 @@ extern struct clk * __init samsung_clk_register_pll45xx(const char *name,
 extern struct clk * __init samsung_clk_register_pll46xx(const char *name,
 			const char *pname, const void __iomem *con_reg,
 			enum pll46xx_type type);
+extern struct clk * __init samsung_clk_register_pll2126x(const char *name,
+			const char *pname, const void __iomem *con_reg);
 extern struct clk * __init samsung_clk_register_pll2550x(const char *name,
 			const char *pname, const void __iomem *reg_base,
 			const unsigned long offset);
+extern struct clk * __init samsung_clk_register_pll3000x(const char *name,
+			const char *pname, const void __iomem *con_reg);
+extern struct clk * __init samsung_clk_register_pll6552x(const char *name,
+			const char *pname, const void __iomem *con_reg);
+extern struct clk * __init samsung_clk_register_pll6553x(const char *name,
+			const char *pname, const void __iomem *con_reg);
 
 #endif /* __SAMSUNG_CLK_PLL_H */
-- 
1.7.10.4
