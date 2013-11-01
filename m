From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 17:02:24 +0800
Subject: [PATCH 2/3] ARM: imx: pllv3 needs relock in .set_rate() call
In-Reply-To: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
References: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1383296545-18652-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pllv3 nees relock not only when powering up but also when rate
changes.  The patch creates a helper function clk_pllv3_wait_lock() and
moves the relock code from clk_pllv3_prepare() into there, so that
both .prepare() and .set_rate() hooks of pllv3 can call into the helper
for relocking.

Since relock is only needed when PLL is powered up while clk_set_rate()
could be called before clk is prepared, we need to add a check in
clk_pllv3_wait_lock() to skip the relock if PLL is not powered.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-pllv3.c |   43 ++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index c9ca191..df17362 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -46,21 +46,15 @@ struct clk_pllv3 {
 
 #define to_clk_pllv3(_hw) container_of(_hw, struct clk_pllv3, hw)
 
-static int clk_pllv3_prepare(struct clk_hw *hw)
+static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 {
-	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	unsigned long timeout;
-	u32 val;
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	u32 val = readl_relaxed(pll->base) & BM_PLL_POWER;
 
-	val = readl_relaxed(pll->base);
-	val &= ~BM_PLL_BYPASS;
-	if (pll->powerup_set)
-		val |= BM_PLL_POWER;
-	else
-		val &= ~BM_PLL_POWER;
-	writel_relaxed(val, pll->base);
+	/* No need to wait for lock when pll is not powered up */
+	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
+		return 0;
 
-	timeout = jiffies + msecs_to_jiffies(10);
 	/* Wait for PLL to lock */
 	do {
 		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
@@ -70,10 +64,23 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 		usleep_range(50, 500);
 	} while (1);
 
-	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
-		return 0;
+	return readl_relaxed(pll->base) & BM_PLL_LOCK ? 0 : -ETIMEDOUT;
+}
+
+static int clk_pllv3_prepare(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val &= ~BM_PLL_BYPASS;
+	if (pll->powerup_set)
+		val |= BM_PLL_POWER;
 	else
-		return -ETIMEDOUT;
+		val &= ~BM_PLL_POWER;
+	writel_relaxed(val, pll->base);
+
+	return clk_pllv3_wait_lock(pll);
 }
 
 static void clk_pllv3_unprepare(struct clk_hw *hw)
@@ -148,7 +155,7 @@ static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate,
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return 0;
+	return clk_pllv3_wait_lock(pll);
 }
 
 static const struct clk_ops clk_pllv3_ops = {
@@ -204,7 +211,7 @@ static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate,
 	val |= div;
 	writel_relaxed(val, pll->base);
 
-	return 0;
+	return clk_pllv3_wait_lock(pll);
 }
 
 static const struct clk_ops clk_pllv3_sys_ops = {
@@ -278,7 +285,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
 	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
 
-	return 0;
+	return clk_pllv3_wait_lock(pll);
 }
 
 static const struct clk_ops clk_pllv3_av_ops = {
-- 
1.7.9.5
