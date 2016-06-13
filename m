From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Mon, 13 Jun 2016 20:24:52 +0800
Subject: [PATCH V3 1/1] clk: imx: refine the powerdown bit of clk-pllv3
In-Reply-To: <1465803434-31507-1-git-send-email-aisheng.dong@nxp.com>
References: <1465803434-31507-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1465820692-20055-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The powerdown bit is a bit confused, let's change it to power_bit
to relfect both powerdown and powerup case according to different
plls.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes from v2:
Sorry for sending the patch too quickly.
There's a rebase error in V2, fixed it.
---
 drivers/clk/imx/clk-pllv3.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index eea2b1b3791e..19f9b622981a 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -29,8 +29,8 @@
  * struct clk_pllv3 - IMX PLL clock version 3
  * @clk_hw:	 clock source
  * @base:	 base address of PLL registers
- * @powerup_set: set POWER bit to power up the PLL
- * @powerdown:   pll powerdown offset bit
+ * @power_bit:	 pll power bit mask
+ * @powerup_set: set power_bit to power up the PLL
  * @div_mask:	 mask of divider bits
  * @div_shift:	 shift of divider bits
  *
@@ -40,8 +40,8 @@
 struct clk_pllv3 {
 	struct clk_hw	hw;
 	void __iomem	*base;
+	u32		power_bit;
 	bool		powerup_set;
-	u32		powerdown;
 	u32		div_mask;
 	u32		div_shift;
 	unsigned long	ref_clock;
@@ -52,7 +52,7 @@ struct clk_pllv3 {
 static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(10);
-	u32 val = readl_relaxed(pll->base) & pll->powerdown;
+	u32 val = readl_relaxed(pll->base) & pll->power_bit;
 
 	/* No need to wait for lock when pll is not powered up */
 	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
@@ -77,9 +77,9 @@ static int clk_pllv3_prepare(struct clk_hw *hw)
 
 	val = readl_relaxed(pll->base);
 	if (pll->powerup_set)
-		val |= pll->powerdown;
+		val |= pll->power_bit;
 	else
-		val &= ~pll->powerdown;
+		val &= ~pll->power_bit;
 	writel_relaxed(val, pll->base);
 
 	return clk_pllv3_wait_lock(pll);
@@ -92,9 +92,9 @@ static void clk_pllv3_unprepare(struct clk_hw *hw)
 
 	val = readl_relaxed(pll->base);
 	if (pll->powerup_set)
-		val &= ~pll->powerdown;
+		val &= ~pll->power_bit;
 	else
-		val |= pll->powerdown;
+		val |= pll->power_bit;
 	writel_relaxed(val, pll->base);
 }
 
@@ -316,7 +316,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	pll->powerdown = BM_PLL_POWER;
+	pll->power_bit = BM_PLL_POWER;
 
 	switch (type) {
 	case IMX_PLLV3_SYS:
@@ -332,7 +332,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		ops = &clk_pllv3_av_ops;
 		break;
 	case IMX_PLLV3_ENET_IMX7:
-		pll->powerdown = IMX7_ENET_PLL_POWER;
+		pll->power_bit = IMX7_ENET_PLL_POWER;
 		pll->ref_clock = 1000000000;
 		ops = &clk_pllv3_enet_ops;
 		break;
-- 
1.9.1
