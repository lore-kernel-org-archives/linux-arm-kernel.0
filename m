From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Dec 2009 18:15:37 +0900
Subject: [PATCH 2/7] ARM: S5P6440: Add Clock and PLL support
Message-ID: <1261127737-30131-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock and pll support for S5P6440. This patch are based on
Harald Welte's patches and Ben's plat-samsung.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/regs-clock.h |  207 +++++++
 arch/arm/plat-s5p/clock.c                       |  147 +++++
 arch/arm/plat-s5p/include/plat/pll.h            |   74 +++
 arch/arm/plat-s5p/include/plat/s5p-clock.h      |   41 ++
 arch/arm/plat-s5p/s5p6440-clock.c               |  705 +++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/clock.h      |    1 +
 6 files changed, 1175 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-clock.h
 create mode 100644 arch/arm/plat-s5p/clock.c
 create mode 100644 arch/arm/plat-s5p/include/plat/pll.h
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p-clock.h
 create mode 100644 arch/arm/plat-s5p/s5p6440-clock.c

diff --git a/arch/arm/mach-s5p6440/include/mach/regs-clock.h b/arch/arm/mach-s5p6440/include/mach/regs-clock.h
new file mode 100644
index 0000000..4632f45
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/regs-clock.h
@@ -0,0 +1,207 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/regs-clock.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - Clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_CLOCK_H
+#define __ASM_ARCH_REGS_CLOCK_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_CLKREG(x)		(S5P_VA_CLK + (x))
+
+#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
+#define S5P_MPLL_LOCK		S5P_CLKREG(0x04)
+#define S5P_EPLL_LOCK		S5P_CLKREG(0x08)
+#define S5P_APLL_CON		S5P_CLKREG(0x0C)
+#define S5P_MPLL_CON		S5P_CLKREG(0x10)
+#define S5P_EPLL_CON		S5P_CLKREG(0x14)
+#define S5P_EPLL_CON_K		S5P_CLKREG(0x18)
+#define S5P_CLK_SRC0		S5P_CLKREG(0x1C)
+#define S5P_CLK_DIV0		S5P_CLKREG(0x20)
+#define S5P_CLK_DIV1		S5P_CLKREG(0x24)
+#define S5P_CLK_DIV2		S5P_CLKREG(0x28)
+#define S5P_CLK_OUT		S5P_CLKREG(0x2C)
+#define S5P_CLK_GATE_HCLK0	S5P_CLKREG(0x30)
+#define S5P_CLK_GATE_PCLK	S5P_CLKREG(0x34)
+#define S5P_CLK_GATE_SCLK0	S5P_CLKREG(0x38)
+#define S5P_CLK_GATE_MEM0	S5P_CLKREG(0x3C)
+#define S5P_CLK_DIV3		S5P_CLKREG(0x40)
+#define S5P_CLK_GATE_HCLK1	S5P_CLKREG(0x44)
+#define S5P_CLK_GATE_SCLK1	S5P_CLKREG(0x48)
+#define S5P_AHB_CON0           	S5P_CLKREG(0x100)
+#define S5P_CLK_SRC1           	S5P_CLKREG(0x10C)
+#define S5P_SWRESET		S5P_CLKREG(0x114)
+#define S5P_SYS_ID		S5P_CLKREG(0x118)
+#define S5P_SYS_OTHERS		S5P_CLKREG(0x11C)
+#define S5P_MEM_CFG_STAT	S5P_CLKREG(0x12C)
+#define S5P_PWR_CFG		S5P_CLKREG(0x804)
+#define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0x808)
+#define S5P_NORMAL_CFG		S5P_CLKREG(0x810)
+#define S5P_STOP_CFG		S5P_CLKREG(0x814)
+#define S5P_SLEEP_CFG		S5P_CLKREG(0x818)
+#define S5P_OSC_FREQ		S5P_CLKREG(0x820)
+#define S5P_OSC_STABLE		S5P_CLKREG(0x824)
+#define S5P_PWR_STABLE		S5P_CLKREG(0x828)
+#define S5P_MTC_STABLE		S5P_CLKREG(0x830)
+#define S5P_OTHERS		S5P_CLKREG(0x900)
+#define S5P_RST_STAT		S5P_CLKREG(0x904)
+#define S5P_WAKEUP_STAT		S5P_CLKREG(0x908)
+#define S5P_SLPEN		S5P_CLKREG(0x930)
+#define S5P_INFORM0		S5P_CLKREG(0xA00)
+#define S5P_INFORM1		S5P_CLKREG(0xA04)
+#define S5P_INFORM2		S5P_CLKREG(0xA08)
+#define S5P_INFORM3		S5P_CLKREG(0xA0C)
+
+/* CLKDIV0 */
+#define S5P_CLKDIV0_PCLK_MASK		(0xf << 12)
+#define S5P_CLKDIV0_PCLK_SHIFT		(12)
+#define S5P_CLKDIV0_HCLK_MASK		(0xf << 8)
+#define S5P_CLKDIV0_HCLK_SHIFT		(8)
+#define S5P_CLKDIV0_MPLL_MASK		(0x1 << 4)
+#define S5P_CLKDIV0_MPLL_SHIFT		(4)
+#define S5P_CLKDIV0_ARM_MASK		(0xf << 0)
+#define S5P_CLKDIV0_ARM_SHIFT		(0)
+
+/* CLKDIV1 */
+#define S5P_CLKDIV1_LCD_MASK		(0xf << 12)
+#define S5P_CLKDIV1_LCD_SHIFT		(12)
+#define S5P_CLKDIV1_MMC2_MASK		(0xf << 8)
+#define S5P_CLKDIV1_MMC2_SHIFT		(8)
+#define S5P_CLKDIV1_MMC1_MASK		(0xf << 4)
+#define S5P_CLKDIV1_MMC1_SHIFT		(4)
+#define S5P_CLKDIV1_MMC0_MASK		(0xf << 0)
+#define S5P_CLKDIV1_MMC0_SHIFT		(0)
+
+/* CLKDIV2 */
+#define S5P_CLKDIV2_AUDIO2_MASK		(0xf << 24)
+#define S5P_CLKDIV2_AUDIO2_SHIFT	(24)
+#define S5P_CLKDIV2_UART_MASK		(0xf << 16)
+#define S5P_CLKDIV2_UART_SHIFT		(16)
+#define S5P_CLKDIV2_SPI1_MASK		(0xf << 4)
+#define S5P_CLKDIV2_SPI1_SHIFT		(4)
+#define S5P_CLKDIV2_SPI0_MASK		(0xf << 0)
+#define S5P_CLKDIV2_SPI0_SHIFT		(0)
+
+/* CLKDIV3 */
+#define S5P_CLKDIV3_PCLK_LOW_MASK	(0xf << 12)
+#define S5P_CLKDIV3_PCLK_LOW_SHIFT	(12)
+#define S5P_CLKDIV3_HCLK_LOW_MASK	(0xf << 8)
+#define S5P_CLKDIV3_HCLK_LOW_SHIFT	(8)
+#define S5P_CLKDIV3_FIMGVG_MASK		(0xf << 4)
+#define S5P_CLKDIV3_FIMGVG_SHIFT	(4)
+#define S5P_CLKDIV3_DISPCON_MASK	(0xf << 0)
+#define S5P_CLKDIV3_DISPCON_SHIFT	(0)
+
+/* HCLK0 GATE Registers */
+#define S5P_CLKCON_HCLK0_MEM0		(1<<21)
+#define S5P_CLKCON_HCLK0_USB		(1<<20)
+#define S5P_CLKCON_HCLK0_HSMMC2		(1<<19)
+#define S5P_CLKCON_HCLK0_HSMMC1		(1<<18)
+#define S5P_CLKCON_HCLK0_HSMMC0		(1<<17)
+#define S5P_CLKCON_HCLK0_DMA0		(1<<12)
+#define S5P_CLKCON_HCLK0_2D		(1<<8)
+#define S5P_CLKCON_HCLK0_POST0		(1<<5)
+#define S5P_CLKCON_HCLK0_TZIC		(1<<2)
+#define S5P_CLKCON_HCLK0_INTC		(1<<1)
+
+/* HCLK1 GATE Registers */
+#define S5P_CLKCON_HCLK1_FIMGVG		(1<<2)
+#define S5P_CLKCON_HCLK1_DISPCON	(1<<1)
+#define S5P_CLKCON_HCLK1_TSI		(1<<0)
+
+/* PCLK GATE Registers */
+#define S5P_CLKCON_PCLK_FIMGVG		(1<<31)
+#define S5P_CLKCON_PCLK_DMC0		(1<<30)
+#define S5P_CLKCON_PCLK_ETM		(1<<29)
+#define S5P_CLKCON_PCLK_DSIM		(1<<28)
+#define S5P_CLKCON_PCLK_IIC1		(1<<27)
+#define S5P_CLKCON_PCLK_IIS2		(1<<26)
+#define S5P_CLKCON_PCLK_GPS		(1<<25)
+#define S5P_CLKCON_PCLK_CHIPID		(1<<23)
+#define S5P_CLKCON_PCLK_SPI1		(1<<22)
+#define S5P_CLKCON_PCLK_SPI0		(1<<21)
+#define S5P_CLKCON_PCLK_GPIO		(1<<18)
+#define S5P_CLKCON_PCLK_IIC0		(1<<17)
+#define S5P_CLKCON_PCLK_TSADC		(1<<12)
+#define S5P_CLKCON_PCLK_PCM0		(1<<8)
+#define S5P_CLKCON_PCLK_PWM		(1<<7)
+#define S5P_CLKCON_PCLK_RTC		(1<<6)
+#define S5P_CLKCON_PCLK_WDT		(1<<5)
+#define S5P_CLKCON_PCLK_UART3		(1<<4)
+#define S5P_CLKCON_PCLK_UART2		(1<<3)
+#define S5P_CLKCON_PCLK_UART1		(1<<2)
+#define S5P_CLKCON_PCLK_UART0		(1<<1)
+
+/* SCLK0 GATE Registers */
+#define S5P_CLKCON_SCLK0_MMC2_48	(1<<29)
+#define S5P_CLKCON_SCLK0_MMC1_48	(1<<28)
+#define S5P_CLKCON_SCLK0_MMC0_48	(1<<27)
+#define S5P_CLKCON_SCLK0_MMC2		(1<<26)
+#define S5P_CLKCON_SCLK0_MMC1		(1<<25)
+#define S5P_CLKCON_SCLK0_MMC0		(1<<24)
+#define S5P_CLKCON_SCLK0_SPI1_48 	(1<<23)
+#define S5P_CLKCON_SCLK0_SPI0_48 	(1<<22)
+#define S5P_CLKCON_SCLK0_SPI1		(1<<21)
+#define S5P_CLKCON_SCLK0_SPI0		(1<<20)
+#define S5P_CLKCON_SCLK0_AUDIO2		(1<<11)
+#define S5P_CLKCON_SCLK0_POST0		(1<<10)
+#define S5P_CLKCON_SCLK0_UART		(1<<5)
+
+/* SCLK1 GATE Registers */
+#define S5P_CLKCON_SCLK1_FIMGVG		(1<<2)
+#define S5P_CLKCON_SCLK1_DISPCON	(1<<1)
+
+/* MEM0 GATE Registers */
+#define S5P_CLKCON_MEM0_HCLK_NFCON	(1<<2)
+#define S5P_CLKCON_MEM0_HCLK_SROM	(1<<1)
+#define S5P_CLKCON_MEM0_HCLK_DMC0	(1<<0)
+
+/*OTHERS Resgister */
+#define S5P_OTHERS_USB_SIG_MASK		(1<<16)
+#define S5P_OTHERS_HCLK_LOW_SEL_MPLL	(1<<6)
+
+/* CLKSRC */
+#define S5P_CLKSRC_APLL_MOUT		(1 << 0)
+#define S5P_CLKSRC_MPLL_MOUT		(1 << 1)
+#define S5P_CLKSRC_EPLL_MOUT		(1 << 2)
+#define S5P_CLKSRC_APLL_MOUT_SHIFT	(0)
+#define S5P_CLKSRC_MPLL_MOUT_SHIFT	(1)
+#define S5P_CLKSRC_EPLL_MOUT_SHIFT	(2)
+
+#define S5P_CLKSRC_POST0_MASK		(0x3 << 26)
+#define S5P_CLKSRC_POST0_SHIFT		(26)
+#define S5P_CLKSRC_MMC2_MASK		(0x3 << 22)
+#define S5P_CLKSRC_MMC2_SHIFT		(22)
+#define S5P_CLKSRC_MMC1_MASK		(0x3 << 20)
+#define S5P_CLKSRC_MMC1_SHIFT		(20)
+#define S5P_CLKSRC_MMC0_MASK		(0x3 << 18)
+#define S5P_CLKSRC_MMC0_SHIFT		(18)
+#define S5P_CLKSRC_SPI1_MASK		(0x3 << 16)
+#define S5P_CLKSRC_SPI1_SHIFT		(16)
+#define S5P_CLKSRC_SPI0_MASK		(0x3 << 14)
+#define S5P_CLKSRC_SPI0_SHIFT		(14)
+#define S5P_CLKSRC_UART_MASK		(0x1 << 13)
+#define S5P_CLKSRC_UART_SHIFT		(13)
+
+#define S5P_CLKSRC1_AUDIO2_MASK		(0x7 << 0)
+#define S5P_CLKSRC1_AUDIO2_SHIFT	(0)
+
+/*CLK SRC BITS*/
+#define S5P_CLKSRC_APLL_CLKSEL          (1<<0)
+#define S5P_CLKSRC_MPLL_CLKSEL          (1<<1)
+#define S5P_CLKSRC_EPLL_CLKSEL          (1<<2)
+
+/* Compatibility defines */
+#define ARM_CLK_DIV			S5P_CLK_DIV0
+#define ARM_DIV_RATIO_SHIFT		0
+#define ARM_DIV_MASK			(0xf << ARM_DIV_RATIO_SHIFT)
+
+#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
new file mode 100644
index 0000000..9204f59
--- /dev/null
+++ b/arch/arm/plat-s5p/clock.c
@@ -0,0 +1,147 @@
+/* linux/arch/arm/plat-s5p/clock.c
+ *
+ * Copyright 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P - Common clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+#include <asm/div64.h>
+
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p-clock.h>
+
+int clk_default_setrate(struct clk *clk, unsigned long rate)
+{
+	clk->rate = rate;
+	return 0;
+}
+
+struct clk_ops clk_ops_def_setrate = {
+	.set_rate	= clk_default_setrate,
+};
+
+/* fin_apll, fin_mpll and fin_epll are all the same clock, which we call
+ * clk_ext_xtal_mux.
+*/
+struct clk clk_ext_xtal_mux = {
+	.name		= "ext_xtal",
+	.id		= -1,
+};
+
+/* 48MHz USB Phy clock output */
+struct clk clk_48m = {
+	.name		= "clk_48m",
+	.id		= -1,
+	.rate		= 48000000,
+	.enable		= s5p6440_clk48m_ctrl,
+};
+
+/* APLL clock output
+ * No need .ctrlbit, this is always on
+*/
+struct clk clk_fout_apll = {
+	.name		= "fout_apll",
+	.id		= -1,
+};
+
+/* MPLL clock output
+ * No need .ctrlbit, this is always on
+*/
+struct clk clk_fout_mpll = {
+	.name		= "fout_mpll",
+	.id		= -1,
+};
+
+/* EPLL clock output */
+struct clk clk_fout_epll = {
+	.name		= "fout_epll",
+	.id		= -1,
+	.ctrlbit	= (1 << 31),
+};
+
+/* ARM clock */
+struct clk clk_arm = {
+	.name		= "armclk",
+	.id		= -1,
+	.rate		= 0,
+	.ctrlbit	= 0,
+};
+
+/* Possible clock sources for APLL Mux */
+static struct clk *clk_src_apll_list[] = {
+	[0] = &clk_fin_apll,
+	[1] = &clk_fout_apll,
+};
+
+struct clksrc_sources clk_src_apll = {
+	.sources	= clk_src_apll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_apll_list),
+};
+
+/* Possible clock sources for MPLL Mux */
+static struct clk *clk_src_mpll_list[] = {
+	[0] = &clk_fin_mpll,
+	[1] = &clk_fout_mpll,
+};
+
+struct clksrc_sources clk_src_mpll = {
+	.sources	= clk_src_mpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_mpll_list),
+};
+
+/* Possible clock sources for EPLL Mux */
+static struct clk *clk_src_epll_list[] = {
+	[0] = &clk_fin_epll,
+	[1] = &clk_fout_epll,
+};
+
+struct clksrc_sources clk_src_epll = {
+	.sources	= clk_src_epll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
+};
+
+int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	u32 con;
+
+	con = __raw_readl(reg);
+	con = enable ? (con | ctrlbit) : (con & ~ctrlbit);
+	__raw_writel(con, reg);
+	return 0;
+}
+
+static struct clk *s5p_clks[] __initdata = {
+	&clk_ext_xtal_mux,
+	&clk_48m,
+	&clk_fout_apll,
+	&clk_fout_mpll,
+	&clk_fout_epll,
+	&clk_arm,
+};
+
+void __init s5p_register_clocks(unsigned long xtal_freq)
+{
+	int ret;
+
+	clk_ext_xtal_mux.rate = xtal_freq;
+
+	ret = s3c24xx_register_clocks(s5p_clks, ARRAY_SIZE(s5p_clks));
+	if (ret > 0)
+		printk(KERN_ERR "Failed to register s5p clocks\n");
+}
diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
new file mode 100644
index 0000000..a60933d
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/pll.h
@@ -0,0 +1,74 @@
+/* arch/arm/plat-s5p/include/plat/pll.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P PLL code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define S5P_PLL_MDIV_MASK	((1 << (25-16+1)) - 1)
+#define S5P_PLL_PDIV_MASK	((1 << (13-8+1)) - 1)
+#define S5P_PLL_SDIV_MASK	((1 << (2-0+1)) - 1)
+#define S5P_PLL_MDIV_SHIFT	(16)
+#define S5P_PLL_PDIV_SHIFT	(8)
+#define S5P_PLL_SDIV_SHIFT	(0)
+
+#include <asm/div64.h>
+
+static inline unsigned long s5p_get_pll(unsigned long baseclk,
+					    u32 pllcon)
+{
+	u32 mdiv, pdiv, sdiv;
+	u64 fvco = baseclk;
+
+	mdiv = (pllcon >> S5P_PLL_MDIV_SHIFT) & S5P_PLL_MDIV_MASK;
+	pdiv = (pllcon >> S5P_PLL_PDIV_SHIFT) & S5P_PLL_PDIV_MASK;
+	sdiv = (pllcon >> S5P_PLL_SDIV_SHIFT) & S5P_PLL_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+
+	return (unsigned long)fvco;
+}
+
+#define S5P6440_EPLL_MDIV_MASK	((1 << (23-16+1)) - 1)
+#define S5P6440_EPLL_PDIV_MASK	((1 << (13-8+1)) - 1)
+#define S5P6440_EPLL_SDIV_MASK	((1 << (2-0+1)) - 1)
+#define S5P6440_EPLL_KDIV_MASK	(0xffff)
+
+#define S5P6440_EPLL_MDIV_SHIFT	(16)
+#define S5P6440_EPLL_PDIV_SHIFT	(8)
+#define S5P6440_EPLL_SDIV_SHIFT	(0)
+#define S5P6440_EPLL_KDIV_SHIFT	(0)
+
+static inline unsigned long s5p6440_get_epll(unsigned long baseclk)
+{
+	unsigned long result;
+	u32 epll_con = __raw_readl(S5P_EPLL_CON);
+	u32 epll_con_k = __raw_readl(S5P_EPLL_CON_K);
+	u32 mdiv, pdiv, sdiv, kdiv;
+	u64 tmp;
+
+	mdiv = (epll_con >> S5P6440_EPLL_MDIV_SHIFT) & S5P6440_EPLL_MDIV_MASK;
+	pdiv = (epll_con >> S5P6440_EPLL_PDIV_SHIFT) & S5P6440_EPLL_PDIV_MASK;
+	sdiv = (epll_con >> S5P6440_EPLL_SDIV_SHIFT) & S5P6440_EPLL_SDIV_MASK;
+	kdiv = epll_con_k & S5P6440_EPLL_KDIV_MASK;
+
+	/* We need to multiple baseclk by mdiv (the integer part) and kdiv
+	 * which is in 2^16ths, so shift mdiv up (does not overflow) and
+	 * add kdiv before multiplying. The use of tmp is to avoid any
+	 * overflows before shifting bac down into result when multipling
+	 * by the mdiv and kdiv pair.
+	 */
+
+	tmp = baseclk;
+	tmp *= (mdiv << 16) + kdiv;
+	do_div(tmp, (pdiv << sdiv));
+	result = tmp >> 16;
+
+	return result;
+}
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
new file mode 100644
index 0000000..5725222
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -0,0 +1,41 @@
+/* linux/arch/arm/plat-s5p/include/plat/s5p-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Header file for s5p clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_S5P_CLOCK_H
+#define __ASM_PLAT_S5P_CLOCK_H __FILE__
+
+#include <linux/clk.h>
+
+#define GET_DIV(clk, field) ((((clk) & field##_MASK) >> field##_SHIFT) + 1)
+
+#define clk_fin_apll clk_ext_xtal_mux
+#define clk_fin_mpll clk_ext_xtal_mux
+#define clk_fin_epll clk_ext_xtal_mux
+
+extern struct clk_ops clk_ops_def_setrate;
+
+extern struct clk clk_ext_xtal_mux;
+extern struct clk clk_48m;
+extern struct clk clk_fout_apll;
+extern struct clk clk_fout_mpll;
+extern struct clk clk_fout_epll;
+extern struct clk clk_arm;
+
+extern struct clksrc_sources clk_src_apll;
+extern struct clksrc_sources clk_src_mpll;
+extern struct clksrc_sources clk_src_epll;
+
+extern int clk_default_setrate(struct clk *clk, unsigned long rate);
+extern int s5p6440_clk48m_ctrl(struct clk *clk, int enable);
+extern int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable);
+
+#endif /* __ASM_PLAT_S5P_CLOCK_H */
diff --git a/arch/arm/plat-s5p/s5p6440-clock.c b/arch/arm/plat-s5p/s5p6440-clock.c
new file mode 100644
index 0000000..7ad3215
--- /dev/null
+++ b/arch/arm/plat-s5p/s5p6440-clock.c
@@ -0,0 +1,705 @@
+/* linux/arch/arm/plat-s5p/s5p6440-clock.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <plat/cpu-freq.h>
+#include <mach/regs-clock.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p-clock.h>
+#include <plat/pll.h>
+#include <asm/div64.h>
+
+/* APLL Mux output clock */
+static struct clksrc_clk clk_mout_apll = {
+	.clk    = {
+		.name           = "mout_apll",
+		.id             = -1,
+	},
+	.sources        = &clk_src_apll,
+	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
+};
+
+static int s5p6440_epll_enable(struct clk *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	unsigned int epll_con = __raw_readl(S5P_EPLL_CON) & ~ctrlbit;
+
+	if (enable)
+		__raw_writel(epll_con | ctrlbit, S5P_EPLL_CON);
+	else
+		__raw_writel(epll_con, S5P_EPLL_CON);
+
+	return 0;
+}
+
+unsigned long s5p6440_epll_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+static unsigned int epll_div[][5] = {
+	{ 36000000,	0,	48, 1, 4 },
+	{ 48000000,	0,	32, 1, 3 },
+	{ 60000000,	0,	40, 1, 3 },
+	{ 72000000,	0,	48, 1, 3 },
+	{ 84000000,	0,	28, 1, 2 },
+	{ 96000000,	0,	32, 1, 2 },
+	{ 32768000,	45264,	43, 1, 4 },
+	{ 45158000,	6903,	30, 1, 3 },
+	{ 49152000,	50332,	32, 1, 3 },
+	{ 67738000,	10398,	45, 1, 3 },
+	{ 73728000,	9961,	49, 1, 3 }
+};
+
+static int s5p6440_epll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int epll_con, epll_con_k;
+	unsigned int i;
+
+	if (clk->rate == rate)	/* Return if nothing changed */
+		return 0;
+
+	epll_con = __raw_readl(S5P_EPLL_CON);
+	epll_con_k = __raw_readl(S5P_EPLL_CON_K);
+
+	epll_con_k &= ~(S5P6440_EPLL_KDIV_MASK);
+	epll_con &= ~(S5P6440_EPLL_MDIV_MASK | S5P6440_EPLL_PDIV_MASK | S5P6440_EPLL_SDIV_MASK);
+
+	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
+		 if (epll_div[i][0] == rate) {
+			epll_con_k |= (epll_div[i][1] << S5P6440_EPLL_KDIV_SHIFT);
+			epll_con |= (epll_div[i][2] << S5P6440_EPLL_MDIV_SHIFT) |
+				    (epll_div[i][3] << S5P6440_EPLL_PDIV_SHIFT) |
+				    (epll_div[i][4] << S5P6440_EPLL_SDIV_SHIFT);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(epll_div)) {
+		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n", __func__);
+		return -EINVAL;
+	}
+
+	__raw_writel(epll_con, S5P_EPLL_CON);
+	__raw_writel(epll_con_k, S5P_EPLL_CON_K);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static struct clk_ops s5p6440_epll_ops = {
+	.get_rate = s5p6440_epll_get_rate,
+	.set_rate = s5p6440_epll_set_rate,
+};
+
+static struct clksrc_clk clk_mout_epll = {
+	.clk    = {
+		.name           = "mout_epll",
+		.id             = -1,
+	},
+	.sources        = &clk_src_epll,
+	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 2, .size = 1 },
+};
+
+static struct clksrc_clk clk_mout_mpll = {
+	.clk = {
+		.name           = "mout_mpll",
+		.id             = -1,
+	},
+	.sources        = &clk_src_mpll,
+	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 1, .size = 1 },
+};
+
+struct clk clk_h_low = {
+	.name		= "hclk_low",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+	.ops		= &clk_ops_def_setrate,
+};
+
+struct clk clk_p_low = {
+	.name		= "pclk_low",
+	.id		= -1,
+	.rate		= 0,
+	.parent		= NULL,
+	.ctrlbit	= 0,
+	.ops		= &clk_ops_def_setrate,
+};
+
+enum perf_level {
+	L0 = 532*1000,
+	L1 = 266*1000,
+	L2 = 133*1000,
+};
+
+static const u32 clock_table[][3] = {
+	/*{ARM_CLK, DIVarm, DIVhclk}*/
+	{L0 * 1000, (0 << ARM_DIV_RATIO_SHIFT), (3 << S5P_CLKDIV0_HCLK_SHIFT)},
+	{L1 * 1000, (1 << ARM_DIV_RATIO_SHIFT), (1 << S5P_CLKDIV0_HCLK_SHIFT)},
+	{L2 * 1000, (3 << ARM_DIV_RATIO_SHIFT), (0 << S5P_CLKDIV0_HCLK_SHIFT)},
+};
+
+static unsigned long s5p6440_armclk_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	u32 clkdiv;
+
+	/* divisor mask starts at bit0, so no need to shift */
+	clkdiv = __raw_readl(ARM_CLK_DIV) & ARM_DIV_MASK;
+
+	return rate / (clkdiv + 1);
+}
+
+static unsigned long s5p6440_armclk_round_rate(struct clk *clk,
+						unsigned long rate)
+{
+	u32 iter;
+
+	for (iter = 1 ; iter < ARRAY_SIZE(clock_table) ; iter++) {
+		if (rate > clock_table[iter][0])
+			return clock_table[iter-1][0];
+	}
+
+	return clock_table[ARRAY_SIZE(clock_table) - 1][0];
+}
+
+static int s5p6440_armclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 round_tmp;
+	u32 iter;
+	u32 clk_div0_tmp;
+	u32 cur_rate = clk->ops->get_rate(clk);
+	unsigned long flags;
+
+	round_tmp = clk->ops->round_rate(clk, rate);
+	if (round_tmp == cur_rate)
+		return 0;
+
+
+	for (iter = 0 ; iter < ARRAY_SIZE(clock_table) ; iter++) {
+		if (round_tmp == clock_table[iter][0])
+			break;
+	}
+
+	if (iter >= ARRAY_SIZE(clock_table))
+		iter = ARRAY_SIZE(clock_table) - 1;
+
+	local_irq_save(flags);
+	if (cur_rate > round_tmp) {
+		/* Frequency Down */
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) & ~(ARM_DIV_MASK);
+		clk_div0_tmp |= clock_table[iter][1];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) &
+				~(S5P_CLKDIV0_HCLK_MASK);
+		clk_div0_tmp |= clock_table[iter][2];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+
+
+	} else {
+		/* Frequency Up */
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) &
+				~(S5P_CLKDIV0_HCLK_MASK);
+		clk_div0_tmp |= clock_table[iter][2];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) & ~(ARM_DIV_MASK);
+		clk_div0_tmp |= clock_table[iter][1];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+		}
+	local_irq_restore(flags);
+
+	clk->rate = clock_table[iter][0];
+
+	return 0;
+}
+
+static struct clk_ops s5p6440_clkarm_ops = {
+	.get_rate	= s5p6440_armclk_get_rate,
+	.set_rate	= s5p6440_armclk_set_rate,
+	.round_rate	= s5p6440_armclk_round_rate,
+};
+
+static unsigned long s5p6440_clk_doutmpll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+
+	if (__raw_readl(S5P_CLK_DIV0) & S5P_CLKDIV0_MPLL_MASK)
+		rate /= 2;
+
+	return rate;
+}
+
+struct clk clk_dout_mpll = {
+	.name		= "dout_mpll",
+	.id		= -1,
+	.parent		= &clk_mout_mpll.clk,
+	.ops            = &(struct clk_ops) {
+		.get_rate	= s5p6440_clk_doutmpll_get_rate,
+	},
+};
+
+int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	/* can't rely on clock lock, this register has other usages */
+	local_irq_save(flags);
+
+	val = __raw_readl(S5P_OTHERS);
+	if (enable)
+		val |= S5P_OTHERS_USB_SIG_MASK;
+	else
+		val &= ~S5P_OTHERS_USB_SIG_MASK;
+
+	__raw_writel(val, S5P_OTHERS);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+static int s5p6440_pclk_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_GATE_PCLK, clk, enable);
+}
+
+static int s5p6440_hclk0_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_GATE_HCLK0, clk, enable);
+}
+
+static int s5p6440_hclk1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_GATE_HCLK1, clk, enable);
+}
+
+static int s5p6440_sclk_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_GATE_SCLK0, clk, enable);
+}
+
+static int s5p6440_mem_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P_CLK_GATE_MEM0, clk, enable);
+}
+
+/*
+ * The following clocks will be disabled during clock initialization. It is
+ * recommended to keep the following clocks disabled until the driver requests
+ * for enabling the clock.
+ */
+static struct clk init_clocks_disable[] = {
+	{
+		.name		= "nand",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s5p6440_mem_ctrl,
+		.ctrlbit	= S5P_CLKCON_MEM0_HCLK_NFCON,
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_TSADC,
+	}, {
+		.name		= "i2c",
+		.id		= -1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_IIC0,
+	}, {
+		.name		= "i2s_v40",
+		.id		= 0,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_IIS2,
+	}, {
+		.name		= "spi",
+		.id		= 0,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_SPI0,
+	}, {
+		.name		= "spi",
+		.id		= 1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_SPI1,
+	}, {
+		.name		= "sclk_spi_48",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5p6440_sclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_SCLK0_SPI0_48,
+	}, {
+		.name		= "sclk_spi_48",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5p6440_sclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_SCLK0_SPI1_48,
+	}, {
+		.name		= "mmc_48m",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5p6440_sclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_SCLK0_MMC0_48,
+	}, {
+		.name		= "mmc_48m",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5p6440_sclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_SCLK0_MMC1_48,
+	}, {
+		.name		= "mmc_48m",
+		.id		= 2,
+		.parent		= &clk_48m,
+		.enable		= s5p6440_sclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_SCLK0_MMC2_48,
+	}, {
+		.name    	= "otg",
+		.id	   	= -1,
+		.parent  	= &clk_h_low,
+		.enable  	= s5p6440_hclk0_ctrl,
+		.ctrlbit 	= S5P_CLKCON_HCLK0_USB
+	}, {
+		.name    	= "post",
+		.id	   	= -1,
+		.parent  	= &clk_h_low,
+		.enable  	= s5p6440_hclk0_ctrl,
+		.ctrlbit 	= S5P_CLKCON_HCLK0_POST0
+	}, {
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_h_low,
+		.enable		= s5p6440_hclk1_ctrl,
+		.ctrlbit	= S5P_CLKCON_HCLK1_DISPCON,
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_h_low,
+		.enable		= s5p6440_hclk0_ctrl,
+		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC0,
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_h_low,
+		.enable		= s5p6440_hclk0_ctrl,
+		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC1,
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_h_low,
+		.enable		= s5p6440_hclk0_ctrl,
+		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC2,
+	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_RTC,
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_WDT,
+	}
+};
+
+/*
+ * The following clocks will be enabled during clock initialization.
+ */
+static struct clk init_clocks[] = {
+	{
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_GPIO,
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_PWM,
+	}, {
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_UART0,
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_UART1,
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_UART2,
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_p_low,
+		.enable		= s5p6440_pclk_ctrl,
+		.ctrlbit	= S5P_CLKCON_PCLK_UART3,
+	}
+};
+
+static struct clk clk_iis_cd_v40 = {
+	.name		= "iis_cdclk_v40",
+	.id		= -1,
+};
+
+static struct clk clk_pcm_cd = {
+	.name		= "pcm_cdclk",
+	.id		= -1,
+};
+
+static struct clk *clkset_spi_mmc_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	&clk_fin_epll,
+};
+
+static struct clksrc_sources clkset_spi_mmc = {
+	.sources	= clkset_spi_mmc_list,
+	.nr_sources	= ARRAY_SIZE(clkset_spi_mmc_list),
+};
+
+static struct clk *clkset_uart_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll,
+	NULL,
+	NULL
+};
+
+static struct clksrc_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 0,
+			.ctrlbit        = S5P_CLKCON_SCLK0_MMC0,
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_spi_mmc,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 18, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 1,
+			.ctrlbit        = S5P_CLKCON_SCLK0_MMC1,
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_spi_mmc,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 2,
+			.ctrlbit        = S5P_CLKCON_SCLK0_MMC2,
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_spi_mmc,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 22, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 8, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "uclk1",
+			.id		= -1,
+			.ctrlbit        = S5P_CLKCON_SCLK0_UART,
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 13, .size = 1 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 16, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "spi_epll",
+			.id		= 0,
+			.ctrlbit        = S5P_CLKCON_SCLK0_SPI0,
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_spi_mmc,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 14, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "spi_epll",
+			.id		= 1,
+			.ctrlbit        = S5P_CLKCON_SCLK0_SPI1,
+			.enable		= s5p6440_sclk_ctrl,
+		},
+		.sources = &clkset_spi_mmc,
+		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 2 },
+		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
+	}
+};
+
+/* Clock initialisation code */
+static struct clksrc_clk *init_parents[] = {
+	&clk_mout_apll,
+	&clk_mout_epll,
+	&clk_mout_mpll,
+};
+
+void __init_or_cpufreq s5p6440_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+	unsigned long xtal;
+	unsigned long fclk;
+	unsigned long hclk;
+	unsigned long hclk_low;
+	unsigned long pclk;
+	unsigned long pclk_low;
+	unsigned long epll;
+	unsigned long apll;
+	unsigned long mpll;
+	unsigned int ptr;
+	u32 clkdiv0;
+	u32 clkdiv3;
+
+	/* Set S5P6440 functions for clk_fout_epll */
+	clk_fout_epll.enable = s5p6440_epll_enable;
+	clk_fout_epll.ops = &s5p6440_epll_ops;
+
+	/* Set S5P6440 functions for arm clock */
+	clk_arm.parent = &clk_mout_apll.clk;
+	clk_arm.ops = &s5p6440_clkarm_ops;
+
+	clkdiv0 = __raw_readl(S5P_CLK_DIV0);
+	clkdiv3 = __raw_readl(S5P_CLK_DIV3);
+
+	xtal_clk = clk_get(NULL, "ext_xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	epll = s5p6440_get_epll(xtal);
+	mpll = s5p_get_pll(xtal, __raw_readl(S5P_MPLL_CON));
+	apll = s5p_get_pll(xtal, __raw_readl(S5P_APLL_CON));
+
+	printk(KERN_INFO "S5P6440: PLL settings, A=%ld.%ldMHz, M=%ld.%ldMHz," \
+			" E=%ld.%ldMHz\n",
+			print_mhz(apll), print_mhz(mpll), print_mhz(epll));
+
+	fclk = apll / GET_DIV(clkdiv0, S5P_CLKDIV0_ARM);
+	hclk = fclk / GET_DIV(clkdiv0, S5P_CLKDIV0_HCLK);
+	pclk = hclk / GET_DIV(clkdiv0, S5P_CLKDIV0_PCLK);
+
+	if (__raw_readl(S5P_OTHERS) & S5P_OTHERS_HCLK_LOW_SEL_MPLL) {
+		/* Asynchronous mode */
+		hclk_low = mpll / GET_DIV(clkdiv3, S5P_CLKDIV3_HCLK_LOW);
+	} else {
+		/* Synchronous mode */
+		hclk_low = apll / GET_DIV(clkdiv3, S5P_CLKDIV3_HCLK_LOW);
+	}
+
+	pclk_low = hclk_low / GET_DIV(clkdiv3, S5P_CLKDIV3_PCLK_LOW);
+
+	printk(KERN_INFO "S5P6440: HCLK=%ld.%ldMHz, HCLK_LOW=%ld.%ldMHz," \
+			" PCLK=%ld.%ldMHz, PCLK_LOW=%ld.%ldMHz\n",
+			print_mhz(hclk), print_mhz(hclk_low),
+			print_mhz(pclk), print_mhz(pclk_low));
+
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+	clk_fout_apll.rate = apll;
+
+	clk_f.rate = fclk;
+	clk_h.rate = hclk;
+	clk_p.rate = pclk;
+	clk_h_low.rate = hclk_low;
+	clk_p_low.rate = pclk_low;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(init_parents); ptr++)
+		s3c_set_clksrc(init_parents[ptr]);
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_set_clksrc(&clksrcs[ptr]);
+}
+
+static struct clk *clks[] __initdata = {
+	&clk_ext,
+	&clk_mout_epll.clk,
+	&clk_mout_mpll.clk,
+	&clk_dout_mpll,
+	&clk_iis_cd_v40,
+	&clk_pcm_cd,
+	&clk_p_low,
+	&clk_h_low,
+};
+
+void __init s5p6440_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+
+	ret = s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+	if (ret > 0)
+		printk(KERN_ERR "Failed to register %u clocks\n", ret);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+
+	clkp = init_clocks;
+	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks); ptr++, clkp++) {
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+		(clkp->enable)(clkp, 1);
+	}
+
+	clkp = init_clocks_disable;
+	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
+
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+		(clkp->enable)(clkp, 0);
+	}
+}
diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
index 43324af..bc9ef41 100644
--- a/arch/arm/plat-samsung/include/plat/clock.h
+++ b/arch/arm/plat-samsung/include/plat/clock.h
@@ -90,6 +90,7 @@ extern int s3c24xx_register_clocks(struct clk **clk, int nr_clks);
 extern int s3c24xx_register_baseclocks(unsigned long xtal);
 
 extern void s3c64xx_register_clocks(void);
+extern void s5p_register_clocks(unsigned long xtal_freq);
 
 extern void s3c24xx_setup_clocks(unsigned long fclk,
 				 unsigned long hclk,
-- 
1.6.2.5
