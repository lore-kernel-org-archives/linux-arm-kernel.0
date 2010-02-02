From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:16 -0800
Subject: [PATCH 04/16] ARM: LPC32XX: Added LXP32XX identified to CLKPWR
	register field macros
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-5-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The CLKPWR macros and associated code have been updated with the
LPC32XX identifier.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/clock.c                 |  222 +++++-----
 arch/arm/mach-lpc32xx/common.c                |   18 +-
 arch/arm/mach-lpc32xx/include/mach/platform.h |  612 ++++++++++++------------
 arch/arm/mach-lpc32xx/phy3250.c               |   51 ++-
 arch/arm/mach-lpc32xx/pm_events.c             |  340 +++++++-------
 arch/arm/mach-lpc32xx/serial.c                |   10 +-
 arch/arm/mach-lpc32xx/suspend.S               |   56 ++-
 arch/arm/mach-lpc32xx/timer.c                 |    8 +-
 8 files changed, 668 insertions(+), 649 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index eb522a5..befe6fa 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -122,26 +122,26 @@ static int local_pll397_enable(struct clk *clk, int enable)
 	u32 reg;
 	unsigned long timeout = 1 + msecs_to_jiffies(10);
 
-	reg = readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+	reg = readl(LPC32XX_CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
 
 	if (enable == 0) 	{
-		reg |= CLKPWR_SYSCTRL_PLL397_DIS;
-		writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+		reg |= LPC32XX_CLKPWR_SYSCTRL_PLL397_DIS;
+		writel(reg, LPC32XX_CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
 		clk->rate = 0;
 	} else {
 		/* Enable PLL397 */
-		reg &= ~CLKPWR_SYSCTRL_PLL397_DIS;
-		writel(reg, CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
+		reg &= ~LPC32XX_CLKPWR_SYSCTRL_PLL397_DIS;
+		writel(reg, LPC32XX_CLKPWR_PLL397_CTRL(CLKPWR_IOBASE));
 		clk->rate = LPC32XX_CLOCK_OSC_FREQ * 397;
 
 		/* Wait for PLL397 lock */
-		while (((readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
-			CLKPWR_SYSCTRL_PLL397_STS) == 0) &&
+		while (((readl(LPC32XX_CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
+			LPC32XX_CLKPWR_SYSCTRL_PLL397_STS) == 0) &&
 			(timeout > jiffies))
 			cpu_relax();
 
-		if ((readl(CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
-			CLKPWR_SYSCTRL_PLL397_STS) == 0)
+		if ((readl(LPC32XX_CLKPWR_PLL397_CTRL(CLKPWR_IOBASE)) &
+			LPC32XX_CLKPWR_SYSCTRL_PLL397_STS) == 0)
 			return -ENODEV;
 	}
 
@@ -153,26 +153,26 @@ static int local_oscmain_enable(struct clk *clk, int enable)
 	u32 reg;
 	unsigned long timeout = 1 + msecs_to_jiffies(10);
 
-	reg = readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+	reg = readl(LPC32XX_CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
 
 	if (enable == 0) {
-		reg |= CLKPWR_MOSC_DISABLE;
-		writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+		reg |= LPC32XX_CLKPWR_MOSC_DISABLE;
+		writel(reg, LPC32XX_CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
 		clk->rate = 0;
 	} else {
 		/* Enable main oscillator */
-		reg &= ~CLKPWR_MOSC_DISABLE;
-		writel(reg, CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
+		reg &= ~LPC32XX_CLKPWR_MOSC_DISABLE;
+		writel(reg, LPC32XX_CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE));
 		clk->rate = LPC32XX_MAIN_OSC_FREQ;
 
 		/* Wait for main oscillator to start */
-		while (((readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
-			CLKPWR_MOSC_DISABLE) != 0) &&
+		while (((readl(LPC32XX_CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
+			LPC32XX_CLKPWR_MOSC_DISABLE) != 0) &&
 			(timeout > jiffies))
 			cpu_relax();
 
-		if ((readl(CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
-			CLKPWR_MOSC_DISABLE) != 0)
+		if ((readl(LPC32XX_CLKPWR_MAIN_OSC_CTRL(CLKPWR_IOBASE)) &
+			LPC32XX_CLKPWR_MOSC_DISABLE) != 0)
 			return -ENODEV;
 	}
 
@@ -200,13 +200,13 @@ static u32 local_clk_pll_setup(struct clk_pll_setup *PllSetup)
 	u32 tv, tmp = 0;
 
 	if (PllSetup->analog_on != 0)
-		tmp |= CLKPWR_HCLKPLL_POWER_UP;
+		tmp |= LPC32XX_CLKPWR_HCLKPLL_POWER_UP;
 	if (PllSetup->cco_bypass_b15 != 0)
-		tmp |= CLKPWR_HCLKPLL_CCO_BYPASS;
+		tmp |= LPC32XX_CLKPWR_HCLKPLL_CCO_BYPASS;
 	if (PllSetup->direct_output_b14 != 0)
-		tmp |= CLKPWR_HCLKPLL_POSTDIV_BYPASS;
+		tmp |= LPC32XX_CLKPWR_HCLKPLL_POSTDIV_BYPASS;
 	if (PllSetup->fdbk_div_ctrl_b13 != 0)
-		tmp |= CLKPWR_HCLKPLL_FDBK_SEL_FCLK;
+		tmp |= LPC32XX_CLKPWR_HCLKPLL_FDBK_SEL_FCLK;
 
 	switch (PllSetup->pll_p) {
 	case 1:
@@ -229,9 +229,9 @@ static u32 local_clk_pll_setup(struct clk_pll_setup *PllSetup)
 		return 0;
 	}
 
-	tmp |= CLKPWR_HCLKPLL_POSTDIV_2POW(tv);
-	tmp |= CLKPWR_HCLKPLL_PREDIV_PLUS1(PllSetup->pll_n - 1);
-	tmp |= CLKPWR_HCLKPLL_PLLM(PllSetup->pll_m - 1);
+	tmp |= LPC32XX_CLKPWR_HCLKPLL_POSTDIV_2POW(tv);
+	tmp |= LPC32XX_CLKPWR_HCLKPLL_PREDIV_PLUS1(PllSetup->pll_n - 1);
+	tmp |= LPC32XX_CLKPWR_HCLKPLL_PLLM(PllSetup->pll_m - 1);
 
 	return tmp;
 }
@@ -244,7 +244,7 @@ static void local_update_armpll_rate(void)
 	u32 clkin, pllreg;
 
 	clkin = clk_armpll.parent->rate;
-	pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+	pllreg = readl(LPC32XX_CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
 
 	clk_armpll.rate = clk_get_pllrate_from_reg(clkin, pllreg);
 }
@@ -381,9 +381,9 @@ static void local_update_usbpll_rate(void)
 	u32 clkin, pllreg;
 
 	clkin = (u32) clk_get_rate(&clk_usbpll);
-	pllreg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+	pllreg = readl(LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
 
-	if ((pllreg & CLKPWR_USBCTRL_PLL_PWRUP) == 0)
+	if ((pllreg & LPC32XX_CLKPWR_USBCTRL_PLL_PWRUP) == 0)
 		clk_usbpll.rate = 0;
 	else
 		clk_usbpll.rate = clk_get_pllrate_from_reg(clkin,
@@ -397,9 +397,9 @@ static u32 local_clk_usbpll_setup(struct clk_pll_setup *pHCLKPllSetup)
 {
 	u32 reg, tmp = local_clk_pll_setup(pHCLKPllSetup);
 
-	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & ~0x1FFFF;
+	reg = readl(LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE)) & ~0x1FFFF;
 	reg |= tmp;
-	writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	writel(reg, LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
 
 	return clk_check_pll_setup(clk_usbpll.parent->rate,
 		pHCLKPllSetup);
@@ -410,25 +410,26 @@ static int local_usbpll_enable(struct clk *clk, int enable)
 	u32 reg;
 	int ret = -ENODEV, qj = (jiffies / 4);
 
-	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg = readl(LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
 
 	if (enable == 0) {
-		reg &= ~(CLKPWR_USBCTRL_CLK_EN1 | CLKPWR_USBCTRL_CLK_EN2);
-		writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
-	} else if (reg & CLKPWR_USBCTRL_PLL_PWRUP) {
-		reg |= CLKPWR_USBCTRL_CLK_EN1;
-		writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+		reg &= ~(LPC32XX_CLKPWR_USBCTRL_CLK_EN1 |
+			LPC32XX_CLKPWR_USBCTRL_CLK_EN2);
+		writel(reg, LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	} else if (reg & LPC32XX_CLKPWR_USBCTRL_PLL_PWRUP) {
+		reg |= LPC32XX_CLKPWR_USBCTRL_CLK_EN1;
+		writel(reg, LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
 
 		/* Wait for PLL lock */
 		while (qj < jiffies) {
-			reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
-			if (reg & CLKPWR_USBCTRL_PLL_STS)
+			reg = readl(LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+			if (reg & LPC32XX_CLKPWR_USBCTRL_PLL_STS)
 				ret = 0;
 		}
 
 		if (ret == 0) {
-			reg |= CLKPWR_USBCTRL_CLK_EN2;
-			writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+			reg |= LPC32XX_CLKPWR_USBCTRL_CLK_EN2;
+			writel(reg, LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
 		}
 	}
 
@@ -450,25 +451,25 @@ static int local_usbpll_set_rate(struct clk *clk, u32 rate)
 		return 0;
 
 	clkin = clk->parent->rate;
-	usbdiv = readl(CLKPWR_USBCLK_PDIV(CLKPWR_IOBASE)) + 1;
+	usbdiv = readl(LPC32XX_CLKPWR_USBCLK_PDIV(CLKPWR_IOBASE)) + 1;
 	clkin = clkin / usbdiv;
 
 	/* Try to find a good rate setup */
 	if (local_clk_find_pll_cfg(clkin, rate, &pllsetup) == 0)
 		return -EINVAL;
 
-	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
-	reg |= CLKPWR_USBCTRL_CLK_EN1;
-	writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg = readl(LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg |= LPC32XX_CLKPWR_USBCTRL_CLK_EN1;
+	writel(reg, LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
 
 	pllsetup.analog_on = 1;
 	local_clk_usbpll_setup(&pllsetup);
 
 	clk->rate = clk_check_pll_setup(clkin, &pllsetup);
 
-	reg = readl(CLKPWR_USB_CTRL(CLKPWR_IOBASE));
-	reg |= CLKPWR_USBCTRL_CLK_EN2;
-	writel(reg, CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg = readl(LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
+	reg |= LPC32XX_CLKPWR_USBCTRL_CLK_EN2;
+	writel(reg, LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE));
 
 	return 0;
 }
@@ -482,8 +483,8 @@ static struct clk clk_usbpll = {
 static u32 clk_get_hclk_div(void)
 {
 	static const u32 hclkdivs[4] = {1, 2, 4, 4};
-	return hclkdivs[CLKPWR_HCLKDIV_DIV_2POW(
-		readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE)))];
+	return hclkdivs[LPC32XX_CLKPWR_HCLKDIV_DIV_2POW(
+		readl(LPC32XX_CLKPWR_HCLK_DIV(CLKPWR_IOBASE)))];
 }
 
 static struct clk clk_hclk = {
@@ -514,86 +515,86 @@ static int local_onoff_enable(struct clk *clk, int enable)
 static struct clk clk_timer0 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER0_EN,
+	.enable_reg	= LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_TMRPWMCLK_TIMER0_EN,
 };
 static struct clk clk_timer1 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER1_EN,
+	.enable_reg	= LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_TMRPWMCLK_TIMER1_EN,
 };
 static struct clk clk_timer2 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER2_EN,
+	.enable_reg	= LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_TMRPWMCLK_TIMER2_EN,
 };
 static struct clk clk_timer3 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_TMRPWMCLK_TIMER3_EN,
+	.enable_reg	= LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_TMRPWMCLK_TIMER3_EN,
 };
 static struct clk clk_wdt = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_PWMCLK_WDOG_EN,
+	.enable_reg	= LPC32XX_CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
 };
 static struct clk clk_vfp9 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_DEBUG_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_VFP_CLOCK_ENABLE_BIT,
+	.enable_reg	= LPC32XX_CLKPWR_DEBUG_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_VFP_CLOCK_ENABLE_BIT,
 };
 static struct clk clk_dma = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_DMA_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_DMACLKCTRL_CLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_DMA_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_DMACLKCTRL_CLK_EN,
 };
 
 static struct clk clk_uart3 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_UARTCLKCTRL_UART3_EN,
+	.enable_reg	= LPC32XX_CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_UARTCLKCTRL_UART3_EN,
 };
 
 static struct clk clk_uart4 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_UARTCLKCTRL_UART4_EN,
+	.enable_reg	= LPC32XX_CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_UARTCLKCTRL_UART4_EN,
 };
 
 static struct clk clk_uart5 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_UARTCLKCTRL_UART5_EN,
+	.enable_reg	= LPC32XX_CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_UARTCLKCTRL_UART5_EN,
 };
 
 static struct clk clk_uart6 = {
 	.parent		= &clk_pclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_UARTCLKCTRL_UART6_EN,
+	.enable_reg	= LPC32XX_CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_UARTCLKCTRL_UART6_EN,
 };
 
 static struct clk clk_i2c0 = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_I2CCLK_I2C1CLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_I2CCLK_I2C1CLK_EN,
 };
 
 static struct clk clk_i2c1 = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_I2CCLK_I2C2CLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_I2CCLK_I2C2CLK_EN,
 };
 
 static struct clk clk_i2c2 = {
@@ -606,49 +607,50 @@ static struct clk clk_i2c2 = {
 static struct clk clk_ssp0 = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_SSPCTRL_SSPCLK0_EN,
+	.enable_reg	= LPC32XX_CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN,
 };
 static struct clk clk_ssp1 = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_SSPCTRL_SSPCLK1_EN,
+	.enable_reg	= LPC32XX_CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_SSPCTRL_SSPCLK1_EN,
 };
 
 static struct clk clk_kscan = {
 	.parent		= &osc_32KHz,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_KEY_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_KEYCLKCTRL_CLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_KEY_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_KEYCLKCTRL_CLK_EN,
 };
 
 static struct clk clk_nand = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_NANDCLK_SLCCLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_NANDCLK_SLCCLK_EN,
 };
 
 static struct clk clk_i2s0 = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_I2SCTRL_I2SCLK0_EN,
+	.enable_reg	= LPC32XX_CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_I2SCTRL_I2SCLK0_EN,
 };
 static struct clk clk_i2s1 = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_I2SCTRL_I2SCLK1_EN,
+	.enable_reg	= LPC32XX_CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_I2SCTRL_I2SCLK1_EN,
 };
 
 static struct clk clk_net = {
 	.parent		= &clk_hclk,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= (CLKPWR_MACCTRL_DMACLK_EN |
-		CLKPWR_MACCTRL_MMIOCLK_EN | CLKPWR_MACCTRL_HRCCLK_EN),
+	.enable_reg	= LPC32XX_CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= (LPC32XX_CLKPWR_MACCTRL_DMACLK_EN |
+		LPC32XX_CLKPWR_MACCTRL_MMIOCLK_EN |
+		LPC32XX_CLKPWR_MACCTRL_HRCCLK_EN),
 };
 
 static struct clk clk_rtc = {
@@ -659,8 +661,8 @@ static struct clk clk_rtc = {
 static struct clk clk_usbd = {
 	.parent		= &clk_usbpll,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_USB_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_USBCTRL_HCLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_USB_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_USBCTRL_HCLK_EN,
 };
 
 static int tsc_onoff_enable(struct clk *clk, int enable)
@@ -668,9 +670,9 @@ static int tsc_onoff_enable(struct clk *clk, int enable)
 	u32 tmp;
 
 	/* Make sure 32KHz clock is the selected clock */
-	tmp = readl(CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
-	tmp &= ~CLKPWR_ADCCTRL1_PCLK_SEL;
-	writel(tmp, CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
+	tmp &= ~LPC32XX_CLKPWR_ADCCTRL1_PCLK_SEL;
+	writel(tmp, LPC32XX_CLKPWR_ADC_CLK_CTRL_1(CLKPWR_IOBASE));
 
 	if (enable == 0)
 		writel(0, clk->enable_reg);
@@ -683,22 +685,24 @@ static int tsc_onoff_enable(struct clk *clk, int enable)
 static struct clk clk_tsc = {
 	.parent		= &osc_32KHz,
 	.enable		= &tsc_onoff_enable,
-	.enable_reg	= CLKPWR_ADC_CLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_ADC32CLKCTRL_CLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_ADC_CLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_ADC32CLKCTRL_CLK_EN,
 };
 
 static int mmc_onoff_enable(struct clk *clk, int enable)
 {
 	u32 tmp;
 
-	tmp = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE)) &
-		~(CLKPWR_MSCARD_SDCARD_EN|CLKPWR_MSCARD_SDCARD_DIV(15));
+	tmp = readl(LPC32XX_CLKPWR_MS_CTRL(CLKPWR_IOBASE)) &
+		~(LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
+		LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(15));
 
 	/* If rate is 0, disable clock */
 	if (enable != 0)
-		tmp |= CLKPWR_MSCARD_SDCARD_EN | CLKPWR_MSCARD_SDCARD_DIV(1);
+		tmp |= LPC32XX_CLKPWR_MSCARD_SDCARD_EN |
+			LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(1);
 
-	writel(tmp, CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+	writel(tmp, LPC32XX_CLKPWR_MS_CTRL(CLKPWR_IOBASE));
 
 	return 0;
 }
@@ -707,8 +711,8 @@ static u32 mmc_get_rate(struct clk *clk)
 {
 	u32 div, tmp, rate;
 
-	div = readl(CLKPWR_MS_CTRL(CLKPWR_IOBASE));
-	tmp = div & CLKPWR_MSCARD_SDCARD_EN;
+	div = readl(LPC32XX_CLKPWR_MS_CTRL(CLKPWR_IOBASE));
+	tmp = div & LPC32XX_CLKPWR_MSCARD_SDCARD_EN;
 
 	if (!tmp)
 		return 0;
@@ -742,16 +746,16 @@ static struct clk clk_mmc = {
 	.set_rate	= &mmc_set_rate,
 	.get_rate	= &mmc_get_rate,
 	.enable		= &mmc_onoff_enable,
-	.enable_reg	= CLKPWR_MS_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_MSCARD_SDCARD_EN,
+	.enable_reg	= LPC32XX_CLKPWR_MS_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_MSCARD_SDCARD_EN,
 };
 
 static u32 clcd_get_rate(struct clk *clk)
 {
 	u32 tmp, div, rate;
 
-	tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
-		CLKPWR_LCDCTRL_CLK_EN;
+	tmp = readl(LPC32XX_CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
+		LPC32XX_CLKPWR_LCDCTRL_CLK_EN;
 
 	if (!tmp)
 		return 0;
@@ -802,8 +806,8 @@ static struct clk clk_lcd = {
 	.set_rate	= &clcd_set_rate,
 	.get_rate	= &clcd_get_rate,
 	.enable		= &local_onoff_enable,
-	.enable_reg	= CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE),
-	.enable_mask	= CLKPWR_LCDCTRL_CLK_EN,
+	.enable_reg	= LPC32XX_CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE),
+	.enable_mask	= LPC32XX_CLKPWR_LCDCTRL_CLK_EN,
 };
 
 static inline void clk_lock(void)
diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index f4e2113..2a97ce0 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -109,7 +109,7 @@ void lpc32xx_get_uid(u32 devid[4])
 	int i;
 
 	for (i = 0; i < 4; i++)
-		devid[i] = readl(CLKPWR_DEVID(CLKPWR_IOBASE, i << 2));
+		devid[i] = readl(LPC32XX_CLKPWR_DEVID(CLKPWR_IOBASE, i << 2));
 }
 
 /*
@@ -118,8 +118,8 @@ void lpc32xx_get_uid(u32 devid[4])
  */
 int clk_is_sysclk_mainosc(void)
 {
-	if ((readl(CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE)) &
-		CLKPWR_SYSCTRL_SYSCLKMUX) == 0)
+	if ((readl(LPC32XX_CLKPWR_SYSCLK_CTRL(CLKPWR_IOBASE)) &
+		LPC32XX_CLKPWR_SYSCTRL_SYSCLKMUX) == 0)
 		return 1;
 
 	return 0;
@@ -131,8 +131,8 @@ int clk_is_sysclk_mainosc(void)
 void lpc32xx_watchdog_reset(void)
 {
 	/* Make sure WDT clocks are enabled */
-	writel(CLKPWR_PWMCLK_WDOG_EN,
-		CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE));
+	writel(LPC32XX_CLKPWR_PWMCLK_WDOG_EN,
+		LPC32XX_CLKPWR_TIMER_CLK_CTRL(CLKPWR_IOBASE));
 
 	/* Instand assert of RESETOUT_N with pulse length 1mS */
 	writel(13000, WDT_IOBASE + 0x18);
@@ -217,11 +217,11 @@ u32 clk_get_pllrate_from_reg(u32 inputclk, u32 regval)
 	pllcfg.cco_bypass_b15 = 0;
 	pllcfg.direct_output_b14 = 0;
 	pllcfg.fdbk_div_ctrl_b13 = 0;
-	if ((regval & CLKPWR_HCLKPLL_CCO_BYPASS) != 0)
+	if ((regval & LPC32XX_CLKPWR_HCLKPLL_CCO_BYPASS) != 0)
 		pllcfg.cco_bypass_b15 = 1;
-	if ((regval & CLKPWR_HCLKPLL_POSTDIV_BYPASS) != 0)
+	if ((regval & LPC32XX_CLKPWR_HCLKPLL_POSTDIV_BYPASS) != 0)
 		pllcfg.direct_output_b14 = 1;
-	if ((regval & CLKPWR_HCLKPLL_FDBK_SEL_FCLK) != 0)
+	if ((regval & LPC32XX_CLKPWR_HCLKPLL_FDBK_SEL_FCLK) != 0)
 		pllcfg.fdbk_div_ctrl_b13 = 1;
 	pllcfg.pll_m = 1 + ((regval >> 1) & 0xFF);
 	pllcfg.pll_n = 1 + ((regval >> 9) & 0x3);
@@ -232,7 +232,7 @@ u32 clk_get_pllrate_from_reg(u32 inputclk, u32 regval)
 
 u32 clk_get_pclk_div(void)
 {
-	return 1 + ((readl(CLKPWR_HCLK_DIV(CLKPWR_IOBASE)) >> 2) &
+	return 1 + ((readl(LPC32XX_CLKPWR_HCLK_DIV(CLKPWR_IOBASE)) >> 2) &
 		0x1F);
 }
 
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 42fe08d..7e9ade1 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -135,455 +135,455 @@
 /*
  * Clock and Power control register offsets
  */
-#define CLKPWR_DEBUG_CTRL(x)		((x) + 0x000)
-#define CLKPWR_BOOTMAP(x)		((x) + 0x014)
-#define CLKPWR_P01_ER(x)		((x) + 0x018)
-#define CLKPWR_USBCLK_PDIV(x)		((x) + 0x01C)
-#define CLKPWR_INT_ER(x)		((x) + 0x020)
-#define CLKPWR_INT_RS(x)		((x) + 0x024)
-#define CLKPWR_INT_SR(x)		((x) + 0x028)
-#define CLKPWR_INT_AP(x)		((x) + 0x02C)
-#define CLKPWR_PIN_ER(x)		((x) + 0x030)
-#define CLKPWR_PIN_RS(x)		((x) + 0x034)
-#define CLKPWR_PIN_SR(x)		((x) + 0x038)
-#define CLKPWR_PIN_AP(x)		((x) + 0x03C)
-#define CLKPWR_HCLK_DIV(x)		((x) + 0x040)
-#define CLKPWR_PWR_CTRL(x)		((x) + 0x044)
-#define CLKPWR_PLL397_CTRL(x)		((x) + 0x048)
-#define CLKPWR_MAIN_OSC_CTRL(x)		((x) + 0x04C)
-#define CLKPWR_SYSCLK_CTRL(x)		((x) + 0x050)
-#define CLKPWR_LCDCLK_CTRL(x)		((x) + 0x054)
-#define CLKPWR_HCLKPLL_CTRL(x)		((x) + 0x058)
-#define CLKPWR_ADC_CLK_CTRL_1(x)	((x) + 0x060)
-#define CLKPWR_USB_CTRL(x)		((x) + 0x064)
-#define CLKPWR_SDRAMCLK_CTRL(x)		((x) + 0x068)
-#define CLKPWR_DDR_LAP_NOM(x)		((x) + 0x06C)
-#define CLKPWR_DDR_LAP_COUNT(x)		((x) + 0x070)
-#define CLKPWR_DDR_LAP_DELAY(x)		((x) + 0x074)
-#define CLKPWR_SSP_CLK_CTRL(x)		((x) + 0x078)
-#define CLKPWR_I2S_CLK_CTRL(x)		((x) + 0x07C)
-#define CLKPWR_MS_CTRL(x)		((x) + 0x080)
-#define CLKPWR_MACCLK_CTRL(x)		((x) + 0x090)
-#define CLKPWR_TEST_CLK_SEL(x)		((x) + 0x0A4)
-#define CLKPWR_SFW_INT(x)		((x) + 0x0A8)
-#define CLKPWR_I2C_CLK_CTRL(x)		((x) + 0x0AC)
-#define CLKPWR_KEY_CLK_CTRL(x)		((x) + 0x0B0)
-#define CLKPWR_ADC_CLK_CTRL(x)		((x) + 0x0B4)
-#define CLKPWR_PWM_CLK_CTRL(x)		((x) + 0x0B8)
-#define CLKPWR_TIMER_CLK_CTRL(x)	((x) + 0x0BC)
-#define CLKPWR_TIMERS_PWMS_CLK_CTRL_1(x) ((x) + 0x0C0)
-#define CLKPWR_SPI_CLK_CTRL(x)		((x) + 0x0C4)
-#define CLKPWR_NAND_CLK_CTRL(x)		((x) + 0x0C8)
-#define CLKPWR_UART3_CLK_CTRL(x)	((x) + 0x0D0)
-#define CLKPWR_UART4_CLK_CTRL(x)	((x) + 0x0D4)
-#define CLKPWR_UART5_CLK_CTRL(x)	((x) + 0x0D8)
-#define CLKPWR_UART6_CLK_CTRL(x)	((x) + 0x0DC)
-#define CLKPWR_IRDA_CLK_CTRL(x)		((x) + 0x0E0)
-#define CLKPWR_UART_CLK_CTRL(x)		((x) + 0x0E4)
-#define CLKPWR_DMA_CLK_CTRL(x)		((x) + 0x0E8)
-#define CLKPWR_AUTOCLOCK(x)		((x) + 0x0EC)
-#define CLKPWR_DEVID(x, y)		((x) + 0x130 + (y))
+#define LPC32XX_CLKPWR_DEBUG_CTRL(x)		((x) + 0x000)
+#define LPC32XX_CLKPWR_BOOTMAP(x)		((x) + 0x014)
+#define LPC32XX_CLKPWR_P01_ER(x)		((x) + 0x018)
+#define LPC32XX_CLKPWR_USBCLK_PDIV(x)		((x) + 0x01C)
+#define LPC32XX_CLKPWR_INT_ER(x)		((x) + 0x020)
+#define LPC32XX_CLKPWR_INT_RS(x)		((x) + 0x024)
+#define LPC32XX_CLKPWR_INT_SR(x)		((x) + 0x028)
+#define LPC32XX_CLKPWR_INT_AP(x)		((x) + 0x02C)
+#define LPC32XX_CLKPWR_PIN_ER(x)		((x) + 0x030)
+#define LPC32XX_CLKPWR_PIN_RS(x)		((x) + 0x034)
+#define LPC32XX_CLKPWR_PIN_SR(x)		((x) + 0x038)
+#define LPC32XX_CLKPWR_PIN_AP(x)		((x) + 0x03C)
+#define LPC32XX_CLKPWR_HCLK_DIV(x)		((x) + 0x040)
+#define LPC32XX_CLKPWR_PWR_CTRL(x)		((x) + 0x044)
+#define LPC32XX_CLKPWR_PLL397_CTRL(x)		((x) + 0x048)
+#define LPC32XX_CLKPWR_MAIN_OSC_CTRL(x)		((x) + 0x04C)
+#define LPC32XX_CLKPWR_SYSCLK_CTRL(x)		((x) + 0x050)
+#define LPC32XX_CLKPWR_LCDCLK_CTRL(x)		((x) + 0x054)
+#define LPC32XX_CLKPWR_HCLKPLL_CTRL(x)		((x) + 0x058)
+#define LPC32XX_CLKPWR_ADC_CLK_CTRL_1(x)	((x) + 0x060)
+#define LPC32XX_CLKPWR_USB_CTRL(x)		((x) + 0x064)
+#define LPC32XX_CLKPWR_SDRAMCLK_CTRL(x)		((x) + 0x068)
+#define LPC32XX_CLKPWR_DDR_LAP_NOM(x)		((x) + 0x06C)
+#define LPC32XX_CLKPWR_DDR_LAP_COUNT(x)		((x) + 0x070)
+#define LPC32XX_CLKPWR_DDR_LAP_DELAY(x)		((x) + 0x074)
+#define LPC32XX_CLKPWR_SSP_CLK_CTRL(x)		((x) + 0x078)
+#define LPC32XX_CLKPWR_I2S_CLK_CTRL(x)		((x) + 0x07C)
+#define LPC32XX_CLKPWR_MS_CTRL(x)		((x) + 0x080)
+#define LPC32XX_CLKPWR_MACCLK_CTRL(x)		((x) + 0x090)
+#define LPC32XX_CLKPWR_TEST_CLK_SEL(x)		((x) + 0x0A4)
+#define LPC32XX_CLKPWR_SFW_INT(x)		((x) + 0x0A8)
+#define LPC32XX_CLKPWR_I2C_CLK_CTRL(x)		((x) + 0x0AC)
+#define LPC32XX_CLKPWR_KEY_CLK_CTRL(x)		((x) + 0x0B0)
+#define LPC32XX_CLKPWR_ADC_CLK_CTRL(x)		((x) + 0x0B4)
+#define LPC32XX_CLKPWR_PWM_CLK_CTRL(x)		((x) + 0x0B8)
+#define LPC32XX_CLKPWR_TIMER_CLK_CTRL(x)	((x) + 0x0BC)
+#define LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(x) ((x) + 0x0C0)
+#define LPC32XX_CLKPWR_SPI_CLK_CTRL(x)		((x) + 0x0C4)
+#define LPC32XX_CLKPWR_NAND_CLK_CTRL(x)		((x) + 0x0C8)
+#define LPC32XX_CLKPWR_UART3_CLK_CTRL(x)	((x) + 0x0D0)
+#define LPC32XX_CLKPWR_UART4_CLK_CTRL(x)	((x) + 0x0D4)
+#define LPC32XX_CLKPWR_UART5_CLK_CTRL(x)	((x) + 0x0D8)
+#define LPC32XX_CLKPWR_UART6_CLK_CTRL(x)	((x) + 0x0DC)
+#define LPC32XX_CLKPWR_IRDA_CLK_CTRL(x)		((x) + 0x0E0)
+#define LPC32XX_CLKPWR_UART_CLK_CTRL(x)		((x) + 0x0E4)
+#define LPC32XX_CLKPWR_DMA_CLK_CTRL(x)		((x) + 0x0E8)
+#define LPC32XX_CLKPWR_AUTOCLOCK(x)		((x) + 0x0EC)
+#define LPC32XX_CLKPWR_DEVID(x, y)		((x) + 0x130 + (y))
 
 /*
  * clkpwr_debug_ctrl register definitions
 */
-#define CLKPWR_VFP_CLOCK_ENABLE_BIT	_BIT(4)
+#define LPC32XX_CLKPWR_VFP_CLOCK_ENABLE_BIT	_BIT(4)
 
 /*
  * clkpwr_bootmap register definitions
  */
-#define CLKPWR_BOOTMAP_SEL_BIT		_BIT(1)
+#define LPC32XX_CLKPWR_BOOTMAP_SEL_BIT		_BIT(1)
 
 /*
  * clkpwr_start_gpio register bit definitions
  */
-#define CLKPWR_GPIOSRC_P1IO23_BIT	_BIT(31)
-#define CLKPWR_GPIOSRC_P1IO22_BIT	_BIT(30)
-#define CLKPWR_GPIOSRC_P1IO21_BIT	_BIT(29)
-#define CLKPWR_GPIOSRC_P1IO20_BIT	_BIT(28)
-#define CLKPWR_GPIOSRC_P1IO19_BIT	_BIT(27)
-#define CLKPWR_GPIOSRC_P1IO18_BIT	_BIT(26)
-#define CLKPWR_GPIOSRC_P1IO17_BIT	_BIT(25)
-#define CLKPWR_GPIOSRC_P1IO16_BIT	_BIT(24)
-#define CLKPWR_GPIOSRC_P1IO15_BIT	_BIT(23)
-#define CLKPWR_GPIOSRC_P1IO14_BIT	_BIT(22)
-#define CLKPWR_GPIOSRC_P1IO13_BIT	_BIT(21)
-#define CLKPWR_GPIOSRC_P1IO12_BIT	_BIT(20)
-#define CLKPWR_GPIOSRC_P1IO11_BIT	_BIT(19)
-#define CLKPWR_GPIOSRC_P1IO10_BIT	_BIT(18)
-#define CLKPWR_GPIOSRC_P1IO9_BIT	_BIT(17)
-#define CLKPWR_GPIOSRC_P1IO8_BIT	_BIT(16)
-#define CLKPWR_GPIOSRC_P1IO7_BIT	_BIT(15)
-#define CLKPWR_GPIOSRC_P1IO6_BIT	_BIT(14)
-#define CLKPWR_GPIOSRC_P1IO5_BIT	_BIT(13)
-#define CLKPWR_GPIOSRC_P1IO4_BIT	_BIT(12)
-#define CLKPWR_GPIOSRC_P1IO3_BIT	_BIT(11)
-#define CLKPWR_GPIOSRC_P1IO2_BIT	_BIT(10)
-#define CLKPWR_GPIOSRC_P1IO1_BIT	_BIT(9)
-#define CLKPWR_GPIOSRC_P1IO0_BIT	_BIT(8)
-#define CLKPWR_GPIOSRC_P0IO7_BIT	_BIT(7)
-#define CLKPWR_GPIOSRC_P0IO6_BIT	_BIT(6)
-#define CLKPWR_GPIOSRC_P0IO5_BIT	_BIT(5)
-#define CLKPWR_GPIOSRC_P0IO4_BIT	_BIT(4)
-#define CLKPWR_GPIOSRC_P0IO3_BIT	_BIT(3)
-#define CLKPWR_GPIOSRC_P0IO2_BIT	_BIT(2)
-#define CLKPWR_GPIOSRC_P0IO1_BIT	_BIT(1)
-#define CLKPWR_GPIOSRC_P0IO0_BIT	_BIT(0)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO23_BIT	_BIT(31)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO22_BIT	_BIT(30)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO21_BIT	_BIT(29)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO20_BIT	_BIT(28)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO19_BIT	_BIT(27)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO18_BIT	_BIT(26)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO17_BIT	_BIT(25)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO16_BIT	_BIT(24)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO15_BIT	_BIT(23)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO14_BIT	_BIT(22)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO13_BIT	_BIT(21)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO12_BIT	_BIT(20)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO11_BIT	_BIT(19)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO10_BIT	_BIT(18)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO9_BIT	_BIT(17)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO8_BIT	_BIT(16)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO7_BIT	_BIT(15)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO6_BIT	_BIT(14)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO5_BIT	_BIT(13)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO4_BIT	_BIT(12)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO3_BIT	_BIT(11)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO2_BIT	_BIT(10)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO1_BIT	_BIT(9)
+#define LPC32XX_CLKPWR_GPIOSRC_P1IO0_BIT	_BIT(8)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO7_BIT	_BIT(7)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO6_BIT	_BIT(6)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO5_BIT	_BIT(5)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO4_BIT	_BIT(4)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO3_BIT	_BIT(3)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO2_BIT	_BIT(2)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO1_BIT	_BIT(1)
+#define LPC32XX_CLKPWR_GPIOSRC_P0IO0_BIT	_BIT(0)
 
 /*
  * clkpwr_usbclk_pdiv register definitions
  */
-#define CLKPWR_SET_PLL_USBPDIV(n)	((n) & 0xF)
-#define CLKPWR_USBPDIV_PLL_MASK		0xF
+#define LPC32XX_CLKPWR_SET_PLL_USBPDIV(n)	((n) & 0xF)
+#define LPC32XX_CLKPWR_USBPDIV_PLL_MASK		0xF
 
 /*
  * clkpwr_start_int, clkpwr_start_raw_sts_int, clkpwr_start_sts_int,
  * clkpwr_start_pol_int, register bit definitions
  */
-#define CLKPWR_INTSRC_ADC_BIT		_BIT(31)
-#define CLKPWR_INTSRC_TS_P_BIT		_BIT(30)
-#define CLKPWR_INTSRC_TS_AUX_BIT	_BIT(29)
-#define CLKPWR_INTSRC_USBAHNEEDCLK_BIT	_BIT(26)
-#define CLKPWR_INTSRC_MSTIMER_BIT	_BIT(25)
-#define CLKPWR_INTSRC_RTC_BIT		_BIT(24)
-#define CLKPWR_INTSRC_USBNEEDCLK_BIT	_BIT(23)
-#define CLKPWR_INTSRC_USB_BIT		_BIT(22)
-#define CLKPWR_INTSRC_I2C_BIT		_BIT(21)
-#define CLKPWR_INTSRC_USBOTGTIMER_BIT	_BIT(20)
-#define CLKPWR_INTSRC_USBATXINT_BIT	_BIT(19)
-#define CLKPWR_INTSRC_KEY_BIT		_BIT(16)
-#define CLKPWR_INTSRC_MAC_BIT		_BIT(7)
-#define CLKPWR_INTSRC_P0P1_BIT		_BIT(6)
-#define CLKPWR_INTSRC_GPIO_05_BIT	_BIT(5)
-#define CLKPWR_INTSRC_GPIO_04_BIT	_BIT(4)
-#define CLKPWR_INTSRC_GPIO_03_BIT	_BIT(3)
-#define CLKPWR_INTSRC_GPIO_02_BIT	_BIT(2)
-#define CLKPWR_INTSRC_GPIO_01_BIT	_BIT(1)
-#define CLKPWR_INTSRC_GPIO_00_BIT	_BIT(0)
+#define LPC32XX_CLKPWR_INTSRC_ADC_BIT		_BIT(31)
+#define LPC32XX_CLKPWR_INTSRC_TS_P_BIT		_BIT(30)
+#define LPC32XX_CLKPWR_INTSRC_TS_AUX_BIT	_BIT(29)
+#define LPC32XX_CLKPWR_INTSRC_USBAHNEEDCLK_BIT	_BIT(26)
+#define LPC32XX_CLKPWR_INTSRC_MSTIMER_BIT	_BIT(25)
+#define LPC32XX_CLKPWR_INTSRC_RTC_BIT		_BIT(24)
+#define LPC32XX_CLKPWR_INTSRC_USBNEEDCLK_BIT	_BIT(23)
+#define LPC32XX_CLKPWR_INTSRC_USB_BIT		_BIT(22)
+#define LPC32XX_CLKPWR_INTSRC_I2C_BIT		_BIT(21)
+#define LPC32XX_CLKPWR_INTSRC_USBOTGTIMER_BIT	_BIT(20)
+#define LPC32XX_CLKPWR_INTSRC_USBATXINT_BIT	_BIT(19)
+#define LPC32XX_CLKPWR_INTSRC_KEY_BIT		_BIT(16)
+#define LPC32XX_CLKPWR_INTSRC_MAC_BIT		_BIT(7)
+#define LPC32XX_CLKPWR_INTSRC_P0P1_BIT		_BIT(6)
+#define LPC32XX_CLKPWR_INTSRC_GPIO_05_BIT	_BIT(5)
+#define LPC32XX_CLKPWR_INTSRC_GPIO_04_BIT	_BIT(4)
+#define LPC32XX_CLKPWR_INTSRC_GPIO_03_BIT	_BIT(3)
+#define LPC32XX_CLKPWR_INTSRC_GPIO_02_BIT	_BIT(2)
+#define LPC32XX_CLKPWR_INTSRC_GPIO_01_BIT	_BIT(1)
+#define LPC32XX_CLKPWR_INTSRC_GPIO_00_BIT	_BIT(0)
 
 /*
  * clkpwr_start_pin, clkpwr_start_raw_sts_pin, clkpwr_start_sts_pin,
  * clkpwr_start_pol_pin register bit definitions
  */
-#define CLKPWR_EXTSRC_U7_RX_BIT		_BIT(31)
-#define CLKPWR_EXTSRC_U7_HCTS_BIT	_BIT(30)
-#define CLKPWR_EXTSRC_U6_IRRX_BIT	_BIT(28)
-#define CLKPWR_EXTSRC_U5_RX_BIT		_BIT(26)
-#define CLKPWR_EXTSRC_GPI_11_BIT	_BIT(25)
-#define CLKPWR_EXTSRC_U3_RX_BIT		_BIT(24)
-#define CLKPWR_EXTSRC_U2_HCTS_BIT	_BIT(23)
-#define CLKPWR_EXTSRC_U2_RX_BIT		_BIT(22)
-#define CLKPWR_EXTSRC_U1_RX_BIT		_BIT(21)
-#define CLKPWR_EXTSRC_MSDIO_INT_BIT	_BIT(18)
-#define CLKPWR_EXTSRC_MSDIO_SRT_BIT	_BIT(17)
-#define CLKPWR_EXTSRC_GPIO_O6_BIT	_BIT(16)
-#define CLKPWR_EXTSRC_GPIO_O5_BIT	_BIT(15)
-#define CLKPWR_EXTSRC_GPIO_O4_BIT	_BIT(14)
-#define CLKPWR_EXTSRC_GPIO_O3_BIT	_BIT(13)
-#define CLKPWR_EXTSRC_GPIO_O2_BIT	_BIT(12)
-#define CLKPWR_EXTSRC_GPIO_O1_BIT	_BIT(11)
-#define CLKPWR_EXTSRC_GPIO_O0_BIT	_BIT(10)
-#define CLKPWR_EXTSRC_SYSCLKEN_BIT	_BIT(9)
-#define CLKPWR_EXTSRC_SPI1_DATIN_BIT	_BIT(8)
-#define CLKPWR_EXTSRC_GPIO_O7_BIT	_BIT(7)
-#define CLKPWR_EXTSRC_SPI2_DATIN_BIT	_BIT(6)
-#define CLKPWR_EXTSRC_GPIO_19_BIT	_BIT(5)
-#define CLKPWR_EXTSRC_GPIO_O9_BIT	_BIT(4)
-#define CLKPWR_EXTSRC_GPIO_O8_BIT	_BIT(3)
+#define LPC32XX_CLKPWR_EXTSRC_U7_RX_BIT		_BIT(31)
+#define LPC32XX_CLKPWR_EXTSRC_U7_HCTS_BIT	_BIT(30)
+#define LPC32XX_CLKPWR_EXTSRC_U6_IRRX_BIT	_BIT(28)
+#define LPC32XX_CLKPWR_EXTSRC_U5_RX_BIT		_BIT(26)
+#define LPC32XX_CLKPWR_EXTSRC_GPI_11_BIT	_BIT(25)
+#define LPC32XX_CLKPWR_EXTSRC_U3_RX_BIT		_BIT(24)
+#define LPC32XX_CLKPWR_EXTSRC_U2_HCTS_BIT	_BIT(23)
+#define LPC32XX_CLKPWR_EXTSRC_U2_RX_BIT		_BIT(22)
+#define LPC32XX_CLKPWR_EXTSRC_U1_RX_BIT		_BIT(21)
+#define LPC32XX_CLKPWR_EXTSRC_MSDIO_INT_BIT	_BIT(18)
+#define LPC32XX_CLKPWR_EXTSRC_MSDIO_SRT_BIT	_BIT(17)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O6_BIT	_BIT(16)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O5_BIT	_BIT(15)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O4_BIT	_BIT(14)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O3_BIT	_BIT(13)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O2_BIT	_BIT(12)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O1_BIT	_BIT(11)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O0_BIT	_BIT(10)
+#define LPC32XX_CLKPWR_EXTSRC_SYSCLKEN_BIT	_BIT(9)
+#define LPC32XX_CLKPWR_EXTSRC_SPI1_DATIN_BIT	_BIT(8)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O7_BIT	_BIT(7)
+#define LPC32XX_CLKPWR_EXTSRC_SPI2_DATIN_BIT	_BIT(6)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_19_BIT	_BIT(5)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O9_BIT	_BIT(4)
+#define LPC32XX_CLKPWR_EXTSRC_GPIO_O8_BIT	_BIT(3)
 
 /*
  * clkpwr_hclk_div register definitions
  */
-#define CLKPWR_HCLKDIV_DDRCLK_STOP	(0x0 << 7)
-#define CLKPWR_HCLKDIV_DDRCLK_NORM	(0x1 << 7)
-#define CLKPWR_HCLKDIV_DDRCLK_HALF	(0x2 << 7)
-#define CLKPWR_HCLKDIV_PCLK_DIV(n)	(((n) & 0x1F) << 2)
-#define CLKPWR_HCLKDIV_DIV_2POW(n)	((n) & 0x3)
+#define LPC32XX_CLKPWR_HCLKDIV_DDRCLK_STOP	(0x0 << 7)
+#define LPC32XX_CLKPWR_HCLKDIV_DDRCLK_NORM	(0x1 << 7)
+#define LPC32XX_CLKPWR_HCLKDIV_DDRCLK_HALF	(0x2 << 7)
+#define LPC32XX_CLKPWR_HCLKDIV_PCLK_DIV(n)	(((n) & 0x1F) << 2)
+#define LPC32XX_CLKPWR_HCLKDIV_DIV_2POW(n)	((n) & 0x3)
 
 /*
  * clkpwr_pwr_ctrl register definitions
  */
-#define CLKPWR_CTRL_FORCE_PCLK		_BIT(10)
-#define CLKPWR_SDRAM_SELF_RFSH		_BIT(9)
-#define CLKPWR_UPD_SDRAM_SELF_RFSH	_BIT(8)
-#define CLKPWR_AUTO_SDRAM_SELF_RFSH	_BIT(7)
-#define CLKPWR_HIGHCORE_STATE_BIT	_BIT(5)
-#define CLKPWR_SYSCLKEN_STATE_BIT	_BIT(4)
-#define CLKPWR_SYSCLKEN_GPIO_EN		_BIT(3)
-#define CLKPWR_SELECT_RUN_MODE		_BIT(2)
-#define CLKPWR_HIGHCORE_GPIO_EN		_BIT(1)
-#define CLKPWR_STOP_MODE_CTRL		_BIT(0)
+#define LPC32XX_CLKPWR_CTRL_FORCE_PCLK		_BIT(10)
+#define LPC32XX_CLKPWR_SDRAM_SELF_RFSH		_BIT(9)
+#define LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH	_BIT(8)
+#define LPC32XX_CLKPWR_AUTO_SDRAM_SELF_RFSH	_BIT(7)
+#define LPC32XX_CLKPWR_HIGHCORE_STATE_BIT	_BIT(5)
+#define LPC32XX_CLKPWR_SYSCLKEN_STATE_BIT	_BIT(4)
+#define LPC32XX_CLKPWR_SYSCLKEN_GPIO_EN		_BIT(3)
+#define LPC32XX_CLKPWR_SELECT_RUN_MODE		_BIT(2)
+#define LPC32XX_CLKPWR_HIGHCORE_GPIO_EN		_BIT(1)
+#define LPC32XX_CLKPWR_STOP_MODE_CTRL		_BIT(0)
 
 /*
  * clkpwr_pll397_ctrl register definitions
  */
-#define CLKPWR_PLL397_MSLOCK_STS	_BIT(10)
-#define CLKPWR_PLL397_BYPASS		_BIT(9)
-#define CLKPWR_PLL397_BIAS_NORM		0x000
-#define CLKPWR_PLL397_BIAS_N12_5	0x040
-#define CLKPWR_PLL397_BIAS_N25		0x080
-#define CLKPWR_PLL397_BIAS_N37_5	0x0C0
-#define CLKPWR_PLL397_BIAS_P12_5	0x100
-#define CLKPWR_PLL397_BIAS_P25		0x140
-#define CLKPWR_PLL397_BIAS_P37_5	0x180
-#define CLKPWR_PLL397_BIAS_P50		0x1C0
-#define CLKPWR_PLL397_BIAS_MASK		0x1C0
-#define CLKPWR_SYSCTRL_PLL397_DIS	_BIT(1)
-#define CLKPWR_SYSCTRL_PLL397_STS	_BIT(0)
+#define LPC32XX_CLKPWR_PLL397_MSLOCK_STS	_BIT(10)
+#define LPC32XX_CLKPWR_PLL397_BYPASS		_BIT(9)
+#define LPC32XX_CLKPWR_PLL397_BIAS_NORM		0x000
+#define LPC32XX_CLKPWR_PLL397_BIAS_N12_5	0x040
+#define LPC32XX_CLKPWR_PLL397_BIAS_N25		0x080
+#define LPC32XX_CLKPWR_PLL397_BIAS_N37_5	0x0C0
+#define LPC32XX_CLKPWR_PLL397_BIAS_P12_5	0x100
+#define LPC32XX_CLKPWR_PLL397_BIAS_P25		0x140
+#define LPC32XX_CLKPWR_PLL397_BIAS_P37_5	0x180
+#define LPC32XX_CLKPWR_PLL397_BIAS_P50		0x1C0
+#define LPC32XX_CLKPWR_PLL397_BIAS_MASK		0x1C0
+#define LPC32XX_CLKPWR_SYSCTRL_PLL397_DIS	_BIT(1)
+#define LPC32XX_CLKPWR_SYSCTRL_PLL397_STS	_BIT(0)
 
 /*
  * clkpwr_main_osc_ctrl register definitions
  */
-#define CLKPWR_MOSC_ADD_CAP(n)		(((n) & 0x7F) << 2)
-#define CLKPWR_MOSC_CAP_MASK		(0x7F << 2)
-#define CLKPWR_TEST_MODE		_BIT(1)
-#define CLKPWR_MOSC_DISABLE		_BIT(0)
+#define LPC32XX_CLKPWR_MOSC_ADD_CAP(n)		(((n) & 0x7F) << 2)
+#define LPC32XX_CLKPWR_MOSC_CAP_MASK		(0x7F << 2)
+#define LPC32XX_CLKPWR_TEST_MODE		_BIT(1)
+#define LPC32XX_CLKPWR_MOSC_DISABLE		_BIT(0)
 
 /*
  * clkpwr_sysclk_ctrl register definitions
  */
-#define CLKPWR_SYSCTRL_BP_TRIG(n)	(((n) & 0x3FF) << 2)
-#define CLKPWR_SYSCTRL_BP_MASK		(0x3FF << 2)
-#define CLKPWR_SYSCTRL_USEPLL397	_BIT(1)
-#define CLKPWR_SYSCTRL_SYSCLKMUX	_BIT(0)
+#define LPC32XX_CLKPWR_SYSCTRL_BP_TRIG(n)	(((n) & 0x3FF) << 2)
+#define LPC32XX_CLKPWR_SYSCTRL_BP_MASK		(0x3FF << 2)
+#define LPC32XX_CLKPWR_SYSCTRL_USEPLL397	_BIT(1)
+#define LPC32XX_CLKPWR_SYSCTRL_SYSCLKMUX	_BIT(0)
 
 /*
  * clkpwr_lcdclk_ctrl register definitions
  */
-#define CLKPWR_LCDCTRL_LCDTYPE_TFT12	0x000
-#define CLKPWR_LCDCTRL_LCDTYPE_TFT16	0x040
-#define CLKPWR_LCDCTRL_LCDTYPE_TFT15	0x080
-#define CLKPWR_LCDCTRL_LCDTYPE_TFT24	0x0C0
-#define CLKPWR_LCDCTRL_LCDTYPE_STN4M	0x100
-#define CLKPWR_LCDCTRL_LCDTYPE_STN8C	0x140
-#define CLKPWR_LCDCTRL_LCDTYPE_DSTN4M	0x180
-#define CLKPWR_LCDCTRL_LCDTYPE_DSTN8C	0x1C0
-#define CLKPWR_LCDCTRL_LCDTYPE_MSK	0x01C0
-#define CLKPWR_LCDCTRL_CLK_EN		0x020
-#define CLKPWR_LCDCTRL_SET_PSCALE(n)	((n - 1) & 0x1F)
-#define CLKPWR_LCDCTRL_PSCALE_MSK	0x001F
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT12	0x000
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT16	0x040
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT15	0x080
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT24	0x0C0
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_STN4M	0x100
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_STN8C	0x140
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_DSTN4M	0x180
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_DSTN8C	0x1C0
+#define LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_MSK	0x01C0
+#define LPC32XX_CLKPWR_LCDCTRL_CLK_EN		0x020
+#define LPC32XX_CLKPWR_LCDCTRL_SET_PSCALE(n)	((n - 1) & 0x1F)
+#define LPC32XX_CLKPWR_LCDCTRL_PSCALE_MSK	0x001F
 
 /*
  * clkpwr_hclkpll_ctrl register definitions
  */
-#define CLKPWR_HCLKPLL_POWER_UP		_BIT(16)
-#define CLKPWR_HCLKPLL_CCO_BYPASS	_BIT(15)
-#define CLKPWR_HCLKPLL_POSTDIV_BYPASS	_BIT(14)
-#define CLKPWR_HCLKPLL_FDBK_SEL_FCLK	_BIT(13)
-#define CLKPWR_HCLKPLL_POSTDIV_2POW(n)	(((n) & 0x3) << 11)
-#define CLKPWR_HCLKPLL_PREDIV_PLUS1(n)	(((n) & 0x3) << 9)
-#define CLKPWR_HCLKPLL_PLLM(n)		(((n) & 0xFF) << 1)
-#define CLKPWR_HCLKPLL_PLL_STS		_BIT(0)
+#define LPC32XX_CLKPWR_HCLKPLL_POWER_UP		_BIT(16)
+#define LPC32XX_CLKPWR_HCLKPLL_CCO_BYPASS	_BIT(15)
+#define LPC32XX_CLKPWR_HCLKPLL_POSTDIV_BYPASS	_BIT(14)
+#define LPC32XX_CLKPWR_HCLKPLL_FDBK_SEL_FCLK	_BIT(13)
+#define LPC32XX_CLKPWR_HCLKPLL_POSTDIV_2POW(n)	(((n) & 0x3) << 11)
+#define LPC32XX_CLKPWR_HCLKPLL_PREDIV_PLUS1(n)	(((n) & 0x3) << 9)
+#define LPC32XX_CLKPWR_HCLKPLL_PLLM(n)		(((n) & 0xFF) << 1)
+#define LPC32XX_CLKPWR_HCLKPLL_PLL_STS		_BIT(0)
 
 /*
  * clkpwr_adc_clk_ctrl_1 register definitions
  */
-#define CLKPWR_ADCCTRL1_RTDIV(n)	(((n) & 0xFF) << 0)
-#define CLKPWR_ADCCTRL1_PCLK_SEL	_BIT(8)
+#define LPC32XX_CLKPWR_ADCCTRL1_RTDIV(n)	(((n) & 0xFF) << 0)
+#define LPC32XX_CLKPWR_ADCCTRL1_PCLK_SEL	_BIT(8)
 
 /*
  * clkpwr_usb_ctrl register definitions
  */
-#define CLKPWR_USBCTRL_HCLK_EN		_BIT(24)
-#define CLKPWR_USBCTRL_USBI2C_EN	_BIT(23)
-#define CLKPWR_USBCTRL_USBDVND_EN	_BIT(22)
-#define CLKPWR_USBCTRL_USBHSTND_EN	_BIT(21)
-#define CLKPWR_USBCTRL_PU_ADD		(0x0 << 19)
-#define CLKPWR_USBCTRL_BUS_KEEPER	(0x1 << 19)
-#define CLKPWR_USBCTRL_PD_ADD		(0x3 << 19)
-#define CLKPWR_USBCTRL_CLK_EN2		_BIT(18)
-#define CLKPWR_USBCTRL_CLK_EN1		_BIT(17)
-#define CLKPWR_USBCTRL_PLL_PWRUP	_BIT(16)
-#define CLKPWR_USBCTRL_CCO_BYPASS	_BIT(15)
-#define CLKPWR_USBCTRL_POSTDIV_BYPASS	_BIT(14)
-#define CLKPWR_USBCTRL_FDBK_SEL_FCLK	_BIT(13)
-#define CLKPWR_USBCTRL_POSTDIV_2POW(n)	(((n) & 0x3) << 11)
-#define CLKPWR_USBCTRL_PREDIV_PLUS1(n)	(((n) & 0x3) << 9)
-#define CLKPWR_USBCTRL_FDBK_PLUS1(n)	(((n) & 0xFF) << 1)
-#define CLKPWR_USBCTRL_PLL_STS		_BIT(0)
+#define LPC32XX_CLKPWR_USBCTRL_HCLK_EN		_BIT(24)
+#define LPC32XX_CLKPWR_USBCTRL_USBI2C_EN	_BIT(23)
+#define LPC32XX_CLKPWR_USBCTRL_USBDVND_EN	_BIT(22)
+#define LPC32XX_CLKPWR_USBCTRL_USBHSTND_EN	_BIT(21)
+#define LPC32XX_CLKPWR_USBCTRL_PU_ADD		(0x0 << 19)
+#define LPC32XX_CLKPWR_USBCTRL_BUS_KEEPER	(0x1 << 19)
+#define LPC32XX_CLKPWR_USBCTRL_PD_ADD		(0x3 << 19)
+#define LPC32XX_CLKPWR_USBCTRL_CLK_EN2		_BIT(18)
+#define LPC32XX_CLKPWR_USBCTRL_CLK_EN1		_BIT(17)
+#define LPC32XX_CLKPWR_USBCTRL_PLL_PWRUP	_BIT(16)
+#define LPC32XX_CLKPWR_USBCTRL_CCO_BYPASS	_BIT(15)
+#define LPC32XX_CLKPWR_USBCTRL_POSTDIV_BYPASS	_BIT(14)
+#define LPC32XX_CLKPWR_USBCTRL_FDBK_SEL_FCLK	_BIT(13)
+#define LPC32XX_CLKPWR_USBCTRL_POSTDIV_2POW(n)	(((n) & 0x3) << 11)
+#define LPC32XX_CLKPWR_USBCTRL_PREDIV_PLUS1(n)	(((n) & 0x3) << 9)
+#define LPC32XX_CLKPWR_USBCTRL_FDBK_PLUS1(n)	(((n) & 0xFF) << 1)
+#define LPC32XX_CLKPWR_USBCTRL_PLL_STS		_BIT(0)
 
 /*
  * clkpwr_sdramclk_ctrl register definitions
  */
-#define CLKPWR_SDRCLK_FASTSLEW_CLK	_BIT(22)
-#define CLKPWR_SDRCLK_FASTSLEW		_BIT(21)
-#define CLKPWR_SDRCLK_FASTSLEW_DAT	_BIT(20)
-#define CLKPWR_SDRCLK_SW_DDR_RESET	_BIT(19)
-#define CLKPWR_SDRCLK_HCLK_DLY(n)	(((n) & 0x1F) << 14)
-#define CLKPWR_SDRCLK_DLY_ADDR_STS	_BIT(13)
-#define CLKPWR_SDRCLK_SENS_FACT(n)	(((n) & 0x7) << 10)
-#define CLKPWR_SDRCLK_USE_CAL		_BIT(9)
-#define CLKPWR_SDRCLK_DO_CAL		_BIT(8)
-#define CLKPWR_SDRCLK_CAL_ON_RTC	_BIT(7)
-#define CLKPWR_SDRCLK_DQS_DLY(n)	(((n) & 0x1F) << 2)
-#define CLKPWR_SDRCLK_USE_DDR		_BIT(1)
-#define CLKPWR_SDRCLK_CLK_DIS		_BIT(0)
+#define LPC32XX_CLKPWR_SDRCLK_FASTSLEW_CLK	_BIT(22)
+#define LPC32XX_CLKPWR_SDRCLK_FASTSLEW		_BIT(21)
+#define LPC32XX_CLKPWR_SDRCLK_FASTSLEW_DAT	_BIT(20)
+#define LPC32XX_CLKPWR_SDRCLK_SW_DDR_RESET	_BIT(19)
+#define LPC32XX_CLKPWR_SDRCLK_HCLK_DLY(n)	(((n) & 0x1F) << 14)
+#define LPC32XX_CLKPWR_SDRCLK_DLY_ADDR_STS	_BIT(13)
+#define LPC32XX_CLKPWR_SDRCLK_SENS_FACT(n)	(((n) & 0x7) << 10)
+#define LPC32XX_CLKPWR_SDRCLK_USE_CAL		_BIT(9)
+#define LPC32XX_CLKPWR_SDRCLK_DO_CAL		_BIT(8)
+#define LPC32XX_CLKPWR_SDRCLK_CAL_ON_RTC	_BIT(7)
+#define LPC32XX_CLKPWR_SDRCLK_DQS_DLY(n)	(((n) & 0x1F) << 2)
+#define LPC32XX_CLKPWR_SDRCLK_USE_DDR		_BIT(1)
+#define LPC32XX_CLKPWR_SDRCLK_CLK_DIS		_BIT(0)
 
 /*
  * clkpwr_ssp_blk_ctrl register definitions
  */
-#define CLKPWR_SSPCTRL_DMA_SSP1RX	_BIT(5)
-#define CLKPWR_SSPCTRL_DMA_SSP1TX	_BIT(4)
-#define CLKPWR_SSPCTRL_DMA_SSP0RX	_BIT(3)
-#define CLKPWR_SSPCTRL_DMA_SSP0TX	_BIT(2)
-#define CLKPWR_SSPCTRL_SSPCLK1_EN	_BIT(1)
-#define CLKPWR_SSPCTRL_SSPCLK0_EN	_BIT(0)
+#define LPC32XX_CLKPWR_SSPCTRL_DMA_SSP1RX	_BIT(5)
+#define LPC32XX_CLKPWR_SSPCTRL_DMA_SSP1TX	_BIT(4)
+#define LPC32XX_CLKPWR_SSPCTRL_DMA_SSP0RX	_BIT(3)
+#define LPC32XX_CLKPWR_SSPCTRL_DMA_SSP0TX	_BIT(2)
+#define LPC32XX_CLKPWR_SSPCTRL_SSPCLK1_EN	_BIT(1)
+#define LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN	_BIT(0)
 
 /*
  * clkpwr_i2s_clk_ctrl register definitions
  */
-#define CLKPWR_I2SCTRL_I2S1_RX_FOR_TX	_BIT(6)
-#define CLKPWR_I2SCTRL_I2S1_TX_FOR_RX	_BIT(5)
-#define CLKPWR_I2SCTRL_I2S1_USE_DMA	_BIT(4)
-#define CLKPWR_I2SCTRL_I2S0_RX_FOR_TX	_BIT(3)
-#define CLKPWR_I2SCTRL_I2S0_TX_FOR_RX	_BIT(2)
-#define CLKPWR_I2SCTRL_I2SCLK1_EN	_BIT(1)
-#define CLKPWR_I2SCTRL_I2SCLK0_EN	_BIT(0)
+#define LPC32XX_CLKPWR_I2SCTRL_I2S1_RX_FOR_TX	_BIT(6)
+#define LPC32XX_CLKPWR_I2SCTRL_I2S1_TX_FOR_RX	_BIT(5)
+#define LPC32XX_CLKPWR_I2SCTRL_I2S1_USE_DMA	_BIT(4)
+#define LPC32XX_CLKPWR_I2SCTRL_I2S0_RX_FOR_TX	_BIT(3)
+#define LPC32XX_CLKPWR_I2SCTRL_I2S0_TX_FOR_RX	_BIT(2)
+#define LPC32XX_CLKPWR_I2SCTRL_I2SCLK1_EN	_BIT(1)
+#define LPC32XX_CLKPWR_I2SCTRL_I2SCLK0_EN	_BIT(0)
 
 /*
  * clkpwr_ms_ctrl register definitions
  */
-#define CLKPWR_MSCARD_MSDIO_PIN_DIS	_BIT(10)
-#define CLKPWR_MSCARD_MSDIO_PU_EN	_BIT(9)
-#define CLKPWR_MSCARD_MSDIO23_DIS	_BIT(8)
-#define CLKPWR_MSCARD_MSDIO1_DIS	_BIT(7)
-#define CLKPWR_MSCARD_MSDIO0_DIS	_BIT(6)
-#define CLKPWR_MSCARD_SDCARD_EN		_BIT(5)
-#define CLKPWR_MSCARD_SDCARD_DIV(n)	((n) & 0xF)
+#define LPC32XX_CLKPWR_MSCARD_MSDIO_PIN_DIS	_BIT(10)
+#define LPC32XX_CLKPWR_MSCARD_MSDIO_PU_EN	_BIT(9)
+#define LPC32XX_CLKPWR_MSCARD_MSDIO23_DIS	_BIT(8)
+#define LPC32XX_CLKPWR_MSCARD_MSDIO1_DIS	_BIT(7)
+#define LPC32XX_CLKPWR_MSCARD_MSDIO0_DIS	_BIT(6)
+#define LPC32XX_CLKPWR_MSCARD_SDCARD_EN		_BIT(5)
+#define LPC32XX_CLKPWR_MSCARD_SDCARD_DIV(n)	((n) & 0xF)
 
 /*
  * clkpwr_macclk_ctrl register definitions
  */
-#define CLKPWR_MACCTRL_NO_ENET_PIS	0x00
-#define CLKPWR_MACCTRL_USE_MII_PINS	0x08
-#define CLKPWR_MACCTRL_USE_RMII_PINS	0x18
-#define CLKPWR_MACCTRL_PINS_MSK		0x18
-#define CLKPWR_MACCTRL_DMACLK_EN	_BIT(2)
-#define CLKPWR_MACCTRL_MMIOCLK_EN	_BIT(1)
-#define CLKPWR_MACCTRL_HRCCLK_EN	_BIT(0)
+#define LPC32XX_CLKPWR_MACCTRL_NO_ENET_PIS	0x00
+#define LPC32XX_CLKPWR_MACCTRL_USE_MII_PINS	0x08
+#define LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS	0x18
+#define LPC32XX_CLKPWR_MACCTRL_PINS_MSK		0x18
+#define LPC32XX_CLKPWR_MACCTRL_DMACLK_EN	_BIT(2)
+#define LPC32XX_CLKPWR_MACCTRL_MMIOCLK_EN	_BIT(1)
+#define LPC32XX_CLKPWR_MACCTRL_HRCCLK_EN	_BIT(0)
 
 /*
  * clkpwr_test_clk_sel register definitions
  */
-#define CLKPWR_TESTCLK1_SEL_PERCLK	(0x0 << 5)
-#define CLKPWR_TESTCLK1_SEL_RTC		(0x1 << 5)
-#define CLKPWR_TESTCLK1_SEL_MOSC	(0x2 << 5)
-#define CLKPWR_TESTCLK1_SEL_MASK	(0x3 << 5)
-#define CLKPWR_TESTCLK_TESTCLK1_EN	_BIT(4)
-#define CLKPWR_TESTCLK2_SEL_HCLK	(0x0 << 1)
-#define CLKPWR_TESTCLK2_SEL_PERCLK	(0x1 << 1)
-#define CLKPWR_TESTCLK2_SEL_USBCLK	(0x2 << 1)
-#define CLKPWR_TESTCLK2_SEL_MOSC	(0x5 << 1)
-#define CLKPWR_TESTCLK2_SEL_PLL397	(0x7 << 1)
-#define CLKPWR_TESTCLK2_SEL_MASK	(0x7 << 1)
-#define CLKPWR_TESTCLK_TESTCLK2_EN	_BIT(0)
+#define LPC32XX_CLKPWR_TESTCLK1_SEL_PERCLK	(0x0 << 5)
+#define LPC32XX_CLKPWR_TESTCLK1_SEL_RTC		(0x1 << 5)
+#define LPC32XX_CLKPWR_TESTCLK1_SEL_MOSC	(0x2 << 5)
+#define LPC32XX_CLKPWR_TESTCLK1_SEL_MASK	(0x3 << 5)
+#define LPC32XX_CLKPWR_TESTCLK_TESTCLK1_EN	_BIT(4)
+#define LPC32XX_CLKPWR_TESTCLK2_SEL_HCLK	(0x0 << 1)
+#define LPC32XX_CLKPWR_TESTCLK2_SEL_PERCLK	(0x1 << 1)
+#define LPC32XX_CLKPWR_TESTCLK2_SEL_USBCLK	(0x2 << 1)
+#define LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC	(0x5 << 1)
+#define LPC32XX_CLKPWR_TESTCLK2_SEL_PLL397	(0x7 << 1)
+#define LPC32XX_CLKPWR_TESTCLK2_SEL_MASK	(0x7 << 1)
+#define LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN	_BIT(0)
 
 /*
  * clkpwr_sw_int register definitions
  */
-#define CLKPWR_SW_INT(n)		(_BIT(0) | (((n) & 0x7F) << 1))
-#define CLKPWR_SW_GET_ARG(n)		(((n) & 0xFE) >> 1)
+#define LPC32XX_CLKPWR_SW_INT(n)		(_BIT(0) | (((n) & 0x7F) << 1))
+#define LPC32XX_CLKPWR_SW_GET_ARG(n)		(((n) & 0xFE) >> 1)
 
 /*
  * clkpwr_i2c_clk_ctrl register definitions
  */
-#define CLKPWR_I2CCLK_USBI2CHI_DRIVE	_BIT(4)
-#define CLKPWR_I2CCLK_I2C2HI_DRIVE	_BIT(3)
-#define CLKPWR_I2CCLK_I2C1HI_DRIVE	_BIT(2)
-#define CLKPWR_I2CCLK_I2C2CLK_EN	_BIT(1)
-#define CLKPWR_I2CCLK_I2C1CLK_EN	_BIT(0)
+#define LPC32XX_CLKPWR_I2CCLK_USBI2CHI_DRIVE	_BIT(4)
+#define LPC32XX_CLKPWR_I2CCLK_I2C2HI_DRIVE	_BIT(3)
+#define LPC32XX_CLKPWR_I2CCLK_I2C1HI_DRIVE	_BIT(2)
+#define LPC32XX_CLKPWR_I2CCLK_I2C2CLK_EN	_BIT(1)
+#define LPC32XX_CLKPWR_I2CCLK_I2C1CLK_EN	_BIT(0)
 
 /*
  * clkpwr_key_clk_ctrl register definitions
  */
-#define CLKPWR_KEYCLKCTRL_CLK_EN	0x1
+#define LPC32XX_CLKPWR_KEYCLKCTRL_CLK_EN	0x1
 
 /*
  * clkpwr_adc_clk_ctrl register definitions
  */
-#define CLKPWR_ADC32CLKCTRL_CLK_EN	0x1
+#define LPC32XX_CLKPWR_ADC32CLKCTRL_CLK_EN	0x1
 
 /*
  * clkpwr_pwm_clk_ctrl register definitions
  */
-#define CLKPWR_PWMCLK_PWM2_DIV(n)	(((n) & 0xF) << 8)
-#define CLKPWR_PWMCLK_PWM1_DIV(n)	(((n) & 0xF) << 4)
-#define CLKPWR_PWMCLK_PWM2SEL_PCLK	0x8
-#define CLKPWR_PWMCLK_PWM2CLK_EN	0x4
-#define CLKPWR_PWMCLK_PWM1SEL_PCLK	0x2
-#define CLKPWR_PWMCLK_PWM1CLK_EN	0x1
+#define LPC32XX_CLKPWR_PWMCLK_PWM2_DIV(n)	(((n) & 0xF) << 8)
+#define LPC32XX_CLKPWR_PWMCLK_PWM1_DIV(n)	(((n) & 0xF) << 4)
+#define LPC32XX_CLKPWR_PWMCLK_PWM2SEL_PCLK	0x8
+#define LPC32XX_CLKPWR_PWMCLK_PWM2CLK_EN	0x4
+#define LPC32XX_CLKPWR_PWMCLK_PWM1SEL_PCLK	0x2
+#define LPC32XX_CLKPWR_PWMCLK_PWM1CLK_EN	0x1
 
 /*
  * clkpwr_timer_clk_ctrl register definitions
  */
-#define CLKPWR_PWMCLK_HSTIMER_EN	0x2
-#define CLKPWR_PWMCLK_WDOG_EN		0x1
+#define LPC32XX_CLKPWR_PWMCLK_HSTIMER_EN	0x2
+#define LPC32XX_CLKPWR_PWMCLK_WDOG_EN		0x1
 
 /*
  * clkpwr_timers_pwms_clk_ctrl_1 register definitions
  */
-#define CLKPWR_TMRPWMCLK_TIMER3_EN	0x20
-#define CLKPWR_TMRPWMCLK_TIMER2_EN	0x10
-#define CLKPWR_TMRPWMCLK_TIMER1_EN	0x08
-#define CLKPWR_TMRPWMCLK_TIMER0_EN	0x04
-#define CLKPWR_TMRPWMCLK_PWM4_EN	0x02
-#define CLKPWR_TMRPWMCLK_PWM3_EN	0x01
+#define LPC32XX_CLKPWR_TMRPWMCLK_TIMER3_EN	0x20
+#define LPC32XX_CLKPWR_TMRPWMCLK_TIMER2_EN	0x10
+#define LPC32XX_CLKPWR_TMRPWMCLK_TIMER1_EN	0x08
+#define LPC32XX_CLKPWR_TMRPWMCLK_TIMER0_EN	0x04
+#define LPC32XX_CLKPWR_TMRPWMCLK_PWM4_EN	0x02
+#define LPC32XX_CLKPWR_TMRPWMCLK_PWM3_EN	0x01
 
 /*
  * clkpwr_spi_clk_ctrl register definitions
  */
-#define CLKPWR_SPICLK_SET_SPI2DATIO	0x80
-#define CLKPWR_SPICLK_SET_SPI2CLK	0x40
-#define CLKPWR_SPICLK_USE_SPI2		0x20
-#define CLKPWR_SPICLK_SPI2CLK_EN	0x10
-#define CLKPWR_SPICLK_SET_SPI1DATIO	0x08
-#define CLKPWR_SPICLK_SET_SPI1CLK	0x04
-#define CLKPWR_SPICLK_USE_SPI1		0x02
-#define CLKPWR_SPICLK_SPI1CLK_EN	0x01
+#define LPC32XX_CLKPWR_SPICLK_SET_SPI2DATIO	0x80
+#define LPC32XX_CLKPWR_SPICLK_SET_SPI2CLK	0x40
+#define LPC32XX_CLKPWR_SPICLK_USE_SPI2		0x20
+#define LPC32XX_CLKPWR_SPICLK_SPI2CLK_EN	0x10
+#define LPC32XX_CLKPWR_SPICLK_SET_SPI1DATIO	0x08
+#define LPC32XX_CLKPWR_SPICLK_SET_SPI1CLK	0x04
+#define LPC32XX_CLKPWR_SPICLK_USE_SPI1		0x02
+#define LPC32XX_CLKPWR_SPICLK_SPI1CLK_EN	0x01
 
 /*
  * clkpwr_nand_clk_ctrl register definitions
  */
-#define CLKPWR_NANDCLK_INTSEL_MLC	0x20
-#define CLKPWR_NANDCLK_DMA_RNB		0x10
-#define CLKPWR_NANDCLK_DMA_INT		0x08
-#define CLKPWR_NANDCLK_SEL_SLC		0x04
-#define CLKPWR_NANDCLK_MLCCLK_EN	0x02
-#define CLKPWR_NANDCLK_SLCCLK_EN	0x01
+#define LPC32XX_CLKPWR_NANDCLK_INTSEL_MLC	0x20
+#define LPC32XX_CLKPWR_NANDCLK_DMA_RNB		0x10
+#define LPC32XX_CLKPWR_NANDCLK_DMA_INT		0x08
+#define LPC32XX_CLKPWR_NANDCLK_SEL_SLC		0x04
+#define LPC32XX_CLKPWR_NANDCLK_MLCCLK_EN	0x02
+#define LPC32XX_CLKPWR_NANDCLK_SLCCLK_EN	0x01
 
 /*
  * clkpwr_uart3_clk_ctrl, clkpwr_uart4_clk_ctrl, clkpwr_uart5_clk_ctrl
  * and clkpwr_uart6_clk_ctrl register definitions
  */
-#define CLKPWR_UART_Y_DIV(y)		((y) & 0xFF)
-#define CLKPWR_UART_X_DIV(x)		(((x) & 0xFF) << 8)
-#define CLKPWR_UART_USE_HCLK		_BIT(16)
+#define LPC32XX_CLKPWR_UART_Y_DIV(y)		((y) & 0xFF)
+#define LPC32XX_CLKPWR_UART_X_DIV(x)		(((x) & 0xFF) << 8)
+#define LPC32XX_CLKPWR_UART_USE_HCLK		_BIT(16)
 
 /*
  * clkpwr_irda_clk_ctrl register definitions
  */
-#define CLKPWR_IRDA_Y_DIV(y)		((y) & 0xFF)
-#define CLKPWR_IRDA_X_DIV(x)		(((x) & 0xFF) << 8)
+#define LPC32XX_CLKPWR_IRDA_Y_DIV(y)		((y) & 0xFF)
+#define LPC32XX_CLKPWR_IRDA_X_DIV(x)		(((x) & 0xFF) << 8)
 
 /*
  * clkpwr_uart_clk_ctrl register definitions
  */
-#define CLKPWR_UARTCLKCTRL_UART6_EN	_BIT(3)
-#define CLKPWR_UARTCLKCTRL_UART5_EN	_BIT(2)
-#define CLKPWR_UARTCLKCTRL_UART4_EN	_BIT(1)
-#define CLKPWR_UARTCLKCTRL_UART3_EN	_BIT(0)
+#define LPC32XX_CLKPWR_UARTCLKCTRL_UART6_EN	_BIT(3)
+#define LPC32XX_CLKPWR_UARTCLKCTRL_UART5_EN	_BIT(2)
+#define LPC32XX_CLKPWR_UARTCLKCTRL_UART4_EN	_BIT(1)
+#define LPC32XX_CLKPWR_UARTCLKCTRL_UART3_EN	_BIT(0)
 
 /*
  * clkpwr_dmaclk_ctrl register definitions
  */
-#define CLKPWR_DMACLKCTRL_CLK_EN	0x1
+#define LPC32XX_CLKPWR_DMACLKCTRL_CLK_EN	0x1
 
 /*
  * clkpwr_autoclock register definitions
  */
-#define CLKPWR_AUTOCLK_USB_EN		0x40
-#define CLKPWR_AUTOCLK_IRAM_EN		0x02
-#define CLKPWR_AUTOCLK_IROM_EN		0x01
+#define LPC32XX_CLKPWR_AUTOCLK_USB_EN		0x40
+#define LPC32XX_CLKPWR_AUTOCLK_IRAM_EN		0x02
+#define LPC32XX_CLKPWR_AUTOCLK_IROM_EN		0x01
 
 /*
  * Interrupt controller register offsets
diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 4ee9714..0612994 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -333,30 +333,32 @@ static void __init phy3250_board_init(void)
 	gpio_direction_output(SPI0_CS_GPIO, 1);
 
 	/* Setup network interface for RMII mode */
-	tmp = readl(CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE));
-	tmp &= ~CLKPWR_MACCTRL_PINS_MSK;
-	tmp |= CLKPWR_MACCTRL_USE_RMII_PINS;
-	writel(tmp, CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE));
+	tmp &= ~LPC32XX_CLKPWR_MACCTRL_PINS_MSK;
+	tmp |= LPC32XX_CLKPWR_MACCTRL_USE_RMII_PINS;
+	writel(tmp, LPC32XX_CLKPWR_MACCLK_CTRL(CLKPWR_IOBASE));
 
 	/* Setup SLC NAND controller muxing */
-	writel(CLKPWR_NANDCLK_SEL_SLC,
-		CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE));
+	writel(LPC32XX_CLKPWR_NANDCLK_SEL_SLC,
+		LPC32XX_CLKPWR_NAND_CLK_CTRL(CLKPWR_IOBASE));
 
 	/* Setup LCD muxing to RGB565 */
-	tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
-		~(CLKPWR_LCDCTRL_LCDTYPE_MSK | CLKPWR_LCDCTRL_PSCALE_MSK);
-	tmp |= CLKPWR_LCDCTRL_LCDTYPE_TFT16;
-	writel(tmp, CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE)) &
+		~(LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_MSK |
+		LPC32XX_CLKPWR_LCDCTRL_PSCALE_MSK);
+	tmp |= LPC32XX_CLKPWR_LCDCTRL_LCDTYPE_TFT16;
+	writel(tmp, LPC32XX_CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
 
 	/* Set up I2C pull levels */
-	tmp = readl(CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE));
-	tmp |= CLKPWR_I2CCLK_USBI2CHI_DRIVE | CLKPWR_I2CCLK_I2C2HI_DRIVE;
-	writel(tmp, CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE));
+	tmp |= LPC32XX_CLKPWR_I2CCLK_USBI2CHI_DRIVE |
+		LPC32XX_CLKPWR_I2CCLK_I2C2HI_DRIVE;
+	writel(tmp, LPC32XX_CLKPWR_I2C_CLK_CTRL(CLKPWR_IOBASE));
 
 	/* Enable DMA for I2S1 channel */
-	tmp = readl(CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE));
-	tmp = CLKPWR_I2SCTRL_I2S1_USE_DMA;
-	writel(tmp, CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE));
+	tmp = LPC32XX_CLKPWR_I2SCTRL_I2S1_USE_DMA;
+	writel(tmp, LPC32XX_CLKPWR_I2S_CLK_CTRL(CLKPWR_IOBASE));
 
 	lpc32xx_serial_init();
 
@@ -365,14 +367,14 @@ static void __init phy3250_board_init(void)
 	   here. However, we don't want to enable them if the peripheral
 	   isn't included in the image */
 #ifdef CONFIG_FB_ARMCLCD
-	tmp = readl(CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
-	writel((tmp | CLKPWR_LCDCTRL_CLK_EN),
-		CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
+	writel((tmp | LPC32XX_CLKPWR_LCDCTRL_CLK_EN),
+		LPC32XX_CLKPWR_LCDCLK_CTRL(CLKPWR_IOBASE));
 #endif
 #ifdef CONFIG_SPI_PL022
-	tmp = readl(CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
-	writel((tmp | CLKPWR_SSPCTRL_SSPCLK0_EN),
-		CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+	tmp = readl(LPC32XX_CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
+	writel((tmp | LPC32XX_CLKPWR_SSPCTRL_SSPCLK0_EN),
+		LPC32XX_CLKPWR_SSP_CLK_CTRL(CLKPWR_IOBASE));
 #endif
 
 	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs));
@@ -382,8 +384,9 @@ static void __init phy3250_board_init(void)
 	}
 
 	/* Test clock needed for UDA1380 initial init */
-	writel((CLKPWR_TESTCLK2_SEL_MOSC | CLKPWR_TESTCLK_TESTCLK2_EN),
-		CLKPWR_TEST_CLK_SEL(CLKPWR_IOBASE));
+	writel((LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
+		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN),
+		LPC32XX_CLKPWR_TEST_CLK_SEL(CLKPWR_IOBASE));
 
 	i2c_register_board_info(0, phy3250_i2c_board_info,
 				ARRAY_SIZE(phy3250_i2c_board_info));
diff --git a/arch/arm/mach-lpc32xx/pm_events.c b/arch/arm/mach-lpc32xx/pm_events.c
index d3b1b54..ffd46c4 100644
--- a/arch/arm/mach-lpc32xx/pm_events.c
+++ b/arch/arm/mach-lpc32xx/pm_events.c
@@ -36,301 +36,301 @@ struct lpc32xx_event_info {
 
 static const struct lpc32xx_event_info events[LPC32XX_LAST_EVENT + 1] = {
 	[LPC32XX_WKUP_GPI_08] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O8_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O8_BIT,
 	},
 	[LPC32XX_WKUP_GPI_09] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O9_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O9_BIT,
 	},
 	[LPC32XX_WKUP_GPI_19] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_19_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_19_BIT,
 	},
 	[LPC32XX_WKUP_SPI2_DATIN] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_SPI2_DATIN_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_SPI2_DATIN_BIT,
 	},
 	[LPC32XX_WKUP_GPI_07] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O7_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O7_BIT,
 	},
 	[LPC32XX_WKUP_SPI1_DATIN] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_SPI1_DATIN_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_SPI1_DATIN_BIT,
 	},
 	[LPC32XX_WKUP_SYSCLKEN] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_SYSCLKEN_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_SYSCLKEN_BIT,
 	},
 	[LPC32XX_WKUP_GPI00] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O0_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O0_BIT,
 	},
 	[LPC32XX_WKUP_GPI01] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O1_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O1_BIT,
 	},
 	[LPC32XX_WKUP_GPI02] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O2_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O2_BIT,
 	},
 	[LPC32XX_WKUP_GPI03] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O3_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O3_BIT,
 	},
 	[LPC32XX_WKUP_GPI04] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O4_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O4_BIT,
 	},
 	[LPC32XX_WKUP_GPI05] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O5_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O5_BIT,
 	},
 	[LPC32XX_WKUP_GPI06] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPIO_O6_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPIO_O6_BIT,
 	},
 	[LPC32XX_WKUP_MSDIO_START] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_MSDIO_SRT_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_MSDIO_SRT_BIT,
 	},
 	[LPC32XX_WKUP_SDIO_INT_N] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_MSDIO_INT_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_MSDIO_INT_BIT,
 	},
 	[LPC32XX_WKUP_U1_RX] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U1_RX_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U1_RX_BIT,
 	},
 	[LPC32XX_WKUP_U2_RX] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U2_RX_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U2_RX_BIT,
 	},
 	[LPC32XX_WKUP_U2_HCTS] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U2_HCTS_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U2_HCTS_BIT,
 	},
 	[LPC32XX_WKUP_U3_RX] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U3_RX_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U3_RX_BIT,
 	},
 	[LPC32XX_WKUP_GPI_28] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_GPI_11_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_GPI_11_BIT,
 	},
 	[LPC32XX_WKUP_U5_RX] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U5_RX_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U5_RX_BIT,
 	},
 	[LPC32XX_WKUP_U6_IRRX] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U6_IRRX_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U6_IRRX_BIT,
 	},
 	[LPC32XX_WKUP_U7_HCTS] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U7_HCTS_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U7_HCTS_BIT,
 	},
 	[LPC32XX_WKUP_U7_RX] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_EXTSRC_U7_RX_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_EXTSRC_U7_RX_BIT,
 	},
 
 	[LPC32XX_WKUP_GPIO_00] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_GPIO_00_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_00_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_01] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_GPIO_01_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_01_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_02] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_GPIO_02_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_02_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_03] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_GPIO_03_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_03_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_04] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_GPIO_04_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_04_BIT,
 	},
 	[LPC32XX_WKUP_GPIO_05] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_GPIO_05_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_GPIO_05_BIT,
 	},
 	[LPC32XX_WKUP_P0_P1_ALL] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_P0P1_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_P0P1_BIT,
 	},
 	[LPC32XX_WKUP_MAC_START] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_MAC_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_MAC_BIT,
 	},
 	[LPC32XX_WKUP_KEY_IRQ] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_KEY_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_KEY_BIT,
 	},
 	[LPC32XX_WKUP_USB_OTG_ATX_INT_N] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_USBATXINT_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_USBATXINT_BIT,
 	},
 	[LPC32XX_WKUP_USB_OTG_TIMER] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_USBOTGTIMER_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_USBOTGTIMER_BIT,
 	},
 	[LPC32XX_WKUP_USB_I2C_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_I2C_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_I2C_BIT,
 	},
 	[LPC32XX_WKUP_USB_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_USB_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_USB_BIT,
 	},
 	[LPC32XX_WKUP_USB_NEED_CLK] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_USBNEEDCLK_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_USBNEEDCLK_BIT,
 	},
 	[LPC32XX_WKUP_RTC_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_RTC_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_RTC_BIT,
 	},
 	[LPC32XX_WKUP_MSTIMER_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_MSTIMER_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_MSTIMER_BIT,
 	},
 	[LPC32XX_WKUP_USB_AHC_NEED_CLK] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_USBAHNEEDCLK_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_USBAHNEEDCLK_BIT,
 	},
 	[LPC32XX_WKUP_TS_AUX_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_TS_AUX_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_TS_AUX_BIT,
 	},
 	[LPC32XX_WKUP_TS_P_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_TS_P_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_TS_P_BIT,
 	},
 	[LPC32XX_WKUP_TS_INT] = {
-		.offs = CLKPWR_INT_ER(0),
-		.mask = CLKPWR_INTSRC_ADC_BIT,
+		.offs = LPC32XX_CLKPWR_INT_ER(0),
+		.mask = LPC32XX_CLKPWR_INTSRC_ADC_BIT,
 	},
 	[LPC32XX_WKUP_P0_0] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO0_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO0_BIT,
 	},
 	[LPC32XX_WKUP_P0_1] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO1_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO1_BIT,
 	},
 	[LPC32XX_WKUP_P0_2] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO2_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO2_BIT,
 	},
 	[LPC32XX_WKUP_P0_3] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO3_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO3_BIT,
 	},
 	[LPC32XX_WKUP_P0_4] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO4_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO4_BIT,
 	},
 	[LPC32XX_WKUP_P0_5] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO5_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO5_BIT,
 	},
 	[LPC32XX_WKUP_P0_6] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO6_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO6_BIT,
 	},
 	[LPC32XX_WKUP_P0_7] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P0IO7_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P0IO7_BIT,
 	},
 	[LPC32XX_WKUP_P1_3] = {
-		.offs = CLKPWR_PIN_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO3_BIT,
+		.offs = LPC32XX_CLKPWR_PIN_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO3_BIT,
 	},
 	[LPC32XX_WKUP_P1_4] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO4_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO4_BIT,
 	},
 	[LPC32XX_WKUP_P1_5] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO5_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO5_BIT,
 	},
 	[LPC32XX_WKUP_P1_6] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO6_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO6_BIT,
 	},
 	[LPC32XX_WKUP_P1_7] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO7_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO7_BIT,
 	},
 	[LPC32XX_WKUP_P1_8] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO8_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO8_BIT,
 	},
 	[LPC32XX_WKUP_P1_9] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO9_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO9_BIT,
 	},
 	[LPC32XX_WKUP_P1_10] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO10_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO10_BIT,
 	},
 	[LPC32XX_WKUP_P1_11] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO11_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO11_BIT,
 	},
 	[LPC32XX_WKUP_P1_12] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO12_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO12_BIT,
 	},
 	[LPC32XX_WKUP_P1_13] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO13_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO13_BIT,
 	},
 	[LPC32XX_WKUP_P1_14] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO14_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO14_BIT,
 	},
 	[LPC32XX_WKUP_P1_15] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO15_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO15_BIT,
 	},
 	[LPC32XX_WKUP_P1_16] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO16_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO16_BIT,
 	},
 	[LPC32XX_WKUP_P1_17] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO17_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO17_BIT,
 	},
 	[LPC32XX_WKUP_P1_18] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO18_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO18_BIT,
 	},
 	[LPC32XX_WKUP_P1_19] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO19_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO19_BIT,
 	},
 	[LPC32XX_WKUP_P1_20] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO20_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO20_BIT,
 	},
 	[LPC32XX_WKUP_P1_21] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO21_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO21_BIT,
 	},
 	[LPC32XX_WKUP_P1_22] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO22_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO22_BIT,
 	},
 	[LPC32XX_WKUP_P1_23] = {
-		.offs = CLKPWR_P01_ER(0),
-		.mask = CLKPWR_GPIOSRC_P1IO23_BIT,
+		.offs = LPC32XX_CLKPWR_P01_ER(0),
+		.mask = LPC32XX_CLKPWR_GPIOSRC_P1IO23_BIT,
 	},
 };
 
