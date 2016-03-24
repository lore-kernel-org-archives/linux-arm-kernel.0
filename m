From: david@lechnology.com (David Lechner)
Date: Thu, 24 Mar 2016 18:51:31 -0500
Subject: [PATCH v3 06/16] ARM: davinci: da850: use clk->set_parent for async3
In-Reply-To: <1458863503-31121-1-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
Message-ID: <1458863503-31121-7-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The da850 family of processors has an async3 clock domain that can be
muxed to either pll0_sysclk2 or pll1_sysclk2. Now that the davinci clocks
have a set_parent callback, we can use this to control the async3 mux
instead of a stand-alone function.

This adds a new async3_clk and sets the appropriate child clocks. The
default is use to pll1_sysclk2 since it is not affected by processor
frequency scaling.

Signed-off-by: David Lechner <david@lechnology.com>
---

v3 changes: 

* Does not use ioremap in da850_async3_set_parent(). This works now becuase the
  clock init has been moved.
* Fixed copy/paste error in a comment.



 arch/arm/mach-davinci/da850.c | 82 ++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9f46706..10bfbed 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -34,9 +34,6 @@
 #include "clock.h"
 #include "mux.h"
 
-/* SoC specific clock flags */
-#define DA850_CLK_ASYNC3	BIT(16)
-
 #define DA850_PLL1_BASE		0x01e1a000
 #define DA850_TIMER64P2_BASE	0x01f0c000
 #define DA850_TIMER64P3_BASE	0x01f0d000
@@ -161,6 +158,33 @@ static struct clk pll1_sysclk3 = {
 	.div_reg	= PLLDIV3,
 };
 
+static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 val;
+
+	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+
+	/* Set the Async3 clock domain mux based on the parent clock. */
+	if (parent == &pll0_sysclk2)
+		val &= ~CFGCHIP3_ASYNC3_CLKSRC;
+	else if (parent == &pll1_sysclk2)
+		val |= CFGCHIP3_ASYNC3_CLKSRC;
+	else {
+		pr_err("Bad parent on async3 clock mux.\n");
+		return -EINVAL;
+	}
+
+	writel(val, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
+
+	return 0;
+}
+
+static struct clk async3_clk = {
+	.name		= "async3",
+	.parent		= &pll1_sysclk2,
+	.set_parent	= da850_async3_set_parent,
+};
+
 static struct clk i2c0_clk = {
 	.name		= "i2c0",
 	.parent		= &pll0_aux_clk,
@@ -234,18 +258,16 @@ static struct clk uart0_clk = {
 
 static struct clk uart1_clk = {
 	.name		= "uart1",
-	.parent		= &pll0_sysclk2,
+	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_UART1,
 	.gpsc		= 1,
-	.flags		= DA850_CLK_ASYNC3,
 };
 
 static struct clk uart2_clk = {
 	.name		= "uart2",
-	.parent		= &pll0_sysclk2,
+	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_UART2,
 	.gpsc		= 1,
-	.flags		= DA850_CLK_ASYNC3,
 };
 
 static struct clk aintc_clk = {
@@ -300,10 +322,9 @@ static struct clk emac_clk = {
 
 static struct clk mcasp_clk = {
 	.name		= "mcasp",
-	.parent		= &pll0_sysclk2,
+	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_McASP0,
 	.gpsc		= 1,
-	.flags		= DA850_CLK_ASYNC3,
 };
 
 static struct clk lcdc_clk = {
@@ -355,10 +376,9 @@ static struct clk spi0_clk = {
 
 static struct clk spi1_clk = {
 	.name		= "spi1",
-	.parent		= &pll0_sysclk2,
+	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_SPI1,
 	.gpsc		= 1,
-	.flags		= DA850_CLK_ASYNC3,
 };
 
 static struct clk vpif_clk = {
@@ -386,10 +406,9 @@ static struct clk dsp_clk = {
 
 static struct clk ehrpwm_clk = {
 	.name		= "ehrpwm",
-	.parent		= &pll0_sysclk2,
+	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_PWM,
 	.gpsc		= 1,
-	.flags		= DA850_CLK_ASYNC3,
 };
 
 #define DA8XX_EHRPWM_TBCLKSYNC	BIT(12)
@@ -421,10 +440,9 @@ static struct clk ehrpwm_tbclk = {
 
 static struct clk ecap_clk = {
 	.name		= "ecap",
-	.parent		= &pll0_sysclk2,
+	.parent		= &async3_clk,
 	.lpsc		= DA8XX_LPSC1_ECAP,
 	.gpsc		= 1,
-	.flags		= DA850_CLK_ASYNC3,
 };
 
 static struct clk_lookup da850_clks[] = {
@@ -442,6 +460,7 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"pll1_aux",	&pll1_aux_clk),
 	CLK(NULL,		"pll1_sysclk2",	&pll1_sysclk2),
 	CLK(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
+	CLK(NULL,		"async3",	&async3_clk),
 	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
 	CLK(NULL,		"timer0",	&timerp64_0_clk),
 	CLK("davinci-wdt",	NULL,		&timerp64_1_clk),
@@ -909,30 +928,6 @@ static struct davinci_timer_info da850_timer_info = {
 	.clocksource_id	= T0_TOP,
 };
 
-static void da850_set_async3_src(int pllnum)
-{
-	struct clk *clk, *newparent = pllnum ? &pll1_sysclk2 : &pll0_sysclk2;
-	struct clk_lookup *c;
-	unsigned int v;
-	int ret;
-
-	for (c = da850_clks; c->clk; c++) {
-		clk = c->clk;
-		if (clk->flags & DA850_CLK_ASYNC3) {
-			ret = clk_set_parent(clk, newparent);
-			WARN(ret, "DA850: unable to re-parent clock %s",
-								clk->name);
-		}
-       }
-
-	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-	if (pllnum)
-		v |= CFGCHIP3_ASYNC3_CLKSRC;
-	else
-		v &= ~CFGCHIP3_ASYNC3_CLKSRC;
-	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
-}
-
 #ifdef CONFIG_CPU_FREQ
 /*
  * Notes:
@@ -1328,15 +1323,6 @@ void __init da850_init(void)
 	if (WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module"))
 		return;
 
-	/*
-	 * Move the clock source of Async3 domain to PLL1 SYSCLK2.
-	 * This helps keeping the peripherals on this domain insulated
-	 * from CPU frequency changes caused by DVFS. The firmware sets
-	 * both PLL0 and PLL1 to the same frequency so, there should not
-	 * be any noticeable change even in non-DVFS use cases.
-	 */
-	da850_set_async3_src(1);
-
 	/* Unlock writing to PLL0 registers */
 	v = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG));
 	v &= ~CFGCHIP0_PLL_MASTER_LOCK;
-- 
1.9.1
