From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:18:04 +0530
Subject: [PATCH 01/14] clk: samsung: add support for 145xx and 1460x PLLs
Message-ID: <1409132889-2080-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By registers bits and offsets the 145xx PLL is similar to
pll_type "pll_35xx". Also, 1460x PLL is similar to pll_type
"pll_46xx".

Hence, reusing the functions defined for pll_35xx and pll_46xx
to support 145xx and 1460x PLLs respectively.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |   50 ++++++++++++++++++++++++++++++++---------
 drivers/clk/samsung/clk-pll.h |    4 ++++
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index b07fad2..fe24e4d 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -130,6 +130,7 @@ static const struct clk_ops samsung_pll3000_clk_ops = {
  */
 /* Maximum lock time can be 270 * PDIV cycles */
 #define PLL35XX_LOCK_FACTOR	(270)
+#define PLL145XX_LOCK_FACTOR	(150)
 
 #define PLL35XX_MDIV_MASK       (0x3FF)
 #define PLL35XX_PDIV_MASK       (0x3F)
@@ -139,6 +140,7 @@ static const struct clk_ops samsung_pll3000_clk_ops = {
 #define PLL35XX_PDIV_SHIFT      (8)
 #define PLL35XX_SDIV_SHIFT      (0)
 #define PLL35XX_LOCK_STAT_SHIFT	(29)
+#define PLL145XX_ENABLE		BIT(31)
 
 static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
@@ -186,6 +188,10 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	tmp = __raw_readl(pll->con_reg);
 
+	/* Enable PLL */
+	if (pll->type == (pll_1450x || pll_1451x || pll_1452x))
+		tmp |= PLL145XX_ENABLE;
+
 	if (!(samsung_pll35xx_mp_change(rate, tmp))) {
 		/* If only s change, change just s value only*/
 		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
@@ -196,8 +202,12 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	}
 
 	/* Set PLL lock time. */
-	__raw_writel(rate->pdiv * PLL35XX_LOCK_FACTOR,
-			pll->lock_reg);
+	if (pll->type == (pll_1450x || pll_1451x || pll_1452x))
+		__raw_writel(rate->pdiv * PLL145XX_LOCK_FACTOR,
+				pll->lock_reg);
+	else
+		__raw_writel(rate->pdiv * PLL35XX_LOCK_FACTOR,
+				pll->lock_reg);
 
 	/* Change PLL PMS values */
 	tmp &= ~((PLL35XX_MDIV_MASK << PLL35XX_MDIV_SHIFT) |
@@ -356,7 +366,6 @@ static const struct clk_ops samsung_pll36xx_clk_min_ops = {
 
 #define PLL45XX_ENABLE		BIT(31)
 #define PLL45XX_LOCKED		BIT(29)
-
 static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
@@ -482,6 +491,8 @@ static const struct clk_ops samsung_pll45xx_clk_min_ops = {
 
 #define PLL46XX_VSEL_MASK	(1)
 #define PLL46XX_MDIV_MASK	(0x1FF)
+#define PLL1460X_MDIV_MASK	(0x3FF)
+
 #define PLL46XX_PDIV_MASK	(0x3F)
 #define PLL46XX_SDIV_MASK	(0x7)
 #define PLL46XX_VSEL_SHIFT	(27)
@@ -511,13 +522,14 @@ static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 
 	pll_con0 = __raw_readl(pll->con_reg);
 	pll_con1 = __raw_readl(pll->con_reg + 4);
-	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
+	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & ((pll->type == pll_1460x) ?
+				PLL1460X_MDIV_MASK : PLL46XX_MDIV_MASK);
 	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
-	kdiv = pll->type == pll_4650c ? pll_con1 & PLL4650C_KDIV_MASK :
+	kdiv = (pll->type == pll_4650c) ? pll_con1 & PLL4650C_KDIV_MASK :
 					pll_con1 & PLL46XX_KDIV_MASK;
 
-	shift = pll->type == pll_4600 ? 16 : 10;
+	shift = (pll->type == (pll_4600 || pll_1460x)) ? 16 : 10;
 	fvco *= (mdiv << shift) + kdiv;
 	do_div(fvco, (pdiv << sdiv));
 	fvco >>= shift;
@@ -526,11 +538,14 @@ static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 }
 
 static bool samsung_pll46xx_mpk_change(u32 pll_con0, u32 pll_con1,
-				const struct samsung_pll_rate_table *rate)
+				const struct samsung_pll_rate_table *rate,
+				struct samsung_clk_pll *pll)
 {
 	u32 old_mdiv, old_pdiv, old_kdiv;
 
-	old_mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
+	old_mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) &
+			((pll->type == pll_1460x) ?
+			PLL1460X_MDIV_MASK : PLL46XX_MDIV_MASK);
 	old_pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
 	old_kdiv = (pll_con1 >> PLL46XX_KDIV_SHIFT) & PLL46XX_KDIV_MASK;
 
@@ -557,7 +572,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	con0 = __raw_readl(pll->con_reg);
 	con1 = __raw_readl(pll->con_reg + 0x4);
 
-	if (!(samsung_pll46xx_mpk_change(con0, con1, rate))) {
+	if (!(samsung_pll46xx_mpk_change(con0, con1, rate, pll))) {
 		/* If only s change, change just s value only*/
 		con0 &= ~(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
 		con0 |= rate->sdiv << PLL46XX_SDIV_SHIFT;
@@ -573,14 +588,23 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		lock = 0xffff;
 
 	/* Set PLL PMS and VSEL values. */
-	con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
+	if (pll->type == pll_1460x) {
+		con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
+			(PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT) |
+			(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT));
+		con0 |= (rate->mdiv << PLL46XX_MDIV_SHIFT) |
+			(rate->pdiv << PLL46XX_PDIV_SHIFT) |
+			(rate->sdiv << PLL46XX_SDIV_SHIFT);
+	} else {
+		con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
 			(PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT) |
 			(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT) |
 			(PLL46XX_VSEL_MASK << PLL46XX_VSEL_SHIFT));
-	con0 |= (rate->mdiv << PLL46XX_MDIV_SHIFT) |
+		con0 |= (rate->mdiv << PLL46XX_MDIV_SHIFT) |
 			(rate->pdiv << PLL46XX_PDIV_SHIFT) |
 			(rate->sdiv << PLL46XX_SDIV_SHIFT) |
 			(rate->vsel << PLL46XX_VSEL_SHIFT);
+	}
 
 	/* Set PLL K, MFR and MRR values. */
 	con1 = __raw_readl(pll->con_reg + 0x4);
@@ -1190,6 +1214,9 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	/* clk_ops for 35xx and 2550 are similar */
 	case pll_35xx:
 	case pll_2550:
+	case pll_1450x:
+	case pll_1451x:
+	case pll_1452x:
 		if (!pll->rate_table)
 			init.ops = &samsung_pll35xx_clk_min_ops;
 		else
@@ -1223,6 +1250,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_4600:
 	case pll_4650:
 	case pll_4650c:
+	case pll_1460x:
 		if (!pll->rate_table)
 			init.ops = &samsung_pll46xx_clk_min_ops;
 		else
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index c0ed4d4..213de9a 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -33,6 +33,10 @@ enum samsung_pll_type {
 	pll_s3c2440_mpll,
 	pll_2550xx,
 	pll_2650xx,
+	pll_1450x,
+	pll_1451x,
+	pll_1452x,
+	pll_1460x,
 };
 
 #define PLL_35XX_RATE(_rate, _m, _p, _s)			\
-- 
1.7.9.5
