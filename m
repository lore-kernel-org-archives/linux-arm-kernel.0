From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:36:00 +0100
Subject: [PATCH 09/15] ARM: S3C2443: Move parts of the clock code to common
	clock file
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-9-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To share code with some of the newer parts such as the S3C2416, move
parts of arch/arm/mach-s3c2443/clock.c to a common file called
arch/arm/plat-s3c24xx/s3c2443-clock.c.

Update the build configuration to deal with this new file.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2443/Kconfig                |    1 +
 arch/arm/mach-s3c2443/clock.c                |  452 +------------------------
 arch/arm/plat-s3c24xx/Kconfig                |    6 +
 arch/arm/plat-s3c24xx/Makefile               |    1 +
 arch/arm/plat-s3c24xx/include/plat/s3c2443.h |   19 +
 arch/arm/plat-s3c24xx/s3c2443-clock.c        |  472 ++++++++++++++++++++++++++
 6 files changed, 505 insertions(+), 446 deletions(-)
 create mode 100644 arch/arm/plat-s3c24xx/s3c2443-clock.c

diff --git a/arch/arm/mach-s3c2443/Kconfig b/arch/arm/mach-s3c2443/Kconfig
index 698140a..4fef723 100644
--- a/arch/arm/mach-s3c2443/Kconfig
+++ b/arch/arm/mach-s3c2443/Kconfig
@@ -8,6 +8,7 @@ config CPU_S3C2443
 	select S3C2443_DMA if S3C2410_DMA
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
+	select S3C2443_CLOCK
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index 76d8d66..83b1aa6 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -21,6 +21,7 @@
 */
 
 #include <linux/init.h>
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -54,111 +55,13 @@
  * set the correct muxing at initialisation
 */
 
-static int s3c2443_gate(void __iomem *reg, struct clk *clk, int enable)
-{
-	u32 ctrlbit = clk->ctrlbit;
-	u32 con = __raw_readl(reg);
-
-	if (enable)
-		con |= ctrlbit;
-	else
-		con &= ~ctrlbit;
-
-	__raw_writel(con, reg);
-	return 0;
-}
-
-static int s3c2443_clkcon_enable_h(struct clk *clk, int enable)
-{
-	return s3c2443_gate(S3C2443_HCLKCON, clk, enable);
-}
-
-static int s3c2443_clkcon_enable_p(struct clk *clk, int enable)
-{
-	return s3c2443_gate(S3C2443_PCLKCON, clk, enable);
-}
-
-static int s3c2443_clkcon_enable_s(struct clk *clk, int enable)
-{
-	return s3c2443_gate(S3C2443_SCLKCON, clk, enable);
-}
-
 /* clock selections */
 
-/* mpllref is a direct descendant of clk_xtal by default, but it is not
- * elided as the EPLL can be either sourced by the XTAL or EXTCLK and as
- * such directly equating the two source clocks is impossible.
- */
-static struct clk clk_mpllref = {
-	.name		= "mpllref",
-	.parent		= &clk_xtal,
-	.id		= -1,
-};
-
 static struct clk clk_i2s_ext = {
 	.name		= "i2s-ext",
 	.id		= -1,
 };
 
