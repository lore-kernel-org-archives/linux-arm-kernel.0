From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 10 Jun 2013 18:54:16 +0530
Subject: [PATCH v6 4/7] clk: samsung: Add set_rate() clk_ops for PLL35xx
In-Reply-To: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
References: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370870659-10929-5-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add set_rate() and round_rate() for PLL35xx

Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |  105 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 104 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index b2088dd..e3e7f0c 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -24,16 +24,51 @@ struct samsung_clk_pll {
 
 #define to_clk_pll(_hw) container_of(_hw, struct samsung_clk_pll, hw)
 
+static const struct samsung_pll_rate_table *samsung_get_pll_settings(
+				struct samsung_clk_pll *pll, unsigned long rate)
+{
+	const struct samsung_pll_rate_table  *rate_table = pll->rate_table;
+	int i;
+
+	for (i = 0; i < pll->rate_count; i++) {
+		if (rate == rate_table[i].rate)
+			return &rate_table[i];
+	}
+
+	return NULL;
+}
+
+static long samsung_pll_round_rate(struct clk_hw *hw,
+			unsigned long drate, unsigned long *prate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	const struct samsung_pll_rate_table *rate_table = pll->rate_table;
+	int i;
+
+	/* Assumming rate_table is in descending order */
+	for (i = 0; i < pll->rate_count; i++) {
+		if (drate >= rate_table[i].rate)
+			return rate_table[i].rate;
+	}
+
+	/* return minimum supported value */
+	return rate_table[i - 1].rate;
+}
+
 /*
  * PLL35xx Clock Type
  */
+/* Maximum lock time can be 270 * PDIV cycles */
+#define PLL35XX_LOCK_FACTOR	(270)
 
 #define PLL35XX_MDIV_MASK       (0x3FF)
 #define PLL35XX_PDIV_MASK       (0x3F)
 #define PLL35XX_SDIV_MASK       (0x7)
+#define PLL35XX_LOCK_STAT_MASK	(0x1)
 #define PLL35XX_MDIV_SHIFT      (16)
 #define PLL35XX_PDIV_SHIFT      (8)
 #define PLL35XX_SDIV_SHIFT      (0)
+#define PLL35XX_LOCK_STAT_SHIFT	(29)
 
 static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
@@ -53,8 +88,73 @@ static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)fvco;
 }
 
+static inline bool samsung_pll35xx_mp_change(
+		const struct samsung_pll_rate_table *rate, u32 pll_con)
+{
+	u32 old_mdiv, old_pdiv;
+
+	old_mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
+	old_pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
+
+	return (rate->mdiv != old_mdiv || rate->pdiv != old_pdiv);
+}
+
+static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	const struct samsung_pll_rate_table *rate;
+	u32 tmp;
+
+	/* Get required rate settings from table */
+	rate = samsung_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	tmp = __raw_readl(pll->con_reg);
+
+	if (!(samsung_pll35xx_mp_change(rate, tmp))) {
+		/* If only s change, change just s value only*/
+		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
+		tmp |= rate->sdiv << PLL35XX_SDIV_SHIFT;
+		__raw_writel(tmp, pll->con_reg);
+
+		return 0;
+	}
+
+	/* Set PLL lock time. */
+	__raw_writel(rate->pdiv * PLL35XX_LOCK_FACTOR,
+			pll->lock_reg);
+
+	/* Change PLL PMS values */
+	tmp &= ~((PLL35XX_MDIV_MASK << PLL35XX_MDIV_SHIFT) |
+			(PLL35XX_PDIV_MASK << PLL35XX_PDIV_SHIFT) |
+			(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT));
+	tmp |= (rate->mdiv << PLL35XX_MDIV_SHIFT) |
+			(rate->pdiv << PLL35XX_PDIV_SHIFT) |
+			(rate->sdiv << PLL35XX_SDIV_SHIFT);
+	__raw_writel(tmp, pll->con_reg);
+
+	/* wait_lock_time */
+	do {
+		cpu_relax();
+		tmp = __raw_readl(pll->con_reg);
+	} while (!(tmp & (PLL35XX_LOCK_STAT_MASK
+				<< PLL35XX_LOCK_STAT_SHIFT)));
+	return 0;
+}
+
 static const struct clk_ops samsung_pll35xx_clk_ops = {
 	.recalc_rate = samsung_pll35xx_recalc_rate,
+	.round_rate = samsung_pll_round_rate,
+	.set_rate = samsung_pll35xx_set_rate,
+};
+
+static const struct clk_ops samsung_pll35xx_clk_min_ops = {
+	.recalc_rate = samsung_pll35xx_recalc_rate,
 };
 
 /*
@@ -386,7 +486,10 @@ void __init samsung_clk_register_pll(struct samsung_pll_clock *clk_list,
 		/* clk_ops for 35xx and 2550 are similar */
 		case pll_35xx:
 		case pll_2550:
-			init.ops = &samsung_pll35xx_clk_ops;
+			if (!pll->rate_table)
+				init.ops = &samsung_pll35xx_clk_min_ops;
+			else
+				init.ops = &samsung_pll35xx_clk_ops;
 			break;
 		/* clk_ops for 36xx and 2650 are similar */
 		case pll_36xx:
-- 
1.7.0.4
