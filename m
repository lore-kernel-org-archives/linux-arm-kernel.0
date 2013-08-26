From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 19:09:07 +0200
Subject: [PATCH v2 12/16] clk: samsung: pll: Add support for rate configuration
 of PLL46xx
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377536951-9307-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements round_rate and set_rate callbacks of PLL46xx
driver to allow reconfiguration of PLL at runtime.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-pll.c | 111 +++++++++++++++++++++++++++++++++++++++++-
 drivers/clk/samsung/clk-pll.h |  25 ++++++++++
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 14bd83e..d8ea6ca 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -411,10 +411,13 @@ static const struct clk_ops samsung_pll45xx_clk_min_ops = {
 /*
  * PLL46xx Clock Type
  */
+#define PLL46XX_LOCK_FACTOR	3000
 
+#define PLL46XX_VSEL_MASK	(1)
 #define PLL46XX_MDIV_MASK	(0x1FF)
 #define PLL46XX_PDIV_MASK	(0x3F)
 #define PLL46XX_SDIV_MASK	(0x7)
+#define PLL46XX_VSEL_SHIFT	(27)
 #define PLL46XX_MDIV_SHIFT	(16)
 #define PLL46XX_PDIV_SHIFT	(8)
 #define PLL46XX_SDIV_SHIFT	(0)
@@ -422,6 +425,15 @@ static const struct clk_ops samsung_pll45xx_clk_min_ops = {
 #define PLL46XX_KDIV_MASK	(0xFFFF)
 #define PLL4650C_KDIV_MASK	(0xFFF)
 #define PLL46XX_KDIV_SHIFT	(0)
+#define PLL46XX_MFR_MASK	(0x3F)
+#define PLL46XX_MRR_MASK	(0x1F)
+#define PLL46XX_KDIV_SHIFT	(0)
+#define PLL46XX_MFR_SHIFT	(16)
+#define PLL46XX_MRR_SHIFT	(24)
+
+#define PLL46XX_ENABLE		BIT(31)
+#define PLL46XX_LOCKED		BIT(29)
+#define PLL46XX_VSEL		BIT(27)
 
 static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
@@ -446,8 +458,102 @@ static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 	return (unsigned long)fvco;
 }
 
+static bool samsung_pll46xx_mpk_change(u32 pll_con0, u32 pll_con1,
+				const struct samsung_pll_rate_table *rate)
+{
+	u32 old_mdiv, old_pdiv, old_kdiv;
+
+	old_mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & PLL46XX_MDIV_MASK;
+	old_pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
+	old_kdiv = (pll_con1 >> PLL46XX_KDIV_SHIFT) & PLL46XX_KDIV_MASK;
+
+	return (old_mdiv != rate->mdiv || old_pdiv != rate->pdiv
+		|| old_kdiv != rate->kdiv);
+}
+
+static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
+					unsigned long prate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	const struct samsung_pll_rate_table *rate;
+	u32 con0, con1, lock;
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
+	if (!(samsung_pll46xx_mpk_change(con0, con1, rate))) {
+		/* If only s change, change just s value only*/
+		con0 &= ~(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
+		con0 |= rate->sdiv << PLL46XX_SDIV_SHIFT;
+		__raw_writel(con0, pll->con_reg);
+
+		return 0;
+	}
+
+	/* Set PLL lock time. */
+	lock = rate->pdiv * PLL46XX_LOCK_FACTOR;
+	if (lock > 0xffff)
+		/* Maximum lock time bitfield is 16-bit. */
+		lock = 0xffff;
+
+	/* Set PLL PMS and VSEL values. */
+	con0 &= ~((PLL46XX_MDIV_MASK << PLL46XX_MDIV_SHIFT) |
+			(PLL46XX_PDIV_MASK << PLL46XX_PDIV_SHIFT) |
+			(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT) |
+			(PLL46XX_VSEL_MASK << PLL46XX_VSEL_SHIFT));
+	con0 |= (rate->mdiv << PLL46XX_MDIV_SHIFT) |
+			(rate->pdiv << PLL46XX_PDIV_SHIFT) |
+			(rate->sdiv << PLL46XX_SDIV_SHIFT) |
+			(rate->vsel << PLL46XX_VSEL_SHIFT);
+
+	/* Set PLL K, MFR and MRR values. */
+	con1 = __raw_readl(pll->con_reg + 0x4);
+	con1 &= ~((PLL46XX_KDIV_MASK << PLL46XX_KDIV_SHIFT) |
+			(PLL46XX_MFR_MASK << PLL46XX_MFR_SHIFT) |
+			(PLL46XX_MRR_MASK << PLL46XX_MRR_SHIFT));
+	con1 |= (rate->kdiv << PLL46XX_KDIV_SHIFT) |
+			(rate->mfr << PLL46XX_MFR_SHIFT) |
+			(rate->mrr << PLL46XX_MRR_SHIFT);
+
+	/* Write configuration to PLL */
+	__raw_writel(lock, pll->lock_reg);
+	__raw_writel(con0, pll->con_reg);
+	__raw_writel(con1, pll->con_reg + 0x4);
+
+	/* Wait for locking. */
+	start = ktime_get();
+	while (!(__raw_readl(pll->con_reg) & PLL46XX_LOCKED)) {
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
 static const struct clk_ops samsung_pll46xx_clk_ops = {
 	.recalc_rate = samsung_pll46xx_recalc_rate,
+	.round_rate = samsung_pll_round_rate,
+	.set_rate = samsung_pll46xx_set_rate,
+};
+
+static const struct clk_ops samsung_pll46xx_clk_min_ops = {
+	.recalc_rate = samsung_pll46xx_recalc_rate,
 };
 
 /*
@@ -758,7 +864,10 @@ static void __init _samsung_clk_register_pll(struct samsung_pll_clock *pll_clk,
 	case pll_4600:
 	case pll_4650:
 	case pll_4650c:
-		init.ops = &samsung_pll46xx_clk_ops;
+		if (!pll->rate_table)
+			init.ops = &samsung_pll46xx_clk_min_ops;
+		else
+			init.ops = &samsung_pll46xx_clk_ops;
 		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 7de5e3e..53847e0 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -51,6 +51,28 @@ enum samsung_pll_type {
 		.afc	=	(_afc),				\
 	}
 
+#define PLL_4600_RATE(_rate, _m, _p, _s, _k, _vsel)		\
+	{							\
+		.rate	=	(_rate),			\
+		.mdiv	=	(_m),				\
+		.pdiv	=	(_p),				\
+		.sdiv	=	(_s),				\
+		.kdiv	=	(_k),				\
+		.vsel	=	(_vsel),			\
+	}
+
+#define PLL_4650_RATE(_rate, _m, _p, _s, _k, _mfr, _mrr, _vsel)	\
+	{							\
+		.rate	=	(_rate),			\
+		.mdiv	=	(_m),				\
+		.pdiv	=	(_p),				\
+		.sdiv	=	(_s),				\
+		.kdiv	=	(_k),				\
+		.mfr	=	(_mfr),				\
+		.mrr	=	(_mrr),				\
+		.vsel	=	(_vsel),			\
+	}
+
 /* NOTE: Rate table should be kept sorted in descending order. */
 
 struct samsung_pll_rate_table {
@@ -60,6 +82,9 @@ struct samsung_pll_rate_table {
 	unsigned int sdiv;
 	unsigned int kdiv;
 	unsigned int afc;
+	unsigned int mfr;
+	unsigned int mrr;
+	unsigned int vsel;
 };
 
 extern struct clk *samsung_clk_register_pll6552(const char *name,
-- 
1.8.3.2
