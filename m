From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  4 Jun 2012 15:27:45 +0200
Subject: [PATCH 2/3] ARM i.MX pllv2: make round_rate accurate
In-Reply-To: <1338816466-2365-1-git-send-email-s.hauer@pengutronix.de>
References: <1338816466-2365-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338816466-2365-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

in round_rate we made the assumption that we can set arbitrary
frequencies and thus returned the input rate. This is not correct,
for certain frequencies after setting a frequency with set_rate,
recalc_rate will return different values. To fix this, introduce
set_rate/recalc_rate functions which work on variables instead
of registers directly. This way we can call these in round_rate
to get the exact rate which we would get if we call set_rate
with this value.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-pllv2.c |   78 ++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv2.c
index 1b03071..0440379 100644
--- a/arch/arm/mach-imx/clk-pllv2.c
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -74,24 +74,15 @@ struct clk_pllv2 {
 	void __iomem	*base;
 };
 
-static unsigned long clk_pllv2_recalc_rate(struct clk_hw *hw,
-		unsigned long parent_rate)
+static unsigned long __clk_pllv2_recalc_rate(unsigned long parent_rate,
+		u32 dp_ctl, u32 dp_op, u32 dp_mfd, u32 dp_mfn)
 {
 	long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
-	unsigned long dp_op, dp_mfd, dp_mfn, dp_ctl, dbl;
-	void __iomem *pllbase;
+	unsigned long dbl;
 	s64 temp;
-	struct clk_pllv2 *pll = to_clk_pllv2(hw);
-
-	pllbase = pll->base;
 
-	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
 	dbl = dp_ctl & MXC_PLL_DP_CTL_DPDCK0_2_EN;
 
-	dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
-	dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
-	dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
-
 	pdf = dp_op & MXC_PLL_DP_OP_PDF_MASK;
 	mfi = (dp_op & MXC_PLL_DP_OP_MFI_MASK) >> MXC_PLL_DP_OP_MFI_OFFSET;
 	mfi = (mfi <= 5) ? 5 : mfi;
@@ -117,18 +108,30 @@ static unsigned long clk_pllv2_recalc_rate(struct clk_hw *hw,
 	return temp;
 }
 
-static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
+static unsigned long clk_pllv2_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
+	u32 dp_op, dp_mfd, dp_mfn, dp_ctl;
+	void __iomem *pllbase;
 	struct clk_pllv2 *pll = to_clk_pllv2(hw);
+
+	pllbase = pll->base;
+
+	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
+	dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
+	dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
+	dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
+
+	return __clk_pllv2_recalc_rate(parent_rate, dp_ctl, dp_op, dp_mfd, dp_mfn);
+}
+
+static int __clk_pllv2_set_rate(unsigned long rate, unsigned long parent_rate,
+		u32 *dp_op, u32 *dp_mfd, u32 *dp_mfn)
+{
 	u32 reg;
-	void __iomem *pllbase;
 	long mfi, pdf, mfn, mfd = 999999;
 	s64 temp64;
 	unsigned long quad_parent_rate;
-	unsigned long dp_ctl;
-
-	pllbase = pll->base;
 
 	quad_parent_rate = 4 * parent_rate;
 	pdf = mfi = -1;
@@ -138,18 +141,41 @@ static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 	pdf--;
 
-	temp64 = rate * (pdf+1) - quad_parent_rate * mfi;
-	do_div(temp64, quad_parent_rate/1000000);
+	temp64 = rate * (pdf + 1) - quad_parent_rate * mfi;
+	do_div(temp64, quad_parent_rate / 1000000);
 	mfn = (long)temp64;
 
+	reg = mfi << 4 | pdf;
+
+	*dp_op = reg;
+	*dp_mfd = mfd;
+	*dp_mfn = mfn;
+
+	return 0;
+}
+
+static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_pllv2 *pll = to_clk_pllv2(hw);
+	void __iomem *pllbase;
+	u32 dp_ctl, dp_op, dp_mfd, dp_mfn;
+	int ret;
+
+	pllbase = pll->base;
+
+
+	ret = __clk_pllv2_set_rate(rate, parent_rate, &dp_op, &dp_mfd, &dp_mfn);
+	if (ret)
+		return ret;
+
 	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
 	/* use dpdck0_2 */
 	__raw_writel(dp_ctl | 0x1000L, pllbase + MXC_PLL_DP_CTL);
 
-	reg = mfi << 4 | pdf;
-	__raw_writel(reg, pllbase + MXC_PLL_DP_OP);
-	__raw_writel(mfd, pllbase + MXC_PLL_DP_MFD);
-	__raw_writel(mfn, pllbase + MXC_PLL_DP_MFN);
+	__raw_writel(dp_op, pllbase + MXC_PLL_DP_OP);
+	__raw_writel(dp_mfd, pllbase + MXC_PLL_DP_MFD);
+	__raw_writel(dp_mfn, pllbase + MXC_PLL_DP_MFN);
 
 	return 0;
 }
@@ -157,7 +183,11 @@ static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
 static long clk_pllv2_round_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long *prate)
 {
-	return rate;
+	u32 dp_op, dp_mfd, dp_mfn;
+
+	__clk_pllv2_set_rate(rate, *prate, &dp_op, &dp_mfd, &dp_mfn);
+	return __clk_pllv2_recalc_rate(*prate, MXC_PLL_DP_CTL_DPDCK0_2_EN,
+			dp_op, dp_mfd, dp_mfn);
 }
 
 static int clk_pllv2_prepare(struct clk_hw *hw)
-- 
1.7.10
