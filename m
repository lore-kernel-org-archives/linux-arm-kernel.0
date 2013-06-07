From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 7 Jun 2013 16:19:06 +0800
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: change wait method for PLL lock
Message-ID: <1370593146-14025-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some unknown reasons, the jiffies will be updated more
than one tick at every short time. Eg, at this code:
After timeout = jiffies + msecs_to_jiffies(10),
the interrupt occurs, and the softirq updates jiffies (eg,  + 2 jiffies),
then return back from interrupt, the time between above operations
are tiny, the PLL is still not locked, but the timeout condition is satisfied.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
Changes for v2:
- According to Russell King's suggestion, change code for more reasonable
for timeout condition.
- Change commit log.

 arch/arm/mach-imx/clk-pllv3.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index d09bc3d..52e54df 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
+#include <linux/delay.h>
 #include "clk.h"
 
 #define PLL_NUM_OFFSET		0x10
@@ -48,7 +49,7 @@ struct clk_pllv3 {
 static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	int count = 100;
 	u32 val;
 
 	val = readl_relaxed(pll->base);
@@ -60,9 +61,14 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 	writel_relaxed(val, pll->base);
 
 	/* Wait for PLL to lock */
-	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
+	do {
+		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
+			break;
+		udelay(100);
+	} while (count--);
+
+	if (count == 0 && !(readl_relaxed(pll->base) & BM_PLL_LOCK))
+		return -ETIMEDOUT;
 
 	return 0;
 }
-- 
1.7.0.4