@@ -339,21 +339,23 @@ void lpc32xx_event_init(void)
 	/* Initially disable all events, set all events to default
 	   type and polarity per chip User guide, and clear any
 	   pending event statuses */
-	writel(0, CLKPWR_P01_ER(CLKPWR_IOBASE));
-	writel(0, CLKPWR_INT_ER(CLKPWR_IOBASE));
-	writel(0, CLKPWR_PIN_ER(CLKPWR_IOBASE));
+	writel(0, LPC32XX_CLKPWR_P01_ER(CLKPWR_IOBASE));
+	writel(0, LPC32XX_CLKPWR_INT_ER(CLKPWR_IOBASE));
+	writel(0, LPC32XX_CLKPWR_PIN_ER(CLKPWR_IOBASE));
 
 	/* Default activation polarities, all pin sources are low edge
 	   triggered */
-	writel(CLKPWR_INTSRC_TS_P_BIT | CLKPWR_INTSRC_MSTIMER_BIT |
-		CLKPWR_INTSRC_RTC_BIT, CLKPWR_INT_AP(CLKPWR_IOBASE));
-	writel(0, CLKPWR_PIN_AP(CLKPWR_IOBASE));
+	writel(LPC32XX_CLKPWR_INTSRC_TS_P_BIT |
+		LPC32XX_CLKPWR_INTSRC_MSTIMER_BIT |
+		LPC32XX_CLKPWR_INTSRC_RTC_BIT,
+		LPC32XX_CLKPWR_INT_AP(CLKPWR_IOBASE));
+	writel(0, LPC32XX_CLKPWR_PIN_AP(CLKPWR_IOBASE));
 
 	/* Clear latched event states */
