From: voytikd@gmail.com (Dmitry Voytik)
Date: Thu,  6 Nov 2014 22:49:32 +0400
Subject: [PATCH] ARM: imx: simplify clk_pllv3_prepare()
Message-ID: <1415299772-21079-1-git-send-email-voytikd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ret variable is redundant. Call clk_pllv3_wait_lock() in the end
return.

Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
---
 arch/arm/mach-imx/clk-pllv3.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 57de74d..0ad6e54 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -69,7 +69,6 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 	u32 val;
-	int ret;
 
 	val = readl_relaxed(pll->base);
 	if (pll->powerup_set)
@@ -78,11 +77,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 		val &= ~BM_PLL_POWER;
 	writel_relaxed(val, pll->base);
 
-	ret = clk_pllv3_wait_lock(pll);
-	if (ret)
-		return ret;
-
-	return 0;
+	return clk_pllv3_wait_lock(pll);
 }
 
 static void clk_pllv3_unprepare(struct clk_hw *hw)
-- 
1.9.1
