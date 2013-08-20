From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 19:31:36 +0200
Subject: [PATCH 09/16] clk: samsung: pll: Use new registration method for
 PLL45xx
In-Reply-To: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
References: <1377019903-14614-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377019903-14614-10-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies PLL45xx support code and its users to use the
recently introduced common PLL registration helper.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 18 ++++++++------
 drivers/clk/samsung/clk-pll.c     | 52 +++++----------------------------------
 drivers/clk/samsung/clk-pll.h     | 12 +++------
 3 files changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index febdce2..6036fdf 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -104,6 +104,7 @@
 #define DIV_DMC1		0x10504
 #define GATE_IP_DMC		0x10900
 #define APLL_LOCK		0x14000
+#define E4210_MPLL_LOCK		0x14008
 #define APLL_CON0		0x14100
 #define E4210_MPLL_CON0		0x14108
 #define SRC_CPU			0x14200
@@ -988,6 +989,13 @@ static struct of_device_id ext_clk_match[] __initdata = {
 	{},
 };
 
+static struct __initdata samsung_pll_clock exynos4210_plls[nr_plls] = {
+	[apll] = PLL_A(pll_4508, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
+		APLL_CON0, "fout_apll", NULL),
+	[mpll] = PLL_A(pll_4508, fout_mpll, "fout_mpll", "fin_pll",
+		E4210_MPLL_LOCK, E4210_MPLL_CON0, "fout_mpll", NULL),
+};
+
 static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
 	[apll] = PLL(pll_35xx, fout_apll, "fout_apll", "fin_pll",
 			APLL_LOCK, APLL_CON0, NULL),
@@ -1004,7 +1012,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc exynos4_soc,
 				    void __iomem *reg_base, unsigned long xom)
 {
-	struct clk *apll, *mpll, *epll, *vpll;
+	struct clk *epll, *vpll;
 
 	reg_base = of_iomap(np, 0);
 	if (!reg_base)
@@ -1026,17 +1034,13 @@ static void __init exynos4_clk_init(struct device_node *np,
 	exynos4_clk_register_finpll(xom);
 
 	if (exynos4_soc == EXYNOS4210) {
-		apll = samsung_clk_register_pll45xx("fout_apll", "fin_pll",
-					reg_base + APLL_CON0, pll_4508);
-		mpll = samsung_clk_register_pll45xx("fout_mpll", "fin_pll",
-					reg_base + E4210_MPLL_CON0, pll_4508);
+		samsung_clk_register_pll(exynos4210_plls,
+					ARRAY_SIZE(exynos4210_plls), reg_base);
 		epll = samsung_clk_register_pll46xx("fout_epll", "fin_pll",
 					reg_base + EPLL_CON0, pll_4600);
 		vpll = samsung_clk_register_pll46xx("fout_vpll", "mout_vpllsrc",
 					reg_base + VPLL_CON0, pll_4650c);
 
-		samsung_clk_add_lookup(apll, fout_apll);
-		samsung_clk_add_lookup(mpll, fout_mpll);
 		samsung_clk_add_lookup(epll, fout_epll);
 		samsung_clk_add_lookup(vpll, fout_vpll);
 	} else {
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 0775554..b0398d2 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -280,18 +280,10 @@ static const struct clk_ops samsung_pll36xx_clk_min_ops = {
 #define PLL45XX_PDIV_SHIFT	(8)
 #define PLL45XX_SDIV_SHIFT	(0)
 
-struct samsung_clk_pll45xx {
-	struct clk_hw		hw;
-	enum pll45xx_type	type;
-	const void __iomem	*con_reg;
-};
-
-#define to_clk_pll45xx(_hw) container_of(_hw, struct samsung_clk_pll45xx, hw)
-
 static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
-	struct samsung_clk_pll45xx *pll = to_clk_pll45xx(hw);
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
@@ -313,43 +305,6 @@ static const struct clk_ops samsung_pll45xx_clk_ops = {
 	.recalc_rate = samsung_pll45xx_recalc_rate,
 };
 
-struct clk * __init samsung_clk_register_pll45xx(const char *name,
-			const char *pname, const void __iomem *con_reg,
-			enum pll45xx_type type)
-{
-	struct samsung_clk_pll45xx *pll;
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
-	init.ops = &samsung_pll45xx_clk_ops;
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
  * PLL46xx Clock Type
  */
@@ -724,6 +679,11 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 		else
 			init.ops = &samsung_pll35xx_clk_ops;
 		break;
+	case pll_4500:
+	case pll_4502:
+	case pll_4508:
+		init.ops = &samsung_pll45xx_clk_ops;
+		break;
 	/* clk_ops for 36xx and 2650 are similar */
 	case pll_36xx:
 	case pll_2650:
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 2f70e88..f3faf24 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -17,6 +17,9 @@ enum samsung_pll_type {
 	pll_36xx,
 	pll_2550,
 	pll_2650,
+	pll_4500,
+	pll_4502,
+	pll_4508
 };
 
 #define PLL_35XX_RATE(_rate, _m, _p, _s)			\
@@ -46,21 +49,12 @@ struct samsung_pll_rate_table {
 	unsigned int kdiv;
 };
 
-enum pll45xx_type {
-	pll_4500,
-	pll_4502,
-	pll_4508
-};
-
 enum pll46xx_type {
 	pll_4600,
 	pll_4650,
 	pll_4650c,
 };
 
-extern struct clk * __init samsung_clk_register_pll45xx(const char *name,
-			const char *pname, const void __iomem *con_reg,
-			enum pll45xx_type type);
 extern struct clk * __init samsung_clk_register_pll46xx(const char *name,
 			const char *pname, const void __iomem *con_reg,
 			enum pll46xx_type type);
-- 
1.8.3.2
