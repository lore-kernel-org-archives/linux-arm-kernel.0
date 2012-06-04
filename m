From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  4 Jun 2012 15:27:44 +0200
Subject: [PATCH 1/3] ARM i.MX pllv2: use standard register set unconditionally
Message-ID: <1338816466-2365-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX5 PLL has two different register sets for setting the
rate. One is used for the standard case and and is used for
DVFS. Which one of them is used depends on a hardware input
of the PLL. Current implementation reads back from the hardware
which setting is used. This is bogus: If we ever want to implement
DVFS we have to program both register sets and not only the one
which happens to be used at the moment. For now, just use the
standard register set uncondionally.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-pllv2.c |   35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv2.c
index 4685919..1b03071 100644
--- a/arch/arm/mach-imx/clk-pllv2.c
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -78,7 +78,7 @@ static unsigned long clk_pllv2_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
 	long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
-	unsigned long dp_op, dp_mfd, dp_mfn, dp_ctl, pll_hfsm, dbl;
+	unsigned long dp_op, dp_mfd, dp_mfn, dp_ctl, dbl;
 	void __iomem *pllbase;
 	s64 temp;
 	struct clk_pllv2 *pll = to_clk_pllv2(hw);
@@ -86,18 +86,12 @@ static unsigned long clk_pllv2_recalc_rate(struct clk_hw *hw,
 	pllbase = pll->base;
 
 	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
-	pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
 	dbl = dp_ctl & MXC_PLL_DP_CTL_DPDCK0_2_EN;
 
-	if (pll_hfsm == 0) {
-		dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
-		dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
-		dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
-	} else {
-		dp_op = __raw_readl(pllbase + MXC_PLL_DP_HFS_OP);
-		dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFD);
-		dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFN);
-	}
+	dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
+	dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
+	dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
+
 	pdf = dp_op & MXC_PLL_DP_OP_PDF_MASK;
 	mfi = (dp_op & MXC_PLL_DP_OP_MFI_MASK) >> MXC_PLL_DP_OP_MFI_OFFSET;
 	mfi = (mfi <= 5) ? 5 : mfi;
@@ -132,7 +126,7 @@ static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
 	long mfi, pdf, mfn, mfd = 999999;
 	s64 temp64;
 	unsigned long quad_parent_rate;
-	unsigned long pll_hfsm, dp_ctl;
+	unsigned long dp_ctl;
 
 	pllbase = pll->base;
 
@@ -151,18 +145,11 @@ static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
 	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
 	/* use dpdck0_2 */
 	__raw_writel(dp_ctl | 0x1000L, pllbase + MXC_PLL_DP_CTL);
-	pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
-	if (pll_hfsm == 0) {
-		reg = mfi << 4 | pdf;
-		__raw_writel(reg, pllbase + MXC_PLL_DP_OP);
-		__raw_writel(mfd, pllbase + MXC_PLL_DP_MFD);
-		__raw_writel(mfn, pllbase + MXC_PLL_DP_MFN);
-	} else {
-		reg = mfi << 4 | pdf;
-		__raw_writel(reg, pllbase + MXC_PLL_DP_HFS_OP);
-		__raw_writel(mfd, pllbase + MXC_PLL_DP_HFS_MFD);
-		__raw_writel(mfn, pllbase + MXC_PLL_DP_HFS_MFN);
-	}
+
+	reg = mfi << 4 | pdf;
+	__raw_writel(reg, pllbase + MXC_PLL_DP_OP);
+	__raw_writel(mfd, pllbase + MXC_PLL_DP_MFD);
+	__raw_writel(mfn, pllbase + MXC_PLL_DP_MFN);
 
 	return 0;
 }
-- 
1.7.10