-	writel(readl(CLKPWR_PIN_RS(CLKPWR_IOBASE)),
-		CLKPWR_PIN_RS(CLKPWR_IOBASE));
-	writel(readl(CLKPWR_INT_RS(CLKPWR_IOBASE)),
-		CLKPWR_INT_RS(CLKPWR_IOBASE));
+	writel(readl(LPC32XX_CLKPWR_PIN_RS(CLKPWR_IOBASE)),
+		LPC32XX_CLKPWR_PIN_RS(CLKPWR_IOBASE));
+	writel(readl(LPC32XX_CLKPWR_INT_RS(CLKPWR_IOBASE)),
+		LPC32XX_CLKPWR_INT_RS(CLKPWR_IOBASE));
 }
 
 void lpc32xx_event_enable(enum lpc32xx_events event_id)
@@ -374,23 +376,23 @@ extern int lpc32xx_event_set(enum lpc32xx_events event_id,
 	u32 tmp;
 
 	if (event_id <= LPC32XX_WKUP_U7_RX) {
-		tmp = readl(CLKPWR_PIN_AP(CLKPWR_IOBASE));
+		tmp = readl(LPC32XX_CLKPWR_PIN_AP(CLKPWR_IOBASE));
 
 		if (high_edge)
 			tmp |= events[event_id].mask;
 		else
 			tmp &= ~events[event_id].mask;
 
-		writel(tmp, CLKPWR_PIN_AP(CLKPWR_IOBASE));
+		writel(tmp, LPC32XX_CLKPWR_PIN_AP(CLKPWR_IOBASE));
 	} else if (event_id <= LPC32XX_WKUP_TS_INT) {
-		tmp = readl(CLKPWR_INT_AP(CLKPWR_IOBASE));
+		tmp = readl(LPC32XX_CLKPWR_INT_AP(CLKPWR_IOBASE));
 
 		if (high_edge)
 			tmp |= events[event_id].mask;
 		else
 			tmp &= ~events[event_id].mask;
 
-		writel(tmp, CLKPWR_INT_AP(CLKPWR_IOBASE));
+		writel(tmp, LPC32XX_CLKPWR_INT_AP(CLKPWR_IOBASE));
 	} else
 		return -EINVAL;
 
@@ -410,17 +412,19 @@ int lpc32xx_event_enabled(enum lpc32xx_events event_id)
 void lpc32xx_event_clear(enum lpc32xx_events event_id)
 {
 	if (event_id <= LPC32XX_WKUP_U7_RX)
-		writel(events[event_id].mask, CLKPWR_PIN_RS(CLKPWR_IOBASE));
+		writel(events[event_id].mask,
+			LPC32XX_CLKPWR_PIN_RS(CLKPWR_IOBASE));
 	else if (event_id <= LPC32XX_WKUP_TS_INT)
-		writel(events[event_id].mask, CLKPWR_INT_RS(CLKPWR_IOBASE));
+		writel(events[event_id].mask,
+			LPC32XX_CLKPWR_INT_RS(CLKPWR_IOBASE));
 }
 
 void lpc32xx_event_clear_all(void)
 {
 	/* Clear all latched event states */
-	writel(readl(CLKPWR_PIN_RS(CLKPWR_IOBASE)),
-		CLKPWR_PIN_RS(CLKPWR_IOBASE));
-	writel(readl(CLKPWR_INT_RS(CLKPWR_IOBASE)),
-		CLKPWR_INT_RS(CLKPWR_IOBASE));
+	writel(readl(LPC32XX_CLKPWR_PIN_RS(CLKPWR_IOBASE)),
+		LPC32XX_CLKPWR_PIN_RS(CLKPWR_IOBASE));
+	writel(readl(LPC32XX_CLKPWR_INT_RS(CLKPWR_IOBASE)),
+		LPC32XX_CLKPWR_INT_RS(CLKPWR_IOBASE));
 }
 
diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
index e4479ba..def5003 100644
--- a/arch/arm/mach-lpc32xx/serial.c
+++ b/arch/arm/mach-lpc32xx/serial.c
@@ -98,28 +98,28 @@ static struct uartinit uartinit_data[] __initdata = {
 	{
 		.uart_ck_name = "uart5_ck",
 		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 5),
-		.pdiv_clk_reg = CLKPWR_UART5_CLK_CTRL(CLKPWR_IOBASE),
+		.pdiv_clk_reg = LPC32XX_CLKPWR_UART5_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART3_ENABLE
 	{
 		.uart_ck_name = "uart3_ck",
 		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 3),
-		.pdiv_clk_reg = CLKPWR_UART3_CLK_CTRL(CLKPWR_IOBASE),
+		.pdiv_clk_reg = LPC32XX_CLKPWR_UART3_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART4_ENABLE
 	{
 		.uart_ck_name = "uart4_ck",
 		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 4),
-		.pdiv_clk_reg = CLKPWR_UART4_CLK_CTRL(CLKPWR_IOBASE),
+		.pdiv_clk_reg = LPC32XX_CLKPWR_UART4_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 #ifdef CONFIG_ARCH_LPC32XX_UART6_ENABLE
 	{
 		.uart_ck_name = "uart6_ck",
 		.ck_mode_mask = UART_CLKMODE_LOAD(UART_CLKMODE_ON, 6),
-		.pdiv_clk_reg = CLKPWR_UART6_CLK_CTRL(CLKPWR_IOBASE),
+		.pdiv_clk_reg = LPC32XX_CLKPWR_UART6_CLK_CTRL(CLKPWR_IOBASE),
 	},
 #endif
 };
@@ -144,7 +144,7 @@ void __init lpc32xx_serial_init(void)
 	int i;
 
 	/* UART clocks are off, let clock driver manage them */
-	__raw_writel(0, CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE));
+	__raw_writel(0, LPC32XX_CLKPWR_UART_CLK_CTRL(CLKPWR_IOBASE));
 
 	for (i = 0; i < ARRAY_SIZE(uartinit_data); i++) {
 		clk = clk_get(NULL, uartinit_data[i].uart_ck_name);
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index aa06be8..1d35b34 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -51,8 +51,9 @@ ENTRY(lpc32xx_sys_suspend)
 	ldr	CLKPWRBASE_REG, [WORK1_REG, #0]
 	ldr	EMCBASE_REG, [WORK1_REG, #4]
 
-	ldr	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
-	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #CLKPWR_SDRAM_SELF_RFSH
+	ldr	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_PWR_CTRL(0)]
+	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #LPC32XX_CLKPWR_SDRAM_SELF_RFSH
 
 	@ Wait for SDRAM busy status to go busy and then idle
 	@ This guarantees a small windows where DRAM isn't busy
@@ -69,10 +70,10 @@ ENTRY(lpc32xx_sys_suspend)
 
 	@ Setup self-refresh with support for manual exit of
 	@ self-refresh mode
-	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
-	orr	WORK2_REG, WORK1_REG, #CLKPWR_UPD_SDRAM_SELF_RFSH
-	str	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
-	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	orr	WORK2_REG, WORK1_REG, #LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
 
 	@ Wait for self-refresh acknowledge, clocks to the DRAM device
 	@ will automatically stop on start of self-refresh
@@ -83,23 +84,25 @@ ENTRY(lpc32xx_sys_suspend)
 	bne	3b @ Branch until self-refresh mode starts
 
 	@ Enter direct-run mode from run mode
-	bic	WORK1_REG, WORK1_REG, #CLKPWR_SELECT_RUN_MODE
-	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	bic	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_SELECT_RUN_MODE
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
 
 	@ Safe disable of DRAM clock in EMC block, prevents DDR sync
 	@ issues on restart
-	ldr	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG, #CLKPWR_HCLK_DIV(0)]
+	ldr	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLK_DIV(0)]
 	and	WORK2_REG, SAVED_HCLK_DIV_REG, #0xFFFFFE7F
-	str	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_HCLK_DIV(0)]
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLK_DIV(0)]
 
 	@ Save HCLK PLL state and disable HCLK PLL
