From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Fri, 24 May 2013 16:01:17 +0530
Subject: [RESEND PATCH 4/5] clk: samsung: Add set_rate() clk_ops for PLL36xx
In-Reply-To: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
References: <1369391478-7665-1-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1369391478-7665-5-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds set_rate and round_rate clk_ops for PLL36xx
The round_rate() implementation as of now is dummy, it returns the same rate
which is passed as input.

Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-pll.c |   67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 291cc9e..55ff5fd 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -224,6 +224,13 @@ struct clk * __init samsung_clk_register_pll35xx(const char *name,
 #define PLL36XX_MDIV_SHIFT	(16)
 #define PLL36XX_PDIV_SHIFT	(8)
 #define PLL36XX_SDIV_SHIFT	(0)
+#define PLL36XX_KDIV_SHIFT	(0)
+#define PLL36XX_LOCK_STAT_SHIFT (29)
+
+#define PLL36XX_MDIV(_tmp) ((_tmp) & (PLL36XX_MDIV_MASK << PLL36XX_MDIV_SHIFT))
+#define PLL36XX_PDIV(_tmp) ((_tmp) & (PLL36XX_PDIV_MASK << PLL36XX_PDIV_SHIFT))
+#define PLL36XX_SDIV(_tmp) ((_tmp) & (PLL36XX_SDIV_MASK << PLL36XX_SDIV_SHIFT))
+#define PLL36XX_KDIV(_tmp) ((_tmp) & (PLL36XX_KDIV_MASK << PLL36XX_KDIV_SHIFT))
 
 static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
@@ -246,8 +253,65 @@ static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)fvco;
 }
 
+static long samsung_pll36xx_round_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long *prate)
+{
+	/* retruns the same 'drate' whichs comes as input */
+	return drate;
+}
+
+static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long parent_rate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	u32 tmp, pll_con0, pll_con1, mdiv, pdiv, sdiv, kdiv;
+	struct samsung_pll_rate_table *rate;
+
+	rate = samsung_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	mdiv = PLL36XX_MDIV(rate->pll_con0);
+	pdiv = PLL36XX_PDIV(rate->pll_con0);
+	sdiv = PLL36XX_SDIV(rate->pll_con0);
+	kdiv = PLL36XX_KDIV(rate->pll_con1);
+
+	pll_con0 = pll_readl(pll, PLL36XX_CON0_OFFSET);
+	pll_con1 = pll_readl(pll, PLL36XX_CON1_OFFSET);
+
+	pll_con1 &= ~(PLL36XX_KDIV_MASK << PLL36XX_KDIV_SHIFT);
+
+	/* Set PLL lock time.
+	   Maximum lock time can be 3000 * PDIV cycles */
+	pll_writel(pll, ((pdiv >> PLL36XX_PDIV_SHIFT) * 3000),
+			PLL36XX_LOCK_OFFSET);
+
+	 /* Change PLL PMS values */
+	pll_con0 &= ~((PLL36XX_MDIV_MASK << PLL36XX_MDIV_SHIFT) |
+			(PLL36XX_PDIV_MASK << PLL36XX_PDIV_SHIFT) |
+			(PLL36XX_SDIV_MASK << PLL36XX_SDIV_SHIFT));
+	pll_con0 |= mdiv | pdiv | sdiv;
+	pll_writel(pll, pll_con0, PLL36XX_CON0_OFFSET);
+
+	pll_con1 |= kdiv;
+	pll_writel(pll, pll_con1, PLL36XX_CON1_OFFSET);
+
+	/* wait_lock_time */
+	do {
+		cpu_relax();
+		tmp = pll_readl(pll, PLL36XX_CON0_OFFSET);
+	} while (!(tmp & (1 << PLL36XX_LOCK_STAT_SHIFT)));
+
+	return 0;
+}
+
 static const struct clk_ops samsung_pll36xx_clk_ops = {
 	.recalc_rate = samsung_pll36xx_recalc_rate,
+	.set_rate = samsung_pll36xx_set_rate,
+	.round_rate = samsung_pll36xx_round_rate,
 };
 
 struct clk * __init samsung_clk_register_pll36xx(const char *name,
@@ -280,6 +344,9 @@ struct clk * __init samsung_clk_register_pll36xx(const char *name,
 		sort(pll->rate_table, pll->rate_count,
 			sizeof(struct samsung_pll_rate_table),
 			samsung_compare_rate, NULL);
+	} else {
+		samsung_pll35xx_clk_ops.round_rate = NULL;
+		samsung_pll35xx_clk_ops.set_rate = NULL;
 	}
 
 	clk = clk_register(NULL, &pll->hw);
-- 
1.7.9.5
