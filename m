From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 20 Nov 2009 02:11:24 +0100
Subject: RFC [PATCH 4/9] Added lpc32xx clock handler
Message-ID: <083DF309106F364B939360100EC290F804F54D560D@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added lpc32xx clock handler

Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
---
 arch/arm/mach-lpc32xx/clock.c | 1680 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1680 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-lpc32xx/clock.c

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
new file mode 100644
index 0000000..8533ea4
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -0,0 +1,1680 @@
+/*
+ *  linux/arch/arm/mach-lpc32xx/clock.c
+ *
+ *  Copyright (C) 2008 NXP Semiconductors
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
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/amba/bus.h>
+#include <linux/amba/clcd.h>
+
+#include <mach/hardware.h>
+#include <asm/io.h>
+#include <asm/clkdev.h>
+#include <mach/clkdev.h>
+
+#include <mach/platform.h>
+#include <mach/clock.h>
+#include <mach/i2c.h>
+#include "common.h"
+
+static struct clk osc_pll397;
+static struct clk osc_main;
+static struct clk clk_armpll;
+static struct clk clk_usbpll;
+
+static void clk_upate_children(struct clk *clk);
+static void local_update_armpll_rate(void);
+static void local_update_usbpll_rate(void);
+
+/*
+ * Structure used for setting up and querying the HCLK PLL
+ */
+typedef struct {
+       int analog_on;
+       int cco_bypass_b15;
+       int direct_output_b14;
+       int fdbk_div_ctrl_b13;
+       int pll_p;
+       int pll_n;
+       u32 pll_m;
+} CLKPWR_HCLK_PLL_SETUP_T;
+
+/*
+ * Post divider values for PLLs based on selected register value
+ */
+static u32 pll_postdivs[4] = {1, 2, 4, 8};
+
+#define USB_OTG_IOBASE io_p2v(USB_BASE)
+
+static int local_clk_dummy_set_rate(struct clk *clk, u32 rate)
+{
+       return 0;
+}
+
+static u32 local_clk_get_st_rate(struct clk *clk)
+{
+       return clk->rate;
+}
+
+static int local_clk_dummy_enable(struct clk *clk, int enable)
+{
+       return 0;
+}
+
+/* Primary system clock sources */
+static struct clk osc_32KHz = {
+       .owner          = NULL,
+       .parent         = NULL,
+       .rate           = CLOCK_OSC_FREQ,
+       .flags          = CLK_FLAG_FIXED,
+       .usecount       = 0,
+       .set_rate       = &local_clk_dummy_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = &local_clk_get_st_rate,
+       .enable         = &local_clk_dummy_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+
+static void clk_upate_children(struct clk *clk)
+{
+       local_update_armpll_rate();
+       local_update_usbpll_rate();
+}
+
+static int local_pll397_set_rate(struct clk *clk, u32 rate)
+{
+       u32 reg;
+
+       reg = readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+
+       /* Disable if rate is 0 */
+       if (rate == 0)  {
+               /* 1 = disable for PLL397 */
+               reg |= CLKPWR_SYSCTRL_PLL397_DIS;
+               writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+               clk->rate = 0;
+       }
+       else {
+               /* Enable PLL397 */
+               reg &= ~CLKPWR_SYSCTRL_PLL397_DIS;
+               writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+               clk->rate = CLOCK_OSC_FREQ * 397;
+
+               /* Wait for PLL397 lock */
+               while ((readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
+                       CLKPWR_SYSCTRL_PLL397_STS) == 0);
+       }
+
+       clk_upate_children(clk);
+
+       return 0;
+}
+
+static int local_pll397_enable(struct clk *clk, int enable)
+{
+       return (int) local_pll397_set_rate(clk, (u32) enable);
+}
+
+
+static int local_oscmain_set_rate(struct clk *clk, u32 rate)
+{
+       u32 reg;
+
+       reg = readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+
+       /* Disable if rate is 0 */
+       if (rate == 0) {
+               /* 1 = disable for main oscillator */
+               reg |= CLKPWR_MOSC_DISABLE;
+               writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+               clk->rate = 0;
+       }
+       else {
+               /* Enable main oscillator */
+               reg &= ~CLKPWR_MOSC_DISABLE;
+               writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+               clk->rate = MAIN_OSC_FREQ;
+
+               /* Wait for main oscillator to start */
+               while ((readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
+                       CLKPWR_MOSC_DISABLE) != 0);
+       }
+
+       clk_upate_children(clk);
+
+       return 0;
+}
+
+static int local_oscmain_enable(struct clk *clk, int enable)
+{
+       return (int) local_oscmain_set_rate(clk, (u32) enable);
+}
+
+static int local_sysclk_set_rate(struct clk *clk, u32 rate)
+{
+       u32 reg, ret = 0;
+
+       reg = readl(CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE));
+
+       if (rate == 0) {
+               /* 0 = Switch to main oscillator */
+               reg &= ~CLKPWR_SYSCTRL_USEPLL397;
+               writel(reg, CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE));
+               clk->parent = &osc_main;
+       }
+       else {
+               /* 1 = Switch to PLL397 opscillator */
+               reg |= CLKPWR_SYSCTRL_USEPLL397;
+               writel(reg, CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE));
+               clk->parent = &osc_pll397;
+       }
+
+       clk->rate = clk->parent->rate;
+
+       clk_upate_children(clk);
+
+       return ret;
+}
+
+static int local_sysclk_set_parent(struct clk *clk, struct clk *parent)
+{
+       u32 reg, ret = 0;
+
+       reg = readl(CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE));
+
+       if (parent == &osc_main)
+               local_sysclk_set_rate(parent, 0);
+       else if (parent == &osc_pll397)
+               local_sysclk_set_rate(parent, 1);
+       else
+               ret = -EINVAL;
+
+       return ret;
+}
+
+static struct clk osc_pll397 = {
+       .owner          = NULL,
+       .parent         = &osc_32KHz,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_pll397_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = NULL,
+       .enable         = &local_pll397_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+
+static struct clk osc_main = {
+       .owner          = NULL,
+       .parent         = NULL,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_oscmain_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = NULL,
+       .enable         = &local_oscmain_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+static struct clk clk_sys = {
+       .owner          = NULL,
+       .parent         = &osc_main,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_sysclk_set_rate,
+       .set_parent     = local_sysclk_set_parent,
+       .round_rate     = NULL,
+       .get_rate       = NULL,
+       .enable         = &local_clk_dummy_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+
+/*
+ * Computes PLL rate from PLL register and input clock
+ */
+static u32 local_clk_check_pll_setup(u32 ifreq,
+       CLKPWR_HCLK_PLL_SETUP_T *pllsetup)
+{
+       u32 i64freq, p, m, n, fcco, fref, cfreq;
+       int mode;
+
+       /* PLL requirements */
+       /* ifreq must be >= 1MHz and <= 20MHz */
+       /* FCCO must be >= 156MHz and <= 320MHz */
+       /* FREF must be >= 1MHz and <= 27MHz. */
+       /* Assume the passed input data is not valid */
+
+       i64freq = ifreq;
+       m = pllsetup->pll_m;
+       n = pllsetup->pll_n;
+       p = pllsetup->pll_p;
+
+       mode = (pllsetup->cco_bypass_b15 << 2) |
+               (pllsetup->direct_output_b14 << 1) |
+       pllsetup->fdbk_div_ctrl_b13;
+
+       switch (mode)
+       {
+       case 0x0: /* Non-integer mode */
+               cfreq = (m * i64freq) / (2 * p * n);
+               fcco = (m * i64freq) / n;
+               fref = i64freq / n;
+               break;
+
+       case 0x1: /* integer mode */
+               cfreq = (m * i64freq) / n;
+               fcco = (m * i64freq) / (n * 2 * p);
+               fref = i64freq / n;
+               break;
+
+       case 0x2:
+       case 0x3: /* Direct mode */
+               cfreq = (m * i64freq) / n;
+               fcco = cfreq;
+               fref = i64freq / n;
+               break;
+
+       case 0x4:
+       case 0x5: /* Bypass mode */
+               cfreq = i64freq / (2 * p);
+               fcco = 156000000;
+               fref = 1000000;
+               break;
+
+       case 0x6:
+       case 0x7: /* Direct bypass mode */
+       default:
+               cfreq = i64freq;
+               fcco = 156000000;
+               fref = 1000000;
+               break;
+       }
+
+       if ((fcco < 156000000) || (fcco > 320000000))
+               cfreq = 0;
+
+       if ((fref < 1000000) || (fref > 27000000))
+               cfreq = 0;
+
+       return (u32) cfreq;
+}
+
+/*
+ * Convert a PLL register value to a PLL output frequency
+ */
+u32 local_clk_get_pllrate_from_reg(u32 inputclk, u32 regval)
+{
+       CLKPWR_HCLK_PLL_SETUP_T pllcfg;
+
+       pllcfg.cco_bypass_b15 = 0;
+       pllcfg.direct_output_b14 = 0;
+       pllcfg.fdbk_div_ctrl_b13 = 0;
+       if ((regval & CLKPWR_HCLKPLL_CCO_BYPASS) != 0)
+               pllcfg.cco_bypass_b15 = 1;
+       if ((regval & CLKPWR_HCLKPLL_POSTDIV_BYPASS) != 0)
+               pllcfg.direct_output_b14 = 1;
+       if ((regval & CLKPWR_HCLKPLL_FDBK_SEL_FCLK) != 0)
+               pllcfg.fdbk_div_ctrl_b13 = 1;
+       pllcfg.pll_m = 1 + ((regval >> 1) & 0xFF);
+       pllcfg.pll_n = 1 + ((regval >> 9) & 0x3);
+       pllcfg.pll_p = pll_postdivs[((regval >> 11) & 0x3)];
+
+       return local_clk_check_pll_setup(inputclk, &pllcfg);
+}
+
+/*
+ * Update the ARM core PLL frequency rate variable from the actual PLL setting
+ */
+static void local_update_armpll_rate(void)
+{
+       u32 clkin, pllreg;
+
+       clkin = clk_armpll.parent->rate;
+       pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+
+       clk_armpll.rate = local_clk_get_pllrate_from_reg(clkin, pllreg);
+}
+
+static int clkpwr_abs(int v1, int v2) {
+       if (v1 > v2)
+               return v1 - v2;
+
+       return v2 - v1;
+}
+
+/*
+ * Find a PLL configuration for the selected input frequency
+ */
+static u32 local_clk_find_pll_cfg(u32 pllin_freq, u32 target_freq,
+       CLKPWR_HCLK_PLL_SETUP_T *pllsetup)
+{
+       u32 ifreq, freqtol, m, n, p, fclkout = 0;
+       u32 flag = 0, freqret = 0;
+
+       /* Determine frequency tolerance limits */
+       freqtol = target_freq / 250;
+       ifreq = pllin_freq;
+
+       /* Is direct bypass mode possible? */
+       if (clkpwr_abs(pllin_freq, target_freq) <= freqtol) {
+               flag = 1;
+               pllsetup->analog_on = 0;
+               pllsetup->cco_bypass_b15 = 1;
+               pllsetup->direct_output_b14 = 1;
+               pllsetup->fdbk_div_ctrl_b13 = 1;
+               pllsetup->pll_p = pll_postdivs[0];
+               pllsetup->pll_n = 1;
+               pllsetup->pll_m = 1;
+               fclkout = local_clk_check_pll_setup(ifreq, pllsetup);
+       }
+       else if (target_freq <= ifreq) {
+               pllsetup->analog_on = 0;
+               pllsetup->cco_bypass_b15 = 1;
+               pllsetup->direct_output_b14 = 0;
+               pllsetup->fdbk_div_ctrl_b13 = 1;
+               pllsetup->pll_n = 1;
+               pllsetup->pll_m = 1;
+               for (p = 0; ((p <= 3) && (flag == 0)); p++) {
+                       pllsetup->pll_p = pll_postdivs[p];
+                       fclkout = local_clk_check_pll_setup(ifreq, pllsetup);
+                       if (clkpwr_abs(target_freq, fclkout) <= freqtol)
+                               flag = 1;
+               }
+       }
+
+       /* Is direct mode possible? */
+       if (flag == 0) {
+               pllsetup->analog_on = 1;
+               pllsetup->cco_bypass_b15 = 0;
+               pllsetup->direct_output_b14 = 1;
+               pllsetup->fdbk_div_ctrl_b13 = 0;
+               pllsetup->pll_p = pll_postdivs[0];
+               for (m = 1; ((m <= 256) && (flag == 0)); m++) {
+                       for (n = 1; ((n <= 4) && (flag == 0)); n++) {
+                               /* Compute output frequency for this value */
+                               pllsetup->pll_n = n;
+                               pllsetup->pll_m = m;
+                               fclkout = local_clk_check_pll_setup(ifreq,
+                                       pllsetup);
+                               if (clkpwr_abs(target_freq, fclkout) <=
+                                       freqtol)
+                                       flag = 1;
+                       }
+               }
+       }
+
+       /* Is integer mode possible? */
+       if (flag == 0) {
+               pllsetup->analog_on = 1;
+               pllsetup->cco_bypass_b15 = 0;
+               pllsetup->direct_output_b14 = 0;
+               pllsetup->fdbk_div_ctrl_b13 = 1;
+               for (m = 1; ((m <= 256) && (flag == 0)); m++) {
+                       for (n = 1; ((n <= 4) && (flag == 0)); n++) {
+                               for (p = 0; ((p < 4) && (flag == 0)); p++) {
+                                       /* Compute output frequency */
+                                       pllsetup->pll_p = pll_postdivs[p];
+                                       pllsetup->pll_n = n;
+                                       pllsetup->pll_m = m;
+                                       fclkout = local_clk_check_pll_setup(
+                                               ifreq, pllsetup);
+                                       if (clkpwr_abs(target_freq,
+                                               fclkout) <= freqtol)
+                                               flag = 1;
+                               }
+                       }
+               }
+       }
+
+       if (flag == 0)  {
+               /* Try non-integer mode */
+               pllsetup->analog_on = 1;
+               pllsetup->cco_bypass_b15 = 0;
+               pllsetup->direct_output_b14 = 0;
+               pllsetup->fdbk_div_ctrl_b13 = 0;
+               for (m = 1; ((m <= 256) && (flag == 0)); m++) {
+                       for (n = 1; ((n <= 4) && (flag == 0)); n++) {
+                               for (p = 0; ((p < 4) && (flag == 0)); p++) {
+                                       /* Compute output frequency */
+                                       pllsetup->pll_p = pll_postdivs[p];
+                                       pllsetup->pll_n = n;
+                                       pllsetup->pll_m = m;
+                                       fclkout = local_clk_check_pll_setup(
+                                               ifreq, pllsetup);
+                                       if (clkpwr_abs(target_freq,
+                                               fclkout) <= freqtol)
+                                               flag = 1;
+                               }
+                       }
+               }
+       }
+
+       if (flag == 1)
+               freqret = fclkout;
+
+       return freqret;
+}
+
+/*
+ * Setup the HCLK PLL with a PLL structure
+ */
+static u32 local_clk_hclkpll_setup(CLKPWR_HCLK_PLL_SETUP_T *pHCLKPllSetup)
+{
+       u32 tv, tmp = 0;
+
+       if (pHCLKPllSetup->analog_on != 0)
+               tmp |= CLKPWR_HCLKPLL_POWER_UP;
+
+       if (pHCLKPllSetup->cco_bypass_b15 != 0)
+               tmp |= CLKPWR_HCLKPLL_CCO_BYPASS;
+
+       if (pHCLKPllSetup->direct_output_b14 != 0)
+               tmp |= CLKPWR_HCLKPLL_POSTDIV_BYPASS;
+
+       if (pHCLKPllSetup->fdbk_div_ctrl_b13 != 0)
+               tmp |= CLKPWR_HCLKPLL_FDBK_SEL_FCLK;
+
+       switch (pHCLKPllSetup->pll_p) {
+       case 1:
+               tv = 0;
+               break;
+
+       case 2:
+               tv = 1;
+               break;
+
+       case 4:
+               tv = 2;
+               break;
+
+       case 8:
+               tv = 3;
+               break;
+
+       default:
+               return 0;
+       }
+
+       tmp |= CLKPWR_HCLKPLL_POSTDIV_2POW(tv);
+       tmp |= CLKPWR_HCLKPLL_PREDIV_PLUS1(pHCLKPllSetup->pll_n - 1);
+       tmp |= CLKPWR_HCLKPLL_PLLM(pHCLKPllSetup->pll_m - 1);
+
+       writel(tmp, CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE));
+
+       return local_clk_check_pll_setup(clk_armpll.parent->rate,
+               pHCLKPllSetup);
+}
+
+static int local_armpll_set_rate(struct clk *clk, u32 rate)
+{
+       u32 clkin;
+       CLKPWR_HCLK_PLL_SETUP_T pllsetup;
+
+       if ((rate < 33000000) || (rate > 266000000))
+               return -EINVAL;
+
+       /* Get input frequency to PLL */
+       clkin = clk->parent->rate;
+
+       /* Try to find a good rate setup */
+       if (local_clk_find_pll_cfg(clkin, rate, &pllsetup) == 0)
+               return -EINVAL;
+
+       /* Setup PLL */
+       local_clk_hclkpll_setup(&pllsetup);
+       clk->rate = local_clk_check_pll_setup(clkin, &pllsetup);
+
+       return 0;
+}
+
+static int local_armpll_enable(struct clk *clk, int enable)
+{
+       u32 reg;
+
+       /* Read PLL reg */
+       reg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE));
+
+       if (enable == 0) {
+               /* Disable PLL - not recommended unless you really know
+                  what your are doing (must be in direct-run mode!) */
+               reg &= ~CLKPWR_HCLKPLL_POWER_UP;
+               writel(reg, CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE));
+               clk->rate = 0;
+       }
+       else {
+               reg |= CLKPWR_HCLKPLL_POWER_UP;
+               writel(reg, CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE));
+
+               /* Wait for PLL lock */
+               while ((readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) &
+                       CLKPWR_HCLKPLL_PLL_STS) == 0);
+
+               local_update_armpll_rate();
+       }
+
+       return 0;
+}
+
+/*
+ * Update the USB PLL frequency rate variable from the actual PLL setting
+ */
+static void local_update_usbpll_rate(void)
+{
+       u32 clkin, pllreg;
+
+       clkin = clk_armpll.parent->rate;
+       pllreg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+
+       if ((pllreg & CLKPWR_USBCTRL_PLL_PWRUP) == 0)
+               clk_usbpll.rate = 0;
+       else
+               clk_usbpll.rate = local_clk_get_pllrate_from_reg(clkin,
+                       pllreg);
+}
+
+/*
+ * Setup the USB PLL with a PLL structure
+ */
+static u32 local_clk_usbpll_setup(CLKPWR_HCLK_PLL_SETUP_T *pHCLKPllSetup)
+{
+       u32 tv, reg, tmp = 0;
+
+       if (pHCLKPllSetup->analog_on != 0)
+               tmp |= CLKPWR_HCLKPLL_POWER_UP;
+
+       if (pHCLKPllSetup->cco_bypass_b15 != 0)
+               tmp |= CLKPWR_HCLKPLL_CCO_BYPASS;
+
+       if (pHCLKPllSetup->direct_output_b14 != 0)
+               tmp |= CLKPWR_HCLKPLL_POSTDIV_BYPASS;
+
+       if (pHCLKPllSetup->fdbk_div_ctrl_b13 != 0)
+               tmp |= CLKPWR_HCLKPLL_FDBK_SEL_FCLK;
+
+       switch (pHCLKPllSetup->pll_p) {
+       case 1:
+               tv = 0;
+               break;
+
+       case 2:
+               tv = 1;
+               break;
+
+       case 4:
+               tv = 2;
+               break;
+
+       case 8:
+               tv = 3;
+               break;
+
+       default:
+               return 0;
+       }
+
+       tmp |= CLKPWR_HCLKPLL_POSTDIV_2POW(tv);
+       tmp |= CLKPWR_HCLKPLL_PREDIV_PLUS1(pHCLKPllSetup->pll_n - 1);
+       tmp |= CLKPWR_HCLKPLL_PLLM(pHCLKPllSetup->pll_m - 1);
+
+       reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & ~0x1FFFF;
+       reg |= tmp;
+       writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+       return local_clk_check_pll_setup(clk_usbpll.parent->rate,
+               pHCLKPllSetup);
+}
+
+static int local_usbpll_enable(struct clk *clk, int enable)
+{
+       u32 reg;
+       int ret = -ENODEV, qj = (jiffies / 4);
+
+       reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+       if (enable == 0) {
+               reg &= ~(CLKPWR_USBCTRL_CLK_EN1 | CLKPWR_USBCTRL_CLK_EN2);
+               writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+       }
+       else if (reg & CLKPWR_USBCTRL_PLL_PWRUP) {
+               reg |= CLKPWR_USBCTRL_CLK_EN1;
+               writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+               /* Wait for PLL lock */
+               while (qj < jiffies) {
+                       reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+                       if (reg & CLKPWR_USBCTRL_PLL_STS)
+                               ret = 0;
+               }
+
+               if (ret == 0) {
+                       reg |= CLKPWR_USBCTRL_CLK_EN2;
+                       writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+               }
+       }
+
+       return ret;
+}
+
+static int local_usbpll_set_rate(struct clk *clk, u32 rate)
+{
+       u32 clkin, reg, usbdiv;
+       CLKPWR_HCLK_PLL_SETUP_T pllsetup;
+
+       /* Unlike other clocks, this clock has a KHz input rate, so bump
+          it up to work with the PLL function */
+       rate = rate * 1000;
+
+       local_usbpll_enable(clk, 0);
+
+       if (rate == 0)
+               return 0;
+
+       clkin = clk->parent->rate;
+       usbdiv = readl(CLKPWR_USBCLK_PDIV(CLKPWR_IOBASE)) + 1;
+       clkin = clkin / usbdiv;
+
+       /* Try to find a good rate setup */
+       if (local_clk_find_pll_cfg(clkin, rate, &pllsetup) == 0)
+               return -EINVAL;
+
+       reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+       reg |= CLKPWR_USBCTRL_CLK_EN1;
+       writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+       pllsetup.analog_on = 1;
+       local_clk_usbpll_setup(&pllsetup);
+
+       clk->rate = local_clk_check_pll_setup(clkin, &pllsetup);
+
+       reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+       reg |= CLKPWR_USBCTRL_CLK_EN2;
+       writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+
+       return 0;
+}
+
+/* Derived system clock sources */
+static struct clk clk_armpll = {
+       .owner          = NULL,
+       .parent         = &clk_sys,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_armpll_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = &local_clk_get_st_rate,
+       .enable         = &local_armpll_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+static struct clk clk_usbpll = {
+       .owner          = NULL,
+       .parent         = &osc_main,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_usbpll_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = &local_clk_get_st_rate,
+       .enable         = &local_usbpll_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+
+static u32 clk_get_hclk_div(void) {
+       static const u32 hclkdivs[4] = {1, 2, 4, 4};
+       return hclkdivs[CLKPWR_HCLKDIV_DIV_2POW(
+               readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE)))];
+}
+
+/*
+ * Set new HCLK bus divider value
+ */
+static int clk_set_hclk_div(struct clk *clk, u32 div)
+{
+       u32 hclkdiv = readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE));
+
+       hclkdiv &= ~CLKPWR_HCLKDIV_DIV_2POW(0x3);
+       switch (div) {
+       case 1:
+       case 2:
+               hclkdiv |= CLKPWR_HCLKDIV_DIV_2POW(div - 1);
+               break;
+
+       case 4:
+       default:
+               hclkdiv |= CLKPWR_HCLKDIV_DIV_2POW(2);
+               break;
+       }
+       writel(hclkdiv, CLKPWR_HCLK_DIV(CLKPWR_IOBASE));
+
+       return 0;
+}
+
+static u32 local_hclk_get_rate(struct clk *clk)
+{
+       return clk->parent->rate / clk_get_hclk_div();
+}
+
+u32 clk_get_pclk_div(void)
+{
+       return (1 + ((readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE)) >> 2) &
+               0x1F));
+}
+
+/*
+ * Set new PCLK bus divider value
+ */
+static int clk_set_pclk_div(struct clk *clk, u32 div)
+{
+       u32 hclkdiv = readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE));
+
+       hclkdiv &= ~CLKPWR_HCLKDIV_PCLK_DIV(0x1F);
+       if (div > 32)
+               div = 32;
+
+       hclkdiv |= CLKPWR_HCLKDIV_PCLK_DIV(div - 1);
+       writel(hclkdiv, CLKPWR_HCLK_DIV(CLKPWR_IOBASE));
+
+       return 0;
+}
+
+static u32 local_pclk_get_rate(struct clk *clk)
+{
+       return clk->parent->rate / clk_get_pclk_div();
+}
+
+/* Bus clocks */
+static struct clk clk_hclk = {
+       .owner          = NULL,
+       .parent         = &clk_armpll,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &clk_set_hclk_div,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = &local_hclk_get_rate,
+       .enable         = &local_clk_dummy_enable,
+       .enable_reg     = 0,
+       .enable_mask    = 0,
+};
+static struct clk clk_pclk = {
+       .owner          = NULL,
+       .parent         = &clk_armpll,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &clk_set_pclk_div,
+       .set_parent     = NULL,
+       .round_rate     = NULL,
+       .get_rate       = &local_pclk_get_rate,
+       .enable         = &local_clk_dummy_enable,
+       .enable_reg     = 0,
+};
+
+static int local_onoff_set_rate(struct clk *clk, u32 rate)
+{
+       u32 tmp;
+
+       tmp = readl(clk->enable_reg);
+
+       if (rate == 0)
+               tmp &= ~clk->enable_mask;
+       else
+               tmp |= clk->enable_mask;
+
+       writel(tmp, clk->enable_reg);
+
+       return 0;
+}
+
+static u32 local_get_periph_rate(struct clk *clk)
+{
+       u32 tmp;
+
+       tmp = readl(clk->enable_reg) & clk->enable_mask;
+
+       if (!tmp)
+               return 0;
+
+       if (clk->parent != NULL) {
+               /* If the parent clock has a get_rate function, call it */
+               if (clk->parent->get_rate != NULL)
+                       return clk->parent->get_rate(clk->parent);
+
+               return clk->parent->rate;
+       }
+
+       return 1;
+}
+
+/* This function is required for drivers that expect a clock rate even
+ * when the clock is disabled */
+static u32 local_get_byp_periph_rate(struct clk *clk)
+{
+       if (clk->parent != NULL) {
+               /* If the parent clock has a get_rate function, call it */
+               if (clk->parent->get_rate != NULL)
+                       return clk->parent->get_rate(clk->parent);
+
+               return clk->parent->rate;
+       }
+
+       return 1;
+}
+
+static int local_onoff_enable(struct clk *clk, int enable)
+{
+       return local_onoff_set_rate(clk, enable);
+}
+
+static u32 local_onoff_round_rate(struct clk *clk, u32 rate)
+{
+       return (rate ? 1 : 0);
+}
+
+/* Peripheral clock sources */
+static struct clk clk_timer0 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_TMRPWMCLK_TIMER0_EN,
+};
+static struct clk clk_timer1 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_TMRPWMCLK_TIMER1_EN,
+};
+static struct clk clk_timer2 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_TMRPWMCLK_TIMER2_EN,
+};
+static struct clk clk_timer3 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_TMRPWMCLK_TIMER3_EN,
+};
+static struct clk clk_wdt = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_PWMCLK_WDOG_EN,
+};
+static struct clk clk_vfp9 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_DEBUG_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_VFP_CLOCK_ENABLE_BIT,
+};
+static struct clk clk_dma = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_DMA_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_DMACLKCTRL_CLK_EN,
+};
+
+static struct clk clk_uart3 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_UARTCLKCTRL_UART3_EN,
+};
+
+static struct clk clk_uart4 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_UARTCLKCTRL_UART4_EN,
+};
+
+static struct clk clk_uart5 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_UARTCLKCTRL_UART5_EN,
+};
+
+static struct clk clk_uart6 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_UARTCLKCTRL_UART6_EN,
+};
+
+static struct clk clk_i2c0 = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_I2CCLK_I2C1CLK_EN,
+};
+
+static struct clk clk_i2c1 = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_I2CCLK_I2C2CLK_EN,
+};
+
+static struct clk clk_i2c2 = {
+       .owner          = NULL,
+       .parent         = &clk_pclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = USB_OTG_IOBASE + 0xFF4,
+       .enable_mask    = 0x4,
+};
+
+/* The AMBA pl022 driver expects a non-0 clock rate even if the clock is
+ * enabled. The get_rate functions for these clocks will not check the
+ * enable flag and will return the 'expected' frequency even if the clock
+ * is disabled. */
+static struct clk clk_ssp0 = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_byp_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_SSPCTRL_SSPCLK0_EN,
+};
+static struct clk clk_ssp1 = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_byp_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_SSPCTRL_SSPCLK1_EN,
+};
+
+static struct clk clk_kscan = {
+       .owner          = NULL,
+       .parent         = &osc_32KHz,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_KEY_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_KEYCLKCTRL_CLK_EN,
+};
+
+static struct clk clk_nand = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_NANDCLK_SLCCLK_EN,
+};
+
+static struct clk clk_i2s0 = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_I2SCTRL_I2SCLK0_EN,
+};
+static struct clk clk_i2s1 = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_I2SCTRL_I2SCLK1_EN,
+};
+
+static int tsc_onoff_enable(struct clk *clk, int enable)
+{
+       u32 tmp;
+
+       /* Make sure 32KHz clock is the selected clock */
+       tmp = readl(CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
+       tmp &= ~CLKPWR_ADCCTRL1_PCLK_SEL;
+       writel(tmp, CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
+
+       if (enable == 0)
+               writel(0, clk->enable_reg);
+       else
+               writel(clk->enable_mask, clk->enable_reg);
+
+       return 0;
+}
+
+static int tsc_set_rate(struct clk *clk, u32 rate)
+{
+       return tsc_onoff_enable(clk, rate);
+}
+
+static struct clk clk_tsc = {
+       .owner          = NULL,
+       .parent         = &osc_32KHz,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &tsc_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &tsc_onoff_enable,
+       .enable_reg     = CLKPWR_ADC_CLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_ADC32CLKCTRL_CLK_EN,
+};
+
+static int mmc_onoff_enable(struct clk *clk, int enable)
+{
+       u32 tmp;
+
+       tmp = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE)) &
+               ~(CLKPWR_MSCARD_SDCARD_EN|CLKPWR_MSCARD_SDCARD_DIV(15));
+
+       /* If rate is 0, disable clock */
+       if (enable != 0)
+               tmp |= CLKPWR_MSCARD_SDCARD_EN | CLKPWR_MSCARD_SDCARD_DIV(1);
+
+       writel(tmp, CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+
+       return 0;
+}
+
+static u32 mmc_get_rate(struct clk *clk)
+{
+       u32 div, tmp, rate;
+
+       div = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+       tmp = div & CLKPWR_MSCARD_SDCARD_EN;
+
+       if (!tmp)
+               return 0;
+
+       /* Get the parent clock rate */
+       rate = clk->parent->get_rate(clk->parent);
+
+       /* Get the LCD controller clock divider value */
+       div = div & 0xF;
+
+       if (!div)
+               return 0;
+
+       tmp = rate / div;
+
+       return tmp;
+}
+static int mmc_set_rate(struct clk *clk, u32 rate)
+{
+       if (rate == 0)
+               mmc_onoff_enable(clk, 0);
+       else
+               mmc_onoff_enable(clk, 1);
+
+       return 0;
+}
+static struct clk clk_mmc = {
+       .owner          = NULL,
+       .parent         = &clk_armpll,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &mmc_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &mmc_get_rate,
+       .enable         = &mmc_onoff_enable,
+       .enable_reg     = CLKPWR_MS_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_MSCARD_SDCARD_EN,
+};
+
+static struct clk clk_net = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = (CLKPWR_MACCTRL_DMACLK_EN |
+               CLKPWR_MACCTRL_MMIOCLK_EN | CLKPWR_MACCTRL_HRCCLK_EN),
+};
+
+static u32 clcd_get_rate(struct clk *clk)
+{
+       u32 tmp, div, rate;
+
+       tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
+               CLKPWR_LCDCTRL_CLK_EN;
+
+       if (!tmp)
+               return 0;
+
+       rate = clk->parent->get_rate(clk->parent);
+       tmp = readl((io_p2v(LCD_BASE)) + CLCD_TIM2);
+
+       /* Only supports internal clocking */
+       if (tmp & TIM2_BCD)
+               return rate;
+
+       div = (tmp & 0x1F) | ((tmp & 0xF8) >> 22);
+       tmp = rate / (2 + div);
+
+       return tmp;
+}
+
+static int clcd_set_rate(struct clk *clk, u32 rate)
+{
+       u32 tmp, prate, div;
+
+       tmp = readl((io_p2v(LCD_BASE)) + CLCD_TIM2);
+       prate = clk->parent->get_rate(clk->parent);
+
+       if (rate == 0)
+               local_onoff_enable(clk, 0);
+       else if (rate == prate) {
+               tmp |= TIM2_BCD;
+               local_onoff_enable(clk, 1);
+       }
+       else {
+               /* Find closest divider */
+               div = prate / rate;
+               if (div == 1)
+                       div = 0;
+               else
+                       div -= 2;
+
+               tmp &= ~(0xF800001F);
+               tmp &= ~TIM2_BCD;
+               tmp |= (div & 0x1F);
+               tmp |= (((div >> 5) & 0x1F) << 27);
+               writel(tmp, ((io_p2v(LCD_BASE)) + CLCD_TIM2));
+               local_onoff_enable(clk, 1);
+       }
+
+       return 0;
+}
+static struct clk clk_lcd = {
+       .owner          = NULL,
+       .parent         = &clk_hclk,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &clcd_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &clcd_get_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_LCDCTRL_CLK_EN,
+};
+
+static struct clk clk_usbd = {
+       .owner          = NULL,
+       .parent         = &clk_usbpll,
+       .rate           = 0,
+       .flags          = 0,
+       .usecount       = 0,
+       .set_rate       = &local_onoff_set_rate,
+       .set_parent     = NULL,
+       .round_rate     = &local_onoff_round_rate,
+       .get_rate       = &local_get_periph_rate,
+       .enable         = &local_onoff_enable,
+       .enable_reg     = CLKPWR_USB_CTRL(CLKPWR_IOBASE),
+       .enable_mask    = CLKPWR_USBCTRL_HCLK_EN,
+};
+
+static inline void clk_lock(void)
+{
+       local_irq_disable();
+}
+
+static inline void clk_unlock(void)
+{
+       local_irq_enable();
+}
+
+static int local_clk_enable(struct clk *clk)
+{
+       int ret = 0;
+
+       if (clk->parent != NULL)
+               ret = local_clk_enable(clk->parent);
+
+       if (clk->usecount == 0)
+               clk->enable(clk, 1);
+
+       clk->usecount++;
+
+       return ret;
+}
+
+static int local_clk_disable(struct clk *clk)
+{
+       int ret = 0;
+
+       clk->usecount--;
+
+       if (clk->usecount == 0)
+               clk->enable(clk, 0);
+
+       if ((clk->parent != NULL) && (ret == 0))
+               ret = local_clk_disable(clk->parent);
+
+       return ret;
+}
+
+static unsigned long local_clk_get_rate(struct clk *clk)
+{
+       if (clk->rate != 0)
+               return clk->rate;
+
+       if (clk->get_rate != NULL)
+               return (clk->get_rate)(clk);
+
+       if (clk->parent != NULL)
+               return local_clk_get_rate(clk->parent);
+
+       return 0;
+}
+
+/*
+ * clk_enable - inform the system when the clock source should be running.
+ */
+int clk_enable(struct clk *clk)
+{
+       int ret;
+
+       if ((IS_ERR(clk)) || (clk == NULL))
+               return -ENODEV;
+
+       clk_lock();
+       ret = local_clk_enable(clk);
+       clk_unlock();
+
+       return ret;
+}
+
+/*
+ * clk_disable - inform the system when the clock source is no longer required
+ */
+void clk_disable(struct clk *clk)
+{
+       if ((IS_ERR(clk)) || (clk == NULL))
+               return;
+
+       clk_lock();
+       local_clk_disable(clk);
+       clk_unlock();
+}
+
+/*
+ * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
+ *               This is only valid once the clock source has been enabled
+ */
+unsigned long clk_get_rate(struct clk *clk)
+{
+       unsigned long rate = 0;
+
+       if (!IS_ERR(clk))
+               rate = local_clk_get_rate(clk);
+
+       return rate;
+}
+
+/*
+ * clk_round_rate - adjust a rate to the exact rate a clock can provide
+ */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+       if (!IS_ERR(clk)) {
+               clk_lock();
+               rate = clk->round_rate(clk, rate);
+               clk_unlock();
+       }
+       else
+               rate = 0;
+
+       return rate;
+}
+
+/*
+ * clk_set_rate - set the clock rate for a clock source
+ */
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+       int ret = -ENODEV;
+
+       if (!IS_ERR(clk)) {
+               clk_lock();
+               ret = (clk->set_rate)(clk, rate);
+               clk_unlock();
+       }
+
+       return ret;
+}
+
+/*
+ * clk_set_parent - set the parent clock source for this clock
+ */
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+       int ret = -ENODEV;
+
+       if (!IS_ERR(clk)) {
+               if (!clk->set_parent) {
+                       clk_lock();
+                       ret = clk->set_parent(clk, parent);
+                       clk_unlock();
+               }
+       }
+
+       return ret;
+}
+
+/*
+ * clk_get_parent - get the parent clock source for this clock
+ */
+struct clk *clk_get_parent(struct clk *clk)
+{
+       return clk->parent;
+}
+
+EXPORT_SYMBOL(clk_disable);
+EXPORT_SYMBOL(clk_enable);
+EXPORT_SYMBOL(clk_get_rate);
+EXPORT_SYMBOL(clk_round_rate);
+EXPORT_SYMBOL(clk_set_rate);
+EXPORT_SYMBOL(clk_set_parent);
+EXPORT_SYMBOL(clk_get_parent);
+
+static void clk_inc_counts(struct clk *clk)
+{
+       clk->usecount++;
+
+       if (clk->parent != NULL)
+               clk_inc_counts(clk->parent);
+}
+
+int clk_is_sysclk_mainosc(void)
+{
+       u32 reg;
+
+       /* Update PLL397 or main osc use count and parent based on
+          current SYSCLK selection */
+       reg = readl(CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE));
+       if ((reg & CLKPWR_SYSCTRL_SYSCLKMUX) == 0)
+               return 1;
+
+       return 0;
+}
+
+#define _REGISTER_CLOCK(d, n, c) \
+       { \
+               .dev_id = d, \
+               .con_id = n, \
+               .clk = &c, \
+       },
+static struct clk_lookup lookups[] __initdata = {
+       _REGISTER_CLOCK(NULL, "osc_32KHz", osc_32KHz)
+       _REGISTER_CLOCK(NULL, "osc_pll397", osc_pll397)
+       _REGISTER_CLOCK(NULL, "osc_main", osc_main)
+       _REGISTER_CLOCK(NULL, "sys_ck", clk_sys)
+       _REGISTER_CLOCK(NULL, "arm_pll_ck", clk_armpll)
+       _REGISTER_CLOCK(NULL, "ck_pll5", clk_usbpll)
+       _REGISTER_CLOCK(NULL, "hclk_ck", clk_hclk)
+       _REGISTER_CLOCK(NULL, "pclk_ck", clk_pclk)
+       _REGISTER_CLOCK(NULL, "timer0_ck", clk_timer0)
+       _REGISTER_CLOCK(NULL, "timer1_ck", clk_timer1)
+       _REGISTER_CLOCK(NULL, "timer2_ck", clk_timer2)
+       _REGISTER_CLOCK(NULL, "timer3_ck", clk_timer3)
+       _REGISTER_CLOCK(NULL, "vfp9_ck", clk_vfp9)
+       _REGISTER_CLOCK(NULL, "clk_dmac", clk_dma)
+       _REGISTER_CLOCK("watchdog", NULL, clk_wdt)
+       _REGISTER_CLOCK(NULL, "uart3_ck", clk_uart3)
+       _REGISTER_CLOCK(NULL, "uart4_ck", clk_uart4)
+       _REGISTER_CLOCK(NULL, "uart5_ck", clk_uart5)
+       _REGISTER_CLOCK(NULL, "uart6_ck", clk_uart6)
+       _REGISTER_CLOCK("pnx-i2c.0", NULL, clk_i2c0)
+       _REGISTER_CLOCK("pnx-i2c.1", NULL, clk_i2c1)
+       _REGISTER_CLOCK("pnx-i2c.2", NULL, clk_i2c2)
+       _REGISTER_CLOCK("dev:ssp0", NULL, clk_ssp0)
+       _REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
+       _REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
+       _REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
+       _REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
+       _REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
+       _REGISTER_CLOCK("lpc32xx-ts", NULL, clk_tsc)
+       _REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
+       _REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
+       _REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
+       _REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
+};
+
+int __init clk_init(void)
+{
+       u32 reg;
+       int i;
+
+       /* Set initial rates for PLL397 and main oscillator */
+       reg = readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+       if ((reg & CLKPWR_SYSCTRL_PLL397_DIS) != 0)
+               osc_pll397.rate = 0;
+       else {
+               osc_pll397.rate = 397 * osc_32KHz.rate;
+               clk_inc_counts(&osc_32KHz);
+       }
+       reg = readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+       if ((reg & CLKPWR_MOSC_DISABLE) != 0)
+               osc_main.rate = 0;
+       else
+               osc_main.rate = MAIN_OSC_FREQ;
+
+       /* Update PLL397 or main osc use count and parent based on
+          current SYSCLK selection */
+       if (clk_is_sysclk_mainosc() != 0)
+               clk_sys.parent = &osc_main;
+       else
+               clk_sys.parent = &osc_pll397;
+       clk_sys.rate = clk_sys.parent->rate;
+
+       /* Compute the ARM PLL and USB PLL frequencies */
+       local_update_armpll_rate();
+       local_update_usbpll_rate();
+       if (clk_usbpll.rate != 0)
+               clk_inc_counts(&osc_main);
+
+       /* HCLK and PCLKs are always on and use the ARM PLL clock*/
+       clk_inc_counts(clk_hclk.parent);
+       clk_inc_counts(clk_pclk.parent);
+
+       /* Timer 0 is used for the system clock tick. It was pre-initialized
+          prior to this elsewhere */
+       clk_inc_counts(clk_timer0.parent);
+
+       /* Register all clocks */
+       for (i = 0; i < ARRAY_SIZE(lookups); i++)
+               clkdev_add(&lookups[i]);
+
+       return 0;
+}
--
1.6.0.6
