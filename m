From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 27 Jan 2010 17:43:26 -0800
Subject: [PATCH 08/13] ARM: LPC32XX: clock tree support
In-Reply-To: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1264643011-17390-9-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

LPC32XX clock control and query functions

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c | 1042 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/clock.h |   41 ++
 2 files changed, 1083 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
new file mode 100644
index 0000000..615c091
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -0,0 +1,1042 @@
+/*
+ * arch/arm/mach-lpc32xx/clock.c
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
+/*
+ * LPC32xx clock mamagement driver overview
+ *
+ * The LPC32XX contains a number of high level system clocks that can be
+ * generated from different sources. These system clocks are used to
+ * generate the CPU and bus rates and the individual peripheral clocks in
+ * the system. When Linux is started by the boot loader, the system
+ * clocks are already running. Stopping a system clock during normal
+ * Linux operation should never be attempted, as peripherals that require
+ * those clocks will quit working (ie, DRAM).
+ *
+ * The LPC32xx high level clock tree looks as follows. Clocks marked with
+ * an asterisk are always on and cannot be disabled. Clocks marked with
+ * an ampersand can only be disabled in CPU suspend mode. Clocks marked
+ * with a carot are always on if it is the selected clock for the SYSCLK
+ * source. The clock that isn't used for SYSCLK can be enabled and
+ * disabled normally.
+ *                               32KHz oscillator*
+ *                               /      |      \
+ *                             RTC*   PLL397^ TOUCH
+ *                                     /
+ *               Main oscillator^     /
+ *                   |        \      /
+ *                   |         SYSCLK&
+ *                   |            \
+ *                   |             \
+ *                USB_PLL       HCLK_PLL&
+ *                   |           |    |
+ *            USB host/device  PCLK&  |
+ *                               |    |
+ *                             Peripherals
+ *
+ * The CPU and chip bus rates are derived from the HCLK PLL, which can
+ * generate various clock rates up to 266MHz and beyond. The internal bus
+ * rates (PCLK and HCLK) are generated from dividers based on the HCLK
+ * PLL rate. HCLK can be a ratio of 1:1, 1:2, or 1:4 or HCLK PLL rate,
+ * while PCLK can be 1:1 to 1:32 of HCLK PLL rate. Most peripherals high
+ * level clocks are based on either HCLK or PCLK, but have their own
+ * dividers as part of the IP itself. Because of this, the system clock
+ * rates should not be changed.
+ *
+ * The HCLK PLL is clocked from SYSCLK, which can be derived from the
+ * main oscillator or PLL397. PLL397 generates a rate that is 397 times
+ * the 32KHz oscillator rate. The main oscillator runs at the selected
+ * oscillator/crystal rate on the mosc_in pin of the LPC32xx. This rate
+ * is normally 13MHz, but depends on the selection of external crystals
+ * or oscillators. If USB operation is required, the main oscillator must
+ * be used in the system.
+ *
+ * Switching SYSCLK between sources during normal Linux operation is not
+ * supported. SYSCLK is preset in the bootloader. Because of the
+ * complexities of clock management during clock frequency changes,
+ * there are some limitations to the clock driver explained below:
+ * - The PLL397 and main oscillator can be enabled and disabled by the
+ *   clk_enable() and clk_disable() functions unless SYSCLK is based
+ *   on that clock. This allows the other oscillator that isn't driving
+ *   the HCLK PLL to be used as another system clock that can be routed
+ *   to an external pin.
+ * - The muxed SYSCLK input and HCLK_PLL rate cannot be changed with
+ *   this driver.
+ * - HCLK and PCLK rates cannot be changed as part of this driver.
+ * - Most peripherals have their own dividers are part of the peripheral
+ *   block. Changing SYSCLK, HCLK PLL, HCLK, or PCLK sources or rates
+ *   will also impact the individual peripheral rates.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+
+#include <mach/hardware.h>
+#include <asm/clkdev.h>
+#include <mach/clkdev.h>
+#include <mach/platform.h>
+#include "clock.h"
+#include "common.h"
+
+static struct clk clk_armpll;
+static struct clk clk_usbpll;
+
+/*
+ * Post divider values for PLLs based on selected register value
+ */
+const u32 pll_postdivs[4] = {1, 2, 4, 8};
+
+#define USB_OTG_IOBASE io_p2v(USB_BASE)
+
+/* 32KHz clock has a fixed rate and is not stoppable */
+static struct clk osc_32KHz = {
+	.rate		= CLOCK_OSC_FREQ,
+};
+
+static int local_pll397_enable(struct clk *clk, int enable)
+{
+	u32 reg;
+	unsigned long timeout = 1 + msecs_to_jiffies(10);
+
+	reg = readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+
+	if (enable == 0) 	{
+		reg |= CLKPWR_SYSCTRL_PLL397_DIS;
+		writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+		clk->rate = 0;
+	} else {
+		/* Enable PLL397 */
+		reg &= ~CLKPWR_SYSCTRL_PLL397_DIS;
+		writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+		clk->rate = CLOCK_OSC_FREQ * 397;
+
+		/* Wait for PLL397 lock */
+		while (((readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
+			CLKPWR_SYSCTRL_PLL397_STS) == 0) &&
+			(timeout > jiffies))
+			cpu_relax();
+
+		if ((readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
+			CLKPWR_SYSCTRL_PLL397_STS) == 0)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int local_oscmain_enable(struct clk *clk, int enable)
+{
+	u32 reg;
+	unsigned long timeout = 1 + msecs_to_jiffies(10);
+
+	reg = readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+
+	if (enable == 0) {
+		reg |= CLKPWR_MOSC_DISABLE;
+		writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+		clk->rate = 0;
+	} else {
+		/* Enable main oscillator */
+		reg &= ~CLKPWR_MOSC_DISABLE;
+		writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+		clk->rate = MAIN_OSC_FREQ;
+
+		/* Wait for main oscillator to start */
+		while (((readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
+			CLKPWR_MOSC_DISABLE) != 0) &&
+			(timeout > jiffies))
+			cpu_relax();
+
+		if ((readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
+			CLKPWR_MOSC_DISABLE) != 0)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+static struct clk osc_pll397 = {
+	.parent		= &osc_32KHz,
+	.enable		= &local_pll397_enable,
+	.rate		= CLOCK_OSC_FREQ * 397,
+};
+
+static struct clk osc_main = {
+	.enable		= &local_oscmain_enable,
+	.rate		= MAIN_OSC_FREQ,
+};
+
+static struct clk clk_sys;
+
+/*
+ * Setup the HCLK PLL with a PLL structure
+ */
+static u32 local_clk_pll_setup(struct clk_pll_setup *PllSetup)
+{
+	u32 tv, tmp = 0;
+
+	if (PllSetup->analog_on != 0)
+		tmp |= CLKPWR_HCLKPLL_POWER_UP;
+	if (PllSetup->cco_bypass_b15 != 0)
+		tmp |= CLKPWR_HCLKPLL_CCO_BYPASS;
+	if (PllSetup->direct_output_b14 != 0)
+		tmp |= CLKPWR_HCLKPLL_POSTDIV_BYPASS;
+	if (PllSetup->fdbk_div_ctrl_b13 != 0)
+		tmp |= CLKPWR_HCLKPLL_FDBK_SEL_FCLK;
+
+	switch (PllSetup->pll_p) {
+	case 1:
+		tv = 0;
+		break;
+
+	case 2:
+		tv = 1;
+		break;
+
+	case 4:
+		tv = 2;
+		break;
+
+	case 8:
+		tv = 3;
+		break;
+
+	default:
+		return 0;
+	}
+
+	tmp |= CLKPWR_HCLKPLL_POSTDIV_2POW(tv);
+	tmp |= CLKPWR_HCLKPLL_PREDIV_PLUS1(PllSetup->pll_n - 1);
+	tmp |= CLKPWR_HCLKPLL_PLLM(PllSetup->pll_m - 1);
+
+	return tmp;
+}
+
+/*
+ * Update the ARM core PLL frequency rate variable from the actual PLL setting
+ */
+static void local_update_armpll_rate(void)
+{
+	u32 clkin, pllreg;
+
+	clkin = clk_armpll.parent->rate;
+	pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+
+	clk_armpll.rate = clk_get_pllrate_from_reg(clkin, pllreg);
+}
+
+static int clkpwr_abs(int v1, int v2)
+{
+	if (v1 > v2)
+		return v1 - v2;
+
+	return v2 - v1;
+}
+
+/*
+ * Find a PLL configuration for the selected input frequency
+ */
+static u32 local_clk_find_pll_cfg(u32 pllin_freq, u32 target_freq,
+	struct clk_pll_setup *pllsetup)
+{
+	u32 ifreq, freqtol, m, n, p, fclkout = 0;
+	u32 flag = 0, freqret = 0;
+
+	/* Determine frequency tolerance limits */
+	freqtol = target_freq / 250;
+	ifreq = pllin_freq;
+
+	/* Is direct bypass mode possible? */
+	if (clkpwr_abs(pllin_freq, target_freq) <= freqtol) {
+		flag = 1;
+		pllsetup->analog_on = 0;
+		pllsetup->cco_bypass_b15 = 1;
+		pllsetup->direct_output_b14 = 1;
+		pllsetup->fdbk_div_ctrl_b13 = 1;
+		pllsetup->pll_p = pll_postdivs[0];
+		pllsetup->pll_n = 1;
+		pllsetup->pll_m = 1;
+		fclkout = clk_check_pll_setup(ifreq, pllsetup);
+	} else if (target_freq <= ifreq) {
+		pllsetup->analog_on = 0;
+		pllsetup->cco_bypass_b15 = 1;
+		pllsetup->direct_output_b14 = 0;
+		pllsetup->fdbk_div_ctrl_b13 = 1;
+		pllsetup->pll_n = 1;
+		pllsetup->pll_m = 1;
+		for (p = 0; ((p <= 3) && (flag == 0)); p++) {
+			pllsetup->pll_p = pll_postdivs[p];
+			fclkout = clk_check_pll_setup(ifreq, pllsetup);
+			if (clkpwr_abs(target_freq, fclkout) <= freqtol)
+				flag = 1;
+		}
+	}
+
+	/* Is direct mode possible? */
+	if (flag == 0) {
+		pllsetup->analog_on = 1;
+		pllsetup->cco_bypass_b15 = 0;
+		pllsetup->direct_output_b14 = 1;
+		pllsetup->fdbk_div_ctrl_b13 = 0;
+		pllsetup->pll_p = pll_postdivs[0];
+		for (m = 1; ((m <= 256) && (flag == 0)); m++) {
+			for (n = 1; ((n <= 4) && (flag == 0)); n++) {
+				/* Compute output frequency for this value */
+				pllsetup->pll_n = n;
+				pllsetup->pll_m = m;
+				fclkout = clk_check_pll_setup(ifreq,
+					pllsetup);
+				if (clkpwr_abs(target_freq, fclkout) <=
+					freqtol)
+					flag = 1;
+			}
+		}
+	}
+
+	/* Is integer mode possible? */
+	if (flag == 0) {
+		pllsetup->analog_on = 1;
+		pllsetup->cco_bypass_b15 = 0;
+		pllsetup->direct_output_b14 = 0;
+		pllsetup->fdbk_div_ctrl_b13 = 1;
+		for (m = 1; ((m <= 256) && (flag == 0)); m++) {
+			for (n = 1; ((n <= 4) && (flag == 0)); n++) {
+				for (p = 0; ((p < 4) && (flag == 0)); p++) {
+					/* Compute output frequency */
+					pllsetup->pll_p = pll_postdivs[p];
+					pllsetup->pll_n = n;
+					pllsetup->pll_m = m;
+					fclkout = clk_check_pll_setup(
+						ifreq, pllsetup);
+					if (clkpwr_abs(target_freq,
+						fclkout) <= freqtol)
+						flag = 1;
+				}
+			}
+		}
+	}
+
+	if (flag == 0)  {
+		/* Try non-integer mode */
+		pllsetup->analog_on = 1;
+		pllsetup->cco_bypass_b15 = 0;
+		pllsetup->direct_output_b14 = 0;
+		pllsetup->fdbk_div_ctrl_b13 = 0;
+		for (m = 1; ((m <= 256) && (flag == 0)); m++) {
+			for (n = 1; ((n <= 4) && (flag == 0)); n++) {
+				for (p = 0; ((p < 4) && (flag == 0)); p++) {
+					/* Compute output frequency */
+					pllsetup->pll_p = pll_postdivs[p];
+					pllsetup->pll_n = n;
+					pllsetup->pll_m = m;
+					fclkout = clk_check_pll_setup(
+						ifreq, pllsetup);
+					if (clkpwr_abs(target_freq,
+						fclkout) <= freqtol)
+						flag = 1;
+				}
+			}
+		}
+	}
+
+	if (flag == 1)
+		freqret = fclkout;
+
+	return freqret;
+}
+
+static struct clk clk_armpll = {
+	.parent		= &clk_sys,
+};
+
+/*
+ * Update the USB PLL frequency rate variable from the actual PLL setting
+ */
+static void local_update_usbpll_rate(void)
+{
+	u32 clkin, pllreg;
+
+	clkin = (u32) clk_get_rate(&clk_usbpll);
+	pllreg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+
+	if ((pllreg & CLKPWR_USBCTRL_PLL_PWRUP) == 0)
+		clk_usbpll.rate = 0;
+	else
+		clk_usbpll.rate = clk_get_pllrate_from_reg(clkin,
+			pllreg);
+}
+
+/*
+ * Setup the USB PLL with a PLL structure
+ */
+static u32 local_clk_usbpll_setup(struct clk_pll_setup *pHCLKPllSetup)
+{
+	u32 reg, tmp = local_clk_pll_setup(pHCLKPllSetup);
+
+	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & ~0x1FFFF;
+	reg |= tmp;
+	writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+	return clk_check_pll_setup(clk_usbpll.parent->rate,
+		pHCLKPllSetup);
+}
+
+static int local_usbpll_enable(struct clk *clk, int enable)
+{
+	u32 reg;
+	int ret = -ENODEV, qj = (jiffies / 4);
+
+	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+	if (enable == 0) {
+		reg &= ~(CLKPWR_USBCTRL_CLK_EN1 | CLKPWR_USBCTRL_CLK_EN2);
+		writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	} else if (reg & CLKPWR_USBCTRL_PLL_PWRUP) {
+		reg |= CLKPWR_USBCTRL_CLK_EN1;
+		writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+		/* Wait for PLL lock */
+		while (qj < jiffies) {
+			reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+			if (reg & CLKPWR_USBCTRL_PLL_STS)
+				ret = 0;
+		}
+
+		if (ret == 0) {
+			reg |= CLKPWR_USBCTRL_CLK_EN2;
+			writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+		}
+	}
+
+	return ret;
+}
+
+static int local_usbpll_set_rate(struct clk *clk, u32 rate)
+{
+	u32 clkin, reg, usbdiv;
+	struct clk_pll_setup pllsetup;
+
+	/* Unlike other clocks, this clock has a KHz input rate, so bump
+	   it up to work with the PLL function */
+	rate = rate * 1000;
+
+	local_usbpll_enable(clk, 0);
+
+	if (rate == 0)
+		return 0;
+
+	clkin = clk->parent->rate;
+	usbdiv = readl(CLKPWR_USBCLK_PDIV(CLKPWR_IOBASE)) + 1;
+	clkin = clkin / usbdiv;
+
+	/* Try to find a good rate setup */
+	if (local_clk_find_pll_cfg(clkin, rate, &pllsetup) == 0)
+		return -EINVAL;
+
+	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg |= CLKPWR_USBCTRL_CLK_EN1;
+	writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+	pllsetup.analog_on = 1;
+	local_clk_usbpll_setup(&pllsetup);
+
+	clk->rate = clk_check_pll_setup(clkin, &pllsetup);
+
+	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg |= CLKPWR_USBCTRL_CLK_EN2;
+	writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+	return 0;
+}
+
+static struct clk clk_usbpll = {
+	.parent		= &osc_main,
+	.set_rate	= &local_usbpll_set_rate,
+	.enable		= &local_usbpll_enable,
+};
+
+static u32 clk_get_hclk_div(void)
+{
+	static const u32 hclkdivs[4] = {1, 2, 4, 4};
+	return hclkdivs[CLKPWR_HCLKDIV_DIV_2POW(
+		readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE)))];
+}
+
+static struct clk clk_hclk = {
+	.parent		= &clk_armpll,
+};
+
+static struct clk clk_pclk = {
+	.parent		= &clk_armpll,
+};
+
+static int local_onoff_enable(struct clk *clk, int enable)
+{
+	u32 tmp;
+
+	tmp = readl(clk->enable_reg);
+
+	if (enable == 0)
+		tmp &= ~clk->enable_mask;
+	else
+		tmp |= clk->enable_mask;
+
+	writel(tmp, clk->enable_reg);
+
+	return 0;
+}
+
+/* Peripheral clock sources */
+static struct clk clk_timer0 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER0_EN,
+};
+static struct clk clk_timer1 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER1_EN,
+};
+static struct clk clk_timer2 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER2_EN,
+};
+static struct clk clk_timer3 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER3_EN,
+};
+static struct clk clk_wdt = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_PWMCLK_WDOG_EN,
+};
+static struct clk clk_vfp9 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_DEBUG_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_VFP_CLOCK_ENABLE_BIT,
+};
+static struct clk clk_dma = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_DMA_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_DMACLKCTRL_CLK_EN,
+};
+
+static struct clk clk_uart3 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_UARTCLKCTRL_UART3_EN,
+};
+
+static struct clk clk_uart4 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_UARTCLKCTRL_UART4_EN,
+};
+
+static struct clk clk_uart5 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_UARTCLKCTRL_UART5_EN,
+};
+
+static struct clk clk_uart6 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_UARTCLKCTRL_UART6_EN,
+};
+
+static struct clk clk_i2c0 = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_I2CCLK_I2C1CLK_EN,
+};
+
+static struct clk clk_i2c1 = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_I2CCLK_I2C2CLK_EN,
+};
+
+static struct clk clk_i2c2 = {
+	.parent		= &clk_pclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= USB_OTG_IOBASE + 0xFF4,
+	.enable_mask	= 0x4,
+};
+
+static struct clk clk_ssp0 = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_SSPCTRL_SSPCLK0_EN,
+};
+static struct clk clk_ssp1 = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_SSPCTRL_SSPCLK1_EN,
+};
+
+static struct clk clk_kscan = {
+	.parent		= &osc_32KHz,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_KEY_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_KEYCLKCTRL_CLK_EN,
+};
+
+static struct clk clk_nand = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_NANDCLK_SLCCLK_EN,
+};
+
+static struct clk clk_i2s0 = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_I2SCTRL_I2SCLK0_EN,
+};
+static struct clk clk_i2s1 = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_I2SCTRL_I2SCLK1_EN,
+};
+
+static struct clk clk_net = {
+	.parent		= &clk_hclk,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= (CLKPWR_MACCTRL_DMACLK_EN |
+		CLKPWR_MACCTRL_MMIOCLK_EN | CLKPWR_MACCTRL_HRCCLK_EN),
+};
+
+static struct clk clk_rtc = {
+	.parent		= &osc_32KHz,
+	.rate		= 1, /* 1 Hz */
+};
+
+static struct clk clk_usbd = {
+	.parent		= &clk_usbpll,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_USB_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_USBCTRL_HCLK_EN,
+};
+
+static int tsc_onoff_enable(struct clk *clk, int enable)
+{
+	u32 tmp;
+
+	/* Make sure 32KHz clock is the selected clock */
+	tmp = readl(CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
+	tmp &= ~CLKPWR_ADCCTRL1_PCLK_SEL;
+	writel(tmp, CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
+
+	if (enable == 0)
+		writel(0, clk->enable_reg);
+	else
+		writel(clk->enable_mask, clk->enable_reg);
+
+	return 0;
+}
+
+static struct clk clk_tsc = {
+	.parent		= &osc_32KHz,
+	.enable		= &tsc_onoff_enable,
+	.enable_reg	= CLKPWR_ADC_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_ADC32CLKCTRL_CLK_EN,
+};
+
+static int mmc_onoff_enable(struct clk *clk, int enable)
+{
+	u32 tmp;
+
+	tmp = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE)) &
+		~(CLKPWR_MSCARD_SDCARD_EN|CLKPWR_MSCARD_SDCARD_DIV(15));
+
+	/* If rate is 0, disable clock */
+	if (enable != 0)
+		tmp |= CLKPWR_MSCARD_SDCARD_EN | CLKPWR_MSCARD_SDCARD_DIV(1);
+
+	writel(tmp, CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+
+	return 0;
+}
+
+static u32 mmc_get_rate(struct clk *clk)
+{
+	u32 div, tmp, rate;
+
+	div = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+	tmp = div & CLKPWR_MSCARD_SDCARD_EN;
+
+	if (!tmp)
+		return 0;
+
+	/* Get the parent clock rate */
+	rate = clk_get_rate(clk->parent);
+
+	/* Get the LCD controller clock divider value */
+	div = div & 0xF;
+
+	if (!div)
+		return 0;
+
+	tmp = rate / div;
+
+	return tmp;
+}
+
+static int mmc_set_rate(struct clk *clk, u32 rate)
+{
+	if (rate == 0)
+		mmc_onoff_enable(clk, 0);
+	else
+		mmc_onoff_enable(clk, 1);
+
+	return 0;
+}
+
+static struct clk clk_mmc = {
+	.parent		= &clk_armpll,
+	.set_rate	= &mmc_set_rate,
+	.get_rate	= &mmc_get_rate,
+	.enable		= &mmc_onoff_enable,
+	.enable_reg	= CLKPWR_MS_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_MSCARD_SDCARD_EN,
+};
+
+static u32 clcd_get_rate(struct clk *clk)
+{
+	u32 tmp, div, rate;
+
+	tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
+		CLKPWR_LCDCTRL_CLK_EN;
+
+	if (!tmp)
+		return 0;
+
+	rate = clk_get_rate(clk->parent);
+	tmp = readl((io_p2v(LCD_BASE)) + CLCD_TIM2);
+
+	/* Only supports internal clocking */
+	if (tmp & TIM2_BCD)
+		return rate;
+
+	div = (tmp & 0x1F) | ((tmp & 0xF8) >> 22);
+	tmp = rate / (2 + div);
+
+	return tmp;
+}
+
+static int clcd_set_rate(struct clk *clk, u32 rate)
+{
+	u32 tmp, prate, div;
+
+	tmp = readl((io_p2v(LCD_BASE)) + CLCD_TIM2);
+	prate = clk_get_rate(clk->parent);
+
+	if (rate == prate) {
+		tmp |= TIM2_BCD;
+		local_onoff_enable(clk, 1);
+	} else {
+		/* Find closest divider */
+		div = prate / rate;
+		if (div == 1)
+			div = 0;
+		else
+			div -= 2;
+
+		tmp &= ~(0xF800001F);
+		tmp &= ~TIM2_BCD;
+		tmp |= (div & 0x1F);
+		tmp |= (((div >> 5) & 0x1F) << 27);
+		writel(tmp, ((io_p2v(LCD_BASE)) + CLCD_TIM2));
+		local_onoff_enable(clk, 1);
+	}
+
+	return 0;
+}
+static struct clk clk_lcd = {
+	.parent		= &clk_hclk,
+	.set_rate	= &clcd_set_rate,
+	.get_rate	= &clcd_get_rate,
+	.enable		= &local_onoff_enable,
+	.enable_reg	= CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= CLKPWR_LCDCTRL_CLK_EN,
+};
+
+static inline void clk_lock(void)
+{
+	local_irq_disable();
+}
+
+static inline void clk_unlock(void)
+{
+	local_irq_enable();
+}
+
+static void local_clk_disable(struct clk *clk)
+{
+	/* Don't attempt to disable clock if it has no users */
+	if (clk->usecount > 0) {
+		clk->usecount--;
+
+		/* Only disable clock when it has no more users */
+		if ((clk->usecount == 0) && (clk->enable))
+			clk->enable(clk, 0);
+
+		/* Check parent clocks, they may need to be disabled too */
+		if (clk->parent)
+			local_clk_disable(clk->parent);
+	}
+}
+
+static int local_clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (clk->usecount == 0) {
+		/* Enable parent clocks first */
+		if (clk->parent)
+			ret = local_clk_enable(clk->parent);
+
+		/* Enable clock on first use */
+		if ((ret == 0) && (clk->enable)) {
+			ret = clk->enable(clk, 1);
+			clk->usecount++;
+		}
+
+		/* Back out use counters if enable fails */
+		if (ret < 0)
+			local_clk_disable(clk);
+	}
+
+	return ret;
+}
+
+/*
+ * clk_enable - inform the system when the clock source should be running.
+ */
+int clk_enable(struct clk *clk)
+{
+	int ret;
+
+	clk_lock();
+	ret = local_clk_enable(clk);
+	clk_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+/*
+ * clk_disable - inform the system when the clock source is no longer required
+ */
+void clk_disable(struct clk *clk)
+{
+	clk_lock();
+	local_clk_disable(clk);
+	clk_unlock();
+}
+EXPORT_SYMBOL(clk_disable);
+
+/*
+ * clk_get_rate - obtain the current clock rate (in Hz) for a clock source
+ */
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (clk->get_rate)
+		return (clk->get_rate)(clk);
+
+	/* If a clocks rate is 0, it uses the parent's rate instead. */
+	while (clk->rate == 0)
+		clk = clk->parent;
+
+	return clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+/*
+ * clk_set_rate - set the clock rate for a clock source
+ */
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EINVAL;
+
+	/* Most system clocks can only be enabled or disabled, with
+	   the actual rate set as part of the peripheral dividers
+	   instead of high level clock control */
+	if (clk->set_rate) {
+		clk_lock();
+		ret = (clk->set_rate)(clk, rate);
+		clk_unlock();
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+/*
+ * clk_round_rate - adjust a rate to the exact rate a clock can provide
+ */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	int ret;
+
+	/* Use set_rate to try to adjust the rate if it supports it */
+	ret = clk_set_rate(clk, rate);
+	if (ret < 0)
+		return (long) ret;
+
+	return clk->rate;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+/*
+ * clk_set_parent - set the parent clock source for this clock
+ */
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	/* Clock re-parenting is not supported */
+	return -EINVAL;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+/*
+ * clk_get_parent - get the parent clock source for this clock
+ */
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+#define _REGISTER_CLOCK(d, n, c) \
+	{ \
+		.dev_id = (d), \
+		.con_id = (n), \
+		.clk = &(c), \
+	},
+
+static struct clk_lookup lookups[] __initdata = {
+	_REGISTER_CLOCK(NULL, "osc_32KHz", osc_32KHz)
+	_REGISTER_CLOCK(NULL, "osc_pll397", osc_pll397)
+	_REGISTER_CLOCK(NULL, "osc_main", osc_main)
+	_REGISTER_CLOCK(NULL, "sys_ck", clk_sys)
+	_REGISTER_CLOCK(NULL, "arm_pll_ck", clk_armpll)
+	_REGISTER_CLOCK(NULL, "ck_pll5", clk_usbpll)
+	_REGISTER_CLOCK(NULL, "hclk_ck", clk_hclk)
+	_REGISTER_CLOCK(NULL, "pclk_ck", clk_pclk)
+	_REGISTER_CLOCK(NULL, "timer0_ck", clk_timer0)
+	_REGISTER_CLOCK(NULL, "timer1_ck", clk_timer1)
+	_REGISTER_CLOCK(NULL, "timer2_ck", clk_timer2)
+	_REGISTER_CLOCK(NULL, "timer3_ck", clk_timer3)
+	_REGISTER_CLOCK(NULL, "vfp9_ck", clk_vfp9)
+	_REGISTER_CLOCK(NULL, "clk_dmac", clk_dma)
+	_REGISTER_CLOCK("pnx4008-watchdog", NULL, clk_wdt)
+	_REGISTER_CLOCK(NULL, "uart3_ck", clk_uart3)
+	_REGISTER_CLOCK(NULL, "uart4_ck", clk_uart4)
+	_REGISTER_CLOCK(NULL, "uart5_ck", clk_uart5)
+	_REGISTER_CLOCK(NULL, "uart6_ck", clk_uart6)
+	_REGISTER_CLOCK("pnx-i2c.0", NULL, clk_i2c0)
+	_REGISTER_CLOCK("pnx-i2c.1", NULL, clk_i2c1)
+	_REGISTER_CLOCK("pnx-i2c.2", NULL, clk_i2c2)
+	_REGISTER_CLOCK("dev:ssp0", NULL, clk_ssp0)
+	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
+	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
+	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
+	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
+	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
+	_REGISTER_CLOCK("lpc32xx-ts", NULL, clk_tsc)
+	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
+	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
+	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
+	_REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
+	_REGISTER_CLOCK("lpc32xx_rtc", NULL, clk_rtc)
+};
+
+int __init clk_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lookups); i++)
+		clkdev_add(&lookups[i]);
+
+	/* Setup muxed SYSCLK for HCLK PLL base -this selects the
+	   parent clock used for the ARM PLL and is used to derive
+	   the many system clock rates in the device. */
+	if (clk_is_sysclk_mainosc() != 0)
+		clk_sys.parent = &osc_main;
+	else
+		clk_sys.parent = &osc_pll397;
+
+	clk_sys.rate = clk_sys.parent->rate;
+
+	/* Compute the current ARM PLL and USB PLL frequencies */
+	local_update_armpll_rate();
+	local_update_usbpll_rate();
+
+	/* Compute HCLK and PCLK bus rates */
+	clk_hclk.rate = clk_hclk.parent->rate / clk_get_hclk_div();
+	clk_pclk.rate = clk_pclk.parent->rate / clk_get_pclk_div();
+
+	/* Enable system clocks - this step is somewhat formal, as the
+	   clocks are already running, but it does get the clock data
+	   inline with the actual system state. Never disable these
+	   clocks as they will only stop if the system is going to sleep.
+	   In that case, the chip/system power management functions will
+	   handle clock gating. */
+	clk_enable(&clk_hclk);
+	clk_enable(&clk_pclk);
+
+	/* Timers 0 and 1 were enabled and are being used by the high
+	   resolution tick function prior to this driver being initialized.
+	   Tag them now as used */
+	clk_enable(&clk_timer0);
+	clk_enable(&clk_timer1);
+
+	return 0;
+}
+core_initcall(clk_init);
+
diff --git a/arch/arm/mach-lpc32xx/clock.h b/arch/arm/mach-lpc32xx/clock.h
new file mode 100644
index 0000000..f37f245
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/clock.h
@@ -0,0 +1,41 @@
+/*
+ * arch/arm/mach-lpc32xx/clock.h
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
+#ifndef __LPC32XX_CLOCK_H
+#define __LPC32XX_CLOCK_H
+
+struct clk {
+	struct list_head node;
+	struct clk *parent;
+	u32 rate;
+	s8 usecount;
+
+	int (*set_rate) (struct clk *, u32);
+	int (*enable) (struct clk *clk, int);
+	u32 (*get_rate) (struct clk *clk);
+
+	/* Register address and bit mask for simple clocks */
+	u32 enable_reg;
+	u32 enable_mask;
+};
+
+#endif
-- 
1.6.6
