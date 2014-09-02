From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 02 Sep 2014 21:05:37 +0530
Subject: [PATCH v2 1/7] clk: samsung: add support for 145xx and 1460x PLLs
In-Reply-To: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409672143-8574-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL145xx is similar to PLL35xx and PLL1460x is almost similar
to PLL46xx with minor differences in bit positions. Hence,
reuse the functions defined for pll_35xx and pll_46xx to
support 145xx and 1460x PLLs respectively.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/samsung/clk-pll.c |   25 ++++++++++++++++++++-----
 drivers/clk/samsung/clk-pll.h |    4 ++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index b07fad2..9d70e5c 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -482,6 +482,8 @@ static const struct clk_ops samsung_pll45xx_clk_min_ops = {
 
 #define PLL46XX_VSEL_MASK	(1)
 #define PLL46XX_MDIV_MASK	(0x1FF)
+#define PLL1460X_MDIV_MASK	(0x3FF)
+
 #define PLL46XX_PDIV_MASK	(0x3F)
 #define PLL46XX_SDIV_MASK	(0x7)
 #define PLL46XX_VSEL_SHIFT	(27)
@@ -511,13 +513,15 @@ static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 
 	pll_con0 = __raw_readl(pll->con_reg);
 	pll_con1 = __raw_readl(pll->con_reg + 4);
-	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
+	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & ((pll->type == pll_1460x) ?
+				PLL1460X_MDIV_MASK : PLL46XX_MDIV_MASK);
 	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
 	kdiv = pll->type == pll_4650c ? pll_con1 & PLL4650C_KDIV_MASK :
 					pll_con1 & PLL46XX_KDIV_MASK;
 
-	shift = pll->type == pll_4600 ? 16 : 10;
+	shift = ((pll->type == pll_4600) || (pll->type == pll_1460x)) ? 16 : 10;
+
 	fvco *= (mdiv << shift) + kdiv;
 	do_div(fvco, (pdiv << sdiv));
 	fvco >>= shift;
@@ -573,14 +577,21 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		lock = 0xffff;
 
 	/* Set PLL PMS and VSEL values. */
-	con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
+	if (pll->type == pll_1460x) {
+		con0 &= ~((PLL1460X_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
+			(PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT) |
+			(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT));
+	} else {
+		con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
 			(PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT) |
 			(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT) |
 			(PLL46XX_VSEL_MASK << PLL46XX_VSEL_SHIFT));
+		con0 |=	rate->vsel << PLL46XX_VSEL_SHIFT;
+	}
+
 	con0 |= (rate->mdiv << PLL46XX_MDIV_SHIFT) |
 			(rate->pdiv << PLL46XX_PDIV_SHIFT) |
-			(rate->sdiv << PLL46XX_SDIV_SHIFT) |
-			(rate->vsel << PLL46XX_VSEL_SHIFT);
+			(rate->sdiv << PLL46XX_SDIV_SHIFT);
 
 	/* Set PLL K, MFR and MRR values. */
 	con1 = __raw_readl(pll->con_reg + 0x4);
@@ -1190,6 +1201,9 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	/* clk_ops for 35xx and 2550 are similar */
 	case pll_35xx:
 	case pll_2550:
+	case pll_1450x:
+	case pll_1451x:
+	case pll_1452x:
 		if (!pll->rate_table)
 			init.ops = &samsung_pll35xx_clk_min_ops;
 		else
@@ -1223,6 +1237,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
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
