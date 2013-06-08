From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Sat, 08 Jun 2013 23:04:20 +0530
Subject: [PATCH v5 5/7] clk: samsung: Add set_rate() clk_ops for PLL36xx
In-Reply-To: <1370712862-10501-1-git-send-email-yadi.brar@samsung.com>
References: <1370712862-10501-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370712862-10501-6-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vikas Sajjan <vikas.sajjan@linaro.org>

This patch adds set_rate and round_rate clk_ops for PLL36xx

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-pll.c |   78 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index df419aa..2adf761 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -159,6 +159,8 @@ static const struct clk_ops samsung_pll35xx_clk_min_ops = {
 /*
  * PLL36xx Clock Type
  */
+/* Maximum lock time can be 3000 * PDIV cycles */
+#define PLL36XX_LOCK_FACTOR    (3000)
 
 #define PLL36XX_KDIV_MASK	(0xFFFF)
 #define PLL36XX_MDIV_MASK	(0x1FF)
@@ -167,6 +169,8 @@ static const struct clk_ops samsung_pll35xx_clk_min_ops = {
 #define PLL36XX_MDIV_SHIFT	(16)
 #define PLL36XX_PDIV_SHIFT	(8)
 #define PLL36XX_SDIV_SHIFT	(0)
+#define PLL36XX_KDIV_SHIFT	(0)
+#define PLL36XX_LOCK_STAT_SHIFT	(29)
 
 static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
@@ -189,8 +193,77 @@ static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)fvco;
 }
 
+static inline bool samsung_pll36xx_mpk_change(
+	const struct samsung_pll_rate_table *rate, u32 pll_con0, u32 pll_con1)
+{
+	u32 old_mdiv, old_pdiv, old_kdiv;
+
+	old_mdiv = (pll_con0 >> PLL36XX_MDIV_SHIFT) & PLL36XX_MDIV_MASK;
+	old_pdiv = (pll_con0 >> PLL36XX_PDIV_SHIFT) & PLL36XX_PDIV_MASK;
+	old_kdiv = (pll_con1 >> PLL36XX_KDIV_SHIFT) & PLL36XX_KDIV_MASK;
+
+	return (rate->mdiv != old_mdiv || rate->pdiv != old_pdiv ||
+		rate->kdiv != old_kdiv);
+}
+
+static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long parent_rate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	u32 tmp, pll_con0, pll_con1;
+	const struct samsung_pll_rate_table *rate;
+
+	rate = samsung_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	pll_con0 = __raw_readl(pll->con_reg);
+	pll_con1 = __raw_readl(pll->con_reg + 4);
+
+	if (!(samsung_pll36xx_mpk_change(rate, pll_con0, pll_con1))) {
+		/* If only s change, change just s value only*/
+		pll_con0 &= ~(PLL36XX_SDIV_MASK << PLL36XX_SDIV_SHIFT);
+		pll_con0 |= (rate->sdiv << PLL36XX_SDIV_SHIFT);
+		__raw_writel(pll_con0, pll->con_reg);
+		return 0;
+	}
+
+	/* Set PLL lock time. */
+	__raw_writel(rate->pdiv * PLL36XX_LOCK_FACTOR, pll->lock_reg);
+
+	 /* Change PLL PMS values */
+	pll_con0 &= ~((PLL36XX_MDIV_MASK << PLL36XX_MDIV_SHIFT) |
+			(PLL36XX_PDIV_MASK << PLL36XX_PDIV_SHIFT) |
+			(PLL36XX_SDIV_MASK << PLL36XX_SDIV_SHIFT));
+	pll_con0 |= (rate->mdiv << PLL36XX_MDIV_SHIFT) |
+			(rate->pdiv << PLL36XX_PDIV_SHIFT) |
+			(rate->sdiv << PLL36XX_SDIV_SHIFT);
+	__raw_writel(pll_con0, pll->con_reg);
+
+	pll_con1 &= ~(PLL36XX_KDIV_MASK << PLL36XX_KDIV_SHIFT);
+	pll_con1 |= rate->kdiv << PLL36XX_KDIV_SHIFT;
+	__raw_writel(pll_con1, pll->con_reg + 4);
+
+	/* wait_lock_time */
+	do {
+		cpu_relax();
+		tmp = __raw_readl(pll->con_reg);
+	} while (!(tmp & (1 << PLL36XX_LOCK_STAT_SHIFT)));
+
+	return 0;
+}
+
 static const struct clk_ops samsung_pll36xx_clk_ops = {
 	.recalc_rate = samsung_pll36xx_recalc_rate,
+	.set_rate = samsung_pll36xx_set_rate,
+	.round_rate = samsung_pll_round_rate,
+};
+
+static const struct clk_ops samsung_pll36xx_clk_min_ops = {
+	.recalc_rate = samsung_pll36xx_recalc_rate,
 };
 
 /*
@@ -489,7 +562,10 @@ void __init samsung_clk_register_pll(struct samsung_pll_clock *clk_list,
 				init.ops = &samsung_pll35xx_clk_ops;
 			break;
 		case pll_36xx:
-			init.ops = &samsung_pll36xx_clk_ops;
+			if (!pll->rate_table)
+				init.ops = &samsung_pll36xx_clk_min_ops;
+			else
+				init.ops = &samsung_pll36xx_clk_ops;
 			break;
 		default:
 			pr_warn("%s: Unknown pll type for pll clk %s\n",
-- 
1.7.0.4
