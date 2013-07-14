From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 14 Jul 2013 08:58:48 +0800
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: move the timeout just before the
 comparison
Message-ID: <1373763528-20792-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can let the timeout value be more precise.

Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/clk-pllv3.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index a9fad5f..e2c026f 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -48,7 +48,7 @@ struct clk_pllv3 {
 static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	unsigned long timeout;
 	u32 val;
 
 	val = readl_relaxed(pll->base);
@@ -59,6 +59,7 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 		val &= ~BM_PLL_POWER;
 	writel_relaxed(val, pll->base);
 
+	timeout = jiffies + msecs_to_jiffies(10);
 	/* Wait for PLL to lock */
 	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
 		if (time_after(jiffies, timeout))
-- 
1.7.0.4
