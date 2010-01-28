From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:25 -0800
Subject: [PATCH 07/13] ARM: LPC32XX: common architecture functions and
	structures
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-8-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

LPC32XX arch specific functions and drivers that may be used
in platforms based on the LCP32XX.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/common.c |  269 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h |   76 +++++++++++
 2 files changed, 345 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
new file mode 100644
index 0000000..77c98b4
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -0,0 +1,269 @@
+/*
+ * arch/arm/mach-lpc32xx/common.c
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/i2c-pnx.h>
+#include <linux/io.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/i2c.h>
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include "common.h"
+
+#define WDT_IOBASE io_p2v(WDTIM_BASE)
+
+/*
+ * Watchdog timer
+ */
+static struct resource watchdog_resources[] = {
+	[0] = {
+		.start = WDTIM_BASE,
+		.end = WDTIM_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device watchdog_device = {
+	.name = "pnx4008-watchdog",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(watchdog_resources),
+	.resource = watchdog_resources,
+};
+
+/*
+ * I2C busses
+ */
+static struct i2c_pnx_data i2c0_data = {
+	.name = I2C_CHIP_NAME "0",
+	.base = I2C1_BASE,
+	.irq = IRQ_I2C_1,
+};
+
+static struct i2c_pnx_data i2c1_data = {
+	.name = I2C_CHIP_NAME "1",
+	.base = I2C2_BASE,
+	.irq = IRQ_I2C_2,
+};
+
+static struct i2c_pnx_data i2c2_data = {
+	.name = "USB-I2C",
+	.base = OTG_I2C_BASE,
+	.irq = IRQ_USB_I2C,
+};
+
+struct platform_device i2c0_device = {
+	.name = "pnx-i2c",
+	.id = 0,
+	.dev = {
+		.platform_data = &i2c0_data,
+	},
+};
+
+struct platform_device i2c1_device = {
+	.name = "pnx-i2c",
+	.id = 1,
+	.dev = {
+		.platform_data = &i2c1_data,
+	},
+};
+
+struct platform_device i2c2_device = {
+	.name = "pnx-i2c",
+	.id = 2,
+	.dev = {
+		.platform_data = &i2c2_data,
+	},
+};
+
+/*
+ * Returns the unique ID for the device
+ */
+void lpc32xx_get_uid(u32 devid[4])
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		devid[i] = readl(CLKPWR_DEVID(CLKPWR_IOBASE, i << 2));
+}
+
+/*
+ * Returns SYSCLK source
+ * 0 = PLL397, 1 = main oscillator
+ */
+int clk_is_sysclk_mainosc(void)
+{
+	if ((readl(CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE)) &
+		CLKPWR_SYSCTRL_SYSCLKMUX) == 0)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * System reset via the watchdog timer
+ */
+void lpc32xx_watchdog_reset(void)
+{
+	/* Make sure WDT clocks are enabled */
+	writel(CLKPWR_PWMCLK_WDOG_EN,
+		CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE));
+
+	/* Instand assert of RESETOUT_N with pulse length 1mS */
+	writel(13000, WDT_IOBASE + 0x18);
+	writel(0x70, WDT_IOBASE + 0xC);
+}
+
+/*
+ * Computes PLL rate from PLL register and input clock
+ */
+u32 clk_check_pll_setup(u32 ifreq, struct clk_pll_setup *pllsetup)
+{
+	u32 ilfreq, p, m, n, fcco, fref, cfreq;
+	int mode;
+
+	/* PLL requirements */
+	/* ifreq must be >= 1MHz and <= 20MHz */
+	/* FCCO must be >= 156MHz and <= 320MHz */
+	/* FREF must be >= 1MHz and <= 27MHz. */
+	/* Assume the passed input data is not valid */
+
+	ilfreq = ifreq;
+	m = pllsetup->pll_m;
+	n = pllsetup->pll_n;
+	p = pllsetup->pll_p;
+
+	mode = (pllsetup->cco_bypass_b15 << 2) |
+		(pllsetup->direct_output_b14 << 1) |
+	pllsetup->fdbk_div_ctrl_b13;
+
+	switch (mode) {
+	case 0x0: /* Non-integer mode */
+		cfreq = (m * ilfreq) / (2 * p * n);
+		fcco = (m * ilfreq) / n;
+		fref = ilfreq / n;
+		break;
+
+	case 0x1: /* integer mode */
+		cfreq = (m * ilfreq) / n;
+		fcco = (m * ilfreq) / (n * 2 * p);
+		fref = ilfreq / n;
+		break;
+
+	case 0x2:
+	case 0x3: /* Direct mode */
+		cfreq = (m * ilfreq) / n;
+		fcco = cfreq;
+		fref = ilfreq / n;
+		break;
+
+	case 0x4:
+	case 0x5: /* Bypass mode */
+		cfreq = ilfreq / (2 * p);
+		fcco = 156000000;
+		fref = 1000000;
+		break;
+
+	case 0x6:
+	case 0x7: /* Direct bypass mode */
+	default:
+		cfreq = ilfreq;
+		fcco = 156000000;
+		fref = 1000000;
+		break;
+	}
+
+	if (fcco < 156000000 || fcco > 320000000)
+		cfreq = 0;
+
+	if (fref < 1000000 || fref > 27000000)
+		cfreq = 0;
+
+	return (u32) cfreq;
+}
+
+/*
+ * Convert a PLL register value to a PLL output frequency
+ */
+u32 clk_get_pllrate_from_reg(u32 inputclk, u32 regval)
+{
+	struct clk_pll_setup pllcfg;
+
+	pllcfg.cco_bypass_b15 = 0;
+	pllcfg.direct_output_b14 = 0;
+	pllcfg.fdbk_div_ctrl_b13 = 0;
+	if ((regval & CLKPWR_HCLKPLL_CCO_BYPASS) != 0)
+		pllcfg.cco_bypass_b15 = 1;
+	if ((regval & CLKPWR_HCLKPLL_POSTDIV_BYPASS) != 0)
+		pllcfg.direct_output_b14 = 1;
+	if ((regval & CLKPWR_HCLKPLL_FDBK_SEL_FCLK) != 0)
+		pllcfg.fdbk_div_ctrl_b13 = 1;
+	pllcfg.pll_m = 1 + ((regval >> 1) & 0xFF);
+	pllcfg.pll_n = 1 + ((regval >> 9) & 0x3);
+	pllcfg.pll_p = pll_postdivs[((regval >> 11) & 0x3)];
+
+	return clk_check_pll_setup(inputclk, &pllcfg);
+}
+
+u32 clk_get_pclk_div(void)
+{
+	return 1 + ((readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE)) >> 2) &
+		0x1F);
+}
+
+static struct map_desc lpc32xx_io_desc[] __initdata = {
+	{
+		.virtual	= io_p2v(AHB0_START),
+		.pfn		= __phys_to_pfn(AHB0_START),
+		.length		= AHB0_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= io_p2v(AHB1_START),
+		.pfn		= __phys_to_pfn(AHB1_START),
+		.length		= AHB1_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= io_p2v(FABAPB_START),
+		.pfn		= __phys_to_pfn(FABAPB_START),
+		.length		= FABAPB_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= io_p2v(IRAM_BASE),
+		.pfn		= __phys_to_pfn(IRAM_BASE),
+		.length		= CONFIG_ARCH_LPC32XX_IRAM_SIZE,
+		.type		= MT_DEVICE
+	},
+};
+
+void __init lpc32xx_map_io(void)
+{
+	iotable_init(lpc32xx_io_desc, ARRAY_SIZE(lpc32xx_io_desc));
+}
diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
new file mode 100644
index 0000000..ab8d2b2
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/common.h
@@ -0,0 +1,76 @@
+/*
+ * arch/arm/mach-lpc32xx/common.h
+ *
+ * Author: Kevin Wells <kevin.wells@nxp.com>
+ *
+ * Copyright (C) 2009-2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __LPC32XX_COMMON_H
+#define __LPC32XX_COMMON_H
+
+#include <linux/platform_device.h>
+
+#define CLKPWR_IOBASE io_p2v(CLK_PM_BASE)
+
+/*
+ * Arch specific platform device structures
+ */
+extern struct platform_device watchdog_device;
+extern struct platform_device i2c0_device;
+extern struct platform_device i2c1_device;
+extern struct platform_device i2c2_device;
+
+/*
+ * Other arch specific structures and functions
+ */
+extern struct sys_timer lpc32xx_timer;
+extern void __init lpc32xx_init_irq(void);
+extern void __init lpc32xx_map_io(void);
+extern void __init lpc32xx_serial_init(void);
+extern void __init lpc32xx_gpio_init(void);
+
+/*
+ * Structure used for setting up and querying the PLLS
+ */
+struct clk_pll_setup {
+	int analog_on;
+	int cco_bypass_b15;
+	int direct_output_b14;
+	int fdbk_div_ctrl_b13;
+	int pll_p;
+	int pll_n;
+	u32 pll_m;
+};
+
+extern const u32 pll_postdivs[4];
+
+extern int clk_is_sysclk_mainosc(void);
+extern u32 clk_check_pll_setup(u32 ifreq, struct clk_pll_setup *pllsetup);
+extern u32 clk_get_pllrate_from_reg(u32 inputclk, u32 regval);
+extern u32 clk_get_pclk_div(void);
+
+/*
+ * Returns the LPC32xx unique 128-bit chip ID
+ */
+extern void lpc32xx_get_uid(u32 devid[4]);
+
+#ifdef CONFIG_DEBUG_LL
+extern void printascii(const char *);
+#endif
+
+#endif
-- 
1.6.6
