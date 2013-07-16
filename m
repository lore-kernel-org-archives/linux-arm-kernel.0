From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 16 Jul 2013 10:23:20 +0800
Subject: [PATCH v2 1/1] ARM: imx: clk-pllv3: improve the timeout waiting method
Message-ID: <1373941400-32274-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two improvements for this commit:

- Add comparing pll lock condition after while loop. It can
fix potential fake timeout problem caused by the code is just
scheduled out before compare the timeout, and the time of
scheduling out are more than one jiffies.

- Move timeout assignment more close to compare the timeout.
It can reduce the possibility the code is scheduled out, and
the timeout can be more precise.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---

Changes for v2:
- Add more description for this improvement according to
Fabio's suggstion.
- Add comparsion after while loop according to Sascha's
suggestion.

 arch/arm/mach-imx/clk-pllv3.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index 36aac94..4499db5 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -50,7 +50,7 @@ struct clk_pllv3 {
 static int clk_pllv3_prepare(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
-	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	unsigned long timeout;
 	u32 val;
 
 	val = readl_relaxed(pll->base);
@@ -61,12 +61,19 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 		val &= ~BM_PLL_POWER;
 	writel_relaxed(val, pll->base);
 
+	timeout = jiffies + msecs_to_jiffies(10);
 	/* Wait for PLL to lock */
-	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
+	do {
+		if (readl_relaxed(pll->base) & BM_PLL_LOCK)
+			break;
 		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
+			break;
+	} while (1);
 
-	return 0;
+	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
+		return 0;
+	else
+		return -ETIMEDOUT;
 }
 
 static void clk_pllv3_unprepare(struct clk_hw *hw)
-- 
1.7.0.4
