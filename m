From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:30:56 +0100
Subject: [RFC PATCH 01/15] clock: exynos: fixup endian in pll clk
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-2-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the clk endian access code to deal with kernels built for big endian
operation.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Tomasz Figa <tomasz.figa@gmail.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
CC: linux-samsung-soc at vger.kernel.org
CC: linux-clk at vger.kernel.org
CC: linux-kernel at vger.kernel.org
---
 drivers/clk/samsung/clk-pll.c | 122 +++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index b7dd396..48139bd 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -79,7 +79,7 @@ static unsigned long samsung_pll2126_recalc_rate(struct clk_hw *hw,
 	u32 pll_con, mdiv, pdiv, sdiv;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLL2126_MDIV_SHIFT) & PLL2126_MDIV_MASK;
 	pdiv = (pll_con >> PLL2126_PDIV_SHIFT) & PLL2126_PDIV_MASK;
 	sdiv = (pll_con >> PLL2126_SDIV_SHIFT) & PLL2126_SDIV_MASK;
@@ -112,7 +112,7 @@ static unsigned long samsung_pll3000_recalc_rate(struct clk_hw *hw,
 	u32 pll_con, mdiv, pdiv, sdiv;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLL3000_MDIV_SHIFT) & PLL3000_MDIV_MASK;
 	pdiv = (pll_con >> PLL3000_PDIV_SHIFT) & PLL3000_PDIV_MASK;
 	sdiv = (pll_con >> PLL3000_SDIV_SHIFT) & PLL3000_SDIV_MASK;
@@ -149,7 +149,7 @@ static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLL35XX_MDIV_SHIFT) & PLL35XX_MDIV_MASK;
 	pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
 	sdiv = (pll_con >> PLL35XX_SDIV_SHIFT) & PLL35XX_SDIV_MASK;
@@ -186,19 +186,19 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	tmp = __raw_readl(pll->con_reg);
+	tmp = readl_relaxed(pll->con_reg);
 
 	if (!(samsung_pll35xx_mp_change(rate, tmp))) {
 		/* If only s change, change just s value only*/
 		tmp &= ~(PLL35XX_SDIV_MASK << PLL35XX_SDIV_SHIFT);
 		tmp |= rate->sdiv << PLL35XX_SDIV_SHIFT;
-		__raw_writel(tmp, pll->con_reg);
+		writel_relaxed(tmp, pll->con_reg);
 
 		return 0;
 	}
 
 	/* Set PLL lock time. */