-	ldr	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
-	bic	WORK2_REG, SAVED_HCLK_PLL_REG, #CLKPWR_HCLKPLL_POWER_UP
-	str	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
+	ldr	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
+	bic	WORK2_REG, SAVED_HCLK_PLL_REG, #LPC32XX_CLKPWR_HCLKPLL_POWER_UP
+	str	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
 
 	@ Enter stop mode until an enabled event occurs
-	orr	WORK1_REG, WORK1_REG, #CLKPWR_STOP_MODE_CTRL
-	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	orr	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_STOP_MODE_CTRL
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
 	nop
 	nop
 	nop
@@ -111,26 +114,31 @@ ENTRY(lpc32xx_sys_suspend)
 	nop
 
 	@ Clear stop status
-	bic	WORK1_REG, WORK1_REG, #CLKPWR_STOP_MODE_CTRL
+	bic	WORK1_REG, WORK1_REG, #LPC32XX_CLKPWR_STOP_MODE_CTRL
 
 	@ Restore original HCLK PLL value and wait for PLL lock
-	str	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
+	str	SAVED_HCLK_PLL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
 4:
-	ldr	WORK2_REG, [CLKPWRBASE_REG, #CLKPWR_HCLKPLL_CTRL(0)]
-	and	WORK2_REG, WORK2_REG, #CLKPWR_HCLKPLL_PLL_STS
+	ldr	WORK2_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_HCLKPLL_CTRL(0)]
+	and	WORK2_REG, WORK2_REG, #LPC32XX_CLKPWR_HCLKPLL_PLL_STS
 	bne	4b
 
 	@ Re-enter run mode with self-refresh flag cleared, but no DRAM
 	@ update yet. DRAM is still in self-refresh
