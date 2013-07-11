From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 11 Jul 2013 14:57:49 +0530
Subject: [PATCH] clk: samsung: add set_rate and round_rate callbacks for
 pll45xx
Message-ID: <1373534869-12034-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for set_rate and round_rate callbacks for pll45xx pll. This allows
configuring pll45xx to generate a desired clock output.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---

The set_rate and round_rate callbacks in this patch for pll45xx are handled
slightly differently from the way it is done in the (not yet merged) patch
series from Yadwinder
(http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg19540.html)

In this patch, the pll lookup table is kept as part of the pll configuration
code itself, since the pll is just a hardware block which takes an input
frequency and configuration values to genertate a output clock frequency.
Given a set of inputs, a pll of a given type will generate the same output
regardless of the SoC it is used in. So instead of supplying the pll lookup
table from per-soc clock driver code (as done in the Yadwinder's patch series),
the pll lookup table can be coupled with the pll code itself, saving duplication
of pll lookup table for every SoC the pll is used with.

 drivers/clk/samsung/clk-pll.c |   88 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h |   15 +++++++
 2 files changed, 103 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 362f12d..4940936 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -172,6 +172,8 @@ struct clk * __init samsung_clk_register_pll36xx(const char *name,
  * PLL45xx Clock Type
  */
 
+#define PLL45XX_EN_MASK		(1 << 31)
+#define PLL45XX_LOCK_MASK	(1 << 29)
 #define PLL45XX_MDIV_MASK	(0x3FF)
 #define PLL45XX_PDIV_MASK	(0x3F)
 #define PLL45XX_SDIV_MASK	(0x7)
@@ -187,6 +189,90 @@ struct samsung_clk_pll45xx {
 
 #define to_clk_pll45xx(_hw) container_of(_hw, struct samsung_clk_pll45xx, hw)
 
+/* a sorted table of freq supported by pll45xx with 24mhz parent clock */
+static struct pll45xx_freq_lookup pll45xx_freq_lookup_24mhz[] = {
+	PLL45XX_PMS(1000000000, 6, 250, 1),
+	PLL45XX_PMS(800000000, 6, 200, 1),
+	PLL45XX_PMS(500000000, 6, 250, 2),
+	PLL45XX_PMS(400000000, 6, 200, 2),
+	PLL45XX_PMS(200000000, 6, 200, 3),
+};
+
+static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long prate)
+{
+	struct samsung_clk_pll45xx *pll = to_clk_pll45xx(hw);
+	struct pll45xx_freq_lookup *f;
+	unsigned long timeout, pll_con, cnt, idx;
+
+	/* select a lookup table based on parent clock frequency */
+	switch (prate) {
+	case 24000000:
+		f = pll45xx_freq_lookup_24mhz;
+		cnt = ARRAY_SIZE(pll45xx_freq_lookup_24mhz);
+		break;
+	default:
+		pr_err("%s: unsupported parent clock rate, failed to set rate",
+					__func__);
+		return -EINVAL;
+	}
+
+	/* check if the requested freq is in the list of supported freq */
+	for (idx = 0; idx < cnt; idx++, f++)
+		if (f->target_freq == rate)
+			break;
+
+	if (idx == cnt) {
+		pr_err("%s: unspported clock speed %ld requested\n",
+				__func__, rate);
+		return -EINVAL;
+	}
+
+	/* first, disable the output of the pll */
+	writel(readl(pll->con_reg) & ~PLL45XX_EN_MASK, (void *)pll->con_reg);
+
+	/* write the new pll configuration values */
+	pll_con = (f->pdiv << PLL45XX_PDIV_SHIFT) |
+			(f->mdiv << PLL45XX_MDIV_SHIFT) |
+			(f->sdiv << PLL45XX_SDIV_SHIFT);
+	writel(pll_con, (void *)pll->con_reg);
+
+	/* enable the pll and wait for it to stabilize */
+	writel(pll_con | PLL45XX_EN_MASK, (void *)pll->con_reg);
+	timeout = jiffies + msecs_to_jiffies(20);
+	while (time_before(jiffies, timeout))
+		if (readl(pll->con_reg) & PLL45XX_LOCK_MASK)
+			return 0;
+	return -EBUSY;
+}
+
+static long samsung_pll45xx_round_rate(struct clk_hw *hw, unsigned long rate,
+						unsigned long *prate)
+{
+	struct pll45xx_freq_lookup *f;
+	unsigned long cnt;
+
+	/* select a lookup table based on parent clock frequency */
+	switch (*prate) {
+	case 24000000:
+		f = pll45xx_freq_lookup_24mhz;
+		cnt = ARRAY_SIZE(pll45xx_freq_lookup_24mhz);
+		break;
+	default:
+		pr_err("%s: unsupported parent clock rate", __func__);
+		return *prate;
+	}
+
+	/* find the nearest possible clock output that can be supported */
+	while (cnt-- > 0) {
+		if (rate >= f->target_freq)
+			return f->target_freq;
+		f++;
+	}
+
+	return (--f)->target_freq;
+}
+
 static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 				unsigned long parent_rate)
 {
@@ -209,6 +295,8 @@ static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops samsung_pll45xx_clk_ops = {
+	.set_rate = samsung_pll45xx_set_rate,
+	.round_rate = samsung_pll45xx_round_rate,
 	.recalc_rate = samsung_pll45xx_recalc_rate,
 };
 
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index f33786e..fb687ec 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -18,6 +18,21 @@ enum pll45xx_type {
 	pll_4508
 };
 
+struct pll45xx_freq_lookup {
+	unsigned long	target_freq;
+	unsigned long	pdiv;
+	unsigned long	mdiv;
+	unsigned long	sdiv;
+};
+
+#define PLL45XX_PMS(f, p, m, s)		\
+	{					\
+		.target_freq	= f,		\
+		.pdiv		= p,		\
+		.mdiv		= m,		\
+		.sdiv		= s,		\
+	}
+
 enum pll46xx_type {
 	pll_4600,
 	pll_4650,
-- 
1.7.5.4
