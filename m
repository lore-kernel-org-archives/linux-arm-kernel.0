From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 20 Jul 2013 12:29:35 +0400
Subject: [RFC v2] ARM: i.MX pllv1: Implement set_rate
Message-ID: <1374308975-20596-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements frequency change for i.MX pllv1.
Selection of the values of the registers is not optimal, since is
made by simple enumeration of all possible values.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/clk-imx27.c |   2 +-
 arch/arm/mach-imx/clk-pllv1.c | 118 +++++++++++++++++++++++++++++++++++-------
 arch/arm/mach-imx/mx27.h      |   7 ++-
 3 files changed, 106 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index c3cfa41..2b363d9 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -125,7 +125,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk[vpu_sel] = imx_clk_mux("vpu_sel", CCM_CSCR, 21, 1, vpu_sel_clks, ARRAY_SIZE(vpu_sel_clks));
 	clk[vpu_div] = imx_clk_divider("vpu_div", "vpu_sel", CCM_PCDR0, 10, 6);
 	clk[usb_div] = imx_clk_divider("usb_div", "spll_gate", CCM_CSCR, 28, 3);
-	clk[cpu_sel] = imx_clk_mux("cpu_sel", CCM_CSCR, 15, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks));
+	clk[cpu_sel] = imx_clk_mux_flags("cpu_sel", CCM_CSCR, 15, 1, cpu_sel_clks, ARRAY_SIZE(cpu_sel_clks), CLK_SET_RATE_PARENT);
 	clk[clko_sel] = imx_clk_mux("clko_sel", CCM_CCSR, 0, 5, clko_sel_clks, ARRAY_SIZE(clko_sel_clks));
 	if (mx27_revision() >= IMX_CHIP_REVISION_2_0)
 		clk[cpu_div] = imx_clk_divider("cpu_div", "cpu_sel", CCM_CSCR, 12, 2);
diff --git a/arch/arm/mach-imx/clk-pllv1.c b/arch/arm/mach-imx/clk-pllv1.c
index c1eaee3..722fea2 100644
--- a/arch/arm/mach-imx/clk-pllv1.c
+++ b/arch/arm/mach-imx/clk-pllv1.c
@@ -9,6 +9,8 @@
 #include "common.h"
 #include "hardware.h"
 
+#include "mx27.h"
+
 /**
  * pll v1
  *
@@ -25,17 +27,13 @@ struct clk_pllv1 {
 
 #define to_clk_pllv1(clk) (container_of(clk, struct clk_pllv1, clk))
 
-static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
-		unsigned long parent_rate)
+static unsigned long _clk_pllv1_recalc_rate(unsigned int mfi, unsigned int mfn,
+					    unsigned int mfd, unsigned int pd,
+					    unsigned long parent_rate)
 {
-	struct clk_pllv1 *pll = to_clk_pllv1(hw);
-	long long ll;
-	int mfn_abs;
-	unsigned int mfi, mfn, mfd, pd;
-	u32 reg;
 	unsigned long rate;
-
-	reg = readl(pll->base);
+	int mfn_abs = mfn;
+	long long ll;
 
 	/*
 	 * Get the resulting clock rate from a PLL register value and the input
@@ -47,15 +45,6 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 	 *                        pd + 1
 	 */
 