-static struct clk *clk_epllref_sources[] = {
-	[0] = &clk_mpllref,
-	[1] = &clk_mpllref,
-	[2] = &clk_xtal,
-	[3] = &clk_ext,
-};
-
-static struct clksrc_clk clk_epllref = {
-	.clk	= {
-		.name		= "epllref",
-		.id		= -1,
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_epllref_sources,
-		.nr_sources = ARRAY_SIZE(clk_epllref_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 7 },
-};
-
-static unsigned long s3c2443_getrate_mdivclk(struct clk *clk)
-{
-	unsigned long parent_rate = clk_get_rate(clk->parent);
-	unsigned long div = __raw_readl(S3C2443_CLKDIV0);
-
-	div  &= S3C2443_CLKDIV0_EXTDIV_MASK;
-	div >>= (S3C2443_CLKDIV0_EXTDIV_SHIFT-1);	/* x2 */
-
-	return parent_rate / (div + 1);
-}
-
-static struct clk clk_mdivclk = {
-	.name		= "mdivclk",
-	.parent		= &clk_mpllref,
-	.id		= -1,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s3c2443_getrate_mdivclk,
-	},
-};
-
-static struct clk *clk_msysclk_sources[] = {
-	[0] = &clk_mpllref,
-	[1] = &clk_mpll,
-	[2] = &clk_mdivclk,
-	[3] = &clk_mpllref,
-};
-
-static struct clksrc_clk clk_msysclk = {
-	.clk	= {
-		.name		= "msysclk",
-		.parent		= &clk_xtal,
-		.id		= -1,
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_msysclk_sources,
-		.nr_sources = ARRAY_SIZE(clk_msysclk_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 3 },
-};
-
 /* armdiv
  *
  * this clock is sourced from msysclk and can have a number of
@@ -266,44 +169,6 @@ static struct clksrc_clk clk_arm = {
 	.reg_src = { .reg = S3C2443_CLKDIV0, .size = 1, .shift = 13 },
 };
 
-/* esysclk
- *
- * this is sourced from either the EPLL or the EPLLref clock
-*/
-
-static struct clk *clk_sysclk_sources[] = {
-	[0] = &clk_epllref.clk,
-	[1] = &clk_epll,
-};
-
-static struct clksrc_clk clk_esysclk = {
-	.clk	= {
-		.name		= "esysclk",
-		.parent		= &clk_epll,
-		.id		= -1,
-	},
-	.sources = &(struct clksrc_sources) {
-		.sources = clk_sysclk_sources,
-		.nr_sources = ARRAY_SIZE(clk_sysclk_sources),
-	},
-	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 6 },
-};
-
-/* uartclk
- *
- * UART baud-rate clock sourced from esysclk via a divisor
-*/
-
-static struct clksrc_clk clk_uart = {
-	.clk	= {
-		.name		= "uartclk",
-		.id		= -1,
-		.parent		= &clk_esysclk.clk,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 8 },
-};
-
-
 /* hsspi
  *
  * high-speed spi clock, sourced from esysclk
@@ -320,21 +185,6 @@ static struct clksrc_clk clk_hsspi = {
 	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 4 },
 };
 
-/* usbhost
- *
- * usb host bus-clock, usually 48MHz to provide USB bus clock timing
-*/
-
-static struct clksrc_clk clk_usb_bus_host = {
-	.clk	= {
-		.name		= "usb-bus-host-parent",
-		.id		= -1,
-		.parent		= &clk_esysclk.clk,
-		.ctrlbit	= S3C2443_SCLKCON_USBHOST,
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 4 },
-};
 
 /* clk_hsmcc_div
  *
@@ -433,89 +283,16 @@ static struct clksrc_clk clk_i2s = {
 	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 14 },
 };
 
-/* cam-if
- *
- * camera interface bus-clock, divided down from esysclk
-*/
-
-static struct clksrc_clk clk_cam = {
-	.clk	= {
-		.name		= "camif-upll",	/* same as 2440 name */
-		.id		= -1,
-		.parent		= &clk_esysclk.clk,
-		.ctrlbit	= S3C2443_SCLKCON_CAMCLK,
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 26 },
-};
-
-/* display-if
- *
- * display interface clock, divided from esysclk
-*/
-
-static struct clksrc_clk clk_display = {
-	.clk	= {
-		.name		= "display-if",
-		.id		= -1,
-		.parent		= &clk_esysclk.clk,
-		.ctrlbit	= S3C2443_SCLKCON_DISPCLK,
-		.enable		= s3c2443_clkcon_enable_s,
-	},
-	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 8, .shift = 16 },
-};
-
-/* prediv
- *
- * this divides the msysclk down to pass to h/p/etc.
- */
-
-static unsigned long s3c2443_prediv_getrate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
-
-	clkdiv0 &= S3C2443_CLKDIV0_PREDIV_MASK;
-	clkdiv0 >>= S3C2443_CLKDIV0_PREDIV_SHIFT;
-
-	return rate / (clkdiv0 + 1);
-}
-
-static struct clk clk_prediv = {
-	.name		= "prediv",
-	.id		= -1,
-	.parent		= &clk_msysclk.clk,
-	.ops		= &(struct clk_ops) {
-		.get_rate	= s3c2443_prediv_getrate,
-	},
-};
-
 /* standard clock definitions */
 
 static struct clk init_clocks_off[] = {
 	{
-		.name		= "nand",
-		.id		= -1,
-		.parent		= &clk_h,
-	}, {
 		.name		= "sdi",
 		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_SDI,
 	}, {
-		.name		= "adc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_ADC,
-	}, {
-		.name		= "i2c",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_IIC,
-	}, {
 		.name		= "iis",
 		.id		= -1,
 		.parent		= &clk_p,
@@ -537,179 +314,12 @@ static struct clk init_clocks_off[] = {
 };
 
 static struct clk init_clocks[] = {
-	{
-		.name		= "dma",
-		.id		= 0,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA0,
-	}, {
-		.name		= "dma",
-		.id		= 1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA1,
-	}, {
-		.name		= "dma",
-		.id		= 2,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA2,
-	}, {
-		.name		= "dma",
-		.id		= 3,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA3,
-	}, {
-		.name		= "dma",
-		.id		= 4,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA4,
-	}, {
-		.name		= "dma",
-		.id		= 5,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_DMA5,
-	}, {
-		.name		= "lcd",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_LCDC,
-	}, {
-		.name		= "gpio",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_GPIO,
-	}, {
-		.name		= "usb-host",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_USBH,
-	}, {
-		.name		= "usb-device",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_USBD,
-	}, {
-		.name		= "hsmmc",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_HSMMC,
-	}, {
-		.name		= "cfc",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_CFC,
-	}, {
-		.name		= "ssmc",
-		.id		= -1,
-		.parent		= &clk_h,
-		.enable		= s3c2443_clkcon_enable_h,
-		.ctrlbit	= S3C2443_HCLKCON_SSMC,
-	}, {
-		.name		= "timers",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_PWMT,
-	}, {
-		.name		= "uart",
-		.id		= 0,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART0,
-	}, {
-		.name		= "uart",
-		.id		= 1,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART1,
-	}, {
-		.name		= "uart",
-		.id		= 2,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART2,
-	}, {
-		.name		= "uart",
-		.id		= 3,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_UART3,
-	}, {
-		.name		= "rtc",
-		.id		= -1,
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_RTC,
-	}, {
-		.name		= "watchdog",
-		.id		= -1,
-		.parent		= &clk_p,
-		.ctrlbit	= S3C2443_PCLKCON_WDT,
-	}, {
-		.name		= "usb-bus-host",
-		.id		= -1,
-		.parent		= &clk_usb_bus_host.clk,
-	}, {
-		.name		= "ac97",
-		.id		= -1,
-		.parent		= &clk_p,
-		.ctrlbit	= S3C2443_PCLKCON_AC97,
-	}
 };
 
-/* clocks to add where we need to check their parentage */
-
-static struct clksrc_clk __initdata *init_list[] = {
-	&clk_epllref, /* should be first */
-	&clk_esysclk,
-	&clk_msysclk,
-	&clk_arm,
-	&clk_i2s_eplldiv,
-	&clk_i2s,
-	&clk_cam,
-	&clk_uart,
-	&clk_display,
-	&clk_hsmmc_div,
-	&clk_usb_bus_host,
-};
-
-static void __init s3c2443_clk_initparents(void)
-{
-	int ptr;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(init_list); ptr++)
-		s3c_set_clksrc(init_list[ptr], true);
-}
-
-static inline unsigned long s3c2443_get_hdiv(unsigned long clkcon0)
-{
-	clkcon0 &= S3C2443_CLKDIV0_HCLKDIV_MASK;
-
-	return clkcon0 + 1;
-}
-
 /* clocks to add straight away */
 
 static struct clksrc_clk *clksrcs[] __initdata = {
-	&clk_usb_bus_host,
-	&clk_epllref,
-	&clk_esysclk,
-	&clk_msysclk,
 	&clk_arm,
-	&clk_uart,
-	&clk_display,
-	&clk_cam,
 	&clk_i2s_eplldiv,
 	&clk_i2s,
 	&clk_hsspi,
@@ -717,46 +327,13 @@ static struct clksrc_clk *clksrcs[] __initdata = {
 };
 
 static struct clk *clks[] __initdata = {
-	&clk_ext,
-	&clk_epll,
-	&clk_usb_bus,
-	&clk_mpllref,
 	&clk_hsmmc,
 	&clk_armdiv,
-	&clk_prediv,
 };
 
 void __init_or_cpufreq s3c2443_setup_clocks(void)
 {
-	unsigned long mpllcon = __raw_readl(S3C2443_MPLLCON);
-	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
-	struct clk *xtal_clk;
-	unsigned long xtal;
-	unsigned long pll;
-	unsigned long fclk;
-	unsigned long hclk;
-	unsigned long pclk;
-
-	xtal_clk = clk_get(NULL, "xtal");
-	xtal = clk_get_rate(xtal_clk);
-	clk_put(xtal_clk);
-
-	pll = s3c2443_get_mpll(mpllcon, xtal);
-	clk_msysclk.clk.rate = pll;
-
-	fclk = pll / s3c2443_fclk_div(clkdiv0);
-	hclk = s3c2443_prediv_getrate(&clk_prediv);
-	hclk /= s3c2443_get_hdiv(clkdiv0);
- 	pclk = hclk / ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 2 : 1);
-
-	s3c24xx_setup_clocks(fclk, hclk, pclk);
-
-	printk("S3C2443: mpll %s %ld.%03ld MHz, cpu %ld.%03ld MHz, mem %ld.%03ld MHz, pclk %ld.%03ld MHz\n",
-	       (mpllcon & S3C2443_PLLCON_OFF) ? "off":"on",
-	       print_mhz(pll), print_mhz(fclk),
-	       print_mhz(hclk), print_mhz(pclk));
-
-	s3c24xx_setup_clocks(fclk, hclk, pclk);
+	s3c2443_common_setup_clocks(s3c2443_get_mpll, s3c2443_fclk_div);
 }
 
 void __init s3c2443_init_clocks(int xtal)
@@ -764,35 +341,18 @@ void __init s3c2443_init_clocks(int xtal)
 	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
 	int ptr;
 
-	/* s3c2443 parents h and p clocks from prediv */
-	clk_h.parent = &clk_prediv;
-	clk_p.parent = &clk_prediv;
+	clk_epll.rate = s3c2443_get_epll(epllcon, xtal);
+	clk_epll.parent = &clk_epllref.clk;
+
+	s3c2443_common_init_clocks(xtal, s3c2443_get_mpll, s3c2443_fclk_div);
 
-	s3c24xx_register_baseclocks(xtal);
 	s3c2443_setup_clocks();
-	s3c2443_clk_initparents();
 
 	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
 
 	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
 		s3c_register_clksrc(clksrcs[ptr], 1);
 
-	clk_epll.rate = s3c2443_get_epll(epllcon, xtal);
-	clk_epll.parent = &clk_epllref.clk;
-	clk_usb_bus.parent = &clk_usb_bus_host.clk;
-
-	/* ensure usb bus clock is within correct rate of 48MHz */
-
-	if (clk_get_rate(&clk_usb_bus_host.clk) != (48 * 1000 * 1000)) {
-		printk(KERN_INFO "Warning: USB host bus not at 48MHz\n");
-		clk_set_rate(&clk_usb_bus_host.clk, 48*1000*1000);
-	}
-
-	printk("S3C2443: epll %s %ld.%03ld MHz, usb-bus %ld.%03ld MHz\n",
-	       (epllcon & S3C2443_PLLCON_OFF) ? "off":"on",
-	       print_mhz(clk_get_rate(&clk_epll)),
-	       print_mhz(clk_get_rate(&clk_usb_bus)));
-
 	/* register clocks from clock array */
 
 	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index a830fad..3ce8f01 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -45,6 +45,12 @@ config S3C2410_CLOCK
 	  Clock code for the S3C2410, and similar processors which
 	  is currently includes the S3C2410, S3C2440, S3C2442.
 
+config S3C2443_CLOCK
+	bool
+	help
+	  Clock code for the S3C2443 and similar processors, which includes
+	  the S3C2416 and S3C2450.
+
 config S3C24XX_DCLK
 	bool
 	help
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index c2237c4..44aea88 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
+obj-$(CONFIG_S3C2443_CLOCK)	+= s3c2443-clock.o
 obj-$(CONFIG_S3C2410_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
diff --git a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h b/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
index 815b107..a19715f 100644
--- a/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
+++ b/arch/arm/plat-s3c24xx/include/plat/s3c2443.h
@@ -30,3 +30,22 @@ extern  int s3c2443_baseclk_add(void);
 #define s3c2443_map_io NULL
 #define s3c2443_init NULL
 #endif
+
+/* common code used by s3c2443 and others.
+ * note, not to be used outside of arch/arm/mach-s3c* */
+
+struct clk;	/* some files don't need clk.h otherwise */
+
+typedef unsigned int (*pll_fn)(unsigned int reg, unsigned int base);
+typedef unsigned int (*fdiv_fn)(unsigned long clkcon0);
+
+extern void s3c2443_common_setup_clocks(pll_fn get_mpll, fdiv_fn fdiv);
+extern void s3c2443_common_init_clocks(int xtal, pll_fn get_mpll, fdiv_fn fdiv);
+
+extern int s3c2443_clkcon_enable_h(struct clk *clk, int enable);
+extern int s3c2443_clkcon_enable_p(struct clk *clk, int enable);
+extern int s3c2443_clkcon_enable_s(struct clk *clk, int enable);
+
+extern struct clksrc_clk clk_epllref;
+extern struct clksrc_clk clk_esysclk;
+extern struct clksrc_clk clk_msysclk;
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
new file mode 100644
index 0000000..461f070
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -0,0 +1,472 @@
+/* linux/arch/arm/plat-s3c24xx/s3c2443-clock.c
+ *
+ * Copyright (c) 2007, 2010 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C2443 Clock control suport - common code
+ */
+
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <mach/regs-s3c2443-clock.h>
+
+#include <plat/s3c2443.h>
+#include <plat/clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/cpu.h>
+
+#include <plat/cpu-freq.h>
+
+
+static int s3c2443_gate(void __iomem *reg, struct clk *clk, int enable)
+{
+	u32 ctrlbit = clk->ctrlbit;
+	u32 con = __raw_readl(reg);
+
+	if (enable)
+		con |= ctrlbit;
+	else
+		con &= ~ctrlbit;
+
+	__raw_writel(con, reg);
+	return 0;
+}
+
+int s3c2443_clkcon_enable_h(struct clk *clk, int enable)
+{
+	return s3c2443_gate(S3C2443_HCLKCON, clk, enable);
+}
+
+int s3c2443_clkcon_enable_p(struct clk *clk, int enable)
+{
+	return s3c2443_gate(S3C2443_PCLKCON, clk, enable);
+}
+
+int s3c2443_clkcon_enable_s(struct clk *clk, int enable)
+{
+	return s3c2443_gate(S3C2443_SCLKCON, clk, enable);
+}
+
+/* mpllref is a direct descendant of clk_xtal by default, but it is not
+ * elided as the EPLL can be either sourced by the XTAL or EXTCLK and as
+ * such directly equating the two source clocks is impossible.
+ */
+struct clk clk_mpllref = {
+	.name		= "mpllref",
+	.parent		= &clk_xtal,
+	.id		= -1,
+};
+
+static struct clk *clk_epllref_sources[] = {
+	[0] = &clk_mpllref,
+	[1] = &clk_mpllref,
+	[2] = &clk_xtal,
+	[3] = &clk_ext,
+};
+
+struct clksrc_clk clk_epllref = {
+	.clk	= {
+		.name		= "epllref",
+		.id		= -1,
+	},
+	.sources = &(struct clksrc_sources) {
+		.sources = clk_epllref_sources,
+		.nr_sources = ARRAY_SIZE(clk_epllref_sources),
+	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 7 },
+};
+
+/* esysclk
+ *
+ * this is sourced from either the EPLL or the EPLLref clock
+*/
+
+static struct clk *clk_sysclk_sources[] = {
+	[0] = &clk_epllref.clk,
+	[1] = &clk_epll,
+};
+
+struct clksrc_clk clk_esysclk = {
+	.clk	= {
+		.name		= "esysclk",
+		.parent		= &clk_epll,
+		.id		= -1,
+	},
+	.sources = &(struct clksrc_sources) {
+		.sources = clk_sysclk_sources,
+		.nr_sources = ARRAY_SIZE(clk_sysclk_sources),
+	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 1, .shift = 6 },
+};
+
+static unsigned long s3c2443_getrate_mdivclk(struct clk *clk)
+{
+	unsigned long parent_rate = clk_get_rate(clk->parent);
+	unsigned long div = __raw_readl(S3C2443_CLKDIV0);
+
+	div  &= S3C2443_CLKDIV0_EXTDIV_MASK;
+	div >>= (S3C2443_CLKDIV0_EXTDIV_SHIFT-1);	/* x2 */
+
+	return parent_rate / (div + 1);
+}
+
+static struct clk clk_mdivclk = {
+	.name		= "mdivclk",
+	.parent		= &clk_mpllref,
+	.id		= -1,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_getrate_mdivclk,
+	},
+};
+
+static struct clk *clk_msysclk_sources[] = {
+	[0] = &clk_mpllref,
+	[1] = &clk_mpll,
+	[2] = &clk_mdivclk,
+	[3] = &clk_mpllref,
+};
+
+struct clksrc_clk clk_msysclk = {
+	.clk	= {
+		.name		= "msysclk",
+		.parent		= &clk_xtal,
+		.id		= -1,
+	},
+	.sources = &(struct clksrc_sources) {
+		.sources = clk_msysclk_sources,
+		.nr_sources = ARRAY_SIZE(clk_msysclk_sources),
+	},
+	.reg_src = { .reg = S3C2443_CLKSRC, .size = 2, .shift = 3 },
+};
+
+/* prediv
+ *
+ * this divides the msysclk down to pass to h/p/etc.
+ */
+
+static unsigned long s3c2443_prediv_getrate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
+
+	clkdiv0 &= S3C2443_CLKDIV0_PREDIV_MASK;
+	clkdiv0 >>= S3C2443_CLKDIV0_PREDIV_SHIFT;
+
+	return rate / (clkdiv0 + 1);
+}
+
+static struct clk clk_prediv = {
+	.name		= "prediv",
+	.id		= -1,
+	.parent		= &clk_msysclk.clk,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2443_prediv_getrate,
+	},
+};
+
+/* usbhost
+ *
+ * usb host bus-clock, usually 48MHz to provide USB bus clock timing
+*/
+
+static struct clksrc_clk clk_usb_bus_host = {
+	.clk	= {
+		.name		= "usb-bus-host-parent",
+		.id		= -1,
+		.parent		= &clk_esysclk.clk,
+		.ctrlbit	= S3C2443_SCLKCON_USBHOST,
+		.enable		= s3c2443_clkcon_enable_s,
+	},
+	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 4 },
+};
+
+/* common clksrc clocks */
+
+static struct clksrc_clk clksrc_clks[] = {
+	{
+		/* ART baud-rate clock sourced from esysclk via a divisor */
+		.clk	= {
+			.name		= "uartclk",
+			.id		= -1,
+			.parent		= &clk_esysclk.clk,
+		},
+		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 8 },
+	}, {
+		/* camera interface bus-clock, divided down from esysclk */
+		.clk	= {
+			.name		= "camif-upll",	/* same as 2440 name */
+			.id		= -1,
+			.parent		= &clk_esysclk.clk,
+			.ctrlbit	= S3C2443_SCLKCON_CAMCLK,
+			.enable		= s3c2443_clkcon_enable_s,
+		},
+		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 26 },
+	}, {
+		.clk	= {
+			.name		= "display-if",
+			.id		= -1,
+			.parent		= &clk_esysclk.clk,
+			.ctrlbit	= S3C2443_SCLKCON_DISPCLK,
+			.enable		= s3c2443_clkcon_enable_s,
+		},
+		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 8, .shift = 16 },
+	},
+};
+
+
+static struct clk init_clocks_off[] = {
+	{
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_ADC,
+	}, {
+		.name		= "i2c",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_IIC,
+	}
+};
+
+static struct clk init_clocks[] = {
+	{
+		.name		= "dma",
+		.id		= 0,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_DMA0,
+	}, {
+		.name		= "dma",
+		.id		= 1,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_DMA1,
+	}, {
+		.name		= "dma",
+		.id		= 2,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_DMA2,
+	}, {
+		.name		= "dma",
+		.id		= 3,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_DMA3,
+	}, {
+		.name		= "dma",
+		.id		= 4,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_DMA4,
+	}, {
+		.name		= "dma",
+		.id		= 5,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_DMA5,
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_HSMMC,
+	}, {
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_GPIO,
+	}, {
+		.name		= "usb-host",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_USBH,
+	}, {
+		.name		= "usb-device",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_USBD,
+	}, {
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_LCDC,
+
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_PWMT,
+	}, {
+		.name		= "cfc",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_CFC,
+	}, {
+		.name		= "ssmc",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s3c2443_clkcon_enable_h,
+		.ctrlbit	= S3C2443_HCLKCON_SSMC,
+	}, {
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_UART0,
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_UART1,
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_UART2,
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_UART3,
+	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c2443_clkcon_enable_p,
+		.ctrlbit	= S3C2443_PCLKCON_RTC,
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_p,
+		.ctrlbit	= S3C2443_PCLKCON_WDT,
+	}, {
+		.name		= "ac97",
+		.id		= -1,
+		.parent		= &clk_p,
+		.ctrlbit	= S3C2443_PCLKCON_AC97,
+	}, {
+		.name		= "nand",
+		.id		= -1,
+		.parent		= &clk_h,
+	}, {
+		.name		= "usb-bus-host",
+		.id		= -1,
+		.parent		= &clk_usb_bus_host.clk,
+	}
+};
+
+static inline unsigned long s3c2443_get_hdiv(unsigned long clkcon0)
+{
+	clkcon0 &= S3C2443_CLKDIV0_HCLKDIV_MASK;
+
+	return clkcon0 + 1;
+}
+
+/* EPLLCON compatible enough to get on/off information */
+
+void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll,
+						   fdiv_fn get_fdiv)
+{
+	unsigned long epllcon = __raw_readl(S3C2443_EPLLCON);
+	unsigned long mpllcon = __raw_readl(S3C2443_MPLLCON);
+	unsigned long clkdiv0 = __raw_readl(S3C2443_CLKDIV0);
+	struct clk *xtal_clk;
+	unsigned long xtal;
+	unsigned long pll;
+	unsigned long fclk;
+	unsigned long hclk;
+	unsigned long pclk;
+	int ptr;
+
+	xtal_clk = clk_get(NULL, "xtal");
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	pll = get_mpll(mpllcon, xtal);
+	clk_msysclk.clk.rate = pll;
+
+	fclk = pll / get_fdiv(clkdiv0);
+	hclk = s3c2443_prediv_getrate(&clk_prediv);
+	hclk /= s3c2443_get_hdiv(clkdiv0);
+	pclk = hclk / ((clkdiv0 & S3C2443_CLKDIV0_HALF_PCLK) ? 2 : 1);
+
+	s3c24xx_setup_clocks(fclk, hclk, pclk);
+
+	printk("CPU: MPLL %s %ld.%03ld MHz, cpu %ld.%03ld MHz, mem %ld.%03ld MHz, pclk %ld.%03ld MHz\n",
+	       (mpllcon & S3C2443_PLLCON_OFF) ? "off":"on",
+	       print_mhz(pll), print_mhz(fclk),
+	       print_mhz(hclk), print_mhz(pclk));
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrc_clks); ptr++)
+		s3c_set_clksrc(&clksrc_clks[ptr], true);
+
+	/* ensure usb bus clock is within correct rate of 48MHz */
+
+	if (clk_get_rate(&clk_usb_bus_host.clk) != (48 * 1000 * 1000)) {
+		printk(KERN_INFO "Warning: USB host bus not at 48MHz\n");
+		clk_set_rate(&clk_usb_bus_host.clk, 48*1000*1000);
+	}
+
+	printk("CPU: EPLL %s %ld.%03ld MHz, usb-bus %ld.%03ld MHz\n",
+	       (epllcon & S3C2443_PLLCON_OFF) ? "off":"on",
+	       print_mhz(clk_get_rate(&clk_epll)),
+	       print_mhz(clk_get_rate(&clk_usb_bus)));
+}
+
+static struct clk *clks[] __initdata = {
+	&clk_prediv,
+	&clk_mpllref,
+	&clk_mdivclk,
+	&clk_ext,
+	&clk_epll,
+	&clk_usb_bus,
+};
+
+static struct clksrc_clk *clksrcs[] __initdata = {
+	&clk_usb_bus_host,
+	&clk_epllref,
+	&clk_esysclk,
+	&clk_msysclk,
+};
+
+void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
+				       fdiv_fn get_fdiv)
+{
+	int ptr;
+
+	/* s3c2443 parents h and p clocks from prediv */
+	clk_h.parent = &clk_prediv;
+	clk_p.parent = &clk_prediv;
+
+	clk_usb_bus.parent = &clk_usb_bus_host.clk;
+	clk_epll.parent = &clk_epllref.clk;
+
+	s3c24xx_register_baseclocks(xtal);
+	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_register_clksrc(clksrcs[ptr], 1);
+
+	s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clks));
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+
+	/* See s3c2443/etc notes on disabling clocks@init time */
+	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
+
+	s3c2443_common_setup_clocks(get_mpll, get_fdiv);
+}
-- 
1.6.3.3
