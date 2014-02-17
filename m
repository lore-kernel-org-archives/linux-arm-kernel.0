From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 17 Feb 2014 21:06:06 +0100
Subject: [PATCH v5 1/7] clk: samsung: add pll_6552 variant for s3c2416
In-Reply-To: <2678040.KALsQ0bZFm@phil>
References: <2678040.KALsQ0bZFm@phil>
Message-ID: <3099790.3uYGHd40oD@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the manual s3c2416 and s3c2450 use a pll 6552 and 6553
and while the pll_6553 matches exactly the one already implemented
the pll_6552 differs to the one from the s3c64xx series.

The change is solely in the bit locations of the mdiv and pdiv values.
All calculations are the same for both implementatons and even the
proposed divider-values for specific frequencies in the manuals are
the same.

Therefore implement a variant that simply uses the changed bit
locations if necessary.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Tomasz Figa <t.figa@samsung.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/samsung/clk-pll.c | 12 ++++++++++--
 drivers/clk/samsung/clk-pll.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 81e6d2f..f9a35a6 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -564,7 +564,9 @@ static const struct clk_ops samsung_pll46xx_clk_min_ops = {
 #define PLL6552_PDIV_MASK	0x3f
 #define PLL6552_SDIV_MASK	0x7
 #define PLL6552_MDIV_SHIFT	16
+#define PLL6552_MDIV_SHIFT_2416	14
 #define PLL6552_PDIV_SHIFT	8
+#define PLL6552_PDIV_SHIFT_2416	5
 #define PLL6552_SDIV_SHIFT	0
 
 static unsigned long samsung_pll6552_recalc_rate(struct clk_hw *hw,
@@ -575,8 +577,13 @@ static unsigned long samsung_pll6552_recalc_rate(struct clk_hw *hw,
 	u64 fvco = parent_rate;
 
 	pll_con = __raw_readl(pll->con_reg);
-	mdiv = (pll_con >> PLL6552_MDIV_SHIFT) & PLL6552_MDIV_MASK;
-	pdiv = (pll_con >> PLL6552_PDIV_SHIFT) & PLL6552_PDIV_MASK;
+	if (pll->type == pll_6552_s3c2416) {
+		mdiv = (pll_con >> PLL6552_MDIV_SHIFT_2416) & PLL6552_MDIV_MASK;
+		pdiv = (pll_con >> PLL6552_PDIV_SHIFT_2416) & PLL6552_PDIV_MASK;
+	} else {
+		mdiv = (pll_con >> PLL6552_MDIV_SHIFT) & PLL6552_MDIV_MASK;
+		pdiv = (pll_con >> PLL6552_PDIV_SHIFT) & PLL6552_PDIV_MASK;
+	}
 	sdiv = (pll_con >> PLL6552_SDIV_SHIFT) & PLL6552_SDIV_MASK;
 
 	fvco *= mdiv;
@@ -773,6 +780,7 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 			init.ops = &samsung_pll36xx_clk_ops;
 		break;
 	case pll_6552:
+	case pll_6552_s3c2416:
 		init.ops = &samsung_pll6552_clk_ops;
 		break;
 	case pll_6553:
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 6c39030..ddf9029 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -24,6 +24,7 @@ enum samsung_pll_type {
 	pll_4650,
 	pll_4650c,
 	pll_6552,
+	pll_6552_s3c2416,
 	pll_6553,
 };
 
-- 
1.8.5.3
