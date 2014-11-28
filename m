From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 28 Nov 2014 19:34:47 +0800
Subject: [PATCH 1/4] clk: Add initial common clock support for Mediatek SoC
 MT8135.
In-Reply-To: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1417174490-6845-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common clock support for Mediatek SoCs, and basic clocks
such as PLLs and TOPCKGEN clocks for MT8135.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/Makefile                   |   1 +
 drivers/clk/mediatek/Makefile          |   2 +
 drivers/clk/mediatek/clk-mt8135-pll.c  | 891 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8135-pll.h  |  28 ++
 drivers/clk/mediatek/clk-mt8135.c      | 752 ++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.c         |  93 ++++
 drivers/clk/mediatek/clk-mtk.h         |  47 ++
 drivers/clk/mediatek/clk-pll.c         |  63 +++
 drivers/clk/mediatek/clk-pll.h         |  50 ++
 include/dt-bindings/clock/mt8135-clk.h | 128 +++++
 10 files changed, 2055 insertions(+)
 create mode 100644 drivers/clk/mediatek/Makefile
 create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.c
 create mode 100644 drivers/clk/mediatek/clk-mt8135-pll.h
 create mode 100644 drivers/clk/mediatek/clk-mt8135.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.h
 create mode 100644 drivers/clk/mediatek/clk-pll.c
 create mode 100644 drivers/clk/mediatek/clk-pll.h
 create mode 100644 include/dt-bindings/clock/mt8135-clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..ce6c250 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIX5HD2)		+= hisilicon/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
+obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
new file mode 100644
index 0000000..3c3432b
--- /dev/null
+++ b/drivers/clk/mediatek/Makefile
@@ -0,0 +1,2 @@
+obj-y += clk-mtk.o clk-pll.o
+obj-y += clk-mt8135.o clk-mt8135-pll.o
diff --git a/drivers/clk/mediatek/clk-mt8135-pll.c b/drivers/clk/mediatek/clk-mt8135-pll.c
new file mode 100644
index 0000000..999f640
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8135-pll.c
@@ -0,0 +1,891 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+#include "clk-mt8135-pll.h"
+
+/*
+ * clk_pll
+ */
+
+#define PLL_BASE_EN	BIT(0)
+#define PLL_PWR_ON	BIT(0)
+#define PLL_ISO_EN	BIT(1)
+#define PLL_PCW_CHG	BIT(31)
+#define RST_BAR_MASK	BIT(27)
+#define AUDPLL_TUNER_EN	BIT(31)
+
+#define PLL_PREDIV_H		5
+#define PLL_PREDIV_L		4
+#define PLL_PREDIV_MASK		GENMASK(PLL_PREDIV_H, PLL_PREDIV_L)
+#define PLL_VCODIV_L		19
+#define PLL_VCODIV_MASK		BIT(19)
+
+static const u32 pll_vcodivsel_map[2] = { 1, 2 };
+static const u32 pll_prediv_map[4] = { 1, 2, 4, 4 };
+static const u32 pll_posdiv_map[8] = { 1, 2, 4, 8, 16, 16, 16, 16 };
+static const u32 pll_fbksel_map[4] = { 1, 2, 4, 4 };
+
+static u32 calc_pll_vco_freq(
+		u32 fin,
+		u32 pcw,
+		u32 vcodivsel,
+		u32 prediv,
+		u32 pcwfbits)
+{
+	/* vco = (fin * pcw * vcodivsel / prediv) >> pcwfbits; */
+	u64 vco = fin;
+	u8 c = 0;
+
+	vco = vco * pcw * vcodivsel;
+	do_div(vco, prediv);
+
+	if (vco & GENMASK(pcwfbits - 1, 0))
+		c = 1;
+	vco >>= pcwfbits;
+
+	if (c)
+		vco++;
+
+	return (u32)vco;
+}
+
+static u32 freq_limit(u32 freq)
+{
+	static const u32 freq_max = 2000 * 1000 * 1000;	/* 2000 MHz */
+	static const u32 freq_min = 1000 * 1000 * 1000 / 16;	/* 1000 MHz */
+
+	if (freq <= freq_min)
+		freq = freq_min + 16;
+	else if (freq > freq_max)
+		freq = freq_max;
+
+	return freq;
+}
+
+static int calc_pll_freq_cfg(
+		u32 *pcw,
+		u32 *postdiv_idx,
+		u32 freq,
+		u32 fin,
+		int pcwfbits)
+{
+	static const u64 freq_max = 2000 * 1000 * 1000;	/* 2000 MHz */
+	static const u64 freq_min = 1000 * 1000 * 1000;	/* 1000 MHz */
+	static const u64 postdiv[] = { 1, 2, 4, 8, 16 };
+	u64 n_info;
+	u32 idx;
+
+	pr_debug("freq: %u\n", freq);
+
+	/* search suitable postdiv */
+	for (idx = 0;
+		idx < ARRAY_SIZE(postdiv) && postdiv[idx] * freq <= freq_min;
+		idx++)
+		;
+
+	if (idx >= ARRAY_SIZE(postdiv))
+		return -EINVAL;	/* freq is out of range (too low) */
+	else if (postdiv[idx] * freq > freq_max)
+		return -EINVAL;	/* freq is out of range (too high) */
+
+	/* n_info = freq * postdiv / 26MHz * 2^pcwfbits */
+	n_info = (postdiv[idx] * freq) << pcwfbits;
+	do_div(n_info, fin);
+
+	*postdiv_idx = idx;
+	*pcw = (u32)n_info;
+
+	return 0;
+}
+
+static int clk_pll_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	int r = (readl_relaxed(pll->base_addr) & PLL_BASE_EN) != 0;
+
+	pr_debug("%d: %s\n", r, __clk_get_name(hw->clk));
+
+	return r;
+}
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	pr_debug("%s\n", __clk_get_name(hw->clk));
+
+	mtk_clk_lock(flags);
+
+	r = readl_relaxed(pll->pwr_addr) | PLL_PWR_ON;
+	writel_relaxed(r, pll->pwr_addr);
+	dsb();
+	udelay(1);
+
+	r = readl_relaxed(pll->pwr_addr) & ~PLL_ISO_EN;
+	writel_relaxed(r , pll->pwr_addr);
+	dsb();
+	udelay(1);
+
+	r = readl_relaxed(pll->base_addr) | pll->en_mask;
+	writel_relaxed(r, pll->base_addr);
+	dsb();
+	udelay(20);
+
+	if (pll->flags & HAVE_RST_BAR) {
+		r = readl_relaxed(pll->base_addr) | RST_BAR_MASK;
+		writel_relaxed(r, pll->base_addr);
+	}
+
+	mtk_clk_unlock(flags);
+
+	return 0;
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	pr_debug("%s: PLL_AO: %d\n",
+		__clk_get_name(hw->clk), !!(pll->flags & PLL_AO));
+
+	if (pll->flags & PLL_AO)
+		return;
+
+	mtk_clk_lock(flags);
+
+	if (pll->flags & HAVE_RST_BAR) {
+		r = readl_relaxed(pll->base_addr) & ~RST_BAR_MASK;
+		writel_relaxed(r, pll->base_addr);
+	}
+
+	r = readl_relaxed(pll->base_addr) & ~PLL_BASE_EN;
+	writel_relaxed(r, pll->base_addr);
+
+	r = readl_relaxed(pll->pwr_addr) | PLL_ISO_EN;
+	writel_relaxed(r, pll->pwr_addr);
+
+	r = readl_relaxed(pll->pwr_addr) & ~PLL_PWR_ON;
+	writel_relaxed(r, pll->pwr_addr);
+
+	mtk_clk_unlock(flags);
+}
+
+#define SDM_PLL_POSTDIV_H	8
+#define SDM_PLL_POSTDIV_L	6
+#define SDM_PLL_POSTDIV_MASK	GENMASK(SDM_PLL_POSTDIV_H, SDM_PLL_POSTDIV_L)
+#define SDM_PLL_PCW_H		20
+#define SDM_PLL_PCW_L		0
+#define SDM_PLL_PCW_MASK	GENMASK(SDM_PLL_PCW_H, SDM_PLL_PCW_L)
+
+static unsigned long clk_pll_recalc_rate(
+		struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	u32 con0 = readl_relaxed(pll->base_addr);
+	u32 con1 = readl_relaxed(pll->base_addr + 4);
+
+	u32 vcodivsel = (con0 & PLL_VCODIV_MASK) >> PLL_VCODIV_L;
+	u32 prediv = (con0 & PLL_PREDIV_MASK) >> PLL_PREDIV_L;
+	u32 posdiv = (con0 & SDM_PLL_POSTDIV_MASK) >> SDM_PLL_POSTDIV_L;
+	u32 pcw = (con1 & SDM_PLL_PCW_MASK) >> SDM_PLL_PCW_L;
+	u32 pcwfbits = 14;
+
+	u32 vco_freq;
+	unsigned long r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	vcodivsel = pll_vcodivsel_map[vcodivsel];
+	prediv = pll_prediv_map[prediv];
+
+	vco_freq = calc_pll_vco_freq(
+			parent_rate, pcw, vcodivsel, prediv, pcwfbits);
+	r = vco_freq / pll_posdiv_map[posdiv];
+
+	pr_debug("%lu: %s\n", r, __clk_get_name(hw->clk));
+
+	return r;
+}
+
+static long clk_pll_round_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long *prate)
+{
+	int r;
+	u32 pcwfbits = 14;
+	u32 pcw = 0;
+	u32 postdiv = 0;
+
+	pr_debug("%s, rate: %lu\n", __clk_get_name(hw->clk), rate);
+
+	*prate = *prate ? *prate : 26000000;
+	rate = freq_limit(rate);
+	calc_pll_freq_cfg(&pcw, &postdiv, rate, *prate, pcwfbits);
+
+	r = calc_pll_vco_freq(*prate, pcw, 1, 1, pcwfbits);
+	r = r / pll_posdiv_map[postdiv];
+	return r;
+}
+
+static void clk_pll_set_rate_regs(
+		struct clk_hw *hw,
+		u32 pcw,
+		u32 postdiv_idx)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	void __iomem *con0_addr = pll->base_addr;
+	void __iomem *con1_addr = pll->base_addr + 4;
+	u32 con0;
+	u32 con1;
+	u32 pll_en;
+
+	mtk_clk_lock(flags);
+
+	con0 = readl_relaxed(con0_addr);
+	con1 = readl_relaxed(con1_addr);
+
+	pll_en = con0 & PLL_BASE_EN;
+
+	/* set postdiv */
+	con0 &= ~SDM_PLL_POSTDIV_MASK;
+	con0 |= postdiv_idx << SDM_PLL_POSTDIV_L;
+	writel_relaxed(con0, con0_addr);
+
+	/* set pcw */
+	con1 &= ~SDM_PLL_PCW_MASK;
+	con1 |= pcw << SDM_PLL_PCW_L;
+
+	if (pll_en)
+		con1 |= PLL_PCW_CHG;
+
+	writel_relaxed(con1, con1_addr);
+
+	if (pll_en) {
+		dsb();
+		udelay(20);
+	}
+
+	mtk_clk_unlock(flags);
+}
+
+static int clk_pll_set_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long parent_rate)
+{
+	u32 pcwfbits = 14;
+	u32 pcw = 0;
+	u32 postdiv_idx = 0;
+	int r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	r = calc_pll_freq_cfg(&pcw, &postdiv_idx, rate, parent_rate, pcwfbits);
+
+	pr_debug("%s, rate: %lu, pcw: %u, postdiv_idx: %u\n",
+		__clk_get_name(hw->clk), rate, pcw, postdiv_idx);
+
+	if (r == 0)
+		clk_pll_set_rate_regs(hw, pcw, postdiv_idx);
+
+	return r;
+}
+
+const struct clk_ops mtk_clk_pll_ops = {
+	.is_enabled	= clk_pll_is_enabled,
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.recalc_rate	= clk_pll_recalc_rate,
+	.round_rate	= clk_pll_round_rate,
+	.set_rate	= clk_pll_set_rate,
+};
+
+#define ARM_PLL_POSTDIV_H	26
+#define ARM_PLL_POSTDIV_L	24
+#define ARM_PLL_POSTDIV_MASK	GENMASK(ARM_PLL_POSTDIV_H, ARM_PLL_POSTDIV_L)
+#define ARM_PLL_PCW_H		20
+#define ARM_PLL_PCW_L		0
+#define ARM_PLL_PCW_MASK	GENMASK(ARM_PLL_PCW_H, ARM_PLL_PCW_L)
+
+static unsigned long clk_arm_pll_recalc_rate(
+		struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	u32 con0 = readl_relaxed(pll->base_addr);
+	u32 con1 = readl_relaxed(pll->base_addr + 4);
+
+	u32 vcodivsel = (con0 & PLL_VCODIV_MASK) >> PLL_VCODIV_L;
+	u32 prediv = (con0 & PLL_PREDIV_MASK) >> PLL_PREDIV_L;
+	u32 posdiv = (con1 & ARM_PLL_POSTDIV_MASK) >> ARM_PLL_POSTDIV_L;
+	u32 pcw = (con1 & ARM_PLL_PCW_MASK) >> ARM_PLL_PCW_L;
+	u32 pcwfbits = 14;
+
+	u32 vco_freq;
+	unsigned long r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	vcodivsel = pll_vcodivsel_map[vcodivsel];
+	prediv = pll_prediv_map[prediv];
+
+	vco_freq = calc_pll_vco_freq(
+			parent_rate, pcw, vcodivsel, prediv, pcwfbits);
+	r = vco_freq / pll_posdiv_map[posdiv];
+
+	pr_debug("%lu: %s\n", r, __clk_get_name(hw->clk));
+
+	return r;
+}
+
+static void clk_arm_pll_set_rate_regs(
+		struct clk_hw *hw,
+		u32 pcw,
+		u32 postdiv_idx)
+
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	void __iomem *con0_addr = pll->base_addr;
+	void __iomem *con1_addr = pll->base_addr + 4;
+	u32 con0;
+	u32 con1;
+	u32 pll_en;
+
+	mtk_clk_lock(flags);
+
+	con0 = readl_relaxed(con0_addr);
+	con1 = readl_relaxed(con1_addr);
+
+	pll_en = con0 & PLL_BASE_EN;
+
+	/* postdiv */
+	con1 &= ~ARM_PLL_POSTDIV_MASK;
+	con1 |= postdiv_idx << ARM_PLL_POSTDIV_L;
+
+	/* pcw */
+	con1 &= ~ARM_PLL_PCW_MASK;
+	con1 |= pcw << ARM_PLL_PCW_L;
+
+	if (pll_en)
+		con1 |= PLL_PCW_CHG;
+
+	writel_relaxed(con1, con1_addr);
+
+	if (pll_en) {
+		dsb();
+		udelay(20);
+	}
+
+	mtk_clk_unlock(flags);
+}
+
+static int clk_arm_pll_set_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long parent_rate)
+{
+	u32 pcwfbits = 14;
+	u32 pcw = 0;
+	u32 postdiv_idx = 0;
+	int r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	r = calc_pll_freq_cfg(&pcw, &postdiv_idx, rate, parent_rate, pcwfbits);
+
+	pr_debug("%s, rate: %lu, pcw: %u, postdiv_idx: %u\n",
+		__clk_get_name(hw->clk), rate, pcw, postdiv_idx);
+
+	if (r == 0)
+		clk_arm_pll_set_rate_regs(hw, pcw, postdiv_idx);
+
+	return r;
+}
+
+const struct clk_ops mtk_clk_arm_pll_ops = {
+	.is_enabled	= clk_pll_is_enabled,
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.recalc_rate	= clk_arm_pll_recalc_rate,
+	.round_rate	= clk_pll_round_rate,
+	.set_rate	= clk_arm_pll_set_rate,
+};
+
+static int clk_lc_pll_prepare(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	pr_debug("%s\n", __clk_get_name(hw->clk));
+
+	mtk_clk_lock(flags);
+
+	r = readl_relaxed(pll->base_addr) | pll->en_mask;
+	writel_relaxed(r, pll->base_addr);
+	dsb();
+	udelay(20);
+
+	if (pll->flags & HAVE_RST_BAR) {
+		r = readl_relaxed(pll->base_addr) | RST_BAR_MASK;
+		writel_relaxed(r, pll->base_addr);
+	}
+
+	mtk_clk_unlock(flags);
+
+	return 0;
+}
+
+static void clk_lc_pll_unprepare(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	pr_debug("%s\n", __clk_get_name(hw->clk));
+
+	mtk_clk_lock(flags);
+
+	if (pll->flags & HAVE_RST_BAR) {
+		r = readl_relaxed(pll->base_addr) & ~RST_BAR_MASK;
+		writel_relaxed(r, pll->base_addr);
+	}
+
+	r = readl_relaxed(pll->base_addr) & ~PLL_BASE_EN;
+	writel_relaxed(r, pll->base_addr);
+
+	mtk_clk_unlock(flags);
+}
+
+#define LC_PLL_FBKSEL_H		21
+#define LC_PLL_FBKSEL_L		20
+#define LC_PLL_FBKSEL_MASK	GENMASK(LC_PLL_FBKSEL_H, LC_PLL_FBKSEL_L)
+#define LC_PLL_POSTDIV_H	8
+#define LC_PLL_POSTDIV_L	6
+#define LC_PLL_POSTDIV_MASK	GENMASK(LC_PLL_POSTDIV_H, LC_PLL_POSTDIV_L)
+#define LC_PLL_FBKDIV_H		15
+#define LC_PLL_FBKDIV_L		9
+#define LC_PLL_FBKDIV_MASK	GENMASK(LC_PLL_FBKDIV_H, LC_PLL_FBKDIV_L)
+
+static unsigned long clk_lc_pll_recalc_rate(
+		struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	u32 con0 = readl_relaxed(pll->base_addr);
+
+	u32 fbksel = (con0 & LC_PLL_FBKSEL_MASK) >> LC_PLL_FBKSEL_L;
+	u32 vcodivsel = (con0 & PLL_VCODIV_MASK) >> PLL_VCODIV_L;
+	u32 fbkdiv = (con0 & LC_PLL_FBKDIV_MASK) >> LC_PLL_FBKDIV_L;
+	u32 prediv = (con0 & PLL_PREDIV_MASK) >> PLL_PREDIV_L;
+	u32 posdiv = (con0 & LC_PLL_POSTDIV_MASK) >> LC_PLL_POSTDIV_L;
+
+	u32 vco_freq;
+	unsigned long r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	vcodivsel = pll_vcodivsel_map[vcodivsel];
+	fbksel = pll_fbksel_map[fbksel];
+	prediv = pll_prediv_map[prediv];
+
+	vco_freq = parent_rate * fbkdiv * fbksel * vcodivsel / prediv;
+	r = vco_freq / pll_posdiv_map[posdiv];
+
+	pr_debug("%lu: %s\n", r, __clk_get_name(hw->clk));
+
+	return r;
+}
+
+static long clk_lc_pll_round_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long *prate)
+{
+	int r;
+	u32 pcwfbits = 0;
+	u32 pcw = 0;
+	u32 postdiv = 0;
+
+	pr_debug("%s, rate: %lu\n", __clk_get_name(hw->clk), rate);
+
+	*prate = *prate ? *prate : 26000000;
+	rate = freq_limit(rate);
+	calc_pll_freq_cfg(&pcw, &postdiv, rate, *prate, pcwfbits);
+
+	r = calc_pll_vco_freq(*prate, pcw, 1, 1, pcwfbits);
+	r = r / pll_posdiv_map[postdiv];
+	return r;
+}
+
+static void clk_lc_pll_set_rate_regs(
+		struct clk_hw *hw,
+		u32 pcw,
+		u32 postdiv_idx)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	void __iomem *con0_addr = pll->base_addr;
+	u32 con0;
+	u32 pll_en;
+
+	mtk_clk_lock(flags);
+
+	con0 = readl_relaxed(con0_addr);
+
+	pll_en = con0 & PLL_BASE_EN;
+
+	/* postdiv */
+	con0 &= ~LC_PLL_POSTDIV_MASK;
+	con0 |= postdiv_idx << LC_PLL_POSTDIV_L;
+
+	/* fkbdiv */
+	con0 &= ~LC_PLL_FBKDIV_MASK;
+	con0 |= pcw << LC_PLL_FBKDIV_L;
+
+	writel_relaxed(con0, con0_addr);
+
+	if (pll_en) {
+		dsb();
+		udelay(20);
+	}
+	mtk_clk_unlock(flags);
+}
+
+static int clk_lc_pll_set_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long parent_rate)
+{
+	u32 pcwfbits = 0;
+	u32 pcw = 0;
+	u32 postdiv_idx = 0;
+	int r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	r = calc_pll_freq_cfg(&pcw, &postdiv_idx, rate, parent_rate, pcwfbits);
+
+	pr_debug("%s, rate: %lu, pcw: %u, postdiv_idx: %u\n",
+		__clk_get_name(hw->clk), rate, pcw, postdiv_idx);
+
+	if (r == 0)
+		clk_lc_pll_set_rate_regs(hw, pcw, postdiv_idx);
+
+	return r;
+}
+
+const struct clk_ops mtk_clk_lc_pll_ops = {
+	.is_enabled	= clk_pll_is_enabled,
+	.prepare	= clk_lc_pll_prepare,
+	.unprepare	= clk_lc_pll_unprepare,
+	.recalc_rate	= clk_lc_pll_recalc_rate,
+	.round_rate	= clk_lc_pll_round_rate,
+	.set_rate	= clk_lc_pll_set_rate,
+};
+
+static int clk_aud_pll_prepare(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	pr_debug("%s\n", __clk_get_name(hw->clk));
+
+	mtk_clk_lock(flags);
+
+	r = readl_relaxed(pll->pwr_addr) | PLL_PWR_ON;
+	writel_relaxed(r, pll->pwr_addr);
+	dsb();
+	udelay(1);
+
+	r = readl_relaxed(pll->pwr_addr) & ~PLL_ISO_EN;
+	writel_relaxed(r, pll->pwr_addr);
+	dsb();
+	udelay(1);
+
+	r = readl_relaxed(pll->base_addr) | pll->en_mask;
+	writel_relaxed(r, pll->base_addr);
+
+	r = readl_relaxed(pll->base_addr + 16) | AUDPLL_TUNER_EN;
+	writel_relaxed(r, pll->base_addr + 16);
+	dsb();
+	udelay(20);
+
+	if (pll->flags & HAVE_RST_BAR) {
+		r = readl_relaxed(pll->base_addr) | RST_BAR_MASK;
+		writel_relaxed(r, pll->base_addr);
+	}
+
+	mtk_clk_unlock(flags);
+
+	return 0;
+}
+
+static void clk_aud_pll_unprepare(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	pr_debug("%s\n", __clk_get_name(hw->clk));
+
+	mtk_clk_lock(flags);
+
+	if (pll->flags & HAVE_RST_BAR) {
+		r = readl_relaxed(pll->base_addr) & ~RST_BAR_MASK;
+		writel_relaxed(r, pll->base_addr);
+	}
+	r = readl_relaxed(pll->base_addr + 16) & ~AUDPLL_TUNER_EN;
+	writel_relaxed(r, pll->base_addr + 16);
+
+	r = readl_relaxed(pll->base_addr) & ~PLL_BASE_EN;
+	writel_relaxed(r, pll->base_addr);
+
+	r = readl_relaxed(pll->pwr_addr) | PLL_ISO_EN;
+	writel_relaxed(r, pll->pwr_addr);
+
+	r = readl_relaxed(pll->pwr_addr) & ~PLL_PWR_ON;
+	writel_relaxed(r, pll->pwr_addr);
+
+	mtk_clk_unlock(flags);
+}
+
+#define AUD_PLL_POSTDIV_H	8
+#define AUD_PLL_POSTDIV_L	6
+#define AUD_PLL_POSTDIV_MASK	GENMASK(AUD_PLL_POSTDIV_H, AUD_PLL_POSTDIV_L)
+#define AUD_PLL_PCW_H		30
+#define AUD_PLL_PCW_L		0
+#define AUD_PLL_PCW_MASK	GENMASK(AUD_PLL_PCW_H, AUD_PLL_PCW_L)
+
+static unsigned long clk_aud_pll_recalc_rate(
+		struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	u32 con0 = readl_relaxed(pll->base_addr);
+	u32 con1 = readl_relaxed(pll->base_addr + 4);
+
+	u32 vcodivsel = (con0 & PLL_VCODIV_MASK) >> PLL_VCODIV_L;
+	u32 prediv = (con0 & PLL_PREDIV_MASK) >> PLL_PREDIV_L;
+	u32 posdiv = (con0 & AUD_PLL_POSTDIV_MASK) >> AUD_PLL_POSTDIV_L;
+	u32 pcw = (con1 & AUD_PLL_PCW_MASK) >> AUD_PLL_PCW_L;
+	u32 pcwfbits = 24;
+
+	u32 vco_freq;
+	unsigned long r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	vcodivsel = pll_vcodivsel_map[vcodivsel];
+	prediv = pll_prediv_map[prediv];
+
+	vco_freq = calc_pll_vco_freq(
+			parent_rate, pcw, vcodivsel, prediv, pcwfbits);
+	r = vco_freq / pll_posdiv_map[posdiv];
+
+	pr_debug("%lu: %s\n", r, __clk_get_name(hw->clk));
+
+	return r;
+}
+
+static long clk_aud_pll_round_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long *prate)
+{
+	int r;
+	u32 pcwfbits = 24;
+	u32 pcw = 0;
+	u32 postdiv = 0;
+
+	pr_debug("%s, rate: %lu\n", __clk_get_name(hw->clk), rate);
+
+	*prate = *prate ? *prate : 26000000;
+	rate = freq_limit(rate);
+	calc_pll_freq_cfg(&pcw, &postdiv, rate, *prate, pcwfbits);
+
+	r = calc_pll_vco_freq(*prate, pcw, 1, 1, pcwfbits);
+	r = r / pll_posdiv_map[postdiv];
+	return r;
+}
+
+static void clk_aud_pll_set_rate_regs(
+		struct clk_hw *hw,
+		u32 pcw,
+		u32 postdiv_idx)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	void __iomem *con0_addr = pll->base_addr;
+	void __iomem *con1_addr = pll->base_addr + 4;
+	void __iomem *con4_addr = pll->base_addr + 16;
+	u32 con0;
+	u32 con1;
+	u32 pll_en;
+
+	mtk_clk_lock(flags);
+
+	con0 = readl_relaxed(con0_addr);
+	con1 = readl_relaxed(con1_addr);
+
+	pll_en = con0 & PLL_BASE_EN;
+
+	/* set postdiv */
+	con0 &= ~AUD_PLL_POSTDIV_MASK;
+	con0 |= postdiv_idx << AUD_PLL_POSTDIV_L;
+	writel_relaxed(con0, con0_addr);
+
+	/* set pcw */
+	con1 &= ~AUD_PLL_PCW_MASK;
+	con1 |= pcw << AUD_PLL_PCW_L;
+
+	if (pll_en)
+		con1 |= PLL_PCW_CHG;
+
+	writel_relaxed(con1, con1_addr);
+	writel_relaxed(con1 + 1, con4_addr);
+	/* AUDPLL_CON4[30:0] (AUDPLL_TUNER_N_INFO) = (pcw + 1) */
+
+	if (pll_en) {
+		dsb();
+		udelay(20);
+	}
+
+	mtk_clk_unlock(flags);
+}
+
+static int clk_aud_pll_set_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long parent_rate)
+{
+	u32 pcwfbits = 24;
+	u32 pcw = 0;
+	u32 postdiv_idx = 0;
+	int r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	r = calc_pll_freq_cfg(&pcw, &postdiv_idx, rate, parent_rate, pcwfbits);
+
+	pr_debug("%s, rate: %lu, pcw: %u, postdiv_idx: %u\n",
+		__clk_get_name(hw->clk), rate, pcw, postdiv_idx);
+
+	if (r == 0)
+		clk_aud_pll_set_rate_regs(hw, pcw, postdiv_idx);
+
+	return r;
+}
+
+const struct clk_ops mtk_clk_aud_pll_ops = {
+	.is_enabled	= clk_pll_is_enabled,
+	.prepare	= clk_aud_pll_prepare,
+	.unprepare	= clk_aud_pll_unprepare,
+	.recalc_rate	= clk_aud_pll_recalc_rate,
+	.round_rate	= clk_aud_pll_round_rate,
+	.set_rate	= clk_aud_pll_set_rate,
+};
+
+#define TVD_PLL_POSTDIV_H	8
+#define TVD_PLL_POSTDIV_L	6
+#define TVD_PLL_POSTDIV_MASK	GENMASK(TVD_PLL_POSTDIV_H, TVD_PLL_POSTDIV_L)
+#define TVD_PLL_PCW_H		30
+#define TVD_PLL_PCW_L		0
+#define TVD_PLL_PCW_MASK	GENMASK(TVD_PLL_PCW_H, TVD_PLL_PCW_L)
+
+static void clk_tvd_pll_set_rate_regs(
+		struct clk_hw *hw,
+		u32 pcw,
+		u32 postdiv_idx)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	void __iomem *con0_addr = pll->base_addr;
+	void __iomem *con1_addr = pll->base_addr + 4;
+	u32 con0;
+	u32 con1;
+	u32 pll_en;
+
+	mtk_clk_lock(flags);
+
+	con0 = readl_relaxed(con0_addr);
+	con1 = readl_relaxed(con1_addr);
+
+	pll_en = con0 & PLL_BASE_EN;
+
+	/* set postdiv */
+	con0 &= ~TVD_PLL_POSTDIV_MASK;
+	con0 |= postdiv_idx << TVD_PLL_POSTDIV_L;
+	writel_relaxed(con0, con0_addr);
+
+	/* set pcw */
+	con1 &= ~TVD_PLL_PCW_MASK;
+	con1 |= pcw << TVD_PLL_PCW_L;
+
+	if (pll_en)
+		con1 |= PLL_PCW_CHG;
+
+	writel_relaxed(con1, con1_addr);
+
+	if (pll_en) {
+		dsb();
+		udelay(20);
+	}
+
+	mtk_clk_unlock(flags);
+}
+
+static int clk_tvd_pll_set_rate(
+		struct clk_hw *hw,
+		unsigned long rate,
+		unsigned long parent_rate)
+{
+	u32 pcwfbits = 24;
+	u32 pcw = 0;
+	u32 postdiv_idx = 0;
+	int r;
+
+	parent_rate = parent_rate ? parent_rate : 26000000;
+	r = calc_pll_freq_cfg(&pcw, &postdiv_idx, rate, parent_rate, pcwfbits);
+
+	pr_debug("%s, rate: %lu, pcw: %u, postdiv_idx: %u\n",
+		__clk_get_name(hw->clk), rate, pcw, postdiv_idx);
+
+	if (r == 0)
+		clk_tvd_pll_set_rate_regs(hw, pcw, postdiv_idx);
+
+	return r;
+}
+
+const struct clk_ops mtk_clk_tvd_pll_ops = {
+	.is_enabled	= clk_pll_is_enabled,
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.recalc_rate	= clk_aud_pll_recalc_rate,
+	.round_rate	= clk_aud_pll_round_rate,
+	.set_rate	= clk_tvd_pll_set_rate,
+};
diff --git a/drivers/clk/mediatek/clk-mt8135-pll.h b/drivers/clk/mediatek/clk-mt8135-pll.h
new file mode 100644
index 0000000..0628189
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8135-pll.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_MT8135_PLL_H
+#define __DRV_CLK_MT8135_PLL_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+extern const struct clk_ops mtk_clk_pll_ops;
+extern const struct clk_ops mtk_clk_arm_pll_ops;
+extern const struct clk_ops mtk_clk_lc_pll_ops;
+extern const struct clk_ops mtk_clk_aud_pll_ops;
+extern const struct clk_ops mtk_clk_tvd_pll_ops;
+
+#endif /* __DRV_CLK_MT8135_PLL_H */
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
new file mode 100644
index 0000000..fa8dd7d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -0,0 +1,752 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+#include "clk-mt8135-pll.h"
+
+#include <dt-bindings/clock/mt8135-clk.h>
+
+/*
+ * platform clocks
+ */
+
+/* ROOT */
+#define clk_null		"clk_null"
+#define clk26m			"clk26m"
+#define rtc32k			"rtc32k"
+
+#define dsi0_lntc_dsiclk	"dsi0_lntc_dsi"
+#define hdmitx_clkdig_cts	"hdmitx_dig_cts"
+#define clkph_mck		"clkph_mck"
+#define cpum_tck_in		"cpum_tck_in"
+
+/* PLL */
+#define armpll1			"armpll1"
+#define armpll2			"armpll2"
+#define mainpll			"mainpll"
+#define univpll			"univpll"
+#define mmpll			"mmpll"
+#define msdcpll			"msdcpll"
+#define tvdpll			"tvdpll"
+#define lvdspll			"lvdspll"
+#define audpll			"audpll"
+#define vdecpll			"vdecpll"
+
+#define mainpll_806m		"mainpll_806m"
+#define mainpll_537p3m		"mainpll_537p3m"
+#define mainpll_322p4m		"mainpll_322p4m"
+#define mainpll_230p3m		"mainpll_230p3m"
+
+#define univpll_624m		"univpll_624m"
+#define univpll_416m		"univpll_416m"
+#define univpll_249p6m		"univpll_249p6m"
+#define univpll_178p3m		"univpll_178p3m"
+#define univpll_48m		"univpll_48m"
+
+/* DIV */
+#define mmpll_d2		"mmpll_d2"
+#define mmpll_d3		"mmpll_d3"
+#define mmpll_d5		"mmpll_d5"
+#define mmpll_d7		"mmpll_d7"
+#define mmpll_d4		"mmpll_d4"
+#define mmpll_d6		"mmpll_d6"
+
+#define syspll_d2		"syspll_d2"
+#define syspll_d4		"syspll_d4"
+#define syspll_d6		"syspll_d6"
+#define syspll_d8		"syspll_d8"
+#define syspll_d10		"syspll_d10"
+#define syspll_d12		"syspll_d12"
+#define syspll_d16		"syspll_d16"
+#define syspll_d24		"syspll_d24"
+#define syspll_d3		"syspll_d3"
+#define syspll_d2p5		"syspll_d2p5"
+#define syspll_d5		"syspll_d5"
+#define syspll_d3p5		"syspll_d3p5"
+
+#define univpll1_d2		"univpll1_d2"
+#define univpll1_d4		"univpll1_d4"
+#define univpll1_d6		"univpll1_d6"
+#define univpll1_d8		"univpll1_d8"
+#define univpll1_d10		"univpll1_d10"
+
+#define univpll2_d2		"univpll2_d2"
+#define univpll2_d4		"univpll2_d4"
+#define univpll2_d6		"univpll2_d6"
+#define univpll2_d8		"univpll2_d8"
+
+#define univpll_d3		"univpll_d3"
+#define univpll_d5		"univpll_d5"
+#define univpll_d7		"univpll_d7"
+#define univpll_d10		"univpll_d10"
+#define univpll_d26		"univpll_d26"
+
+#define apll_ck			"apll"
+#define apll_d4			"apll_d4"
+#define apll_d8			"apll_d8"
+#define apll_d16		"apll_d16"
+#define apll_d24		"apll_d24"
+
+#define lvdspll_d2		"lvdspll_d2"
+#define lvdspll_d4		"lvdspll_d4"
+#define lvdspll_d8		"lvdspll_d8"
+
+#define lvdstx_clkdig_cts	"lvdstx_dig_cts"
+#define vpll_dpix_ck		"vpll_dpix_ck"
+#define tvhdmi_h_ck		"tvhdmi_h_ck"
+#define hdmitx_clkdig_d2	"hdmitx_dig_d2"
+#define hdmitx_clkdig_d3	"hdmitx_dig_d3"
+#define tvhdmi_d2		"tvhdmi_d2"
+#define tvhdmi_d4		"tvhdmi_d4"
+#define mempll_mck_d4		"mempll_mck_d4"
+
+/* TOP */
+#define axi_sel			"axi_sel"
+#define smi_sel			"smi_sel"
+#define mfg_sel			"mfg_sel"
+#define irda_sel		"irda_sel"
+#define cam_sel			"cam_sel"
+#define aud_intbus_sel		"aud_intbus_sel"
+#define jpg_sel			"jpg_sel"
+#define disp_sel		"disp_sel"
+#define msdc30_1_sel		"msdc30_1_sel"
+#define msdc30_2_sel		"msdc30_2_sel"
+#define msdc30_3_sel		"msdc30_3_sel"
+#define msdc30_4_sel		"msdc30_4_sel"
+#define usb20_sel		"usb20_sel"
+#define venc_sel		"venc_sel"
+#define spi_sel			"spi_sel"
+#define uart_sel		"uart_sel"
+#define mem_sel			"mem_sel"
+#define camtg_sel		"camtg_sel"
+#define audio_sel		"audio_sel"
+#define fix_sel			"fix_sel"
+#define vdec_sel		"vdec_sel"
+#define ddrphycfg_sel		"ddrphycfg_sel"
+#define dpilvds_sel		"dpilvds_sel"
+#define pmicspi_sel		"pmicspi_sel"
+#define msdc30_0_sel		"msdc30_0_sel"
+#define smi_mfg_as_sel		"smi_mfg_as_sel"
+#define gcpu_sel		"gcpu_sel"
+#define dpi1_sel		"dpi1_sel"
+#define cci_sel			"cci_sel"
+#define apll_sel		"apll_sel"
+#define hdmipll_sel		"hdmipll_sel"
+
+struct mtk_fixed_factor {
+	int id;
+	const char *name;
+	const char *parent_name;
+	int mult;
+	int div;
+};
+
+#define FACTOR(_id, _name, _parent, _mult, _div) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.mult = _mult,				\
+		.div = _div,				\
+	}
+
+static void __init init_factors(struct mtk_fixed_factor *clks, int num,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		struct mtk_fixed_factor *ff = &clks[i];
+
+		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
+				0, ff->mult, ff->div);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					ff->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[ff->id] = clk;
+
+		pr_debug("factor %3d: %s\n", i, ff->name);
+	}
+}
+
+static struct mtk_fixed_factor root_clk_alias[] __initdata = {
+	FACTOR(TOP_DSI0_LNTC_DSICLK, dsi0_lntc_dsiclk, clk_null, 1, 1),
+	FACTOR(TOP_HDMITX_CLKDIG_CTS, hdmitx_clkdig_cts, clk_null, 1, 1),
+	FACTOR(TOP_CLKPH_MCK, clkph_mck, clk_null, 1, 1),
+	FACTOR(TOP_CPUM_TCK_IN, cpum_tck_in, clk_null, 1, 1),
+};
+
+static void __init init_clk_root_alias(struct clk_onecell_data *clk_data)
+{
+	init_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
+}
+
+static struct mtk_fixed_factor top_divs[] __initdata = {
+	FACTOR(TOP_MAINPLL_806M, mainpll_806m, mainpll, 1, 2),
+	FACTOR(TOP_MAINPLL_537P3M, mainpll_537p3m, mainpll, 1, 3),
+	FACTOR(TOP_MAINPLL_322P4M, mainpll_322p4m, mainpll, 1, 5),
+	FACTOR(TOP_MAINPLL_230P3M, mainpll_230p3m, mainpll, 1, 7),
+
+	FACTOR(TOP_UNIVPLL_624M, univpll_624m, univpll, 1, 2),
+	FACTOR(TOP_UNIVPLL_416M, univpll_416m, univpll, 1, 3),
+	FACTOR(TOP_UNIVPLL_249P6M, univpll_249p6m, univpll, 1, 5),
+	FACTOR(TOP_UNIVPLL_178P3M, univpll_178p3m, univpll, 1, 7),
+	FACTOR(TOP_UNIVPLL_48M, univpll_48m, univpll, 1, 26),
+
+	FACTOR(TOP_MMPLL_D2, mmpll_d2, mmpll, 1, 2),
+	FACTOR(TOP_MMPLL_D3, mmpll_d3, mmpll, 1, 3),
+	FACTOR(TOP_MMPLL_D5, mmpll_d5, mmpll, 1, 5),
+	FACTOR(TOP_MMPLL_D7, mmpll_d7, mmpll, 1, 7),
+	FACTOR(TOP_MMPLL_D4, mmpll_d4, mmpll_d2, 1, 2),
+	FACTOR(TOP_MMPLL_D6, mmpll_d6, mmpll_d3, 1, 2),
+
+	FACTOR(TOP_SYSPLL_D2, syspll_d2, mainpll_806m, 1, 1),
+	FACTOR(TOP_SYSPLL_D4, syspll_d4, mainpll_806m, 1, 2),
+	FACTOR(TOP_SYSPLL_D6, syspll_d6, mainpll_806m, 1, 3),
+	FACTOR(TOP_SYSPLL_D8, syspll_d8, mainpll_806m, 1, 4),
+	FACTOR(TOP_SYSPLL_D10, syspll_d10, mainpll_806m, 1, 5),
+	FACTOR(TOP_SYSPLL_D12, syspll_d12, mainpll_806m, 1, 6),
+	FACTOR(TOP_SYSPLL_D16, syspll_d16, mainpll_806m, 1, 8),
+	FACTOR(TOP_SYSPLL_D24, syspll_d24, mainpll_806m, 1, 12),
+
+	FACTOR(TOP_SYSPLL_D3, syspll_d3, mainpll_537p3m, 1, 1),
+
+	FACTOR(TOP_SYSPLL_D2P5, syspll_d2p5, mainpll_322p4m, 2, 1),
+	FACTOR(TOP_SYSPLL_D5, syspll_d5, mainpll_322p4m, 1, 1),
+
+	FACTOR(TOP_SYSPLL_D3P5, syspll_d3p5, mainpll_230p3m, 2, 1),
+
+	FACTOR(TOP_UNIVPLL1_D2, univpll1_d2, univpll_624m, 1, 2),
+	FACTOR(TOP_UNIVPLL1_D4, univpll1_d4, univpll_624m, 1, 4),
+	FACTOR(TOP_UNIVPLL1_D6, univpll1_d6, univpll_624m, 1, 6),
+	FACTOR(TOP_UNIVPLL1_D8, univpll1_d8, univpll_624m, 1, 8),
+	FACTOR(TOP_UNIVPLL1_D10, univpll1_d10, univpll_624m, 1, 10),
+
+	FACTOR(TOP_UNIVPLL2_D2, univpll2_d2, univpll_416m, 1, 2),
+	FACTOR(TOP_UNIVPLL2_D4, univpll2_d4, univpll_416m, 1, 4),
+	FACTOR(TOP_UNIVPLL2_D6, univpll2_d6, univpll_416m, 1, 6),
+	FACTOR(TOP_UNIVPLL2_D8, univpll2_d8, univpll_416m, 1, 8),
+
+	FACTOR(TOP_UNIVPLL_D3, univpll_d3, univpll_416m, 1, 1),
+	FACTOR(TOP_UNIVPLL_D5, univpll_d5, univpll_249p6m, 1, 1),
+	FACTOR(TOP_UNIVPLL_D7, univpll_d7, univpll_178p3m, 1, 1),
+	FACTOR(TOP_UNIVPLL_D10, univpll_d10, univpll_249p6m, 1, 5),
+	FACTOR(TOP_UNIVPLL_D26, univpll_d26, univpll_48m, 1, 1),
+
+	FACTOR(TOP_APLL_CK, apll_ck, audpll, 1, 1),
+	FACTOR(TOP_APLL_D4, apll_d4, audpll, 1, 4),
+	FACTOR(TOP_APLL_D8, apll_d8, audpll, 1, 8),
+	FACTOR(TOP_APLL_D16, apll_d16, audpll, 1, 16),
+	FACTOR(TOP_APLL_D24, apll_d24, audpll, 1, 24),
+
+	FACTOR(TOP_LVDSPLL_D2, lvdspll_d2, lvdspll, 1, 2),
+	FACTOR(TOP_LVDSPLL_D4, lvdspll_d4, lvdspll, 1, 4),
+	FACTOR(TOP_LVDSPLL_D8, lvdspll_d8, lvdspll, 1, 8),
+
+	FACTOR(TOP_LVDSTX_CLKDIG_CT, lvdstx_clkdig_cts, lvdspll, 1, 1),
+	FACTOR(TOP_VPLL_DPIX_CK, vpll_dpix_ck, lvdspll, 1, 1),
+
+	FACTOR(TOP_TVHDMI_H_CK, tvhdmi_h_ck, tvdpll, 1, 1),
+
+	FACTOR(TOP_HDMITX_CLKDIG_D2, hdmitx_clkdig_d2, hdmitx_clkdig_cts, 1, 2),
+	FACTOR(TOP_HDMITX_CLKDIG_D3, hdmitx_clkdig_d3, hdmitx_clkdig_cts, 1, 3),
+
+	FACTOR(TOP_TVHDMI_D2, tvhdmi_d2, tvhdmi_h_ck, 1, 2),
+	FACTOR(TOP_TVHDMI_D4, tvhdmi_d4, tvhdmi_h_ck, 1, 4),
+
+	FACTOR(TOP_MEMPLL_MCK_D4, mempll_mck_d4, clkph_mck, 1, 4),
+};
+
+static void __init init_clk_top_div(struct clk_onecell_data *clk_data)
+{
+	init_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+}
+
+static const char *axi_parents[] __initconst = {
+		clk26m,
+		syspll_d3,
+		syspll_d4,
+		syspll_d6,
+		univpll_d5,
+		univpll2_d2,
+		syspll_d3p5};
+
+static const char *smi_parents[] __initconst = {
+		clk26m,
+		clkph_mck,
+		syspll_d2p5,
+		syspll_d3,
+		syspll_d8,
+		univpll_d5,
+		univpll1_d2,
+		univpll1_d6,
+		mmpll_d3,
+		mmpll_d4,
+		mmpll_d5,
+		mmpll_d6,
+		mmpll_d7,
+		vdecpll,
+		lvdspll};
+
+static const char *mfg_parents[] __initconst = {
+		clk26m,
+		univpll1_d4,
+		syspll_d2,
+		syspll_d2p5,
+		syspll_d3,
+		univpll_d5,
+		univpll1_d2,
+		mmpll_d2,
+		mmpll_d3,
+		mmpll_d4,
+		mmpll_d5,
+		mmpll_d6,
+		mmpll_d7};
+
+static const char *irda_parents[] __initconst = {
+		clk26m,
+		univpll2_d8,
+		univpll1_d6};
+
+static const char *cam_parents[] __initconst = {
+		clk26m,
+		syspll_d3,
+		syspll_d3p5,
+		syspll_d4,
+		univpll_d5,
+		univpll2_d2,
+		univpll_d7,
+		univpll1_d4};
+
+static const char *aud_intbus_parents[] __initconst = {
+		clk26m,
+		syspll_d6,
+		univpll_d10};
+
+static const char *jpg_parents[] __initconst = {
+		clk26m,
+		syspll_d5,
+		syspll_d4,
+		syspll_d3,
+		univpll_d7,
+		univpll2_d2,
+		univpll_d5};
+
+static const char *disp_parents[] __initconst = {
+		clk26m,
+		syspll_d3p5,
+		syspll_d3,
+		univpll2_d2,
+		univpll_d5,
+		univpll1_d2,
+		lvdspll,
+		vdecpll};
+
+static const char *msdc30_parents[] __initconst = {
+		clk26m,
+		syspll_d6,
+		syspll_d5,
+		univpll1_d4,
+		univpll2_d4,
+		msdcpll};
+
+static const char *usb20_parents[] __initconst = {
+		clk26m,
+		univpll2_d6,
+		univpll1_d10};
+
+static const char *venc_parents[] __initconst = {
+		clk26m,
+		syspll_d3,
+		syspll_d8,
+		univpll_d5,
+		univpll1_d6,
+		mmpll_d4,
+		mmpll_d5,
+		mmpll_d6};
+
+static const char *spi_parents[] __initconst = {
+		clk26m,
+		syspll_d6,
+		syspll_d8,
+		syspll_d10,
+		univpll1_d6,
+		univpll1_d8};
+
+static const char *uart_parents[] __initconst = {
+		clk26m,
+		univpll2_d8};
+
+static const char *mem_parents[] __initconst = {
+		clk26m,
+		clkph_mck};
+
+static const char *camtg_parents[] __initconst = {
+		clk26m,
+		univpll_d26,
+		univpll1_d6,
+		syspll_d16,
+		syspll_d8};
+
+static const char *audio_parents[] __initconst = {
+		clk26m,
+		syspll_d24};
+
+static const char *fix_parents[] __initconst = {
+		rtc32k,
+		clk26m,
+		univpll_d5,
+		univpll_d7,
+		univpll1_d2,
+		univpll1_d4,
+		univpll1_d6,
+		univpll1_d8};
+
+static const char *vdec_parents[] __initconst = {
+		clk26m,
+		vdecpll,
+		clkph_mck,
+		syspll_d2p5,
+		syspll_d3,
+		syspll_d3p5,
+		syspll_d4,
+		syspll_d5,
+		syspll_d6,
+		syspll_d8,
+		univpll1_d2,
+		univpll2_d2,
+		univpll_d7,
+		univpll_d10,
+		univpll2_d4,
+		lvdspll};
+
+static const char *ddrphycfg_parents[] __initconst = {
+		clk26m,
+		axi_sel,
+		syspll_d12};
+
+static const char *dpilvds_parents[] __initconst = {
+		clk26m,
+		lvdspll,
+		lvdspll_d2,
+		lvdspll_d4,
+		lvdspll_d8};
+
+static const char *pmicspi_parents[] __initconst = {
+		clk26m,
+		univpll2_d6,
+		syspll_d8,
+		syspll_d10,
+		univpll1_d10,
+		mempll_mck_d4,
+		univpll_d26,
+		syspll_d24};
+
+static const char *smi_mfg_as_parents[] __initconst = {
+		clk26m,
+		smi_sel,
+		mfg_sel,
+		mem_sel};
+
+static const char *gcpu_parents[] __initconst = {
+		clk26m,
+		syspll_d4,
+		univpll_d7,
+		syspll_d5,
+		syspll_d6};
+
+static const char *dpi1_parents[] __initconst = {
+		clk26m,
+		tvhdmi_h_ck,
+		tvhdmi_d2,
+		tvhdmi_d4};
+
+static const char *cci_parents[] __initconst = {
+		clk26m,
+		mainpll_537p3m,
+		univpll_d3,
+		syspll_d2p5,
+		syspll_d3,
+		syspll_d5};
+
+static const char *apll_parents[] __initconst = {
+		clk26m,
+		apll_ck,
+		apll_d4,
+		apll_d8,
+		apll_d16,
+		apll_d24};
+
+static const char *hdmipll_parents[] __initconst = {
+		clk26m,
+		hdmitx_clkdig_cts,
+		hdmitx_clkdig_d2,
+		hdmitx_clkdig_d3};
+
+struct mtk_mux {
+	int id;
+	const char *name;
+	u32 reg;
+	int shift;
+	int width;
+	int gate;
+	const char **parent_names;
+	int num_parents;
+};
+
+#define MUX(_id, _name, _parents, _reg, _shift, _width, _gate) {	\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.shift = _shift,					\
+		.width = _width,					\
+		.gate = _gate,						\
+		.parent_names = (const char **)_parents,		\
+		.num_parents = ARRAY_SIZE(_parents),			\
+	}
+
+static struct mtk_mux top_muxes[] __initdata = {
+	/* CLK_CFG_0 */
+	MUX(TOP_AXI_SEL, axi_sel, axi_parents,
+		0x0140, 0, 3, INVALID_MUX_GATE_BIT),
+	MUX(TOP_SMI_SEL, smi_sel, smi_parents, 0x0140, 8, 4, 15),
+	MUX(TOP_MFG_SEL, mfg_sel, mfg_parents, 0x0140, 16, 4, 23),
+	MUX(TOP_IRDA_SEL, irda_sel, irda_parents, 0x0140, 24, 2, 31),
+	/* CLK_CFG_1 */
+	MUX(TOP_CAM_SEL, cam_sel, cam_parents, 0x0144, 0, 3, 7),
+	MUX(TOP_AUD_INTBUS_SEL, aud_intbus_sel, aud_intbus_parents,
+		0x0144, 8, 2, 15),
+	MUX(TOP_JPG_SEL, jpg_sel, jpg_parents, 0x0144, 16, 3, 23),
+	MUX(TOP_DISP_SEL, disp_sel, disp_parents, 0x0144, 24, 3, 31),
+	/* CLK_CFG_2 */
+	MUX(TOP_MSDC30_1_SEL, msdc30_1_sel, msdc30_parents, 0x0148, 0, 3, 7),
+	MUX(TOP_MSDC30_2_SEL, msdc30_2_sel, msdc30_parents, 0x0148, 8, 3, 15),
+	MUX(TOP_MSDC30_3_SEL, msdc30_3_sel, msdc30_parents, 0x0148, 16, 3, 23),
+	MUX(TOP_MSDC30_4_SEL, msdc30_4_sel, msdc30_parents, 0x0148, 24, 3, 31),
+	/* CLK_CFG_3 */
+	MUX(TOP_USB20_SEL, usb20_sel, usb20_parents, 0x014c, 0, 2, 7),
+	/* CLK_CFG_4 */
+	MUX(TOP_VENC_SEL, venc_sel, venc_parents, 0x0150, 8, 3, 15),
+	MUX(TOP_SPI_SEL, spi_sel, spi_parents, 0x0150, 16, 3, 23),
+	MUX(TOP_UART_SEL, uart_sel, uart_parents, 0x0150, 24, 2, 31),
+	/* CLK_CFG_6 */
+	MUX(TOP_MEM_SEL, mem_sel, mem_parents, 0x0158, 0, 2, 7),
+	MUX(TOP_CAMTG_SEL, camtg_sel, camtg_parents, 0x0158, 8, 3, 15),
+	MUX(TOP_AUDIO_SEL, audio_sel, audio_parents, 0x0158, 24, 2, 31),
+	/* CLK_CFG_7 */
+	MUX(TOP_FIX_SEL, fix_sel, fix_parents, 0x015c, 0, 3, 7),
+	MUX(TOP_VDEC_SEL, vdec_sel, vdec_parents, 0x015c, 8, 4, 15),
+	MUX(TOP_DDRPHYCFG_SEL, ddrphycfg_sel, ddrphycfg_parents,
+		0x015c, 16, 2, 23),
+	MUX(TOP_DPILVDS_SEL, dpilvds_sel, dpilvds_parents, 0x015c, 24, 3, 31),
+	/* CLK_CFG_8 */
+	MUX(TOP_PMICSPI_SEL, pmicspi_sel, pmicspi_parents, 0x0164, 0, 3, 7),
+	MUX(TOP_MSDC30_0_SEL, msdc30_0_sel, msdc30_parents, 0x0164, 8, 3, 15),
+	MUX(TOP_SMI_MFG_AS_SEL, smi_mfg_as_sel, smi_mfg_as_parents,
+		0x0164, 16, 2, 23),
+	MUX(TOP_GCPU_SEL, gcpu_sel, gcpu_parents, 0x0164, 24, 3, 31),
+	/* CLK_CFG_9 */
+	MUX(TOP_DPI1_SEL, dpi1_sel, dpi1_parents, 0x0168, 0, 2, 7),
+	MUX(TOP_CCI_SEL, cci_sel, cci_parents, 0x0168, 8, 3, 15),
+	MUX(TOP_APLL_SEL, apll_sel, apll_parents, 0x0168, 16, 3, 23),
+	MUX(TOP_HDMIPLL_SEL, hdmipll_sel, hdmipll_parents, 0x0168, 24, 2, 31),
+};
+
+static void __init init_clk_topckgen(void __iomem *top_base,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < ARRAY_SIZE(top_muxes); i++) {
+		struct mtk_mux *mux = &top_muxes[i];
+
+		clk = mtk_clk_register_mux(mux->name,
+			mux->parent_names, mux->num_parents,
+			top_base + mux->reg, mux->shift, mux->width, mux->gate);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					mux->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[mux->id] = clk;
+
+		pr_debug("mux %3d: %s\n", i, mux->name);
+	}
+}
+
+struct mtk_pll {
+	int id;
+	const char *name;
+	const char *parent_name;
+	u32 reg;
+	u32 pwr_reg;
+	u32 en_mask;
+	unsigned int flags;
+	const struct clk_ops *ops;
+};
+
+#define PLL(_id, _name, _parent, _reg, _pwr_reg, _en_mask, _flags, _ops) { \
+		.id = _id,						\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.ops = _ops,						\
+	}
+
+static struct mtk_pll plls[] __initdata = {
+	PLL(APMIXED_ARMPLL1, armpll1, clk26m, 0x0200, 0x0218,
+		0x80000001, HAVE_PLL_HP, &mtk_clk_arm_pll_ops),
+	PLL(APMIXED_ARMPLL2, armpll2, clk26m, 0x02cc, 0x02e4,
+		0x80000001, HAVE_PLL_HP, &mtk_clk_arm_pll_ops),
+	PLL(APMIXED_MAINPLL, mainpll, clk26m, 0x021c, 0x0234,
+		0xf0000001, HAVE_PLL_HP | HAVE_RST_BAR | PLL_AO,
+		&mtk_clk_pll_ops),
+	PLL(APMIXED_UNIVPLL, univpll, clk26m, 0x0238, 0x0250,
+		0xf3000001, HAVE_RST_BAR | HAVE_FIX_FRQ | PLL_AO,
+		&mtk_clk_lc_pll_ops),
+	PLL(APMIXED_MMPLL, mmpll, clk26m, 0x0254, 0x026c,
+		0xf0000001, HAVE_PLL_HP | HAVE_RST_BAR, &mtk_clk_pll_ops),
+	PLL(APMIXED_MSDCPLL, msdcpll, clk26m, 0x0278, 0x0290,
+		0x80000001, HAVE_PLL_HP, &mtk_clk_pll_ops),
+	PLL(APMIXED_TVDPLL, tvdpll, clk26m, 0x0294, 0x02ac,
+		0x80000001, HAVE_PLL_HP, &mtk_clk_tvd_pll_ops),
+	PLL(APMIXED_LVDSPLL, lvdspll, clk26m, 0x02b0, 0x02c8,
+		0x80000001, HAVE_PLL_HP, &mtk_clk_pll_ops),
+	PLL(APMIXED_AUDPLL, audpll, clk26m, 0x02e8, 0x0300,
+		0x80000001, 0, &mtk_clk_aud_pll_ops),
+	PLL(APMIXED_VDECPLL, vdecpll, clk26m, 0x0304, 0x031c,
+		0x80000001, HAVE_PLL_HP, &mtk_clk_pll_ops),
+};
+
+static void __init init_clk_apmixedsys(void __iomem *apmixed_base,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < ARRAY_SIZE(plls); i++) {
+		struct mtk_pll *pll = &plls[i];
+
+		clk = mtk_clk_register_pll(pll->name, pll->parent_name,
+				apmixed_base + pll->reg,
+				apmixed_base + pll->pwr_reg,
+				pll->en_mask, pll->flags, pll->ops);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					pll->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[pll->id] = clk;
+
+		pr_debug("pll %3d: %s\n", i, pll->name);
+	}
+}
+
+/*
+ * device tree support
+ */
+
+static struct clk_onecell_data *alloc_clk_data(unsigned int clk_num)
+{
+	int i;
+	struct clk_onecell_data *clk_data;
+
+	clk_data = kzalloc(sizeof(clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return NULL;
+
+	clk_data->clks = kcalloc(clk_num, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks) {
+		kfree(clk_data);
+		return NULL;
+	}
+
+	clk_data->clk_num = clk_num;
+
+	for (i = 0; i < clk_num; ++i)
+		clk_data->clks[i] = ERR_PTR(-ENOENT);
+
+	return clk_data;
+}
+
+static void __init mtk_topckgen_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	void __iomem *base;
+	int r;
+
+	pr_debug("%s: %s\n", __func__, node->name);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("ioremap topckgen failed\n");
+		return;
+	}
+
+	clk_data = alloc_clk_data(TOP_NR_CLK);
+
+	init_clk_root_alias(clk_data);
+	init_clk_top_div(clk_data);
+	init_clk_topckgen(base, clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("could not register clock provide\n");
+}
+CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8135-topckgen", mtk_topckgen_init);
+
+static void __init mtk_apmixedsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	void __iomem *base;
+	int r;
+
+	pr_debug("%s: %s\n", __func__, node->name);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("ioremap apmixedsys failed\n");
+		return;
+	}
+
+	clk_data = alloc_clk_data(APMIXED_NR_CLK);
+
+	init_clk_apmixedsys(base, clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("could not register clock provide\n");
+}
+CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8135-apmixedsys",
+		mtk_apmixedsys_init);
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
new file mode 100644
index 0000000..41a12d3
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -0,0 +1,93 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+
+static DEFINE_SPINLOCK(clk_ops_lock);
+
+spinlock_t *get_mtk_clk_lock(void)
+{
+	return &clk_ops_lock;
+}
+
+/*
+ * clk_mux
+ */
+
+struct clk *mtk_clk_register_mux(
+		const char *name,
+		const char **parent_names,
+		u8 num_parents,
+		void __iomem *base_addr,
+		u8 shift,
+		u8 width,
+		u8 gate_bit)
+{
+	struct clk *clk;
+	struct clk_mux *mux;
+	struct clk_gate *gate = NULL;
+	struct clk_hw *gate_hw = NULL;
+	const struct clk_ops *gate_ops = NULL;
+	u32 mask = BIT(width) - 1;
+
+	pr_debug("name: %s, num_parents: %d, gate_bit: %d\n",
+		name, (int)num_parents, (int)gate_bit);
+
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux->reg = base_addr;
+	mux->mask = mask;
+	mux->shift = shift;
+	mux->flags = 0;
+	mux->lock = &clk_ops_lock;
+
+	if (gate_bit <= MAX_MUX_GATE_BIT) {
+		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(mux);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		gate->reg = base_addr;
+		gate->bit_idx = gate_bit;
+		gate->flags = CLK_GATE_SET_TO_DISABLE;
+		gate->lock = &clk_ops_lock;
+
+		gate_hw = &gate->hw;
+		gate_ops = &clk_gate_ops;
+	}
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+		&mux->hw, &clk_mux_ops,
+		NULL, NULL,
+		gate_hw, gate_ops,
+		CLK_IGNORE_UNUSED);
+
+	if (IS_ERR(clk)) {
+		kfree(gate);
+		kfree(mux);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
new file mode 100644
index 0000000..b69245d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_MTK_H
+#define __DRV_CLK_MTK_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#define CLK_DEBUG		0
+#define DUMMY_REG_TEST		0
+
+extern spinlock_t *get_mtk_clk_lock(void);
+
+#define mtk_clk_lock(flags)	spin_lock_irqsave(get_mtk_clk_lock(), flags)
+#define mtk_clk_unlock(flags)	\
+	spin_unlock_irqrestore(get_mtk_clk_lock(), flags)
+
+#define MAX_MUX_GATE_BIT	31
+#define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
+
+struct clk *mtk_clk_register_mux(
+		const char *name,
+		const char **parent_names,
+		u8 num_parents,
+		void __iomem *base_addr,
+		u8 shift,
+		u8 width,
+		u8 gate_bit);
+
+#endif /* __DRV_CLK_MTK_H */
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
new file mode 100644
index 0000000..864cc60
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+/*
+ * clk_pll
+ */
+
+struct clk *mtk_clk_register_pll(
+		const char *name,
+		const char *parent_name,
+		u32 *base_addr,
+		u32 *pwr_addr,
+		u32 en_mask,
+		u32 flags,
+		const struct clk_ops *ops)
+{
+	struct mtk_clk_pll *pll;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	pr_debug("name: %s\n", name);
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base_addr = base_addr;
+	pll->pwr_addr = pwr_addr;
+	pll->en_mask = en_mask;
+	pll->flags = flags;
+	pll->hw.init = &init;
+
+	init.name = name;
+	init.ops = ops;
+	init.flags = CLK_IGNORE_UNUSED;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clk = clk_register(NULL, &pll->hw);
+
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
new file mode 100644
index 0000000..cb7f335
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_PLL_H
+#define __DRV_CLK_PLL_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+struct mtk_clk_pll {
+	struct clk_hw	hw;
+	void __iomem	*base_addr;
+	void __iomem	*pwr_addr;
+	u32		en_mask;
+	u32		flags;
+};
+
+#define to_mtk_clk_pll(_hw) container_of(_hw, struct mtk_clk_pll, hw)
+
+#define HAVE_RST_BAR	BIT(0)
+#define HAVE_PLL_HP	BIT(1)
+#define HAVE_FIX_FRQ	BIT(2)
+#define PLL_AO		BIT(3)
+
+struct clk *mtk_clk_register_pll(
+		const char *name,
+		const char *parent_name,
+		u32 *base_addr,
+		u32 *pwr_addr,
+		u32 en_mask,
+		u32 flags,
+		const struct clk_ops *ops);
+
+#endif /* __DRV_CLK_PLL_H */
diff --git a/include/dt-bindings/clock/mt8135-clk.h b/include/dt-bindings/clock/mt8135-clk.h
new file mode 100644
index 0000000..674fd1a
--- /dev/null
+++ b/include/dt-bindings/clock/mt8135-clk.h
@@ -0,0 +1,128 @@
+/*
+* Copyright (c) 2014 MediaTek Inc.
+* Author: James Liao <jamesjj.liao@mediatek.com>
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License version 2 as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*/
+
+#ifndef _DT_BINDINGS_CLK_MT8135_H
+#define _DT_BINDINGS_CLK_MT8135_H
+
+/* TOPCKGEN */
+
+#define TOP_DSI0_LNTC_DSICLK	1
+#define TOP_HDMITX_CLKDIG_CTS	2
+#define TOP_CLKPH_MCK		3
+#define TOP_CPUM_TCK_IN		4
+#define TOP_MAINPLL_806M	5
+#define TOP_MAINPLL_537P3M	6
+#define TOP_MAINPLL_322P4M	7
+#define TOP_MAINPLL_230P3M	8
+#define TOP_UNIVPLL_624M	9
+#define TOP_UNIVPLL_416M	10
+#define TOP_UNIVPLL_249P6M	11
+#define TOP_UNIVPLL_178P3M	12
+#define TOP_UNIVPLL_48M		13
+#define TOP_MMPLL_D2		14
+#define TOP_MMPLL_D3		15
+#define TOP_MMPLL_D5		16
+#define TOP_MMPLL_D7		17
+#define TOP_MMPLL_D4		18
+#define TOP_MMPLL_D6		19
+#define TOP_SYSPLL_D2		20
+#define TOP_SYSPLL_D4		21
+#define TOP_SYSPLL_D6		22
+#define TOP_SYSPLL_D8		23
+#define TOP_SYSPLL_D10		24
+#define TOP_SYSPLL_D12		25
+#define TOP_SYSPLL_D16		26
+#define TOP_SYSPLL_D24		27
+#define TOP_SYSPLL_D3		28
+#define TOP_SYSPLL_D2P5		29
+#define TOP_SYSPLL_D5		30
+#define TOP_SYSPLL_D3P5		31
+#define TOP_UNIVPLL1_D2		32
+#define TOP_UNIVPLL1_D4		33
+#define TOP_UNIVPLL1_D6		34
+#define TOP_UNIVPLL1_D8		35
+#define TOP_UNIVPLL1_D10	36
+#define TOP_UNIVPLL2_D2		37
+#define TOP_UNIVPLL2_D4		38
+#define TOP_UNIVPLL2_D6		39
+#define TOP_UNIVPLL2_D8		40
+#define TOP_UNIVPLL_D3		41
+#define TOP_UNIVPLL_D5		42
+#define TOP_UNIVPLL_D7		43
+#define TOP_UNIVPLL_D10		44
+#define TOP_UNIVPLL_D26		45
+#define TOP_APLL_CK		46
+#define TOP_APLL_D4		47
+#define TOP_APLL_D8		48
+#define TOP_APLL_D16		49
+#define TOP_APLL_D24		50
+#define TOP_LVDSPLL_D2		51
+#define TOP_LVDSPLL_D4		52
+#define TOP_LVDSPLL_D8		53
+#define TOP_LVDSTX_CLKDIG_CT	54
+#define TOP_VPLL_DPIX_CK	55
+#define TOP_TVHDMI_H_CK		56
+#define TOP_HDMITX_CLKDIG_D2	57
+#define TOP_HDMITX_CLKDIG_D3	58
+#define TOP_TVHDMI_D2		59
+#define TOP_TVHDMI_D4		60
+#define TOP_MEMPLL_MCK_D4	61
+#define TOP_AXI_SEL		62
+#define TOP_SMI_SEL		63
+#define TOP_MFG_SEL		64
+#define TOP_IRDA_SEL		65
+#define TOP_CAM_SEL		66
+#define TOP_AUD_INTBUS_SEL	67
+#define TOP_JPG_SEL		68
+#define TOP_DISP_SEL		69
+#define TOP_MSDC30_1_SEL	70
+#define TOP_MSDC30_2_SEL	71
+#define TOP_MSDC30_3_SEL	72
+#define TOP_MSDC30_4_SEL	73
+#define TOP_USB20_SEL		74
+#define TOP_VENC_SEL		75
+#define TOP_SPI_SEL		76
+#define TOP_UART_SEL		77
+#define TOP_MEM_SEL		78
+#define TOP_CAMTG_SEL		79
+#define TOP_AUDIO_SEL		80
+#define TOP_FIX_SEL		81
+#define TOP_VDEC_SEL		82
+#define TOP_DDRPHYCFG_SEL	83
+#define TOP_DPILVDS_SEL		84
+#define TOP_PMICSPI_SEL		85
+#define TOP_MSDC30_0_SEL	86
+#define TOP_SMI_MFG_AS_SEL	87
+#define TOP_GCPU_SEL		88
+#define TOP_DPI1_SEL		89
+#define TOP_CCI_SEL		90
+#define TOP_APLL_SEL		91
+#define TOP_HDMIPLL_SEL		92
+#define TOP_NR_CLK		93
+
+/* APMIXED_SYS */
+
+#define APMIXED_ARMPLL1		1
+#define APMIXED_ARMPLL2		2
+#define APMIXED_MAINPLL		3
+#define APMIXED_UNIVPLL		4
+#define APMIXED_MMPLL		5
+#define APMIXED_MSDCPLL		6
+#define APMIXED_TVDPLL		7
+#define APMIXED_LVDSPLL		8
+#define APMIXED_AUDPLL		9
+#define APMIXED_VDECPLL		10
+#define APMIXED_NR_CLK		11
+
+#endif /* _DT_BINDINGS_CLK_MT8135_H */
-- 
1.8.1.1.dirty
