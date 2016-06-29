From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 29 Jun 2016 21:52:14 +0800
Subject: [PATCH RFC 6/7] clk: imx: pllv3: convert to prepare_hw and set_rate_hw
In-Reply-To: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
References: <1467208335-29876-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1467208335-29876-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert to prepare_hw and set_rate_hw and let the clk core
to handle the polling process automatically.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/imx/clk-pllv3.c | 64 ++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 4826b3c9e19e..78184310ad35 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -49,27 +49,6 @@ struct clk_pllv3 {
 
 #define to_clk_pllv3(_hw) container_of(_hw, struct clk_pllv3, hw)
 
-static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
-	u32 val = readl_relaxed(pll->base) & pll->powerdown;
-
-	/* No need to wait for lock when pll is not powered up */
-	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
-		return 0;
-
-	/* Wait for PLL to lock */
-	do {
-		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
-			break;
-		if (time_after(jiffies, timeout))
-			break;
-		usleep_range(50, 500);
-	} while (1);
-
-	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
-}
-
 static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
@@ -82,7 +61,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 		val &= ~BM_PLL_POWER;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	return 0;
 }
 
 static void clk_pllv3_unprepare(struct clk_hw *hw)
@@ -126,6 +105,18 @@ static long clk_pllv3_round_rate(struct clk_hw *hw, unsigned long rate,
 					    parent_rate * 20;
 }
 
+static int clk_pllv3_set_rate_done(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val = readl_relaxed(pll->base) & pll->powerdown;
+
+	/* always return true if pll is not powered up */
+	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
+		return 1;
+
+	return readl_relaxed(pll->base) & BM_PLL_LOCK;
+}
+
 static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long parent_rate)
 {
@@ -144,16 +135,18 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 	val |= (div << pll->div_shift);
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	return 0;
 }
 
 static const struct clk_ops clk_pllv3_ops = {
-	.prepare	= clk_pllv3_prepare,
+	.prepare_hw	= clk_pllv3_prepare,
+	.prepare_done	= clk_pllv3_is_prepared,
 	.unprepare	= clk_pllv3_unprepare,
 	.is_prepared	= clk_pllv3_is_prepared,
 	.recalc_rate	= clk_pllv3_recalc_rate,
 	.round_rate	= clk_pllv3_round_rate,
-	.set_rate	= clk_pllv3_set_rate,
+	.set_rate_hw	= clk_pllv3_set_rate,
+	.set_rate_done	= clk_pllv3_set_rate_done,
 };
 
 static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
@@ -199,16 +192,18 @@ static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate,
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	return 0;
 }
 
 static const struct clk_ops clk_pllv3_sys_ops = {
-	.prepare	= clk_pllv3_prepare,
+	.prepare_hw	= clk_pllv3_prepare,
+	.prepare_done	= clk_pllv3_is_prepared,
 	.unprepare	= clk_pllv3_unprepare,
 	.is_prepared	= clk_pllv3_is_prepared,
 	.recalc_rate	= clk_pllv3_sys_recalc_rate,
 	.round_rate	= clk_pllv3_sys_round_rate,
-	.set_rate	= clk_pllv3_sys_set_rate,
+	.set_rate_hw	= clk_pllv3_sys_set_rate,
+	.set_rate_done	= clk_pllv3_set_rate_done,
 };
 
 static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
@@ -272,16 +267,18 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
 	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
 
-	return clk_pllv3_wait_lock(pll);
+	return 0;
 }
 
 static const struct clk_ops clk_pllv3_av_ops = {
-	.prepare	= clk_pllv3_prepare,
+	.prepare_hw	= clk_pllv3_prepare,
+	.prepare_done	= clk_pllv3_is_prepared,
 	.unprepare	= clk_pllv3_unprepare,
 	.is_prepared	= clk_pllv3_is_prepared,
 	.recalc_rate	= clk_pllv3_av_recalc_rate,
 	.round_rate	= clk_pllv3_av_round_rate,
-	.set_rate	= clk_pllv3_av_set_rate,
+	.set_rate_hw	= clk_pllv3_av_set_rate,
+	.set_rate_done	= clk_pllv3_set_rate_done,
 };
 
 static unsigned long clk_pllv3_enet_recalc_rate(struct clk_hw *hw,
@@ -293,7 +290,8 @@ static unsigned long clk_pllv3_enet_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops clk_pllv3_enet_ops = {
-	.prepare	= clk_pllv3_prepare,
+	.prepare_hw	= clk_pllv3_prepare,
+	.prepare_done	= clk_pllv3_is_prepared,
 	.unprepare	= clk_pllv3_unprepare,
 	.is_prepared	= clk_pllv3_is_prepared,
 	.recalc_rate	= clk_pllv3_enet_recalc_rate,
@@ -347,6 +345,8 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 	init.flags = 0;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
+	init.delay_min = 50;
+	init.delay_max = 500;
 
 	pll->hw.init = &init;
 
-- 
1.9.1
