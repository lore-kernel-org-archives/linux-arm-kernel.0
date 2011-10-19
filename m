From: zoss@devai.org (Zoltan Devai)
Date: Wed, 19 Oct 2011 18:01:55 +0200
Subject: [PATCH v2 2/5] ARM: SPMP8000: Add clk support
In-Reply-To: <1319040118-29773-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
Message-ID: <1319040118-29773-3-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the clk API

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/clkdev.c |  611 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-spmp8000/clock.c  |  149 ++++++++++
 arch/arm/mach-spmp8000/clock.h  |   32 ++
 3 files changed, 792 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/clkdev.c
 create mode 100644 arch/arm/mach-spmp8000/clock.c
 create mode 100644 arch/arm/mach-spmp8000/clock.h

diff --git a/arch/arm/mach-spmp8000/clkdev.c b/arch/arm/mach-spmp8000/clkdev.c
new file mode 100644
index 0000000..470ce1a
--- /dev/null
+++ b/arch/arm/mach-spmp8000/clkdev.c
@@ -0,0 +1,611 @@
+/*
+ * SPMP8000 machines clock support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+
+#include "clock.h"
+
+/* System Control Unit registers */
+#define SCU_A_PERI_CLKEN	0x04
+
+#define SCU_A_APLL_CFG		0x44
+#define APLL_CFG_P		BIT(0)
+#define APLL_CFG_S		BIT(1)
+#define APLL_CFG_F		BIT(2)
+#define APLL_CFG_E		BIT(3)
+#define APLL_CFG_AS_MASK	0x3F0
+#define APLL_CFG_AS_SHIFT	4
+#define APLL_CFG_AS_MAGIC	0x12
+#define APLL_CFG_C		BIT(10)
+#define APLL_CFG_R		BIT(11)
+#define APLL_CFG_DAR_SHIFT	16
+#define APLL_CFG_DAR_MASK	(7 << APLL_CFG_DAR_SHIFT)
+#define APLL_CFG_DS		BIT(19)
+#define APLL_CFG_ADR_SHIFT	24
+#define APLL_CFG_ADR_MASK	(7 << APLL_CFG_ADR_SHIFT)
+#define APLL_CFG_AS		BIT(27)
+
+#define SCU_A_LCD_CLK_CFG	0x80
+#define LCD_CLK_CFG_RATIO_MASK	0xFF
+#define LCD_CLK_CFG_EN		BIT(8)
+#define SCU_A_CSI_CLK_CFG	0x84
+#define CSI_CLK_CFG_RATIO_MASK	0xFF
+#define CSI_CLK_CFG_EN		BIT(8)
+#define SCU_A_I2S_BCK_CFG	0x90
+#define I2S_BCK_CFG_RATIO_MASK	0xFF
+#define I2S_BCK_CFG_EN		BIT(8)
+#define SCU_A_UART_CFG		0x94
+#define UART_CFG_RATIO_MASK	0xFF
+#define UART_CFG_EN		BIT(8)
+#define DIVIDER_ENABLE_BIT	BIT(8)
+
+#define SCU_B_PERI_CLKEN	0x20
+#define SCU_B_UPDATE_ARM_RATIO	0x28
+
+#define SCU_B_SPLL_CFG		0x04
+#define SPLL_CFG_R_MASK		3
+#define SPLL_CFG_R_SHIFT	0
+#define SPLL_CFG_F_MASK		0xFC
+#define SPLL_CFG_F_SHIFT	2
+#define SPLL_CFG_BS		BIT(8)
+#define SPLL_CFG_OD		BIT(9)
+#define SPLL_CFG_BP		BIT(10)
+#define SPLL_CFG_PD		BIT(11)
+#define SPLL_CFG_CSEL_MASK	(BIT(13) | BIT(12))
+#define SPLL_CFG_CSEL_SHIFT	12
+#define SPLL_CFG_ASEL_MASK	(BIT(15) | BIT(14))
+#define SPLL_CFG_ASEL_SHIFT	14
+#define SPLL_CFG_SE		BIT(17)
+#define SPLL_CFG_XE		BIT(18)
+#define SPLL_CFG_AE		BIT(19)
+#define SPLL_CFG_XR		BIT(20)
+#define SPLL_CFG_PL		BIT(31)
+
+#define SCU_B_ARM_RATIO		0xD0
+#define SCU_B_ARM_AHB_RATIO	0xD4
+#define SCU_B_ARM_APB_RATIO	0xD8
+#define SCU_B_SYS_CNT_EN	0xDC
+#define SYS_CNT_EN_SYS		BIT(0)
+#define SYS_CNT_EN_SYS_RT	BIT(1)
+#define SYS_CNT_EN_SYS_AHB	BIT(2)
+#define SYS_CNT_EN_SYS_APB	BIT(3)
+#define SYS_CNT_EN_SYS_CHECK	BIT(31)
+
+#define SCU_C_PERI_CLKEN	0x04
+
+#define SCU_C_UPDATE_SYS_RATIO	0x28
+#define SCU_C_SYS_RATIO		0x100
+#define SCU_C_SYS_RT_RATIO	0x104
+#define SCU_C_SYS_AHB_RATIO	0x108
+#define SCU_C_SYS_APB_RATIO	0x10C
+#define SCU_C_CEVA_RATIO	0x110
+#define SCU_C_CEVA_AHB_RATIO	0x114
+#define SCU_C_CEVA_APB_RATIO	0x118
+#define SCU_C_CEVA_CNT_EN	0x11C
+#define CEVA_CNT_EN_CEVA	BIT(0)
+#define CEVA_CNT_EN_CEVA_AHB	BIT(1)
+#define CEVA_CNT_EN_CEVA_APB	BIT(2)
+#define CEVA_CNT_EN_CEVA_CHECK	BIT(31)
+
+/* The SoC doesn't support anything else, no need to make these machine
+ * configurable.
+ */
+#define XTAL_FREQ		27000000UL
+#define XTAL_32K_FREQ		32768UL
+#define APLL_48K_FREQ		73728000UL
+#define APLL_44K_FREQ		67737600UL
+
+static void __iomem *scu_a_base;
+static void __iomem *scu_b_base;
+static void __iomem *scu_c_base;
+
+static unsigned long spll_get_rate(struct clk *clk)
+{
+	unsigned int f, r, od;
+	unsigned long osc;
+	u32 cfg;
+
+	cfg = readl(scu_b_base + SCU_B_SPLL_CFG);
+	osc = XTAL_FREQ;
+
+	f = (cfg & SPLL_CFG_F_MASK) >> SPLL_CFG_F_SHIFT;
+	r = (cfg & SPLL_CFG_R_MASK) >> SPLL_CFG_R_SHIFT;
+	od = !!(cfg & SPLL_CFG_OD);
+	clk->rate = (osc * (f + 1) * 2) / ((r + 1) * (od + 1));
+
+	return clk->rate;
+}
+
+static unsigned long pll_mux_get_rate(int ratesel, struct clk *clk)
+{
+	int pll_rate;
+
+	switch (ratesel) {
+	case 0:
+		clk->rate = XTAL_FREQ;
+		break;
+	case 1:
+		clk->rate = XTAL_32K_FREQ;
+		break;
+	case 2:
+		pll_rate = clk_get_rate(clk->parent);
+		clk->rate = pll_rate / 2;
+		break;
+	case 3:
+		pll_rate = clk_get_rate(clk->parent);
+		clk->rate = pll_rate / 3;
+		break;
+	}
+
+	return clk->rate;
+}
+
+static unsigned long ref_arm_get_rate(struct clk *clk)
+{
+	int ratesel;
+	u32 spll_cfg;
+
+	spll_cfg = readl(scu_b_base + SCU_B_SPLL_CFG);
+	ratesel = (spll_cfg & SPLL_CFG_ASEL_MASK) >> SPLL_CFG_ASEL_SHIFT;
+	return pll_mux_get_rate(ratesel, clk);
+}
+
+static unsigned long ref_ceva_get_rate(struct clk *clk)
+{
+	int ratesel;
+	u32 spll_cfg;
+
+	spll_cfg = readl(scu_b_base + SCU_B_SPLL_CFG);
+	ratesel = (spll_cfg & SPLL_CFG_CSEL_MASK) >> SPLL_CFG_CSEL_SHIFT;
+	return pll_mux_get_rate(ratesel, clk);
+}
+
+static unsigned long apll_get_rate(void)
+{
+	u32 cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+
+	if ((cfg & APLL_CFG_R) || (~cfg & (APLL_CFG_P | APLL_CFG_E)) ||
+		(((cfg & APLL_CFG_AS_MASK) >> APLL_CFG_AS_SHIFT)
+			!= APLL_CFG_AS_MAGIC)) {
+		return 0;
+	}
+
+	/* Not dealing with the input oscillator frequency as the settings
+	 * for non-27Mhz are unknown, and all platforms use that anyway */
+	if (cfg & APLL_CFG_S)
+		return APLL_44K_FREQ;
+	else
+		return APLL_48K_FREQ;
+}
+
+static void apll_enable(struct clk *clk)
+{
+	u32 cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+
+	/* Store new config with reset, then disable reset */
+	cfg |= APLL_CFG_R;
+	cfg |= APLL_CFG_E | APLL_CFG_P | APLL_CFG_F;
+	cfg |= APLL_CFG_AS_MAGIC << APLL_CFG_AS_SHIFT;
+
+	writel(cfg, scu_a_base + SCU_A_APLL_CFG);
+
+	cfg &= ~APLL_CFG_R;
+	writel(cfg, scu_a_base + SCU_A_APLL_CFG);
+}
+
+static void apll_disable(struct clk *clk)
+{
+	u32 cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+
+	cfg &= ~APLL_CFG_P;
+	cfg |= APLL_CFG_E;
+
+	writel(cfg, scu_a_base + SCU_A_APLL_CFG);
+}
+
+static int apll_set_rate(unsigned long rate)
+{
+	u32 cfg;
+
+	cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+
+	switch (rate) {
+	case 67737600:
+		cfg |= APLL_CFG_S;
+		break;
+	case 73728000:
+		cfg &= ~APLL_CFG_S;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel(cfg, scu_a_base + SCU_A_APLL_CFG);
+
+	return 0;
+}
+
+static void i2s_mck_switch(u32 mask, int enable)
+{
+	u32 cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+	if (enable)
+		cfg &= ~mask;
+	else
+		cfg |= mask;
+
+	writel(cfg, scu_a_base + SCU_A_APLL_CFG);
+}
+
+static void i2stx_mck_enable(struct clk *clk)
+{
+	i2s_mck_switch(APLL_CFG_DS, 1);
+}
+
+static void i2stx_mck_disable(struct clk *clk)
+{
+	i2s_mck_switch(APLL_CFG_DS, 0);
+}
+
+static void i2srx_mck_enable(struct clk *clk)
+{
+	i2s_mck_switch(APLL_CFG_AS, 1);
+}
+
+static void i2srx_mck_disable(struct clk *clk)
+{
+	i2s_mck_switch(APLL_CFG_AS, 0);
+}
+
+static const int apll_dividers[7] = {
+	3, 6, 9, 12, 18, 24, 32,
+};
+
+static unsigned long i2s_mck_get_rate(struct clk *clk, u32 msk, u32 sh)
+{
+	unsigned long apll_rate = apll_get_rate();
+	u32 cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+	int divider;
+
+	divider = (cfg & msk) >> sh;
+
+	if (divider == ARRAY_SIZE(apll_dividers))
+		return 0;
+
+	divider = apll_dividers[divider];
+
+	return apll_rate / divider;
+}
+
+static unsigned long i2stx_mck_get_rate(struct clk *clk)
+{
+	return i2s_mck_get_rate(clk, APLL_CFG_DAR_MASK, APLL_CFG_DAR_SHIFT);
+}
+
+static unsigned long i2srx_mck_get_rate(struct clk *clk)
+{
+	return i2s_mck_get_rate(clk, APLL_CFG_ADR_MASK, APLL_CFG_ADR_SHIFT);
+}
+
+static int i2s_mck_set_rate(struct clk *clk, unsigned long rate,
+					u32 msk, u32 sh)
+{
+	int i = ARRAY_SIZE(apll_dividers) - 1;
+	unsigned long apll_rate;
+	int divider = -1;
+	u32 cfg;
+
+	/* Set up APLL */
+	if (rate % 8000)
+		apll_rate = APLL_44K_FREQ;
+	else
+		apll_rate = APLL_48K_FREQ;
+
+	apll_set_rate(apll_rate);
+
+	cfg = readl(scu_a_base + SCU_A_APLL_CFG);
+
+	/* Get the biggest possible divider for MCK */
+	while (i >= 0) {
+		if (apll_rate / apll_dividers[i] == rate) {
+			divider = apll_dividers[i];
+			break;
+		}
+
+		i--;
+	}
+
+	if (divider < 0)
+		return -EINVAL;
+
+	cfg &= ~msk;
+	cfg |= (i << sh);
+
+	writel(cfg, scu_a_base + SCU_A_APLL_CFG);
+
+	return 0;
+}
+
+static int i2stx_mck_set_rate(struct clk *clk, unsigned long rate)
+{
+	return i2s_mck_set_rate(clk, rate,
+					APLL_CFG_DAR_MASK, APLL_CFG_DAR_SHIFT);
+}
+
+static int i2srx_mck_set_rate(struct clk *clk, unsigned long rate)
+{
+	return i2s_mck_set_rate(clk, rate,
+					APLL_CFG_ADR_MASK, APLL_CFG_ADR_SHIFT);
+}
+
+static void divider_set_clock(struct clk *clk, int on)
+{
+	u32 divider;
+
+	divider = readl(clk->scu_base + clk->scu_divreg);
+	if (on)
+		divider |= DIVIDER_ENABLE_BIT;
+	else
+		divider &= ~DIVIDER_ENABLE_BIT;
+	writel(divider, clk->scu_base + clk->scu_divreg);
+}
+
+static void divider_enable_clock(struct clk *clk)
+{
+	divider_set_clock(clk, 1);
+}
+
+static void divider_disable_clock(struct clk *clk)
+{
+	divider_set_clock(clk, 0);
+}
+
+static unsigned long divider_get_rate(struct clk *clk)
+{
+	u32 divider;
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+
+	if (!parent_rate) {
+		clk->rate = 0;
+		return clk->rate;
+	}
+
+	divider = readl(clk->scu_base + clk->scu_divreg);
+	clk->rate = parent_rate / ((divider & clk->divmask) + 1);
+
+	return clk->rate;
+}
+
+static int divider_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 divider, divider_old;
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+
+	if (unlikely(!parent_rate || rate > parent_rate)) {
+		clk->rate = parent_rate;
+		pr_debug("spmp8000: clk: parent rate < requested rate\n");
+		return 0;
+	}
+
+	divider = (parent_rate / rate) - 1;
+
+	if (divider > clk->divmask) {
+		pr_debug("spmp8000: clk: input clock / requested > max div\n");
+		divider = clk->divmask;
+	}
+
+	divider_old = readl(clk->scu_base + clk->scu_divreg);
+
+	/* Order of writes is important: 0 -> divider value -> enable bit */
+	writel(0, clk->scu_base + clk->scu_divreg);
+	writel(divider, clk->scu_base + clk->scu_divreg);
+
+	/* Re-enable clock if it was enabled before */
+	if (divider_old & DIVIDER_ENABLE_BIT)
+		writel(divider | DIVIDER_ENABLE_BIT,
+				clk->scu_base + clk->scu_divreg);
+
+	clk->rate = parent_rate / (divider + 1);
+
+	return 0;
+}
+static void periph_enable_clock(struct clk *clk)
+{
+	u32 scu_reg = readl(clk->scu_base + clk->scu_clkreg);
+
+	scu_reg |= (1 << clk->clkreg_off);
+
+	writel(scu_reg, clk->scu_base + clk->scu_clkreg);
+}
+
+static void periph_disable_clock(struct clk *clk)
+{
+	u32 scu_reg = readl(clk->scu_base + clk->scu_clkreg);
+
+	scu_reg &= ~(1 << clk->clkreg_off);
+
+	writel(scu_reg, clk->scu_base + clk->scu_clkreg);
+}
+
+void spmp8000_update_arm_freqs(void)
+{
+	writel(7, scu_b_base + SCU_B_UPDATE_ARM_RATIO);
+}
+EXPORT_SYMBOL(spmp8000_update_arm_freqs);
+
+static struct clk clk_spll = {
+	.get_rate = spll_get_rate,
+};
+
+static struct clk clk_ref_arm = {
+	.parent = &clk_spll,
+	.get_rate = ref_arm_get_rate,
+};
+
+static struct clk clk_ref_ceva = {
+	.parent = &clk_spll,
+	.get_rate = ref_ceva_get_rate,
+};
+
+static struct clk clk_apll = {
+	.name = "clk_apll",
+	.enable = apll_enable,
+	.disable = apll_disable,
+};
+
+static struct clk clk_i2stx_mck = {
+	.name = "clk_i2stx_mck",
+	.parent = &clk_apll,
+	.enable = i2stx_mck_enable,
+	.disable = i2stx_mck_disable,
+	.get_rate = i2stx_mck_get_rate,
+	.set_rate = i2stx_mck_set_rate,
+};
+
+static struct clk clk_i2srx_mck = {
+	.name = "clk_i2srx_mck",
+	.parent = &clk_apll,
+	.enable = i2srx_mck_enable,
+	.disable = i2srx_mck_disable,
+	.get_rate = i2srx_mck_get_rate,
+	.set_rate = i2srx_mck_set_rate,
+};
+
+#define SYS_CLK_DIV(__name, __parent, __scu_base, __divreg) \
+static struct clk __name = { \
+	.name = #__name, \
+	.parent = __parent, \
+	.scu_base = __scu_base, \
+	.scu_divreg = __divreg, \
+	.divmask = 0x3F, \
+	.get_rate = &divider_get_rate, \
+	.set_rate = &divider_set_rate, \
+}
+
+SYS_CLK_DIV(clk_arm, &clk_ref_arm, &scu_b_base, SCU_B_ARM_RATIO);
+SYS_CLK_DIV(clk_arm_ahb, &clk_arm, &scu_b_base, SCU_B_ARM_AHB_RATIO);
+SYS_CLK_DIV(clk_arm_apb, &clk_arm_ahb, &scu_b_base, SCU_B_ARM_APB_RATIO);
+SYS_CLK_DIV(clk_ceva, &clk_ref_ceva, &scu_c_base, SCU_C_CEVA_RATIO);
+SYS_CLK_DIV(clk_ceva_ahb, &clk_ceva, &scu_c_base, SCU_C_CEVA_AHB_RATIO);
+SYS_CLK_DIV(clk_ceva_apb, &clk_ceva_ahb, &scu_c_base, SCU_C_CEVA_APB_RATIO);
+SYS_CLK_DIV(clk_sys, &clk_ref_ceva, &scu_c_base, SCU_C_SYS_RATIO);
+SYS_CLK_DIV(clk_sys_ahb, &clk_sys, &scu_c_base, SCU_C_SYS_AHB_RATIO);
+SYS_CLK_DIV(clk_sys_apb, &clk_sys_ahb, &scu_c_base, SCU_C_SYS_APB_RATIO);
+
+#define SYS_CLK_DIV_EN(__name, __parent, __scu_base, __divreg) \
+static struct clk __name = { \
+	.name = #__name, \
+	.parent = __parent, \
+	.scu_base = __scu_base, \
+	.scu_divreg = __divreg, \
+	.divmask = 0xFF, \
+	.enable = &divider_enable_clock, \
+	.disable = &divider_disable_clock, \
+	.get_rate = &divider_get_rate, \
+	.set_rate = &divider_set_rate, \
+}
+
+SYS_CLK_DIV_EN(clk_uart, &clk_ref_ceva, &scu_a_base, SCU_A_UART_CFG);
+SYS_CLK_DIV_EN(clk_lcd, &clk_ref_ceva, &scu_a_base, SCU_A_LCD_CLK_CFG);
+SYS_CLK_DIV_EN(clk_i2srx_bck, &clk_i2srx_mck, &scu_a_base, SCU_A_I2S_BCK_CFG);
+SYS_CLK_DIV_EN(clk_i2stx_bck, &clk_i2stx_mck, &scu_a_base, SCU_A_I2S_BCK_CFG);
+
+/* Peripherals */
+#define PERIPH_CLK(__name, __parent, __scu_base, __clkreg_off) \
+static struct clk __name = { \
+	.name = #__name, \
+	.parent = __parent, \
+	.scu_base = __scu_base, \
+	.clkreg_off = __clkreg_off, \
+	.enable = periph_enable_clock, \
+	.disable = periph_disable_clock, \
+}
+
+PERIPH_CLK(clk_rt_abt, &clk_sys, &scu_a_base, 21);
+/* Make the parent rt_abt to auto-enable it when enabling the lcdc clock */
+PERIPH_CLK(clk_lcd_ctrl, &clk_rt_abt, &scu_a_base, 1);
+PERIPH_CLK(clk_apbdma_a, &clk_rt_abt, &scu_a_base, 9);
+PERIPH_CLK(clk_apll_ctrl, &clk_sys_ahb, &scu_a_base, 14);
+PERIPH_CLK(clk_i2stx_ctrl, &clk_apbdma_a, &scu_a_base, 17);
+PERIPH_CLK(clk_i2srx_ctrl, &clk_apbdma_a, &scu_a_base, 18);
+PERIPH_CLK(clk_saacc, &clk_sys_apb, &scu_a_base, 19);
+
+PERIPH_CLK(clk_tmrb, &clk_arm_apb, &scu_b_base, 9);
+PERIPH_CLK(clk_apbdma_c, &clk_sys_apb, &scu_c_base, 7);
+PERIPH_CLK(clk_sd0, &clk_sys_apb, &scu_c_base, 18);
+
+static struct clk_lookup lookups[] = {
+	CLKDEV_INIT(NULL, "arm", &clk_arm),
+	CLKDEV_INIT(NULL, "arm_ahb", &clk_arm_ahb),
+	CLKDEV_INIT(NULL, "arm_apb", &clk_arm_apb),
+	CLKDEV_INIT(NULL, "ceva", &clk_ceva),
+	CLKDEV_INIT(NULL, "ceva_ahb", &clk_ceva_ahb),
+	CLKDEV_INIT(NULL, "ceva_apb", &clk_ceva_apb),
+	CLKDEV_INIT(NULL, "sys", &clk_sys),
+	CLKDEV_INIT(NULL, "sys_ahb", &clk_sys_ahb),
+	CLKDEV_INIT(NULL, "sys_apb", &clk_sys_apb),
+	CLKDEV_INIT(NULL, "lcd", &clk_lcd),
+	CLKDEV_INIT(NULL, "apbdma_a", &clk_apbdma_a),
+	CLKDEV_INIT(NULL, "saacc", &clk_saacc),
+	CLKDEV_INIT(NULL, "i2stx_mck", &clk_i2stx_mck),
+	CLKDEV_INIT(NULL, "i2srx_mck", &clk_i2srx_mck),
+	CLKDEV_INIT(NULL, "i2stx_bck", &clk_i2stx_bck),
+	CLKDEV_INIT(NULL, "i2srx_bck", &clk_i2srx_bck),
+	CLKDEV_INIT("uart.0", NULL, &clk_uart),
+	CLKDEV_INIT("uart.1", NULL, &clk_uart),
+	CLKDEV_INIT("uart.2", NULL, &clk_uart),
+	CLKDEV_INIT("93000000.fb", NULL, &clk_lcd_ctrl),
+	CLKDEV_INIT("90000000.pwm", NULL, &clk_tmrb),
+	CLKDEV_INIT("92b00000.dma", NULL, &clk_apbdma_c),
+	CLKDEV_INIT("92b0b000.mmc", NULL, &clk_sd0),
+	CLKDEV_INIT("93010000.dma", NULL, &clk_apbdma_a),
+	CLKDEV_INIT("93012000.i2s", NULL, &clk_i2stx_ctrl),
+	CLKDEV_INIT("9301d000.i2s", NULL, &clk_i2srx_ctrl),
+};
+
+void __init *spmp8000_map_scu(const char *compatible)
+{
+	struct device_node *np;
+	void __iomem *addr;
+
+	np = of_find_compatible_node(NULL, NULL, compatible);
+	if (!np)
+		panic("spmp8000: unable to find %s node in dtb\n",
+			compatible);
+
+	addr = of_iomap(np, 0);
+	if (!addr)
+		panic("spmp8000: unable to map %s registers\n",
+			compatible);
+
+	return addr;
+}
+
+void __init spmp8000_init_clkdev(void)
+{
+	scu_a_base = spmp8000_map_scu("sunplus,spmp8000-scua");
+	scu_b_base = spmp8000_map_scu("sunplus,spmp8000-scub");
+	scu_c_base = spmp8000_map_scu("sunplus,spmp8000-scuc");
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	/* Enable the apll control registers here, as the according clock
+	 * isn't exported, but used by the mck/bck clocks. If we wouldn't
+	 * enable it here, the freq of the pll couldn't be set up before
+	 * enabling one of its child clocks.
+	 * The PLL clock itself will be auto-enabled on demand by them.
+	 */
+	clk_enable(&clk_apll_ctrl);
+}
diff --git a/arch/arm/mach-spmp8000/clock.c b/arch/arm/mach-spmp8000/clock.c
new file mode 100644
index 0000000..d3b95ec
--- /dev/null
+++ b/arch/arm/mach-spmp8000/clock.c
@@ -0,0 +1,149 @@
+/*
+ * Usual clk API boilerplate
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+
+#include "clock.h"
+
+static DEFINE_MUTEX(clocks_mutex);
+
+static void __clk_disable(struct clk *clk)
+{
+	BUG_ON(clk->refcount == 0);
+
+	if (!(--clk->refcount)) {
+		if (clk->disable)
+			clk->disable(clk);
+		if (clk->parent)
+			__clk_disable(clk->parent);
+	}
+}
+
+static int __clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (clk->refcount++ == 0) {
+		if (clk->parent)
+			ret = __clk_enable(clk->parent);
+		if (ret)
+			return ret;
+		else if (clk->enable)
+			clk->enable(clk);
+	}
+
+	return 0;
+}
+
+int clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+	ret = __clk_enable(clk);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return;
+
+	mutex_lock(&clocks_mutex);
+	__clk_disable(clk);
+	mutex_unlock(&clocks_mutex);
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return 0UL;
+
+	if (clk->get_rate)
+		return clk->get_rate(clk);
+
+	return clk_get_rate(clk->parent);
+}
+EXPORT_SYMBOL_GPL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return 0;
+	if (unlikely(!clk->round_rate))
+		return 0;
+
+	return clk->round_rate(clk, rate);
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EINVAL;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return ret;
+
+	if (unlikely(!clk->set_rate || !rate))
+		return ret;
+
+	mutex_lock(&clocks_mutex);
+	ret = clk->set_rate(clk, rate);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk *old;
+	int ret = -EINVAL;
+
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return ret;
+	if (unlikely(!clk->set_parent || !parent))
+		return ret;
+
+	mutex_lock(&clocks_mutex);
+	old = clk->parent;
+	if (clk->refcount)
+		__clk_enable(parent);
+	ret = clk->set_parent(clk, parent);
+	if (ret)
+		old = parent;
+	if (clk->refcount)
+		__clk_disable(old);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (unlikely(IS_ERR_OR_NULL(clk)))
+		return NULL;
+
+	return clk->parent;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent);
diff --git a/arch/arm/mach-spmp8000/clock.h b/arch/arm/mach-spmp8000/clock.h
new file mode 100644
index 0000000..d20759a
--- /dev/null
+++ b/arch/arm/mach-spmp8000/clock.h
@@ -0,0 +1,32 @@
+/*
+ * SPMP8000 machines clock support
+ *
+ * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __MACH_SPMP8000_CLOCK_H__
+#define __MACH_SPMP8000_CLOCK_H__
+
+struct clk {
+	char		*name;
+	unsigned long	rate;
+	unsigned int	id;
+	unsigned int	refcount;
+	void __iomem	*scu_base;
+	int		scu_clkreg;
+	unsigned int	clkreg_off;
+	int		scu_divreg;
+	int		divmask;
+	struct clk	*parent;
+	unsigned long	(*get_rate)(struct clk *clk);
+	unsigned long	(*round_rate) (struct clk *, u32);
+	int		(*set_rate) (struct clk *, unsigned long);
+	int		(*set_parent) (struct clk *clk, struct clk *parent);
+	void		(*enable) (struct clk *);
+	void		(*disable) (struct clk *);
+};
+
+#endif /* __MACH_SPMP8000_CLOCK_H__ */
-- 
1.7.4.1
