From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 1 Nov 2013 17:02:25 +0800
Subject: [PATCH 3/3] ARM: imx: set up pllv3 POWER and BYPASS sequentially
In-Reply-To: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
References: <1383296545-18652-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1383296545-18652-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, POWER and BYPASS bits are set up in a single write to pllv3
register.  This causes problem occasionally from the IPU/HDMI testing.
Let's follow FSL BSP code to set up POWER bit, relock, and then BYPASS
sequentially.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-pllv3.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index df17362..6136405 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -71,16 +71,24 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	u32 val;
+	int ret;
 
 	val = readl_relaxed(pll->base);
-	val &= ~BM_PLL_BYPASS;
 	if (pll->powerup_set)
 		val |= BM_PLL_POWER;
 	else
 		val &= ~BM_PLL_POWER;
 	writel_relaxed(val, pll->base);
 
-	return clk_pllv3_wait_lock(pll);
+	ret = clk_pllv3_wait_lock(pll);
+	if (ret)
+		return ret;
+
+	val = readl_relaxed(pll->base);
+	val &= ~BM_PLL_BYPASS;
+	writel_relaxed(val, pll->base);
+
+	return 0;
 }
 
 static void clk_pllv3_unprepare(struct clk_hw *hw)
-- 
1.7.9.5
