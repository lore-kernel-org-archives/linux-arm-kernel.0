From: jiada_wang@mentor.com (Jiada Wang)
Date: Wed, 14 May 2014 18:36:37 +0900
Subject: [PATCH] ARM: imx: powerdown PLL before changing of its setting
Message-ID: <1400060197-706-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to i.MX6 user manual,  "Before changing the PLL setting,
power it down. Power up the PLL after the change"
But currently PLL setting is being updated without power-down
it first. This may end up with improper output/gitches which
prevents furture operation.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm/mach-imx/clk-pllv3.c | 72 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 6136405..f77edd6 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -67,6 +67,42 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
 }
 
+static void clk_pllv3_powerdown(struct clk_pllv3 *pll)
+{
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val |= BM_PLL_BYPASS;
+	writel_relaxed(val, pll->base);
+
+	if (pll->powerup_set)
+		val &= ~BM_PLL_POWER;
+	else
+		val |= BM_PLL_POWER;
+	writel_relaxed(val, pll->base);
+}
+
+static int clk_pllv3_powerrestore(struct clk_pllv3 *pll, u32 power, u32 bypass)
+{
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(pll->base);
+	val &= ~BM_PLL_POWER;
+	val |= power;
+	writel_relaxed(val, pll->base);
+
+	ret = clk_pllv3_wait_lock(pll);
+	if (ret == 0) {
+		/* only if it locked can we switch back to the PLL */
+		val &= ~BM_PLL_BYPASS;
+		val |= bypass;
+		writel_relaxed(val, pll->base);
+	}
+
+	return ret;
+}
+
 static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
@@ -149,7 +185,7 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long parent_rate)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	u32 val, div;
+	u32 val, powerval, bypassval, div;
 
 	if (rate == parent_rate * 22)
 		div = 1;
@@ -159,11 +195,19 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	val = readl_relaxed(pll->base);
+	powerval = val & BM_PLL_POWER;
+	bypassval = val & BM_PLL_BYPASS;
+
+	/* power down PLL first */
+	clk_pllv3_powerdown(pll);
+
+	val = readl_relaxed(pll->base);
 	val &= ~pll->div_mask;
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	/* restore power & bypass bit */
+	return clk_pllv3_powerrestore(pll, powerval, bypassval);
 }
 
 static const struct clk_ops clk_pllv3_ops = {
@@ -208,18 +252,26 @@ static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	unsigned long min_rate = parent_rate * 54 / 2;
 	unsigned long max_rate = parent_rate * 108 / 2;
-	u32 val, div;
+	u32 val, powerval, bypassval, div;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
 
+	val = readl_relaxed(pll->base);
+	powerval = val & BM_PLL_POWER;
+	bypassval = val & BM_PLL_BYPASS;
+
+	/* power down PLL first */
+	clk_pllv3_powerdown(pll);
+
 	div = rate * 2 / parent_rate;
 	val = readl_relaxed(pll->base);
 	val &= ~pll->div_mask;
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	/* restore power & bypass bit */
+	return clk_pllv3_powerrestore(pll, powerval, bypassval);
 }
 
 static const struct clk_ops clk_pllv3_sys_ops = {
@@ -273,13 +325,20 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	unsigned long min_rate = parent_rate * 27;
 	unsigned long max_rate = parent_rate * 54;
-	u32 val, div;
+	u32 val, powerval, bypassval, div;
 	u32 mfn, mfd = 1000000;
 	s64 temp64;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
 
+	val = readl_relaxed(pll->base);
+	powerval = val & BM_PLL_POWER;
+	bypassval = val & BM_PLL_BYPASS;
+
+	/* power down PLL first */
+	clk_pllv3_powerdown(pll);
+
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
@@ -293,7 +352,8 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
 	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
 
-	return clk_pllv3_wait_lock(pll);
+	/* restore power & bypass bit */
+	return clk_pllv3_powerrestore(pll, powerval, bypassval);
 }
 
 static const struct clk_ops clk_pllv3_av_ops = {
-- 
1.9.3
