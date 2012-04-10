From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Apr 2012 15:45:35 +0200
Subject: [PATCH 22/40] ARM: imx: add common clock support for pllv3
In-Reply-To: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1334065553-7565-23-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

This PLL is found on i.MX6 SoCs

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile    |    2 +-
 arch/arm/mach-imx/clk-pllv3.c |  408 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clk.h       |   13 ++
 3 files changed, 422 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/clk-pllv3.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0c0e5c4..66bc6be 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clock-imx35.o ehci-imx35.o pm-i
 
 obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o mm-imx5.o clock-mx51-mx53.o ehci-imx5.o pm-imx5.o cpu_op-mx51.o
 
-obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o
+obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o
 
 # Support for CMOS sensor interface
 obj-$(CONFIG_MX1_VIDEO) += mx1-camera-fiq.o mx1-camera-fiq-ksym.o
diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
new file mode 100644
index 0000000..6f328f1
--- /dev/null
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -0,0 +1,408 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include "clk.h"
+
+#define PLL_NUM_OFFSET		0x10
+#define PLL_DENOM_OFFSET	0x20
+
+#define BM_PLL_POWER		(0x1 << 12)
+#define BM_PLL_ENABLE		(0x1 << 13)
+#define BM_PLL_BYPASS		(0x1 << 16)
+#define BM_PLL_LOCK		(0x1 << 31)
+
+/**
+ * struct clk_pllv3 - IMX PLL clock version 3
+ * @clk_hw:	 clock source
+ * @base:	 base address of PLL registers
+ * @powerup_set: set POWER bit to power up the PLL
+ * @gate_mask:	 mask of gate bits
+ * @div_mask:	 mask of divider bits
+ *
+ * IMX PLL clock version 3, found on i.MX6 series.  Divider for pllv3
+ * is actually a multiplier, and always sits@bit 0.
+ */
+struct clk_pllv3 {
+	struct clk_hw	hw;
+	void __iomem	*base;
+	bool		powerup_set;
+	u32		gate_mask;
+	u32		div_mask;
+};
+
+#define to_clk_pllv3(_hw) container_of(_hw, struct clk_pllv3, hw)
+
+static int clk_pllv3_prepare(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val &= ~BM_PLL_BYPASS;
+	if (pll->powerup_set)
+		val |= BM_PLL_POWER;
+	else
+		val &= ~BM_PLL_POWER;
+	writel_relaxed(val, pll->base);
+
+	/* Wait for PLL to lock */
+	while (!(readl_relaxed(pll->base) & BM_PLL_LOCK))
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+
+	return 0;
+}
+
+static void clk_pllv3_unprepare(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val |= BM_PLL_BYPASS;
+	if (pll->powerup_set)
+		val &= ~BM_PLL_POWER;
+	else
+		val |= BM_PLL_POWER;
+	writel_relaxed(val, pll->base);
+}
+
+static int clk_pllv3_enable(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val |= pll->gate_mask;
+	writel_relaxed(val, pll->base);
+
+	return 0;
+}
+
+static void clk_pllv3_disable(struct clk_hw *hw)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val &= ~pll->gate_mask;
+	writel_relaxed(val, pll->base);
+}
+
+static unsigned long clk_pllv3_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 div = readl_relaxed(pll->base)  & pll->div_mask;
+
+	return (div == 1) ? parent_rate * 22 : parent_rate * 20;
+}
+
+static long clk_pllv3_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+
+	return (rate >= parent_rate * 22) ? parent_rate * 22 :
+					    parent_rate * 20;
+}
+
+static int clk_pllv3_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	u32 val, div;
+
+	if (rate == parent_rate * 22)
+		div = 1;
+	else if (rate == parent_rate * 20)
+		div = 0;
+	else
+		return -EINVAL;
+
+	val = readl_relaxed(pll->base);
+	val &= ~pll->div_mask;
+	val |= div;
+	writel_relaxed(val, pll->base);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pllv3_ops = {
+	.prepare	= clk_pllv3_prepare,
+	.unprepare	= clk_pllv3_unprepare,
+	.enable		= clk_pllv3_enable,
+	.disable	= clk_pllv3_disable,
+	.recalc_rate	= clk_pllv3_recalc_rate,
+	.round_rate	= clk_pllv3_round_rate,
+	.set_rate	= clk_pllv3_set_rate,
+};
+
+static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 div = readl_relaxed(pll->base) & pll->div_mask;
+
+	return parent_rate * div / 2;
+}
+
+static long clk_pllv3_sys_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *prate)
+{
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	unsigned long min_rate = parent_rate * 54 / 2;
+	unsigned long max_rate = parent_rate * 108 / 2;
+	u32 div;
+
+	if (rate > max_rate)
+		rate = max_rate;
+	else if (rate < min_rate)
+		rate = min_rate;
+	div = rate * 2 / parent_rate;
+
+	return parent_rate * div / 2;
+}
+
+static int clk_pllv3_sys_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	unsigned long min_rate = parent_rate * 54 / 2;
+	unsigned long max_rate = parent_rate * 108 / 2;
+	u32 val, div;
+
+	if (rate < min_rate || rate > max_rate)
+		return -EINVAL;
+
+	div = rate * 2 / parent_rate;
+	val = readl_relaxed(pll->base);
+	val &= ~pll->div_mask;
+	val |= div;
+	writel_relaxed(val, pll->base);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pllv3_sys_ops = {
+	.prepare	= clk_pllv3_prepare,
+	.unprepare	= clk_pllv3_unprepare,
+	.enable		= clk_pllv3_enable,
+	.disable	= clk_pllv3_disable,
+	.recalc_rate	= clk_pllv3_sys_recalc_rate,
+	.round_rate	= clk_pllv3_sys_round_rate,
+	.set_rate	= clk_pllv3_sys_set_rate,
+};
+
+static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 mfn = readl_relaxed(pll->base + PLL_NUM_OFFSET);
+	u32 mfd = readl_relaxed(pll->base + PLL_DENOM_OFFSET);
+	u32 div = readl_relaxed(pll->base) & pll->div_mask;
+
+	return (parent_rate * div) + ((parent_rate / mfd) * mfn);
+}
+
+static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *prate)
+{
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	unsigned long min_rate = parent_rate * 27;
+	unsigned long max_rate = parent_rate * 54;
+	u32 div;
+	u32 mfn, mfd = 1000000;
+	s64 temp64;
+
+	if (rate > max_rate)
+		rate = max_rate;
+	else if (rate < min_rate)
+		rate = min_rate;
+
+	div = rate / parent_rate;
+	temp64 = (u64) (parent_rate - div * parent_rate);
+	temp64 *= mfd;
+	do_div(temp64, parent_rate);
+	mfn = temp64;
+
+	return parent_rate * div + parent_rate / mfd * mfn;
+}
+
+static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
+	unsigned long min_rate = parent_rate * 27;
+	unsigned long max_rate = parent_rate * 54;
+	u32 val, div;
+	u32 mfn, mfd = 1000000;
+	s64 temp64;
+
+	if (rate < min_rate || rate > max_rate)
+		return -EINVAL;
+
+	div = rate / parent_rate;
+	temp64 = (u64) (rate - div * parent_rate);
+	temp64 *= mfd;
+	do_div(temp64, parent_rate);
+	mfn = temp64;
+
+	val = readl_relaxed(pll->base);
+	val &= ~pll->div_mask;
+	val |= div;
+	writel_relaxed(val, pll->base);
+	writel_relaxed(mfn, pll->base + PLL_NUM_OFFSET);
+	writel_relaxed(mfd, pll->base + PLL_DENOM_OFFSET);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pllv3_av_ops = {
+	.prepare	= clk_pllv3_prepare,
+	.unprepare	= clk_pllv3_unprepare,
+	.enable		= clk_pllv3_enable,
+	.disable	= clk_pllv3_disable,
+	.recalc_rate	= clk_pllv3_av_recalc_rate,
+	.round_rate	= clk_pllv3_av_round_rate,
+	.set_rate	= clk_pllv3_av_set_rate,
+};
+
+static unsigned long clk_pllv3_enet_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 div = readl_relaxed(pll->base) & pll->div_mask;
+
+	switch (div) {
+	case 0:
+		return 25000000;
+	case 1:
+		return 50000000;
+	case 2:
+		return 100000000;
+	case 3:
+		return 125000000;
+	}
+
+	return 0;
+}
+
+static long clk_pllv3_enet_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *prate)
+{
+	if (rate >= 125000000)
+		rate = 125000000;
+	else if (rate >= 100000000)
+		rate = 100000000;
+	else if (rate >= 50000000)
+		rate = 50000000;
+	else
+		rate = 25000000;
+	return rate;
+}
+
+static int clk_pllv3_enet_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val, div;
+
+	switch (rate) {
+	case 25000000:
+		div = 0;
+		break;
+	case 50000000:
+		div = 1;
+		break;
+	case 100000000:
+		div = 2;
+		break;
+	case 125000000:
+		div = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = readl_relaxed(pll->base);
+	val &= ~pll->div_mask;
+	val |= div;
+	writel_relaxed(val, pll->base);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pllv3_enet_ops = {
+	.prepare	= clk_pllv3_prepare,
+	.unprepare	= clk_pllv3_unprepare,
+	.enable		= clk_pllv3_enable,
+	.disable	= clk_pllv3_disable,
+	.recalc_rate	= clk_pllv3_enet_recalc_rate,
+	.round_rate	= clk_pllv3_enet_round_rate,
+	.set_rate	= clk_pllv3_enet_set_rate,
+};
+
+static const struct clk_ops clk_pllv3_mlb_ops = {
+	.prepare	= clk_pllv3_prepare,
+	.unprepare	= clk_pllv3_unprepare,
+	.enable		= clk_pllv3_enable,
+	.disable	= clk_pllv3_disable,
+};
+
+struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+			  char *parent_name, void __iomem *base,
+			  u32 gate_mask, u32 div_mask)
+{
+	struct clk_pllv3 *pll;
+	const struct clk_ops *ops;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return NULL;
+
+	switch (type) {
+	case IMX_PLLV3_SYS:
+		ops = &clk_pllv3_sys_ops;
+		break;
+	case IMX_PLLV3_USB:
+		ops = &clk_pllv3_ops;
+		pll->powerup_set = true;
+		break;
+	case IMX_PLLV3_AV:
+		ops = &clk_pllv3_av_ops;
+		break;
+	case IMX_PLLV3_ENET:
+		ops = &clk_pllv3_enet_ops;
+		break;
+	case IMX_PLLV3_MLB:
+		ops = &clk_pllv3_mlb_ops;
+		break;
+	default:
+		ops = &clk_pllv3_ops;
+	}
+	pll->base = base;
+	pll->gate_mask = gate_mask;
+	pll->div_mask = div_mask;
+
+	clk = clk_register(NULL, name, ops, &pll->hw, &parent_name, 1, 0);
+	if (!clk)
+		kfree(pll);
+
+	return clk;
+}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index 7897d5b..96ac3b1 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -5,12 +5,25 @@
 #include <linux/clk-provider.h>
 #include <mach/clock.h>
 
+enum imx_pllv3_type {
+	IMX_PLLV3_GENERIC,
+	IMX_PLLV3_SYS,
+	IMX_PLLV3_USB,
+	IMX_PLLV3_AV,
+	IMX_PLLV3_ENET,
+	IMX_PLLV3_MLB,
+};
+
 struct clk *imx_clk_pllv1(const char *name, char *parent,
 		void __iomem *base);
 
 struct clk *imx_clk_pllv2(const char *name, char *parent,
 		void __iomem *base);
 
+struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
+		char *parent_name, void __iomem *base, u32 gate_mask,
+		u32 div_mask);
+
 static inline struct clk *imx_clk_fixed(const char *name, int rate)
 {
 	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
-- 
1.7.9.5
