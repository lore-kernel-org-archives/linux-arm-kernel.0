From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 6 Jun 2013 14:55:26 +0800
Subject: [PATCH 1/1] ARM: imx: clk-pllv3: change wait method for PLL lock
Message-ID: <1370501726-7421-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For tickless system, the jiffies may be updated long time (>20ms).
At high loading system, the current waiting method will cause waiting
timeout, and cause a kernel dump at below case.
After timeout = jiffies + msecs_to_jiffies(10),
the timer interrupt occurs, it updates jiffies (eg,  + 2 jiffies),
then return back from interrupt, the time between above operations
are tiny, the PLL is still not locked, but the timeout condition is satisfied.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/clk-pllv3.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 36aac94..eefc6c2 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 #include "clk.h"
 
 #define PLL_NUM_OFFSET		0x10
@@ -50,7 +51,7 @@ struct clk_pllv3 {
 static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	int count = 100;
 	u32 val;
 
 	val = readl_relaxed(pll->base);
@@ -62,9 +63,11 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 	writel_relaxed(val, pll->base);
 
 	/* Wait for PLL to lock */
-	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
-		if (time_after(jiffies, timeout))
+	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK)) {
+		udelay(100);
+		if (--count == 0)
 			return -ETIMEDOUT;
+	}
 
 	return 0;
 }
-- 
1.7.0.4