-	__raw_writel(rate->pdiv * PLL35XX_LOCK_FACTOR,
+	writel_relaxed(rate->pdiv * PLL35XX_LOCK_FACTOR,
 			pll->lock_reg);
 
 	/* Change PLL PMS values */
@@ -208,12 +208,12 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	tmp |= (rate->mdiv << PLL35XX_MDIV_SHIFT) |
 			(rate->pdiv << PLL35XX_PDIV_SHIFT) |
 			(rate->sdiv << PLL35XX_SDIV_SHIFT);
-	__raw_writel(tmp, pll->con_reg);
+	writel_relaxed(tmp, pll->con_reg);
 
 	/* wait_lock_time */
 	do {
 		cpu_relax();
-		tmp = __raw_readl(pll->con_reg);
+		tmp = readl_relaxed(pll->con_reg);
 	} while (!(tmp & (PLL35XX_LOCK_STAT_MASK
 				<< PLL35XX_LOCK_STAT_SHIFT)));
 	return 0;
@@ -253,8 +253,8 @@ static unsigned long samsung_pll36xx_recalc_rate(struct clk_hw *hw,
 	s16 kdiv;
 	u64 fvco = parent_rate;
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con1 = __raw_readl(pll->con_reg + 4);
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con1 = readl_relaxed(pll->con_reg + 4);
 	mdiv = (pll_con0 >> PLL36XX_MDIV_SHIFT) & PLL36XX_MDIV_MASK;
 	pdiv = (pll_con0 >> PLL36XX_PDIV_SHIFT) & PLL36XX_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL36XX_SDIV_SHIFT) & PLL36XX_SDIV_MASK;
@@ -294,20 +294,20 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con1 = __raw_readl(pll->con_reg + 4);
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con1 = readl_relaxed(pll->con_reg + 4);
 
 	if (!(samsung_pll36xx_mpk_change(rate, pll_con0, pll_con1))) {
 		/* If only s change, change just s value only*/
 		pll_con0 &= ~(PLL36XX_SDIV_MASK << PLL36XX_SDIV_SHIFT);
 		pll_con0 |= (rate->sdiv << PLL36XX_SDIV_SHIFT);
-		__raw_writel(pll_con0, pll->con_reg);
+		writel_relaxed(pll_con0, pll->con_reg);
 
 		return 0;
 	}
 
 	/* Set PLL lock time. */
-	__raw_writel(rate->pdiv * PLL36XX_LOCK_FACTOR, pll->lock_reg);
+	writel_relaxed(rate->pdiv * PLL36XX_LOCK_FACTOR, pll->lock_reg);
 
 	 /* Change PLL PMS values */
 	pll_con0 &= ~((PLL36XX_MDIV_MASK << PLL36XX_MDIV_SHIFT) |
@@ -316,16 +316,16 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	pll_con0 |= (rate->mdiv << PLL36XX_MDIV_SHIFT) |
 			(rate->pdiv << PLL36XX_PDIV_SHIFT) |
 			(rate->sdiv << PLL36XX_SDIV_SHIFT);
-	__raw_writel(pll_con0, pll->con_reg);
+	writel_relaxed(pll_con0, pll->con_reg);
 
 	pll_con1 &= ~(PLL36XX_KDIV_MASK << PLL36XX_KDIV_SHIFT);
 	pll_con1 |= rate->kdiv << PLL36XX_KDIV_SHIFT;
-	__raw_writel(pll_con1, pll->con_reg + 4);
+	writel_relaxed(pll_con1, pll->con_reg + 4);
 
 	/* wait_lock_time */
 	do {
 		cpu_relax();
-		tmp = __raw_readl(pll->con_reg);
+		tmp = readl_relaxed(pll->con_reg);
 	} while (!(tmp & (1 << PLL36XX_LOCK_STAT_SHIFT)));
 
 	return 0;
@@ -366,7 +366,7 @@ static unsigned long samsung_pll45xx_recalc_rate(struct clk_hw *hw,
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLL45XX_MDIV_SHIFT) & PLL45XX_MDIV_MASK;
 	pdiv = (pll_con >> PLL45XX_PDIV_SHIFT) & PLL45XX_PDIV_MASK;
 	sdiv = (pll_con >> PLL45XX_SDIV_SHIFT) & PLL45XX_SDIV_MASK;
@@ -409,14 +409,14 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	con0 = __raw_readl(pll->con_reg);
-	con1 = __raw_readl(pll->con_reg + 0x4);
+	con0 = readl_relaxed(pll->con_reg);
+	con1 = readl_relaxed(pll->con_reg + 0x4);
 
 	if (!(samsung_pll45xx_mp_change(con0, con1, rate))) {
 		/* If only s change, change just s value only*/
 		con0 &= ~(PLL45XX_SDIV_MASK << PLL45XX_SDIV_SHIFT);
 		con0 |= rate->sdiv << PLL45XX_SDIV_SHIFT;
-		__raw_writel(con0, pll->con_reg);
+		writel_relaxed(con0, pll->con_reg);
 
 		return 0;
 	}
@@ -430,29 +430,29 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 			(rate->sdiv << PLL45XX_SDIV_SHIFT);
 
 	/* Set PLL AFC value. */
-	con1 = __raw_readl(pll->con_reg + 0x4);
+	con1 = readl_relaxed(pll->con_reg + 0x4);
 	con1 &= ~(PLL45XX_AFC_MASK << PLL45XX_AFC_SHIFT);
 	con1 |= (rate->afc << PLL45XX_AFC_SHIFT);
 
 	/* Set PLL lock time. */
 	switch (pll->type) {
 	case pll_4502:
-		__raw_writel(rate->pdiv * PLL4502_LOCK_FACTOR, pll->lock_reg);
+		writel_relaxed(rate->pdiv * PLL4502_LOCK_FACTOR, pll->lock_reg);
 		break;
 	case pll_4508:
-		__raw_writel(rate->pdiv * PLL4508_LOCK_FACTOR, pll->lock_reg);
+		writel_relaxed(rate->pdiv * PLL4508_LOCK_FACTOR, pll->lock_reg);
 		break;
 	default:
 		break;
 	}
 
 	/* Set new configuration. */
-	__raw_writel(con1, pll->con_reg + 0x4);
-	__raw_writel(con0, pll->con_reg);
+	writel_relaxed(con1, pll->con_reg + 0x4);
+	writel_relaxed(con0, pll->con_reg);
 
 	/* Wait for locking. */
 	start = ktime_get();
-	while (!(__raw_readl(pll->con_reg) & PLL45XX_LOCKED)) {
+	while (!(readl_relaxed(pll->con_reg) & PLL45XX_LOCKED)) {
 		ktime_t delta = ktime_sub(ktime_get(), start);
 
 		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
@@ -513,8 +513,8 @@ static unsigned long samsung_pll46xx_recalc_rate(struct clk_hw *hw,
 	u32 mdiv, pdiv, sdiv, kdiv, pll_con0, pll_con1, shift;
 	u64 fvco = parent_rate;
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con1 = __raw_readl(pll->con_reg + 4);
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con1 = readl_relaxed(pll->con_reg + 4);
 	mdiv = (pll_con0 >> PLL46XX_MDIV_SHIFT) & ((pll->type == pll_1460x) ?
 				PLL1460X_MDIV_MASK : PLL46XX_MDIV_MASK);
 	pdiv = (pll_con0 >> PLL46XX_PDIV_SHIFT) & PLL46XX_PDIV_MASK;
@@ -560,14 +560,14 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	con0 = __raw_readl(pll->con_reg);
-	con1 = __raw_readl(pll->con_reg + 0x4);
+	con0 = readl_relaxed(pll->con_reg);
+	con1 = readl_relaxed(pll->con_reg + 0x4);
 
 	if (!(samsung_pll46xx_mpk_change(con0, con1, rate))) {
 		/* If only s change, change just s value only*/
 		con0 &= ~(PLL46XX_SDIV_MASK << PLL46XX_SDIV_SHIFT);
 		con0 |= rate->sdiv << PLL46XX_SDIV_SHIFT;
-		__raw_writel(con0, pll->con_reg);
+		writel_relaxed(con0, pll->con_reg);
 
 		return 0;
 	}
@@ -596,7 +596,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 			(rate->sdiv << PLL46XX_SDIV_SHIFT);
 
 	/* Set PLL K, MFR and MRR values. */
-	con1 = __raw_readl(pll->con_reg + 0x4);
+	con1 = readl_relaxed(pll->con_reg + 0x4);
 	con1 &= ~((PLL46XX_KDIV_MASK << PLL46XX_KDIV_SHIFT) |
 			(PLL46XX_MFR_MASK << PLL46XX_MFR_SHIFT) |
 			(PLL46XX_MRR_MASK << PLL46XX_MRR_SHIFT));
@@ -605,13 +605,13 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 			(rate->mrr << PLL46XX_MRR_SHIFT);
 
 	/* Write configuration to PLL */
-	__raw_writel(lock, pll->lock_reg);
-	__raw_writel(con0, pll->con_reg);
-	__raw_writel(con1, pll->con_reg + 0x4);
+	writel_relaxed(lock, pll->lock_reg);
+	writel_relaxed(con0, pll->con_reg);
+	writel_relaxed(con1, pll->con_reg + 0x4);
 
 	/* Wait for locking. */
 	start = ktime_get();
-	while (!(__raw_readl(pll->con_reg) & PLL46XX_LOCKED)) {
+	while (!(readl_relaxed(pll->con_reg) & PLL46XX_LOCKED)) {
 		ktime_t delta = ktime_sub(ktime_get(), start);
 
 		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
@@ -656,7 +656,7 @@ static unsigned long samsung_pll6552_recalc_rate(struct clk_hw *hw,
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	if (pll->type == pll_6552_s3c2416) {
 		mdiv = (pll_con >> PLL6552_MDIV_SHIFT_2416) & PLL6552_MDIV_MASK;
 		pdiv = (pll_con >> PLL6552_PDIV_SHIFT_2416) & PLL6552_PDIV_MASK;
@@ -696,8 +696,8 @@ static unsigned long samsung_pll6553_recalc_rate(struct clk_hw *hw,
 	u32 mdiv, pdiv, sdiv, kdiv, pll_con0, pll_con1;
 	u64 fvco = parent_rate;
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con1 = __raw_readl(pll->con_reg + 0x4);
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con1 = readl_relaxed(pll->con_reg + 0x4);
 	mdiv = (pll_con0 >> PLL6553_MDIV_SHIFT) & PLL6553_MDIV_MASK;
 	pdiv = (pll_con0 >> PLL6553_PDIV_SHIFT) & PLL6553_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL6553_SDIV_SHIFT) & PLL6553_SDIV_MASK;
@@ -734,7 +734,7 @@ static unsigned long samsung_s3c2410_pll_recalc_rate(struct clk_hw *hw,
 	u32 pll_con, mdiv, pdiv, sdiv;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLLS3C2410_MDIV_SHIFT) & PLLS3C2410_MDIV_MASK;
 	pdiv = (pll_con >> PLLS3C2410_PDIV_SHIFT) & PLLS3C2410_PDIV_MASK;
 	sdiv = (pll_con >> PLLS3C2410_SDIV_SHIFT) & PLLS3C2410_SDIV_MASK;
@@ -752,7 +752,7 @@ static unsigned long samsung_s3c2440_mpll_recalc_rate(struct clk_hw *hw,
 	u32 pll_con, mdiv, pdiv, sdiv;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLLS3C2410_MDIV_SHIFT) & PLLS3C2410_MDIV_MASK;
 	pdiv = (pll_con >> PLLS3C2410_PDIV_SHIFT) & PLLS3C2410_PDIV_MASK;
 	sdiv = (pll_con >> PLLS3C2410_SDIV_SHIFT) & PLLS3C2410_SDIV_MASK;
@@ -778,7 +778,7 @@ static int samsung_s3c2410_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	tmp = __raw_readl(pll->con_reg);
+	tmp = readl_relaxed(pll->con_reg);
 
 	/* Change PLL PMS values */
 	tmp &= ~((PLLS3C2410_MDIV_MASK << PLLS3C2410_MDIV_SHIFT) |
@@ -787,7 +787,7 @@ static int samsung_s3c2410_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	tmp |= (rate->mdiv << PLLS3C2410_MDIV_SHIFT) |
 			(rate->pdiv << PLLS3C2410_PDIV_SHIFT) |
 			(rate->sdiv << PLLS3C2410_SDIV_SHIFT);
-	__raw_writel(tmp, pll->con_reg);
+	writel_relaxed(tmp, pll->con_reg);
 
 	/* Time to settle according to the manual */
 	udelay(300);
@@ -798,7 +798,7 @@ static int samsung_s3c2410_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 static int samsung_s3c2410_pll_enable(struct clk_hw *hw, int bit, bool enable)
 {
 	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 pll_en = __raw_readl(pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
+	u32 pll_en = readl_relaxed(pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
 	u32 pll_en_orig = pll_en;
 
 	if (enable)
@@ -806,7 +806,7 @@ static int samsung_s3c2410_pll_enable(struct clk_hw *hw, int bit, bool enable)
 	else
 		pll_en |= BIT(bit);
 
-	__raw_writel(pll_en, pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
+	writel_relaxed(pll_en, pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
 
 	/* if we started the UPLL, then allow to settle */
 	if (enable && (pll_en_orig & BIT(bit)))
@@ -905,7 +905,7 @@ static unsigned long samsung_pll2550x_recalc_rate(struct clk_hw *hw,
 	u32 r, p, m, s, pll_stat;
 	u64 fvco = parent_rate;
 
-	pll_stat = __raw_readl(pll->reg_base + pll->offset * 3);
+	pll_stat = readl_relaxed(pll->reg_base + pll->offset * 3);
 	r = (pll_stat >> PLL2550X_R_SHIFT) & PLL2550X_R_MASK;
 	if (!r)
 		return 0;
@@ -983,7 +983,7 @@ static unsigned long samsung_pll2550xx_recalc_rate(struct clk_hw *hw,
 	u32 mdiv, pdiv, sdiv, pll_con;
 	u64 fvco = parent_rate;
 
-	pll_con = __raw_readl(pll->con_reg);
+	pll_con = readl_relaxed(pll->con_reg);
 	mdiv = (pll_con >> PLL2550XX_M_SHIFT) & PLL2550XX_M_MASK;
 	pdiv = (pll_con >> PLL2550XX_P_SHIFT) & PLL2550XX_P_MASK;
 	sdiv = (pll_con >> PLL2550XX_S_SHIFT) & PLL2550XX_S_MASK;
@@ -1019,19 +1019,19 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	tmp = __raw_readl(pll->con_reg);
+	tmp = readl_relaxed(pll->con_reg);
 
 	if (!(samsung_pll2550xx_mp_change(rate->mdiv, rate->pdiv, tmp))) {
 		/* If only s change, change just s value only*/
 		tmp &= ~(PLL2550XX_S_MASK << PLL2550XX_S_SHIFT);
 		tmp |= rate->sdiv << PLL2550XX_S_SHIFT;
-		__raw_writel(tmp, pll->con_reg);
+		writel_relaxed(tmp, pll->con_reg);
 
 		return 0;
 	}
 
 	/* Set PLL lock time. */
-	__raw_writel(rate->pdiv * PLL2550XX_LOCK_FACTOR, pll->lock_reg);
+	writel_relaxed(rate->pdiv * PLL2550XX_LOCK_FACTOR, pll->lock_reg);
 
 	/* Change PLL PMS values */
 	tmp &= ~((PLL2550XX_M_MASK << PLL2550XX_M_SHIFT) |
@@ -1040,12 +1040,12 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	tmp |= (rate->mdiv << PLL2550XX_M_SHIFT) |
 			(rate->pdiv << PLL2550XX_P_SHIFT) |
 			(rate->sdiv << PLL2550XX_S_SHIFT);
-	__raw_writel(tmp, pll->con_reg);
+	writel_relaxed(tmp, pll->con_reg);
 
 	/* wait_lock_time */
 	do {
 		cpu_relax();
-		tmp = __raw_readl(pll->con_reg);
+		tmp = readl_relaxed(pll->con_reg);
 	} while (!(tmp & (PLL2550XX_LOCK_STAT_MASK
 			<< PLL2550XX_LOCK_STAT_SHIFT)));
 
@@ -1089,8 +1089,8 @@ static unsigned long samsung_pll2650xx_recalc_rate(struct clk_hw *hw,
 	s16 kdiv;
 	u64 fvco = parent_rate;
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con2 = __raw_readl(pll->con_reg + 8);
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con2 = readl_relaxed(pll->con_reg + 8);
 	mdiv = (pll_con0 >> PLL2650XX_MDIV_SHIFT) & PLL2650XX_MDIV_MASK;
 	pdiv = (pll_con0 >> PLL2650XX_PDIV_SHIFT) & PLL2650XX_PDIV_MASK;
 	sdiv = (pll_con0 >> PLL2650XX_SDIV_SHIFT) & PLL2650XX_SDIV_MASK;
@@ -1117,8 +1117,8 @@ static int samsung_pll2650xx_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	pll_con0 = __raw_readl(pll->con_reg);
-	pll_con2 = __raw_readl(pll->con_reg + 8);
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con2 = readl_relaxed(pll->con_reg + 8);
 
 	 /* Change PLL PMS values */
 	pll_con0 &= ~(PLL2650XX_MDIV_MASK << PLL2650XX_MDIV_SHIFT |
@@ -1135,13 +1135,13 @@ static int samsung_pll2650xx_set_rate(struct clk_hw *hw, unsigned long drate,
 			<< PLL2650XX_KDIV_SHIFT;
 
 	/* Set PLL lock time. */
-	__raw_writel(PLL2650XX_LOCK_FACTOR * rate->pdiv, pll->lock_reg);
+	writel_relaxed(PLL2650XX_LOCK_FACTOR * rate->pdiv, pll->lock_reg);
 
-	__raw_writel(pll_con0, pll->con_reg);
-	__raw_writel(pll_con2, pll->con_reg + 8);
+	writel_relaxed(pll_con0, pll->con_reg);
+	writel_relaxed(pll_con2, pll->con_reg + 8);
 
 	do {
-		tmp = __raw_readl(pll->con_reg);
+		tmp = readl_relaxed(pll->con_reg);
 	} while (!(tmp & (0x1 << PLL2650XX_PLL_LOCKTIME_SHIFT)));
 
 	return 0;
-- 
2.8.3
