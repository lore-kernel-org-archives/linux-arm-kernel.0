From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 21 May 2014 07:47:51 -0700
Subject: [PATCH 2/2] ARM: imx: powerdown PLL before changing of its setting
In-Reply-To: <1400683671-19132-1-git-send-email-jiada_wang@mentor.com>
References: <1400683671-19132-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1400683671-19132-3-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

According to i.MX6 user manual, "Before changing the PLL setting,
power it down. Power up the PLL after the change".
But currently PLL setting is being updated without power-down
it first. This may end up with improper output/gitches which
prevents future operation.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm/mach-imx/clk-pllv3.c |   53 +++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 36f2396..773c249 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -67,30 +67,41 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
 }
 
-static int clk_pllv3_prepare(struct clk_hw *hw)
+static int __clk_pllv3_powerset(struct clk_pllv3 *pll, u32 newval)
 {
-	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	u32 val;
 	int ret;
 
 	val = readl_relaxed(pll->base);
-	if (pll->powerup_set)
-		val |= BM_PLL_POWER;
-	else
-		val &= ~BM_PLL_POWER;
+	val &= ~BM_PLL_POWER;
+	val |= (newval & BM_PLL_POWER);
 	writel_relaxed(val, pll->base);
 
 	ret = clk_pllv3_wait_lock(pll);
 	if (ret)
 		return ret;
 
+	/* only if its locked we can switch back to the PLL */
 	val = readl_relaxed(pll->base);
 	val &= ~BM_PLL_BYPASS;
+	val |= (newval & BM_PLL_BYPASS);
 	writel_relaxed(val, pll->base);
 
 	return 0;
 }
 
+static int clk_pllv3_prepare(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 power = 0; /* PLL_POWER == 0, PLL_BYPASS == 0 */
+
+	if (pll->powerup_set)
+		power = BM_PLL_POWER;
+
+	/* power on, bypass disable */
+	return __clk_pllv3_powerset(pll, power);
+}
+
 static void clk_pllv3_unprepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
@@ -151,7 +162,7 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long parent_rate)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	u32 val, div;
+	u32 val, oldval, div;
 
 	if (rate == parent_rate * 22)
 		div = 1;
@@ -160,12 +171,18 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 	else
 		return -EINVAL;
 
+	oldval = readl_relaxed(pll->base);
+
+	/* power down PLL first */
+	clk_pllv3_unprepare(hw);
+
 	val = readl_relaxed(pll->base);
 	val &= ~pll->div_mask;
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	/* restore power & bypass bit */
+	return __clk_pllv3_powerset(pll, oldval);
 }
 
 static const struct clk_ops clk_pllv3_ops = {
@@ -210,18 +227,24 @@ static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	unsigned long min_rate = parent_rate * 54 / 2;
 	unsigned long max_rate = parent_rate * 108 / 2;
-	u32 val, div;
+	u32 val, oldval, div;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
 
+	oldval = readl_relaxed(pll->base);
+
+	/* power down PLL first */
+	clk_pllv3_unprepare(hw);
+
 	div = rate * 2 / parent_rate;
 	val = readl_relaxed(pll->base);
 	val &= ~pll->div_mask;
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	/* restore power & bypass bit */
+	return __clk_pllv3_powerset(pll, oldval);
 }
 
 static const struct clk_ops clk_pllv3_sys_ops = {
@@ -275,13 +298,18 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	unsigned long min_rate = parent_rate * 27;
 	unsigned long max_rate = parent_rate * 54;
-	u32 val, div;
+	u32 val, oldval, div;
 	u32 mfn, mfd = 1000000;
 	s64 temp64;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
 
+	oldval = readl_relaxed(pll->base);
+
+	/* power down PLL first */
+	clk_pllv3_unprepare(hw);
+
 	div = rate / parent_rate;
 	temp64 = (u64) (rate - div * parent_rate);
 	temp64 *= mfd;
@@ -295,7 +323,8 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
 	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
 
-	return clk_pllv3_wait_lock(pll);
+	/* restore power & bypass bit */
+	return __clk_pllv3_powerset(pll, oldval);
 }
 
 static const struct clk_ops clk_pllv3_av_ops = {
-- 
1.7.9.5
