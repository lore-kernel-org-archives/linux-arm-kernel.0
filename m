From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Apr 2012 17:28:11 +0200
Subject: [PATCH 21/33] ARM i.MX: Add common clock support for pllv2
In-Reply-To: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1335367703-19929-22-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This PLL is found on i.MX51 and i.MX53

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/Makefile    |    2 +-
 arch/arm/mach-imx/clk-pllv2.c |  239 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h       |    3 +
 3 files changed, 243 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-pllv2.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 7e71b39..0c0e5c4 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
-obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/clk-pllv2.c b/arch/arm/mach-imx/clk-pllv2.c
new file mode 100644
index 0000000..179c34f
--- /dev/null
+++ b/arch/arm/mach-imx/clk-pllv2.c
@@ -0,0 +1,239 @@
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <asm/div64.h>
+
+#include "clk.h"
+
+#define to_clk_pllv2(clk) (container_of(clk, struct clk_pllv2, clk))
+
+/* PLL Register Offsets */
+#define MXC_PLL_DP_CTL			0x00
+#define MXC_PLL_DP_CONFIG		0x04
+#define MXC_PLL_DP_OP			0x08
+#define MXC_PLL_DP_MFD			0x0C
+#define MXC_PLL_DP_MFN			0x10
+#define MXC_PLL_DP_MFNMINUS		0x14
+#define MXC_PLL_DP_MFNPLUS		0x18
+#define MXC_PLL_DP_HFS_OP		0x1C
+#define MXC_PLL_DP_HFS_MFD		0x20
+#define MXC_PLL_DP_HFS_MFN		0x24
+#define MXC_PLL_DP_MFN_TOGC		0x28
+#define MXC_PLL_DP_DESTAT		0x2c
+
+/* PLL Register Bit definitions */
+#define MXC_PLL_DP_CTL_MUL_CTRL		0x2000
+#define MXC_PLL_DP_CTL_DPDCK0_2_EN	0x1000
+#define MXC_PLL_DP_CTL_DPDCK0_2_OFFSET	12
+#define MXC_PLL_DP_CTL_ADE		0x800
+#define MXC_PLL_DP_CTL_REF_CLK_DIV	0x400
+#define MXC_PLL_DP_CTL_REF_CLK_SEL_MASK	(3 << 8)
+#define MXC_PLL_DP_CTL_REF_CLK_SEL_OFFSET	8
+#define MXC_PLL_DP_CTL_HFSM		0x80
+#define MXC_PLL_DP_CTL_PRE		0x40
+#define MXC_PLL_DP_CTL_UPEN		0x20
+#define MXC_PLL_DP_CTL_RST		0x10
+#define MXC_PLL_DP_CTL_RCP		0x8
+#define MXC_PLL_DP_CTL_PLM		0x4
+#define MXC_PLL_DP_CTL_BRM0		0x2
+#define MXC_PLL_DP_CTL_LRF		0x1
+
+#define MXC_PLL_DP_CONFIG_BIST		0x8
+#define MXC_PLL_DP_CONFIG_SJC_CE	0x4
+#define MXC_PLL_DP_CONFIG_AREN		0x2
+#define MXC_PLL_DP_CONFIG_LDREQ		0x1
+
+#define MXC_PLL_DP_OP_MFI_OFFSET	4
+#define MXC_PLL_DP_OP_MFI_MASK		(0xF << 4)
+#define MXC_PLL_DP_OP_PDF_OFFSET	0
+#define MXC_PLL_DP_OP_PDF_MASK		0xF
+
+#define MXC_PLL_DP_MFD_OFFSET		0
+#define MXC_PLL_DP_MFD_MASK		0x07FFFFFF
+
+#define MXC_PLL_DP_MFN_OFFSET		0x0
+#define MXC_PLL_DP_MFN_MASK		0x07FFFFFF
+
+#define MXC_PLL_DP_MFN_TOGC_TOG_DIS	(1 << 17)
+#define MXC_PLL_DP_MFN_TOGC_TOG_EN	(1 << 16)
+#define MXC_PLL_DP_MFN_TOGC_CNT_OFFSET	0x0
+#define MXC_PLL_DP_MFN_TOGC_CNT_MASK	0xFFFF
+
+#define MXC_PLL_DP_DESTAT_TOG_SEL	(1 << 31)
+#define MXC_PLL_DP_DESTAT_MFN		0x07FFFFFF
+
+#define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
+
+struct clk_pllv2 {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+static unsigned long clk_pllv2_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
+	unsigned long dp_op, dp_mfd, dp_mfn, dp_ctl, pll_hfsm, dbl;
+	void __iomem *pllbase;
+	s64 temp;
+	struct clk_pllv2 *pll = to_clk_pllv2(hw);
+
+	pllbase = pll->base;
+
+	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
+	pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
+	dbl = dp_ctl & MXC_PLL_DP_CTL_DPDCK0_2_EN;
+
+	if (pll_hfsm == 0) {
+		dp_op = __raw_readl(pllbase + MXC_PLL_DP_OP);
+		dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_MFD);
+		dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_MFN);
+	} else {
+		dp_op = __raw_readl(pllbase + MXC_PLL_DP_HFS_OP);
+		dp_mfd = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFD);
+		dp_mfn = __raw_readl(pllbase + MXC_PLL_DP_HFS_MFN);
+	}
+	pdf = dp_op & MXC_PLL_DP_OP_PDF_MASK;
+	mfi = (dp_op & MXC_PLL_DP_OP_MFI_MASK) >> MXC_PLL_DP_OP_MFI_OFFSET;
+	mfi = (mfi <= 5) ? 5 : mfi;
+	mfd = dp_mfd & MXC_PLL_DP_MFD_MASK;
+	mfn = mfn_abs = dp_mfn & MXC_PLL_DP_MFN_MASK;
+	/* Sign extend to 32-bits */
+	if (mfn >= 0x04000000) {
+		mfn |= 0xFC000000;
+		mfn_abs = -mfn;
+	}
+
+	ref_clk = 2 * parent_rate;
+	if (dbl != 0)
+		ref_clk *= 2;
+
+	ref_clk /= (pdf + 1);
+	temp = (u64) ref_clk * mfn_abs;
+	do_div(temp, mfd + 1);
+	if (mfn < 0)
+		temp = -temp;
+	temp = (ref_clk * mfi) + temp;
+
+	return temp;
+}
+
+static int clk_pllv2_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_pllv2 *pll = to_clk_pllv2(hw);
+	u32 reg;
+	void __iomem *pllbase;
+	long mfi, pdf, mfn, mfd = 999999;
+	s64 temp64;
+	unsigned long quad_parent_rate;
+	unsigned long pll_hfsm, dp_ctl;
+
+	pllbase = pll->base;
+
+	quad_parent_rate = 4 * parent_rate;
+	pdf = mfi = -1;
+	while (++pdf < 16 && mfi < 5)
+		mfi = rate * (pdf+1) / quad_parent_rate;
+	if (mfi > 15)
+		return -EINVAL;
+	pdf--;
+
+	temp64 = rate * (pdf+1) - quad_parent_rate * mfi;
+	do_div(temp64, quad_parent_rate/1000000);
+	mfn = (long)temp64;
+
+	dp_ctl = __raw_readl(pllbase + MXC_PLL_DP_CTL);
+	/* use dpdck0_2 */
+	__raw_writel(dp_ctl | 0x1000L, pllbase + MXC_PLL_DP_CTL);
+	pll_hfsm = dp_ctl & MXC_PLL_DP_CTL_HFSM;
+	if (pll_hfsm == 0) {
+		reg = mfi << 4 | pdf;
+		__raw_writel(reg, pllbase + MXC_PLL_DP_OP);
+		__raw_writel(mfd, pllbase + MXC_PLL_DP_MFD);
+		__raw_writel(mfn, pllbase + MXC_PLL_DP_MFN);
+	} else {
+		reg = mfi << 4 | pdf;
+		__raw_writel(reg, pllbase + MXC_PLL_DP_HFS_OP);
+		__raw_writel(mfd, pllbase + MXC_PLL_DP_HFS_MFD);
+		__raw_writel(mfn, pllbase + MXC_PLL_DP_HFS_MFN);
+	}
+
+	return 0;
+}
+
+static long clk_pllv2_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *prate)
+{
+	return rate;
+}
+
+static int clk_pllv2_prepare(struct clk_hw *hw)
+{
+	struct clk_pllv2 *pll = to_clk_pllv2(hw);
+	u32 reg;
+	void __iomem *pllbase;
+	int i = 0;
+
+	pllbase = pll->base;
+	reg = __raw_readl(pllbase + MXC_PLL_DP_CTL) | MXC_PLL_DP_CTL_UPEN;
+	__raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
+
+	/* Wait for lock */
+	do {
+		reg = __raw_readl(pllbase + MXC_PLL_DP_CTL);
+		if (reg & MXC_PLL_DP_CTL_LRF)
+			break;
+
+		udelay(1);
+	} while (++i < MAX_DPLL_WAIT_TRIES);
+
+	if (i == MAX_DPLL_WAIT_TRIES) {
+		pr_err("MX5: pll locking failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void clk_pllv2_unprepare(struct clk_hw *hw)
+{
+	struct clk_pllv2 *pll = to_clk_pllv2(hw);
+	u32 reg;
+	void __iomem *pllbase;
+
+	pllbase = pll->base;
+	reg = __raw_readl(pllbase + MXC_PLL_DP_CTL) & ~MXC_PLL_DP_CTL_UPEN;
+	__raw_writel(reg, pllbase + MXC_PLL_DP_CTL);
+}
+
+struct clk_ops clk_pllv2_ops = {
+	.prepare = clk_pllv2_prepare,
+	.unprepare = clk_pllv2_unprepare,
+	.recalc_rate = clk_pllv2_recalc_rate,
+	.round_rate = clk_pllv2_round_rate,
+	.set_rate = clk_pllv2_set_rate,
+};
+
+struct clk *imx_clk_pllv2(const char *name, const char *parent,
+		void __iomem *base)
+{
+	struct clk_pllv2 *pll;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return NULL;
+
+	pll->base = base;
+
+	clk = clk_register(NULL, name, &clk_pllv2_ops, &pll->hw, &parent, 1, 0);
+	if (!clk)
+		kfree(pll);
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 8a4aee6..7f5da75 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -8,6 +8,9 @@
 struct clk *imx_clk_pllv1(const char *name, const char *parent,
 		void __iomem *base);
 
+struct clk *imx_clk_pllv2(const char *name, const char *parent,
+		void __iomem *base);
+
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
-- 
1.7.10
