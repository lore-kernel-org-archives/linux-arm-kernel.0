From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 19:09:05 +0200
Subject: [PATCH v2 10/16] clk: samsung: pll: Add support for rate configuration
 of PLL45xx
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377536951-9307-11-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements round_rate and set_rate callbacks of PLL45xx
driver to allow reconfiguration of PLL at runtime.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-pll.c | 110 +++++++++++++++++++++++++++++++++++++++++-
 drivers/clk/samsung/clk-pll.h |  10 ++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index b0398d2..052fc37 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -10,9 +10,12 @@
 */
 
 #include <linux/errno.h>
+#include <linux/hrtimer.h>
 #include "clk.h"
 #include "clk-pll.h"
 
+#define PLL_TIMEOUT_MS		10
+
 struct samsung_clk_pll {
 	struct clk_hw		hw;
 	void __iomem		*lock_reg;
@@ -272,13 +275,20 @@ static const struct clk_ops samsung_pll36xx_clk_min_ops = {
 /*
  * PLL45xx Clock Type
  */
+#define PLL4502_LOCK_FACTOR	400
+#define PLL4508_LOCK_FACTOR	240
 
 #define PLL45XX_MDIV_MASK	(0x3FF)
 #define PLL45XX_PDIV_MASK	(0x3F)
 #define PLL45XX_SDIV_MASK	(0x7)
+#define PLL45XX_AFC_MASK	(0x1F)
 #define PLL45XX_MDIV_SHIFT	(16)
 #define PLL45XX_PDIV_SHIFT	(8)
 #define PLL45XX_SDIV_SHIFT	(0)
+#define PLL45XX_AFC_SHIFT	(0)
+
+#define PLL45XX_ENABLE		BIT(31)
+#define PLL45XX_LOCKED		BIT(29)
 
 static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
@@ -301,8 +311,101 @@ static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)fvco;
 }
 
+static bool samsung_pll45xx_mp_change(u32 pll_con0, u32 pll_con1,
+				const struct samsung_pll_rate_table *rate)
+{
+	u32 old_mdiv, old_pdiv, old_afc;
+
+	old_mdiv = (pll_con0 >> PLL45XX_MDIV_SHIFT) & PLL45XX_MDIV_MASK;
+	old_pdiv = (pll_con0 >> PLL45XX_PDIV_SHIFT) & PLL45XX_PDIV_MASK;
+	old_afc = (pll_con1 >> PLL45XX_AFC_SHIFT) & PLL45XX_AFC_MASK;
+
+	return (old_mdiv != rate->mdiv || old_pdiv != rate->pdiv
+		|| old_afc != rate->afc);
+}
+
+static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	const struct samsung_pll_rate_table *rate;
+	u32 con0, con1;
+	ktime_t start;
+
+	/* Get required rate settings from table */
+	rate = samsung_get_pll_settings(pll, drate);
+	if (!rate) {
+		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
+			drate, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	con0 = __raw_readl(pll->con_reg);
+	con1 = __raw_readl(pll->con_reg + 0x4);
+
+	if (!(samsung_pll45xx_mp_change(con0, con1, rate))) {
+		/* If only s change, change just s value only*/
+		con0 &= ~(PLL45XX_SDIV_MASK << PLL45XX_SDIV_SHIFT);
+		con0 |= rate->sdiv << PLL45XX_SDIV_SHIFT;
+		__raw_writel(con0, pll->con_reg);
+
+		return 0;
+	}
+
+	/* Set PLL PMS values. */
+	con0 &= ~((PLL45XX_MDIV_MASK << PLL45XX_MDIV_SHIFT) |
+			(PLL45XX_PDIV_MASK << PLL45XX_PDIV_SHIFT) |
+			(PLL45XX_SDIV_MASK << PLL45XX_SDIV_SHIFT));
+	con0 |= (rate->mdiv << PLL45XX_MDIV_SHIFT) |
+			(rate->pdiv << PLL45XX_PDIV_SHIFT) |
+			(rate->sdiv << PLL45XX_SDIV_SHIFT);
+
+	/* Set PLL AFC value. */
+	con1 = __raw_readl(pll->con_reg + 0x4);
+	con1 &= ~(PLL45XX_AFC_MASK << PLL45XX_AFC_SHIFT);
+	con1 |= (rate->afc << PLL45XX_AFC_SHIFT);
+
+	/* Set PLL lock time. */
+	switch (pll->type) {
+	case pll_4502:
+		__raw_writel(rate->pdiv * PLL4502_LOCK_FACTOR, pll->lock_reg);
+		break;
+	case pll_4508:
+		__raw_writel(rate->pdiv * PLL4508_LOCK_FACTOR, pll->lock_reg);
+		break;
+	default:
+		break;
+	};
+
+	/* Set new configuration. */
+	__raw_writel(con1, pll->con_reg + 0x4);
+	__raw_writel(con0, pll->con_reg);
+
+	/* Wait for locking. */
+	start = ktime_get();
+	while (!(__raw_readl(pll->con_reg) & PLL45XX_LOCKED)) {
+		ktime_t delta = ktime_sub(ktime_get(), start);
+
+		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
+			pr_err("%s: could not lock PLL %s\n",
+					__func__, __clk_get_name(hw->clk));
+			return -EFAULT;
+		}
+
+		cpu_relax();
+	}
+
+	return 0;
+}
+
 static const struct clk_ops samsung_pll45xx_clk_ops = {
 	.recalc_rate = samsung_pll45xx_recalc_rate,
+	.round_rate = samsung_pll_round_rate,
+	.set_rate = samsung_pll45xx_set_rate,
+};
+
+static const struct clk_ops samsung_pll45xx_clk_min_ops = {
+	.recalc_rate = samsung_pll45xx_recalc_rate,
 };
 
 /*
@@ -680,9 +783,14 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 			init.ops = &samsung_pll35xx_clk_ops;
 		break;
 	case pll_4500:
+		init.ops = &samsung_pll45xx_clk_min_ops;
+		break;
 	case pll_4502:
 	case pll_4508:
-		init.ops = &samsung_pll45xx_clk_ops;
+		if (!pll->rate_table)
+			init.ops = &samsung_pll45xx_clk_min_ops;
+		else
+			init.ops = &samsung_pll45xx_clk_ops;
 		break;
 	/* clk_ops for 36xx and 2650 are similar */
 	case pll_36xx:
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index f3faf24..aa8cc15 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -39,6 +39,15 @@ enum samsung_pll_type {
 		.kdiv	=	(_k),				\
 	}
 
+#define PLL_45XX_RATE(_rate, _m, _p, _s, _afc)			\
+	{							\
+		.rate	=	(_rate),			\
+		.mdiv	=	(_m),				\
+		.pdiv	=	(_p),				\
+		.sdiv	=	(_s),				\
+		.afc	=	(_afc),				\
+	}
+
 /* NOTE: Rate table should be kept sorted in descending order. */
 
 struct samsung_pll_rate_table {
@@ -47,6 +56,7 @@ struct samsung_pll_rate_table {
 	unsigned int mdiv;
 	unsigned int sdiv;
 	unsigned int kdiv;
+	unsigned int afc;
 };
 
 enum pll46xx_type {
-- 
1.8.3.2
