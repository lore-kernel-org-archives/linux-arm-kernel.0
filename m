From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 04 Mar 2014 16:42:35 +0530
Subject: [PATCH v4 2/5] clk/samsung: add support for pll2550xx
In-Reply-To: <1393931558-23502-1-git-send-email-rahul.sharma@samsung.com>
References: <1393931558-23502-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1393931558-23502-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

exynos5260 use pll2550xx and it has different bit fields
for P,M,S values as compared to pll2550. Support for
pll2550xx is added here.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |  107 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h |    1 +
 2 files changed, 108 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 1f310be..3eb2788 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -947,6 +947,108 @@ struct clk * __init samsung_clk_register_pll2550x(const char *name,
 	return clk;
 }
 
+/*
+ * PLL2550xx Clock Type
+ */
+
+/* Maximum lock time can be 270 * PDIV cycles */
+#define PLL2550XX_LOCK_FACTOR 270
+
+#define PLL2550XX_M_MASK		0x3FF
+#define PLL2550XX_P_MASK		0x3F
+#define PLL2550XX_S_MASK		0x7
+#define PLL2550XX_LOCK_STAT_MASK	0x1
+#define PLL2550XX_M_SHIFT		9
+#define PLL2550XX_P_SHIFT		3
+#define PLL2550XX_S_SHIFT		0
+#define PLL2550XX_LOCK_STAT_SHIFT	21
+
+static unsigned long samsung_pll2550xx_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	u32 mdiv, pdiv, sdiv, pll_con;
+	u64 fvco = parent_rate;
+
+	pll_con = __raw_readl(pll->con_reg);
+	mdiv = (pll_con >> PLL2550XX_M_SHIFT) & PLL2550XX_M_MASK;
+	pdiv = (pll_con >> PLL2550XX_P_SHIFT) & PLL2550XX_P_MASK;
+	sdiv = (pll_con >> PLL2550XX_S_SHIFT) & PLL2550XX_S_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
+
+static inline bool samsung_pll2550xx_mp_change(u32 mdiv, u32 pdiv, u32 pll_con)
+{
+	u32 old_mdiv, old_pdiv;
+
+	old_mdiv = (pll_con >> PLL2550XX_M_SHIFT) & PLL2550XX_M_MASK;
+	old_pdiv = (pll_con >> PLL2550XX_P_SHIFT) & PLL2550XX_P_MASK;
+
+	return mdiv != old_mdiv || pdiv != old_pdiv;
+}
+
+static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
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
+	if (!(samsung_pll2550xx_mp_change(rate->mdiv, rate->pdiv, tmp))) {
+		/* If only s change, change just s value only*/
+		tmp &= ~(PLL2550XX_S_MASK << PLL2550XX_S_SHIFT);
+		tmp |= rate->sdiv << PLL2550XX_S_SHIFT;
+		__raw_writel(tmp, pll->con_reg);
+
+		return 0;
+	}
+
+	/* Set PLL lock time. */
+	__raw_writel(rate->pdiv * PLL2550XX_LOCK_FACTOR, pll->lock_reg);
+
+	/* Change PLL PMS values */
+	tmp &= ~((PLL2550XX_M_MASK << PLL2550XX_M_SHIFT) |
+			(PLL2550XX_P_MASK << PLL2550XX_P_SHIFT) |
+			(PLL2550XX_S_MASK << PLL2550XX_S_SHIFT));
+	tmp |= (rate->mdiv << PLL2550XX_M_SHIFT) |
+			(rate->pdiv << PLL2550XX_P_SHIFT) |
+			(rate->sdiv << PLL2550XX_S_SHIFT);
+	__raw_writel(tmp, pll->con_reg);
+
+	/* wait_lock_time */
+	do {
+		cpu_relax();
+		tmp = __raw_readl(pll->con_reg);
+	} while (!(tmp & (PLL2550XX_LOCK_STAT_MASK
+			<< PLL2550XX_LOCK_STAT_SHIFT)));
+
+	return 0;
+}
+
+static const struct clk_ops samsung_pll2550xx_clk_ops = {
+	.recalc_rate = samsung_pll2550xx_recalc_rate,
+	.round_rate = samsung_pll_round_rate,
+	.set_rate = samsung_pll2550xx_set_rate,
+};
+
+static const struct clk_ops samsung_pll2550xx_clk_min_ops = {
+	.recalc_rate = samsung_pll2550xx_recalc_rate,
+};
+
 static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 				struct samsung_pll_clock *pll_clk,
 				void __iomem *base)
@@ -1048,6 +1150,11 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 			init.ops = &samsung_s3c2440_mpll_clk_min_ops;
 		else
 			init.ops = &samsung_s3c2440_mpll_clk_ops;
+	case pll_2550xx:
+		if (!pll->rate_table)
+			init.ops = &samsung_pll2550xx_clk_min_ops;
+		else
+			init.ops = &samsung_pll2550xx_clk_ops;
 		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 6428bcc..ec4bc1d 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -31,6 +31,7 @@ enum samsung_pll_type {
 	pll_s3c2410_mpll,
 	pll_s3c2410_upll,
 	pll_s3c2440_mpll,
+	pll_2550xx,
 };
 
 #define PLL_35XX_RATE(_rate, _m, _p, _s)			\
-- 
1.7.9.5