-	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_PWR_CTRL(0)]
 
 	@ Restore original DRAM clock mode to restore DRAM clocks
-	str	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG, #CLKPWR_HCLK_DIV(0)]
+	str	SAVED_HCLK_DIV_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_HCLK_DIV(0)]
 
 	@ Clear self-refresh mode
-	orr	WORK1_REG, SAVED_PWR_CTRL_REG, #CLKPWR_UPD_SDRAM_SELF_RFSH
-	str	WORK1_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
-	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG, #CLKPWR_PWR_CTRL(0)]
+	orr	WORK1_REG, SAVED_PWR_CTRL_REG,\
+		#LPC32XX_CLKPWR_UPD_SDRAM_SELF_RFSH
+	str	WORK1_REG, [CLKPWRBASE_REG, #LPC32XX_CLKPWR_PWR_CTRL(0)]
+	str	SAVED_PWR_CTRL_REG, [CLKPWRBASE_REG,\
+		#LPC32XX_CLKPWR_PWR_CTRL(0)]
 
 	@ Wait for EMC to clear self-refresh mode
 5:
diff --git a/arch/arm/mach-lpc32xx/timer.c b/arch/arm/mach-lpc32xx/timer.c
index c5fa62d..35f58e2 100644
--- a/arch/arm/mach-lpc32xx/timer.c
+++ b/arch/arm/mach-lpc32xx/timer.c
@@ -132,9 +132,9 @@ static void __init lpc32xx_timer_init(void)
 	u32 clkrate, pllreg;
 
 	/* Enable timer clock */
-	writel(
-		(CLKPWR_TMRPWMCLK_TIMER0_EN | CLKPWR_TMRPWMCLK_TIMER1_EN),
-		CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE));
+	writel(LPC32XX_CLKPWR_TMRPWMCLK_TIMER0_EN |
+		LPC32XX_CLKPWR_TMRPWMCLK_TIMER1_EN,
+		LPC32XX_CLKPWR_TIMERS_PWMS_CLK_CTRL_1(CLKPWR_IOBASE));
 
 	/* The clock driver isn't initialized@this point. So determine if
 	   the SYSCLK is driven from the PLL397 or main oscillator and then use
@@ -146,7 +146,7 @@ static void __init lpc32xx_timer_init(void)
 		clkrate = 397 * LPC32XX_CLOCK_OSC_FREQ;
 
 	/* Get ARM HCLKPLL register and convert it into a frequency*/
-	pllreg = readl(CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
+	pllreg = readl(LPC32XX_CLKPWR_HCLKPLL_CTRL(CLKPWR_IOBASE)) & 0x1FFFF;
 	clkrate = clk_get_pllrate_from_reg(clkrate, pllreg);
 
 	/* Get PCLK divider and divide ARM PLL clock by it to get timer rate */
-- 
1.6.6