-	mfi = (reg >> 10) & 0xf;
-	mfn = reg & 0x3ff;
-	mfd = (reg >> 16) & 0x3ff;
-	pd =  (reg >> 26) & 0xf;
-
-	mfi = mfi <= 5 ? 5 : mfi;
-
-	mfn_abs = mfn;
-
 	/*
 	 * On all i.MXs except i.MX1 and i.MX21 mfn is a 10bit
 	 * 2's complements number
@@ -78,8 +67,99 @@ static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
 	return ll;
 }
 
+static unsigned long clk_pllv1_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct clk_pllv1 *pll = to_clk_pllv1(hw);
+	unsigned int mfi, mfn, mfd, pd;
+	u32 reg = readl(pll->base);
+
+	/* Avoid i.MX27 TO2 SPCTL0 bug */
+	if (cpu_is_mx27() && (mx27_revision() == IMX_CHIP_REVISION_2_0))
+		writel(reg, pll->base);
+
+	mfi = (reg >> 10) & 0xf;
+	mfn = reg & 0x3ff;
+	mfd = (reg >> 16) & 0x3ff;
+	pd =  (reg >> 26) & 0xf;
+
+	mfi = mfi <= 5 ? 5 : mfi;
+
+	return _clk_pllv1_recalc_rate(mfi, mfn, mfd, pd, parent_rate);
+}
+
+static void _clk_pllv1_set_rate(unsigned long rate, unsigned long parent_rate,
+				unsigned int *reg)
+{
+	unsigned int pd, mfi, mfn, mfd, mfn_offs = 0;
+	long tmp, res, best = 0;
+
+	pd = (parent_rate * 2 * 5) / rate;
+	if (pd > 15)
+		pd = 15;
+	mfi = rate / (parent_rate * 2 * (pd + 1));
+	if (mfi < 5)
+		mfi = 5;
+	if (mfi < 15) {
+		tmp = parent_rate * 2;
+		tmp /= pd + 1;
+		tmp *= mfi;
+		if (tmp / parent_rate) {
+			mfi++;
+			/* Use negative values */
+			mfn_offs = 0x200;
+		}
+	} else if (mfi > 15)
+		mfi = 15;
+
+	for (mfd = 1; mfd < 0x400; mfd++)
+		for (mfn = 0; (mfn < mfd) && (mfn <= 0x1fe); mfn++) {
+			res = _clk_pllv1_recalc_rate(mfi, mfn_offs + mfn, mfd,
+						     pd, parent_rate);
+			if (!best || (abs(rate - res) < abs(rate - best))) {
+				*reg = mfn_offs + mfn;
+				*reg |= mfi << 10;
+				*reg |= mfd << 16;
+				*reg |= pd << 26;
+				if (res == rate)
+					return;
+				best = res;
+			}
+		}
+}
+
+static int clk_pllv1_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pllv1 *pll = to_clk_pllv1(hw);
+	u32 reg;
+
+	_clk_pllv1_set_rate(rate, parent_rate, &reg);
+	writel(reg, pll->base);
+
+	return 0;
+}
+
+static long clk_pllv1_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	unsigned int pd, mfi, mfn, mfd;
+	u32 reg;
+
+	_clk_pllv1_set_rate(rate, *prate, &reg);
+
+	mfi = (reg >> 10) & 0xf;
+	mfn = reg & 0x3ff;
+	mfd = (reg >> 16) & 0x3ff;
+	pd =  (reg >> 26) & 0xf;
+
+	return _clk_pllv1_recalc_rate(mfi, mfn, mfd, pd, *prate);
+}
+
 static struct clk_ops clk_pllv1_ops = {
-	.recalc_rate = clk_pllv1_recalc_rate,
+	.recalc_rate	= clk_pllv1_recalc_rate,
+	.round_rate	= clk_pllv1_round_rate,
+	.set_rate	= clk_pllv1_set_rate,
 };
 
 struct clk *imx_clk_pllv1(const char *name, const char *parent,
diff --git a/arch/arm/mach-imx/mx27.h b/arch/arm/mach-imx/mx27.h
index 8a65f19..c64632b 100644
--- a/arch/arm/mach-imx/mx27.h
+++ b/arch/arm/mach-imx/mx27.h
@@ -231,8 +231,13 @@
 #define MX27_DMA_REQ_SDHC3	36
 #define MX27_DMA_REQ_NFC	37
 
-#ifndef __ASSEMBLY__
+#ifdef CONFIG_SOC_IMX27
 extern int mx27_revision(void);
+#else
+static int mx27_revision(void)
+{
+	return -1;
+}
 #endif
 
 #endif /* ifndef __MACH_MX27_H__ */
-- 
1.8.1.5
