From: stigge@antcom.de (Roland Stigge)
Date: Mon, 30 Jan 2012 17:02:01 +0100
Subject: [PATCH v2 2/7] LPC32xx: clock.c: jiffies wrapping
In-Reply-To: <1327939327-7799-1-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
Message-ID: <1327939327-7799-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the jiffies wrapping bug in clock.c.

It corrects the timeout computation based on jiffies, uses time_before() for
correct wrapping handling and replaces a binary "&" which should really be a
logical "&&" in a truth expression.

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 8e79313..f64c9a1 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -128,7 +128,7 @@ static struct clk osc_32KHz = {
 static int local_pll397_enable(struct clk *clk, int enable)
 {
 	u32 reg;
-	unsigned long timeout = 1 + msecs_to_jiffies(10);
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
 
 	reg = __raw_readl(LPC32XX_CLKPWR_PLL397_CTRL);
 
@@ -143,7 +143,7 @@ static int local_pll397_enable(struct clk *clk, int enable)
 		/* Wait for PLL397 lock */
 		while (((__raw_readl(LPC32XX_CLKPWR_PLL397_CTRL) &
 			LPC32XX_CLKPWR_SYSCTRL_PLL397_STS) == 0) &&
-			(timeout > jiffies))
+			time_before(jiffies, timeout))
 			cpu_relax();
 
 		if ((__raw_readl(LPC32XX_CLKPWR_PLL397_CTRL) &
@@ -157,7 +157,7 @@ static int local_pll397_enable(struct clk *clk, int enable)
 static int local_oscmain_enable(struct clk *clk, int enable)
 {
 	u32 reg;
-	unsigned long timeout = 1 + msecs_to_jiffies(10);
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
 
 	reg = __raw_readl(LPC32XX_CLKPWR_MAIN_OSC_CTRL);
 
@@ -172,7 +172,7 @@ static int local_oscmain_enable(struct clk *clk, int enable)
 		/* Wait for main oscillator to start */
 		while (((__raw_readl(LPC32XX_CLKPWR_MAIN_OSC_CTRL) &
 			LPC32XX_CLKPWR_MOSC_DISABLE) != 0) &&
-			(timeout > jiffies))
+			time_before(jiffies, timeout))
 			cpu_relax();
 
 		if ((__raw_readl(LPC32XX_CLKPWR_MAIN_OSC_CTRL) &
@@ -384,7 +384,7 @@ static int local_usbpll_enable(struct clk *clk, int enable)
 {
 	u32 reg;
 	int ret = -ENODEV;
-	unsigned long timeout = 1 + msecs_to_jiffies(10);
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
 
 	reg = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
 
@@ -397,7 +397,7 @@ static int local_usbpll_enable(struct clk *clk, int enable)
 		__raw_writel(reg, LPC32XX_CLKPWR_USB_CTRL);
 
 		/* Wait for PLL lock */
-		while ((timeout > jiffies) & (ret == -ENODEV)) {
+		while (time_before(jiffies, timeout) && (ret == -ENODEV)) {
 			reg = __raw_readl(LPC32XX_CLKPWR_USB_CTRL);
 			if (reg & LPC32XX_CLKPWR_USBCTRL_PLL_STS)
 				ret = 0;
