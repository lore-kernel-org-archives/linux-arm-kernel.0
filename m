From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:06 +0200
Subject: [PATCH 3/9] ARM: SPMP8000: Add clk support
In-Reply-To: <1318178172-7965-1-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
Message-ID: <1318178172-7965-4-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Zoltan Devai <zoss@devai.org>
---
 arch/arm/mach-spmp8000/clkdev.c             |  586 +++++++++++++++++++++++++++
 arch/arm/mach-spmp8000/clock.c              |  155 +++++++
 arch/arm/mach-spmp8000/include/mach/clock.h |   37 ++
 3 files changed, 778 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spmp8000/clkdev.c
 create mode 100644 arch/arm/mach-spmp8000/clock.c
 create mode 100644 arch/arm/mach-spmp8000/include/mach/clock.h

diff --git a/arch/arm/mach-spmp8000/clkdev.c b/arch/arm/mach-spmp8000/clkdev.c
new file mode 100644
index 0000000..c492d20
--- /dev/null
+++ b/arch/arm/mach-spmp8000/clkdev.c
@@ -0,0 +1,586 @@
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
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <mach/clock.h>
+#include <mach/scu.h>
+
+/* The SoC doesn't support anything else, so no need to make these machine
+ * configurable.
+ */
+#define XTAL_FREQ		27000000UL
+#define XTAL_32K_FREQ		32768UL
+#define APLL_48K_FREQ		73728000UL
+#define APLL_44K_FREQ		67737600UL
+
+static unsigned long spll_get_rate(struct clk *clk)
+{
+	unsigned int f, r, od;
+	unsigned long osc;
+	u32 cfg;
+
+	cfg = readl(REG_SCU_B(SCU_B_SPLL_CFG));
+	osc = XTAL_FREQ;
+
+	/* SPLL off ? */
+	if ((cfg & (SPLL_CFG_XR | SPLL_CFG_PD | SPLL_CFG_BP)) ||
+		(~cfg & (SPLL_CFG_PL | SPLL_CFG_XE | SPLL_CFG_SE))) {
+		return 0;
+	}
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
+	spll_cfg = readl(REG_SCU_B(SCU_B_SPLL_CFG));
+	ratesel = (spll_cfg & SPLL_CFG_ASEL_MASK) >> SPLL_CFG_ASEL_SHIFT;
+	return pll_mux_get_rate(ratesel, clk);
+}
+
+static unsigned long ref_ceva_get_rate(struct clk *clk)
+{
+	int ratesel;
+	u32 spll_cfg;
+
+	spll_cfg = readl(REG_SCU_B(SCU_B_SPLL_CFG));
+	ratesel = (spll_cfg & SPLL_CFG_CSEL_MASK) >> SPLL_CFG_CSEL_SHIFT;
+	return pll_mux_get_rate(ratesel, clk);
+}
+
+static unsigned long apll_get_rate(void)
+{
+	u32 cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
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
+	u32 cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
+
+	/* Store new config with reset, then disable reset */
+	cfg |= APLL_CFG_R;
+	cfg |= APLL_CFG_E | APLL_CFG_P | APLL_CFG_F;
+	cfg |= APLL_CFG_AS_MAGIC << APLL_CFG_AS_SHIFT;
+
+	writel(cfg, REG_SCU_A(SCU_A_APLL_CFG));
+
+	cfg &= ~APLL_CFG_R;
+	writel(cfg, REG_SCU_A(SCU_A_APLL_CFG));
+}
+
+static void apll_disable(struct clk *clk)
+{
+	u32 cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
+
+	cfg &= ~APLL_CFG_P;
+	cfg |= APLL_CFG_E;
+
+	writel(cfg, REG_SCU_A(SCU_A_APLL_CFG));
+}
+
+static int apll_set_rate(unsigned long rate)
+{
+	u32 cfg;
+
+	cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
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
+	writel(cfg, REG_SCU_A(SCU_A_APLL_CFG));
+
+	return 0;
+}
+
+static void i2s_mck_switch(u32 mask, int enable)
+{
+	u32 cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
+	if (enable)
+		cfg &= ~mask;
+	else
+		cfg |= mask;
+
+	writel(cfg, REG_SCU_A(SCU_A_APLL_CFG));
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
+	u32 cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
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
+	cfg = readl(REG_SCU_A(SCU_A_APLL_CFG));
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
+	writel(cfg, REG_SCU_A(SCU_A_APLL_CFG));
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
+static int divider_set_clock(struct clk *clk, int on)
+{
+	u32 divider;
+
+	if (!(clk->flags & CLK_DIVIDER_WITH_ENABLE))
+		return -EINVAL;
+
+	divider = readl(REG_SCU_BASE(clk->scu) + clk->dividerreg);
+	if (on)
+		divider |= DIVIDER_ENABLE_BIT;
+	else
+		divider = 0;
+	writel(divider, REG_SCU_BASE(clk->scu) + clk->dividerreg);
+
+	return 0;
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
+	divider = readl(REG_SCU_BASE(clk->scu) + clk->dividerreg);
+	if ((clk->flags & CLK_DIVIDER_WITH_ENABLE) &&
+		!(divider & DIVIDER_ENABLE_BIT)) {
+		clk->rate = 0UL;
+		return clk->rate;
+	}
+
+	clk->rate = parent_rate / ((divider & clk->divmask) + 1);
+
+	return clk->rate;
+}
+
+static int divider_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+	u32 divider, divider_old;
+
+	if (unlikely(!parent_rate || rate > parent_rate)) {
+		clk->rate = 0;
+		pr_debug("parent rate not sufficient\n");
+		return -EINVAL;
+	}
+
+	divider = (parent_rate / rate) - 1;
+
+	if (divider > clk->divmask) {
+		pr_debug("input clock too high\n");
+		return -EINVAL;
+	};
+
+	divider_old = readl(REG_SCU_BASE(clk->scu) + clk->dividerreg);
+	writel(0, REG_SCU_BASE(clk->scu) + clk->dividerreg);
+	writel(divider, REG_SCU_BASE(clk->scu) + clk->dividerreg);
+
+	/* Re-enable clock if it was enabled before */
+	if (divider_old & DIVIDER_ENABLE_BIT)
+		writel(divider | DIVIDER_ENABLE_BIT,
+			REG_SCU_BASE(clk->scu) + clk->dividerreg);
+
+	clk->rate = parent_rate / (divider + 1);
+
+	return 0;
+}
+static void periph_enable_clock(struct clk *clk)
+{
+	u32 scu_reg = readl(REG_SCU_CLKEN(clk->scu));
+
+	scu_reg |= (1 << clk->scu_periph_id);
+
+	writel(scu_reg, REG_SCU_CLKEN(clk->scu));
+}
+
+static void periph_disable_clock(struct clk *clk)
+{
+	u32 scu_reg = readl(REG_SCU_CLKEN(clk->scu));
+
+	scu_reg &= ~(1 << clk->scu_periph_id);
+
+	writel(scu_reg, REG_SCU_CLKEN(clk->scu));
+}
+
+void spmp8000_update_arm_freqs(void)
+{
+	writel(7, REG_SCU_B(SCU_B_UPDATE_ARM_RATIO));
+}
+EXPORT_SYMBOL(spmp8000_update_arm_freqs);
+
+static struct clk clk_spll = {
+	.get_rate = spll_get_rate,
+	.flags = CLK_FIXED_RATE,
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
+#define SYSTEM_CLK(__name, __parent, __scu, __divider, __divmask, __flags) \
+static struct clk clk_##__name = { \
+	.name = "clk_" #__name, \
+	.parent = &clk_##__parent, \
+	.scu = REG_SCU_##__scu##_ID, \
+	.dividerreg = __divider, \
+	.divmask = __divmask, \
+	.flags = __flags, \
+	.enable = &divider_enable_clock, \
+	.disable = &divider_disable_clock, \
+	.get_rate = &divider_get_rate, \
+	.set_rate = &divider_set_rate, \
+}
+
+SYSTEM_CLK(arm, ref_arm, B, SCU_B_ARM_RATIO, 0x3F, 0);
+SYSTEM_CLK(arm_ahb, arm, B, SCU_B_ARM_AHB_RATIO, 0x3F, 0);
+SYSTEM_CLK(arm_apb, arm_ahb, B, SCU_B_ARM_APB_RATIO, 0x3F, 0);
+SYSTEM_CLK(ceva, ref_ceva, C, SCU_C_CEVA_RATIO, 0x3F, 0);
+SYSTEM_CLK(ceva_ahb, ceva, C, SCU_C_CEVA_AHB_RATIO, 0x3F, 0);
+SYSTEM_CLK(ceva_apb, ceva_ahb, C, SCU_C_CEVA_APB_RATIO, 0x3F, 0);
+SYSTEM_CLK(sys, ref_ceva, C, SCU_C_SYS_RATIO, 0x3F, 0);
+SYSTEM_CLK(sys_ahb, sys, C, SCU_C_SYS_AHB_RATIO, 0x3F, 0);
+SYSTEM_CLK(sys_apb, sys_ahb, C, SCU_C_SYS_APB_RATIO, 0x3F, 0);
+
+SYSTEM_CLK(uart, ref_ceva, A, SCU_A_UART_CFG, 0xFF, CLK_DIVIDER_WITH_ENABLE);
+SYSTEM_CLK(lcd, ref_ceva, A, SCU_A_LCD_CLK_CFG, 0xFF, CLK_DIVIDER_WITH_ENABLE);
+SYSTEM_CLK(csi, ref_ceva, A, SCU_A_CSI_CLK_CFG, 0xFF, CLK_DIVIDER_WITH_ENABLE);
+SYSTEM_CLK(i2srx_bck, i2srx_mck, A, SCU_A_I2S_BCK_CFG, 0xFF,
+		CLK_DIVIDER_WITH_ENABLE);
+SYSTEM_CLK(i2stx_bck, i2stx_mck, A, SCU_A_I2S_BCK_CFG, 0xFF,
+		CLK_DIVIDER_WITH_ENABLE);
+
+
+/* Peripherals */
+#define PERIPH_CLK(__name, __parent, __scu, __id) \
+static struct clk clk_##__name = { \
+	.name = "clk_" #__name, \
+	.parent = &__parent, \
+	.scu = REG_SCU_##__scu##_ID, \
+	.scu_periph_id = __id, \
+	.enable = periph_enable_clock, \
+	.disable = periph_disable_clock, \
+}
+
+/* Not needed yet for any driver */
+#if 0
+PERIPH_CLK(drm, clk_sys_ahb, A, 2);
+PERIPH_CLK(usb_host, clk_sys_ahb, A, 3);
+PERIPH_CLK(usb_device, clk_sys_ahb, A, 4);
+PERIPH_CLK(scu_a, clk_sys_ahb, A, 6);
+PERIPH_CLK(tvout, clk_sys, A, 7);
+PERIPH_CLK(csi_ctrl, clk_sys, A, 10);
+PERIPH_CLK(nand0, clk_sys_ahb, A, 11);
+PERIPH_CLK(nand1, clk_sys_ahb, A, 12);
+PERIPH_CLK(ecc, clk_sys_ahb, A, 13);
+PERIPH_CLK(uart_con, clk_sys_ahb, A, 15);
+PERIPH_CLK(aahbm212, clk_sys, A, 16);
+PERIPH_CLK(nand_abt, clk_sys_ahb, A, 20);
+PERIPH_CLK(rt_abt212, clk_sys, A, 22);
+PERIPH_CLK(cahbm212, clk_sys, A, 23);
+
+PERIPH_CLK(tcm_bist, clk_arm, B, 0);
+PERIPH_CLK(tcm_ctrl, clk_arm, B, 1);
+PERIPH_CLK(ahb2ahb, clk_arm, B, 2);
+PERIPH_CLK(ahbsw, clk_arm, B, 3);
+PERIPH_CLK(vic0, clk_arm_ahb, B, 4);
+PERIPH_CLK(vic1, clk_arm_ahb, B, 5);
+PERIPH_CLK(dpm, clk_arm_ahb, B, 6);
+PERIPH_CLK(apbb, clk_arm_ahb, B, 7);
+PERIPH_CLK(arm926, clk_arm, B, 8);
+PERIPH_CLK(wdt, clk_arm_apb, B, 10);
+PERIPH_CLK(uartapb, clk_arm_apb, B, 11);
+PERIPH_CLK(i2c, clk_arm_apb, B, 12);
+PERIPH_CLK(rand, clk_arm_apb, B, 13);
+PERIPH_CLK(gpio0, clk_arm_apb, B, 14);
+PERIPH_CLK(rtc, clk_arm_apb, B, 15);
+
+PERIPH_CLK(fabricc, clk_sys, C, 0);
+PERIPH_CLK(dmac0, clk_sys, C, 1);
+PERIPH_CLK(dmac1, clk_sys, C, 2);
+PERIPH_CLK(dram_ctrl, clk_sys, C, 4);
+PERIPH_CLK(scu_c, clk_sys, C, 5);
+PERIPH_CLK(i2c_ctrl, clk_sys, C, 6);
+PERIPH_CLK(2d, clk_sys, C, 8);
+PERIPH_CLK(extmem, clk_sys, C, 9);
+PERIPH_CLK(cf, clk_sys_apb, C, 10);
+PERIPH_CLK(ms, clk_sys_apb, C, 11);
+PERIPH_CLK(intmem, clk_sys, C, 12);
+PERIPH_CLK(uartc0, clk_sys_apb, C, 13);
+PERIPH_CLK(uartc1, clk_sys_apb, C, 14);
+PERIPH_CLK(uartc2, clk_sys_apb, C, 15);
+PERIPH_CLK(ssp0, clk_sys_apb, C, 16);
+PERIPH_CLK(ssp1, clk_sys_apb, C, 17);
+PERIPH_CLK(sd1, clk_sys_apb, C, 19);
+PERIPH_CLK(i2c_sys, clk_sys_apb, C, 20);
+PERIPH_CLK(scale, clk_sys, C, 21);
+PERIPH_CLK(scaleabt, clk_sys, C, 22);
+PERIPH_CLK(ti2c, clk_sys_apb, C, 23);
+PERIPH_CLK(fabric_a, clk_sys, C, 24);
+PERIPH_CLK(cxmp_sl, clk_sys, C, 25);
+PERIPH_CLK(cxmd_sl, clk_sys, C, 26);
+#endif
+
+PERIPH_CLK(rt_abt, clk_sys, A, 21);
+/* Make the parent rt_abt to auto-enable it when enabling the lcdc clock */
+PERIPH_CLK(lcd_ctrl, clk_rt_abt, A, 1);
+PERIPH_CLK(apbdma_a, clk_rt_abt, A, 9);
+PERIPH_CLK(apll_ctrl, clk_sys_ahb, A, 14);
+PERIPH_CLK(i2stx_ctrl, clk_apbdma_a, A, 17);
+PERIPH_CLK(i2srx_ctrl, clk_apbdma_a, A, 18);
+PERIPH_CLK(saacc, clk_sys_apb, A, 19);
+
+PERIPH_CLK(tmrb, clk_arm_apb, B, 9);
+PERIPH_CLK(apbdma_c, clk_sys_apb, C, 7);
+PERIPH_CLK(sd0, clk_sys_apb, C, 18);
+
+/* TODO use common macro once available */
+#define _DEFINE_CLKDEV_CON(n) \
+	{ \
+		.dev_id = NULL, \
+		.con_id = #n, \
+		.clk = &clk_##n, \
+	}
+
+#define _DEFINE_CLKDEV_DEV(d, c) \
+	{ \
+		.dev_id = d, \
+		.con_id = NULL, \
+		.clk = &clk_##c, \
+	}
+
+static struct clk_lookup lookups[] = {
+	_DEFINE_CLKDEV_CON(arm),
+	_DEFINE_CLKDEV_CON(arm_ahb),
+	_DEFINE_CLKDEV_CON(arm_apb),
+	_DEFINE_CLKDEV_CON(ceva),
+	_DEFINE_CLKDEV_CON(ceva_ahb),
+	_DEFINE_CLKDEV_CON(ceva_apb),
+	_DEFINE_CLKDEV_CON(sys),
+	_DEFINE_CLKDEV_CON(sys_ahb),
+	_DEFINE_CLKDEV_CON(sys_apb),
+	_DEFINE_CLKDEV_CON(lcd),
+	_DEFINE_CLKDEV_CON(apbdma_a),
+	_DEFINE_CLKDEV_CON(saacc),
+	_DEFINE_CLKDEV_CON(i2stx_mck),
+	_DEFINE_CLKDEV_CON(i2srx_mck),
+	_DEFINE_CLKDEV_CON(i2stx_bck),
+	_DEFINE_CLKDEV_CON(i2srx_bck),
+	_DEFINE_CLKDEV_DEV("uart.0", uart),
+	_DEFINE_CLKDEV_DEV("uart.1", uart),
+	_DEFINE_CLKDEV_DEV("uart.2", uart),
+	_DEFINE_CLKDEV_DEV("93000000.fb", lcd_ctrl),
+	_DEFINE_CLKDEV_DEV("90000000.pwm", tmrb),
+	_DEFINE_CLKDEV_DEV("92b00000.dma", apbdma_c),
+	_DEFINE_CLKDEV_DEV("92b0b000.mmc", sd0),
+	_DEFINE_CLKDEV_DEV("93010000.dma", apbdma_a),
+	_DEFINE_CLKDEV_DEV("93012000.i2s", i2stx_ctrl),
+	_DEFINE_CLKDEV_DEV("9301d000.i2s", i2srx_ctrl),
+};
+
+void __init spmp8000_init_clkdev(void)
+{
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
index 0000000..5652aff
--- /dev/null
+++ b/arch/arm/mach-spmp8000/clock.c
@@ -0,0 +1,155 @@
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
+#include <mach/clock.h>
+
+static DEFINE_MUTEX(clocks_mutex);
+
+static void __clk_disable(struct clk *clk)
+{
+	BUG_ON(clk->refcount == 0);
+
+	if (!(--clk->refcount) && clk->disable) {
+		clk->disable(clk);
+		if (clk->parent)
+			__clk_disable(clk->parent);
+	}
+}
+
+static int __clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (clk->refcount++ == 0 && clk->enable) {
+		if (clk->parent)
+			ret = __clk_enable(clk->parent);
+		if (ret)
+			return ret;
+		else
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
+	/* Is fixed and has been calculated already */
+	if ((clk->flags & CLK_FIXED_RATE) && clk->rate)
+		return clk->rate;
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
+	if (unlikely(clk->flags & CLK_FIXED_RATE))
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
diff --git a/arch/arm/mach-spmp8000/include/mach/clock.h b/arch/arm/mach-spmp8000/include/mach/clock.h
new file mode 100644
index 0000000..e5cdbd2
--- /dev/null
+++ b/arch/arm/mach-spmp8000/include/mach/clock.h
@@ -0,0 +1,37 @@
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
+	int		scu;
+	int		scu_periph_id;
+	int		dividerreg;
+	int		divmask;
+	unsigned long	flags;
+/* Either really fixed rate (crystal) or which we don't change for sure */
+#define CLK_FIXED_RATE			BIT(0)
+/* SPMP8000 has two types of dividers, one of them needs enabling */
+#define CLK_DIVIDER_WITH_ENABLE		BIT(1)
+
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
