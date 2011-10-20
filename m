From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 20 Oct 2011 17:14:28 +0530
Subject: [PATCH] ARM: davinci: Use CLKDEV_INIT for creating clk_lookup
Message-ID: <1319111068-27669-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A common macro CLKDEV_INIT was added for creating clk_lookup
instance in include/linux/clkdev.h. So replace CLK macro with
CLKDEV_INIT.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |    5 +-
 arch/arm/mach-davinci/clock.h            |    7 --
 arch/arm/mach-davinci/da830.c            |  101 +++++++++++-----------
 arch/arm/mach-davinci/da850.c            |   95 +++++++++++-----------
 arch/arm/mach-davinci/dm355.c            |   87 ++++++++++----------
 arch/arm/mach-davinci/dm365.c            |  113 +++++++++++++-------------
 arch/arm/mach-davinci/dm644x.c           |   77 +++++++++---------
 arch/arm/mach-davinci/dm646x.c           |   81 +++++++++---------
 arch/arm/mach-davinci/tnetv107x.c        |  133 +++++++++++++++---------------
 9 files changed, 350 insertions(+), 349 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index e574d7f..63951d0 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/at24.h>
 #include <linux/i2c/pcf857x.h>
+#include <linux/clkdev.h>
 
 #include <media/tvp514x.h>
 
@@ -704,8 +705,8 @@ static struct clk cdce_clk_in = {
 };
 
 static struct clk_lookup cdce_clks[] = {
-	CLK(NULL, "xin", &cdce_clk_in),
-	CLK(NULL, NULL, NULL),
+	CLKDEV_INIT(NULL, "xin", &cdce_clk_in),
+	CLKDEV_INIT(NULL, NULL, NULL),
 };
 
 static void __init cdce_clk_init(void)
diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index a705f36..df153d5 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -113,13 +113,6 @@ struct clk {
 #define PSC_SWRSTDISABLE	BIT(6) /* Disable state is SwRstDisable */
 #define PSC_FORCE		BIT(7) /* Force module state transtition */
 
-#define CLK(dev, con, ck) 	\
-	{			\
-		.dev_id = dev,	\
-		.con_id = con,	\
-		.clk = ck,	\
-	}			\
-
 int davinci_clk_init(struct clk_lookup *clocks);
 int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index a6bf5dc..f2f359b 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -11,6 +11,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach/map.h>
 
@@ -374,56 +375,56 @@ static struct clk rmii_clk = {
 };
 
 static struct clk_lookup da830_clks[] = {
-	CLK(NULL,		"ref",		&ref_clk),
-	CLK(NULL,		"pll0",		&pll0_clk),
-	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
-	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
-	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
-	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
-	CLK(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
-	CLK(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
-	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
-	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
-	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("watchdog",		NULL,		&timerp64_1_clk),
-	CLK(NULL,		"arm_rom",	&arm_rom_clk),
-	CLK(NULL,		"scr0_ss",	&scr0_ss_clk),
-	CLK(NULL,		"scr1_ss",	&scr1_ss_clk),
-	CLK(NULL,		"scr2_ss",	&scr2_ss_clk),
-	CLK(NULL,		"dmax",		&dmax_clk),
-	CLK(NULL,		"tpcc",		&tpcc_clk),
-	CLK(NULL,		"tptc0",	&tptc0_clk),
-	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK("davinci_mmc.0",	NULL,		&mmcsd_clk),
-	CLK(NULL,		"uart0",	&uart0_clk),
-	CLK(NULL,		"uart1",	&uart1_clk),
-	CLK(NULL,		"uart2",	&uart2_clk),
-	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-	CLK(NULL,		"ecap0",	&ecap0_clk),
-	CLK(NULL,		"ecap1",	&ecap1_clk),
-	CLK(NULL,		"ecap2",	&ecap2_clk),
-	CLK(NULL,		"pwm0",		&pwm0_clk),
-	CLK(NULL,		"pwm1",		&pwm1_clk),
-	CLK(NULL,		"pwm2",		&pwm2_clk),
-	CLK("eqep.0",		NULL,		&eqep0_clk),
-	CLK("eqep.1",		NULL,		&eqep1_clk),
-	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
-	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
-	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
-	CLK(NULL,		"usb20",	&usb20_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
-	CLK(NULL,		"aintc",	&aintc_clk),
-	CLK(NULL,		"secu_mgr",	&secu_mgr_clk),
-	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK(NULL,		"gpio",		&gpio_clk),
-	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK(NULL,		"usb11",	&usb11_clk),
-	CLK(NULL,		"emif3",	&emif3_clk),
-	CLK(NULL,		"arm",		&arm_clk),
-	CLK(NULL,		"rmii",		&rmii_clk),
-	CLK(NULL,		NULL,		NULL),
+	CLKDEV_INIT(NULL,		"ref",		&ref_clk),
+	CLKDEV_INIT(NULL,		"pll0",		&pll0_clk),
+	CLKDEV_INIT(NULL,		"pll0_aux",	&pll0_aux_clk),
+	CLKDEV_INIT(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
+	CLKDEV_INIT(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
+	CLKDEV_INIT(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
+	CLKDEV_INIT(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
+	CLKDEV_INIT(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
+	CLKDEV_INIT(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
+	CLKDEV_INIT("i2c_davinci.1",	NULL,		&i2c0_clk),
+	CLKDEV_INIT(NULL,		"timer0",	&timerp64_0_clk),
+	CLKDEV_INIT("watchdog",		NULL,		&timerp64_1_clk),
+	CLKDEV_INIT(NULL,		"arm_rom",	&arm_rom_clk),
+	CLKDEV_INIT(NULL,		"scr0_ss",	&scr0_ss_clk),
+	CLKDEV_INIT(NULL,		"scr1_ss",	&scr1_ss_clk),
+	CLKDEV_INIT(NULL,		"scr2_ss",	&scr2_ss_clk),
+	CLKDEV_INIT(NULL,		"dmax",		&dmax_clk),
+	CLKDEV_INIT(NULL,		"tpcc",		&tpcc_clk),
+	CLKDEV_INIT(NULL,		"tptc0",	&tptc0_clk),
+	CLKDEV_INIT(NULL,		"tptc1",	&tptc1_clk),
+	CLKDEV_INIT("davinci_mmc.0",	NULL,		&mmcsd_clk),
+	CLKDEV_INIT(NULL,		"uart0",	&uart0_clk),
+	CLKDEV_INIT(NULL,		"uart1",	&uart1_clk),
+	CLKDEV_INIT(NULL,		"uart2",	&uart2_clk),
+	CLKDEV_INIT("spi_davinci.0",	NULL,		&spi0_clk),
+	CLKDEV_INIT("spi_davinci.1",	NULL,		&spi1_clk),
+	CLKDEV_INIT(NULL,		"ecap0",	&ecap0_clk),
+	CLKDEV_INIT(NULL,		"ecap1",	&ecap1_clk),
+	CLKDEV_INIT(NULL,		"ecap2",	&ecap2_clk),
+	CLKDEV_INIT(NULL,		"pwm0",		&pwm0_clk),
+	CLKDEV_INIT(NULL,		"pwm1",		&pwm1_clk),
+	CLKDEV_INIT(NULL,		"pwm2",		&pwm2_clk),
+	CLKDEV_INIT("eqep.0",		NULL,		&eqep0_clk),
+	CLKDEV_INIT("eqep.1",		NULL,		&eqep1_clk),
+	CLKDEV_INIT("da8xx_lcdc.0",	NULL,		&lcdc_clk),
+	CLKDEV_INIT("davinci-mcasp.0",	NULL,		&mcasp0_clk),
+	CLKDEV_INIT("davinci-mcasp.1",	NULL,		&mcasp1_clk),
+	CLKDEV_INIT("davinci-mcasp.2",	NULL,		&mcasp2_clk),
+	CLKDEV_INIT(NULL,		"usb20",	&usb20_clk),
+	CLKDEV_INIT(NULL,		"aemif",	&aemif_clk),
+	CLKDEV_INIT(NULL,		"aintc",	&aintc_clk),
+	CLKDEV_INIT(NULL,		"secu_mgr",	&secu_mgr_clk),
+	CLKDEV_INIT("davinci_emac.1",	NULL,		&emac_clk),
+	CLKDEV_INIT(NULL,		"gpio",		&gpio_clk),
+	CLKDEV_INIT("i2c_davinci.2",	NULL,		&i2c1_clk),
+	CLKDEV_INIT(NULL,		"usb11",	&usb11_clk),
+	CLKDEV_INIT(NULL,		"emif3",	&emif3_clk),
+	CLKDEV_INIT(NULL,		"arm",		&arm_clk),
+	CLKDEV_INIT(NULL,		"rmii",		&rmii_clk),
+	CLKDEV_INIT(NULL,		NULL,		NULL),
 };
 
 /*
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index b047f87..1d6d511 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
 #include <linux/regulator/consumer.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach/map.h>
 
@@ -384,53 +385,53 @@ static struct clk sata_clk = {
 };
 
 static struct clk_lookup da850_clks[] = {
-	CLK(NULL,		"ref",		&ref_clk),
-	CLK(NULL,		"pll0",		&pll0_clk),
-	CLK(NULL,		"pll0_aux",	&pll0_aux_clk),
-	CLK(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
-	CLK(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
-	CLK(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
-	CLK(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
-	CLK(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
-	CLK(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
-	CLK(NULL,		"pll1",		&pll1_clk),
-	CLK(NULL,		"pll1_aux",	&pll1_aux_clk),
-	CLK(NULL,		"pll1_sysclk2",	&pll1_sysclk2),
-	CLK(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
-	CLK(NULL,		"pll1_sysclk4",	&pll1_sysclk4),
-	CLK(NULL,		"pll1_sysclk5",	&pll1_sysclk5),
-	CLK(NULL,		"pll1_sysclk6",	&pll1_sysclk6),
-	CLK(NULL,		"pll1_sysclk7",	&pll1_sysclk7),
-	CLK("i2c_davinci.1",	NULL,		&i2c0_clk),
-	CLK(NULL,		"timer0",	&timerp64_0_clk),
-	CLK("watchdog",		NULL,		&timerp64_1_clk),
-	CLK(NULL,		"arm_rom",	&arm_rom_clk),
-	CLK(NULL,		"tpcc0",	&tpcc0_clk),
-	CLK(NULL,		"tptc0",	&tptc0_clk),
-	CLK(NULL,		"tptc1",	&tptc1_clk),
-	CLK(NULL,		"tpcc1",	&tpcc1_clk),
-	CLK(NULL,		"tptc2",	&tptc2_clk),
-	CLK(NULL,		"uart0",	&uart0_clk),
-	CLK(NULL,		"uart1",	&uart1_clk),
-	CLK(NULL,		"uart2",	&uart2_clk),
-	CLK(NULL,		"aintc",	&aintc_clk),
-	CLK(NULL,		"gpio",		&gpio_clk),
-	CLK("i2c_davinci.2",	NULL,		&i2c1_clk),
-	CLK(NULL,		"emif3",	&emif3_clk),
-	CLK(NULL,		"arm",		&arm_clk),
-	CLK(NULL,		"rmii",		&rmii_clk),
-	CLK("davinci_emac.1",	NULL,		&emac_clk),
-	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
-	CLK("da8xx_lcdc.0",	NULL,		&lcdc_clk),
-	CLK("davinci_mmc.0",	NULL,		&mmcsd0_clk),
-	CLK("davinci_mmc.1",	NULL,		&mmcsd1_clk),
-	CLK(NULL,		"aemif",	&aemif_clk),
-	CLK(NULL,		"usb11",	&usb11_clk),
-	CLK(NULL,		"usb20",	&usb20_clk),
-	CLK("spi_davinci.0",	NULL,		&spi0_clk),
-	CLK("spi_davinci.1",	NULL,		&spi1_clk),
-	CLK("ahci",		NULL,		&sata_clk),
-	CLK(NULL,		NULL,		NULL),
+	CLKDEV_INIT(NULL,		"ref",		&ref_clk),
+	CLKDEV_INIT(NULL,		"pll0",		&pll0_clk),
+	CLKDEV_INIT(NULL,		"pll0_aux",	&pll0_aux_clk),
+	CLKDEV_INIT(NULL,		"pll0_sysclk2",	&pll0_sysclk2),
+	CLKDEV_INIT(NULL,		"pll0_sysclk3",	&pll0_sysclk3),
+	CLKDEV_INIT(NULL,		"pll0_sysclk4",	&pll0_sysclk4),
+	CLKDEV_INIT(NULL,		"pll0_sysclk5",	&pll0_sysclk5),
+	CLKDEV_INIT(NULL,		"pll0_sysclk6",	&pll0_sysclk6),
+	CLKDEV_INIT(NULL,		"pll0_sysclk7",	&pll0_sysclk7),
+	CLKDEV_INIT(NULL,		"pll1",		&pll1_clk),
+	CLKDEV_INIT(NULL,		"pll1_aux",	&pll1_aux_clk),
+	CLKDEV_INIT(NULL,		"pll1_sysclk2",	&pll1_sysclk2),
+	CLKDEV_INIT(NULL,		"pll1_sysclk3",	&pll1_sysclk3),
+	CLKDEV_INIT(NULL,		"pll1_sysclk4",	&pll1_sysclk4),
+	CLKDEV_INIT(NULL,		"pll1_sysclk5",	&pll1_sysclk5),
+	CLKDEV_INIT(NULL,		"pll1_sysclk6",	&pll1_sysclk6),
+	CLKDEV_INIT(NULL,		"pll1_sysclk7",	&pll1_sysclk7),
+	CLKDEV_INIT("i2c_davinci.1",	NULL,		&i2c0_clk),
+	CLKDEV_INIT(NULL,		"timer0",	&timerp64_0_clk),
+	CLKDEV_INIT("watchdog",		NULL,		&timerp64_1_clk),
+	CLKDEV_INIT(NULL,		"arm_rom",	&arm_rom_clk),
+	CLKDEV_INIT(NULL,		"tpcc0",	&tpcc0_clk),
+	CLKDEV_INIT(NULL,		"tptc0",	&tptc0_clk),
+	CLKDEV_INIT(NULL,		"tptc1",	&tptc1_clk),
+	CLKDEV_INIT(NULL,		"tpcc1",	&tpcc1_clk),
+	CLKDEV_INIT(NULL,		"tptc2",	&tptc2_clk),
+	CLKDEV_INIT(NULL,		"uart0",	&uart0_clk),
+	CLKDEV_INIT(NULL,		"uart1",	&uart1_clk),
+	CLKDEV_INIT(NULL,		"uart2",	&uart2_clk),
+	CLKDEV_INIT(NULL,		"aintc",	&aintc_clk),
+	CLKDEV_INIT(NULL,		"gpio",		&gpio_clk),
+	CLKDEV_INIT("i2c_davinci.2",	NULL,		&i2c1_clk),
+	CLKDEV_INIT(NULL,		"emif3",	&emif3_clk),
+	CLKDEV_INIT(NULL,		"arm",		&arm_clk),
+	CLKDEV_INIT(NULL,		"rmii",		&rmii_clk),
+	CLKDEV_INIT("davinci_emac.1",	NULL,		&emac_clk),
+	CLKDEV_INIT("davinci-mcasp.0",	NULL,		&mcasp_clk),
+	CLKDEV_INIT("da8xx_lcdc.0",	NULL,		&lcdc_clk),
+	CLKDEV_INIT("davinci_mmc.0",	NULL,		&mmcsd0_clk),
+	CLKDEV_INIT("davinci_mmc.1",	NULL,		&mmcsd1_clk),
+	CLKDEV_INIT(NULL,		"aemif",	&aemif_clk),
+	CLKDEV_INIT(NULL,		"usb11",	&usb11_clk),
+	CLKDEV_INIT(NULL,		"usb20",	&usb20_clk),
+	CLKDEV_INIT("spi_davinci.0",	NULL,		&spi0_clk),
+	CLKDEV_INIT("spi_davinci.1",	NULL,		&spi1_clk),
+	CLKDEV_INIT("ahci",		NULL,		&sata_clk),
+	CLKDEV_INIT(NULL,		NULL,		NULL),
 };
 
 /*
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index fe520d4..1df71e0 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -13,6 +13,7 @@
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/clkdev.h>
 
 #include <linux/spi/spi.h>
 
@@ -336,49 +337,49 @@ static struct clk usb_clk = {
 };
 
 static struct clk_lookup dm355_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk4", &pll1_sysclk4),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "vpss_dac", &vpss_dac_clk),
-	CLK(NULL, "vpss_master", &vpss_master_clk),
-	CLK(NULL, "vpss_slave", &vpss_slave_clk),
-	CLK(NULL, "clkout1", &clkout1_clk),
-	CLK(NULL, "clkout2", &clkout2_clk),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
-	CLK(NULL, "clkout3", &clkout3_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK(NULL, "uart2", &uart2_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci-mcbsp.0", NULL, &asp0_clk),
-	CLK("davinci-mcbsp.1", NULL, &asp1_clk),
-	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
-	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
-	CLK("spi_davinci.0", NULL, &spi0_clk),
-	CLK("spi_davinci.1", NULL, &spi1_clk),
-	CLK("spi_davinci.2", NULL, &spi2_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "pwm3", &pwm3_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
-	CLK(NULL, "timer3", &timer3_clk),
-	CLK(NULL, "rto", &rto_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK(NULL, NULL, NULL),
+	CLKDEV_INIT(NULL, "ref", &ref_clk),
+	CLKDEV_INIT(NULL, "pll1", &pll1_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclk1", &pll1_sysclk1),
+	CLKDEV_INIT(NULL, "pll1_sysclk2", &pll1_sysclk2),
+	CLKDEV_INIT(NULL, "pll1_sysclk3", &pll1_sysclk3),
+	CLKDEV_INIT(NULL, "pll1_sysclk4", &pll1_sysclk4),
+	CLKDEV_INIT(NULL, "pll1_aux", &pll1_aux_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
+	CLKDEV_INIT(NULL, "vpss_dac", &vpss_dac_clk),
+	CLKDEV_INIT(NULL, "vpss_master", &vpss_master_clk),
+	CLKDEV_INIT(NULL, "vpss_slave", &vpss_slave_clk),
+	CLKDEV_INIT(NULL, "clkout1", &clkout1_clk),
+	CLKDEV_INIT(NULL, "clkout2", &clkout2_clk),
+	CLKDEV_INIT(NULL, "pll2", &pll2_clk),
+	CLKDEV_INIT(NULL, "pll2_sysclk1", &pll2_sysclk1),
+	CLKDEV_INIT(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
+	CLKDEV_INIT(NULL, "clkout3", &clkout3_clk),
+	CLKDEV_INIT(NULL, "arm", &arm_clk),
+	CLKDEV_INIT(NULL, "mjcp", &mjcp_clk),
+	CLKDEV_INIT(NULL, "uart0", &uart0_clk),
+	CLKDEV_INIT(NULL, "uart1", &uart1_clk),
+	CLKDEV_INIT(NULL, "uart2", &uart2_clk),
+	CLKDEV_INIT("i2c_davinci.1", NULL, &i2c_clk),
+	CLKDEV_INIT("davinci-mcbsp.0", NULL, &asp0_clk),
+	CLKDEV_INIT("davinci-mcbsp.1", NULL, &asp1_clk),
+	CLKDEV_INIT("davinci_mmc.0", NULL, &mmcsd0_clk),
+	CLKDEV_INIT("davinci_mmc.1", NULL, &mmcsd1_clk),
+	CLKDEV_INIT("spi_davinci.0", NULL, &spi0_clk),
+	CLKDEV_INIT("spi_davinci.1", NULL, &spi1_clk),
+	CLKDEV_INIT("spi_davinci.2", NULL, &spi2_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT(NULL, "aemif", &aemif_clk),
+	CLKDEV_INIT(NULL, "pwm0", &pwm0_clk),
+	CLKDEV_INIT(NULL, "pwm1", &pwm1_clk),
+	CLKDEV_INIT(NULL, "pwm2", &pwm2_clk),
+	CLKDEV_INIT(NULL, "pwm3", &pwm3_clk),
+	CLKDEV_INIT(NULL, "timer0", &timer0_clk),
+	CLKDEV_INIT(NULL, "timer1", &timer1_clk),
+	CLKDEV_INIT("watchdog", NULL, &timer2_clk),
+	CLKDEV_INIT(NULL, "timer3", &timer3_clk),
+	CLKDEV_INIT(NULL, "rto", &rto_clk),
+	CLKDEV_INIT(NULL, "usb", &usb_clk),
+	CLKDEV_INIT(NULL, NULL, NULL),
 };
 
 /*----------------------------------------------------------------------*/
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 679e168..b0637b4 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach/map.h>
 
@@ -406,62 +407,62 @@ static struct clk mjcp_clk = {
 };
 
 static struct clk_lookup dm365_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "clkout0", &clkout0_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk4", &pll1_sysclk4),
-	CLK(NULL, "pll1_sysclk5", &pll1_sysclk5),
-	CLK(NULL, "pll1_sysclk6", &pll1_sysclk6),
-	CLK(NULL, "pll1_sysclk7", &pll1_sysclk7),
-	CLK(NULL, "pll1_sysclk8", &pll1_sysclk8),
-	CLK(NULL, "pll1_sysclk9", &pll1_sysclk9),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_aux", &pll2_aux_clk),
-	CLK(NULL, "clkout1", &clkout1_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclk2", &pll2_sysclk2),
-	CLK(NULL, "pll2_sysclk3", &pll2_sysclk3),
-	CLK(NULL, "pll2_sysclk4", &pll2_sysclk4),
-	CLK(NULL, "pll2_sysclk5", &pll2_sysclk5),
-	CLK(NULL, "pll2_sysclk6", &pll2_sysclk6),
-	CLK(NULL, "pll2_sysclk7", &pll2_sysclk7),
-	CLK(NULL, "pll2_sysclk8", &pll2_sysclk8),
-	CLK(NULL, "pll2_sysclk9", &pll2_sysclk9),
-	CLK(NULL, "vpss_dac", &vpss_dac_clk),
-	CLK(NULL, "vpss_master", &vpss_master_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
-	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
-	CLK("spi_davinci.0", NULL, &spi0_clk),
-	CLK("spi_davinci.1", NULL, &spi1_clk),
-	CLK("spi_davinci.2", NULL, &spi2_clk),
-	CLK("spi_davinci.3", NULL, &spi3_clk),
-	CLK("spi_davinci.4", NULL, &spi4_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "pwm3", &pwm3_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
-	CLK(NULL, "timer3", &timer3_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("davinci_voicecodec", NULL, &voicecodec_clk),
-	CLK("davinci-mcbsp", NULL, &asp0_clk),
-	CLK(NULL, "rto", &rto_clk),
-	CLK(NULL, "mjcp", &mjcp_clk),
-	CLK(NULL, NULL, NULL),
+	CLKDEV_INIT(NULL, "ref", &ref_clk),
+	CLKDEV_INIT(NULL, "pll1", &pll1_clk),
+	CLKDEV_INIT(NULL, "pll1_aux", &pll1_aux_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
+	CLKDEV_INIT(NULL, "clkout0", &clkout0_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclk1", &pll1_sysclk1),
+	CLKDEV_INIT(NULL, "pll1_sysclk2", &pll1_sysclk2),
+	CLKDEV_INIT(NULL, "pll1_sysclk3", &pll1_sysclk3),
+	CLKDEV_INIT(NULL, "pll1_sysclk4", &pll1_sysclk4),
+	CLKDEV_INIT(NULL, "pll1_sysclk5", &pll1_sysclk5),
+	CLKDEV_INIT(NULL, "pll1_sysclk6", &pll1_sysclk6),
+	CLKDEV_INIT(NULL, "pll1_sysclk7", &pll1_sysclk7),
+	CLKDEV_INIT(NULL, "pll1_sysclk8", &pll1_sysclk8),
+	CLKDEV_INIT(NULL, "pll1_sysclk9", &pll1_sysclk9),
+	CLKDEV_INIT(NULL, "pll2", &pll2_clk),
+	CLKDEV_INIT(NULL, "pll2_aux", &pll2_aux_clk),
+	CLKDEV_INIT(NULL, "clkout1", &clkout1_clk),
+	CLKDEV_INIT(NULL, "pll2_sysclk1", &pll2_sysclk1),
+	CLKDEV_INIT(NULL, "pll2_sysclk2", &pll2_sysclk2),
+	CLKDEV_INIT(NULL, "pll2_sysclk3", &pll2_sysclk3),
+	CLKDEV_INIT(NULL, "pll2_sysclk4", &pll2_sysclk4),
+	CLKDEV_INIT(NULL, "pll2_sysclk5", &pll2_sysclk5),
+	CLKDEV_INIT(NULL, "pll2_sysclk6", &pll2_sysclk6),
+	CLKDEV_INIT(NULL, "pll2_sysclk7", &pll2_sysclk7),
+	CLKDEV_INIT(NULL, "pll2_sysclk8", &pll2_sysclk8),
+	CLKDEV_INIT(NULL, "pll2_sysclk9", &pll2_sysclk9),
+	CLKDEV_INIT(NULL, "vpss_dac", &vpss_dac_clk),
+	CLKDEV_INIT(NULL, "vpss_master", &vpss_master_clk),
+	CLKDEV_INIT(NULL, "arm", &arm_clk),
+	CLKDEV_INIT(NULL, "uart0", &uart0_clk),
+	CLKDEV_INIT(NULL, "uart1", &uart1_clk),
+	CLKDEV_INIT("i2c_davinci.1", NULL, &i2c_clk),
+	CLKDEV_INIT("davinci_mmc.0", NULL, &mmcsd0_clk),
+	CLKDEV_INIT("davinci_mmc.1", NULL, &mmcsd1_clk),
+	CLKDEV_INIT("spi_davinci.0", NULL, &spi0_clk),
+	CLKDEV_INIT("spi_davinci.1", NULL, &spi1_clk),
+	CLKDEV_INIT("spi_davinci.2", NULL, &spi2_clk),
+	CLKDEV_INIT("spi_davinci.3", NULL, &spi3_clk),
+	CLKDEV_INIT("spi_davinci.4", NULL, &spi4_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT(NULL, "aemif", &aemif_clk),
+	CLKDEV_INIT(NULL, "pwm0", &pwm0_clk),
+	CLKDEV_INIT(NULL, "pwm1", &pwm1_clk),
+	CLKDEV_INIT(NULL, "pwm2", &pwm2_clk),
+	CLKDEV_INIT(NULL, "pwm3", &pwm3_clk),
+	CLKDEV_INIT(NULL, "timer0", &timer0_clk),
+	CLKDEV_INIT(NULL, "timer1", &timer1_clk),
+	CLKDEV_INIT("watchdog", NULL, &timer2_clk),
+	CLKDEV_INIT(NULL, "timer3", &timer3_clk),
+	CLKDEV_INIT(NULL, "usb", &usb_clk),
+	CLKDEV_INIT("davinci_emac.1", NULL, &emac_clk),
+	CLKDEV_INIT("davinci_voicecodec", NULL, &voicecodec_clk),
+	CLKDEV_INIT("davinci-mcbsp", NULL, &asp0_clk),
+	CLKDEV_INIT(NULL, "rto", &rto_clk),
+	CLKDEV_INIT(NULL, "mjcp", &mjcp_clk),
+	CLKDEV_INIT(NULL, NULL, NULL),
 };
 
 /*----------------------------------------------------------------------*/
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 3470983..f61610e 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -12,6 +12,7 @@
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach/map.h>
 
@@ -278,44 +279,44 @@ static struct clk timer2_clk = {
 };
 
 static struct clk_lookup dm644x_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk1", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk2", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk3", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk5", &pll1_sysclk5),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "pll2_sysclk2", &pll2_sysclk2),
-	CLK(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
-	CLK(NULL, "dsp", &dsp_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "vicp", &vicp_clk),
-	CLK(NULL, "vpss_master", &vpss_master_clk),
-	CLK(NULL, "vpss_slave", &vpss_slave_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK(NULL, "uart2", &uart2_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("davinci-mcbsp", NULL, &asp_clk),
-	CLK("davinci_mmc.0", NULL, &mmcsd_clk),
-	CLK(NULL, "spi", &spi_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK(NULL, "usb", &usb_clk),
-	CLK(NULL, "vlynq", &vlynq_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "pwm2", &pwm2_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
-	CLK(NULL, NULL, NULL),
+	CLKDEV_INIT(NULL, "ref", &ref_clk),
+	CLKDEV_INIT(NULL, "pll1", &pll1_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclk1", &pll1_sysclk1),
+	CLKDEV_INIT(NULL, "pll1_sysclk2", &pll1_sysclk2),
+	CLKDEV_INIT(NULL, "pll1_sysclk3", &pll1_sysclk3),
+	CLKDEV_INIT(NULL, "pll1_sysclk5", &pll1_sysclk5),
+	CLKDEV_INIT(NULL, "pll1_aux", &pll1_aux_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclkbp", &pll1_sysclkbp),
+	CLKDEV_INIT(NULL, "pll2", &pll2_clk),
+	CLKDEV_INIT(NULL, "pll2_sysclk1", &pll2_sysclk1),
+	CLKDEV_INIT(NULL, "pll2_sysclk2", &pll2_sysclk2),
+	CLKDEV_INIT(NULL, "pll2_sysclkbp", &pll2_sysclkbp),
+	CLKDEV_INIT(NULL, "dsp", &dsp_clk),
+	CLKDEV_INIT(NULL, "arm", &arm_clk),
+	CLKDEV_INIT(NULL, "vicp", &vicp_clk),
+	CLKDEV_INIT(NULL, "vpss_master", &vpss_master_clk),
+	CLKDEV_INIT(NULL, "vpss_slave", &vpss_slave_clk),
+	CLKDEV_INIT(NULL, "arm", &arm_clk),
+	CLKDEV_INIT(NULL, "uart0", &uart0_clk),
+	CLKDEV_INIT(NULL, "uart1", &uart1_clk),
+	CLKDEV_INIT(NULL, "uart2", &uart2_clk),
+	CLKDEV_INIT("davinci_emac.1", NULL, &emac_clk),
+	CLKDEV_INIT("i2c_davinci.1", NULL, &i2c_clk),
+	CLKDEV_INIT("palm_bk3710", NULL, &ide_clk),
+	CLKDEV_INIT("davinci-mcbsp", NULL, &asp_clk),
+	CLKDEV_INIT("davinci_mmc.0", NULL, &mmcsd_clk),
+	CLKDEV_INIT(NULL, "spi", &spi_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT(NULL, "usb", &usb_clk),
+	CLKDEV_INIT(NULL, "vlynq", &vlynq_clk),
+	CLKDEV_INIT(NULL, "aemif", &aemif_clk),
+	CLKDEV_INIT(NULL, "pwm0", &pwm0_clk),
+	CLKDEV_INIT(NULL, "pwm1", &pwm1_clk),
+	CLKDEV_INIT(NULL, "pwm2", &pwm2_clk),
+	CLKDEV_INIT(NULL, "timer0", &timer0_clk),
+	CLKDEV_INIT(NULL, "timer1", &timer1_clk),
+	CLKDEV_INIT("watchdog", NULL, &timer2_clk),
+	CLKDEV_INIT(NULL, NULL, NULL),
 };
 
 static struct emac_platform_data dm644x_emac_pdata = {
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 0b68ed5..ad9b71b 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach/map.h>
 
@@ -316,46 +317,46 @@ static struct clk vpif1_clk = {
 };
 
 static struct clk_lookup dm646x_clks[] = {
-	CLK(NULL, "ref", &ref_clk),
-	CLK(NULL, "aux", &aux_clkin),
-	CLK(NULL, "pll1", &pll1_clk),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk1),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk2),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk3),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk4),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk5),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk6),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk8),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclk9),
-	CLK(NULL, "pll1_sysclk", &pll1_sysclkbp),
-	CLK(NULL, "pll1_aux", &pll1_aux_clk),
-	CLK(NULL, "pll2", &pll2_clk),
-	CLK(NULL, "pll2_sysclk1", &pll2_sysclk1),
-	CLK(NULL, "dsp", &dsp_clk),
-	CLK(NULL, "arm", &arm_clk),
-	CLK(NULL, "edma_cc", &edma_cc_clk),
-	CLK(NULL, "edma_tc0", &edma_tc0_clk),
-	CLK(NULL, "edma_tc1", &edma_tc1_clk),
-	CLK(NULL, "edma_tc2", &edma_tc2_clk),
-	CLK(NULL, "edma_tc3", &edma_tc3_clk),
-	CLK(NULL, "uart0", &uart0_clk),
-	CLK(NULL, "uart1", &uart1_clk),
-	CLK(NULL, "uart2", &uart2_clk),
-	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK(NULL, "gpio", &gpio_clk),
-	CLK("davinci-mcasp.0", NULL, &mcasp0_clk),
-	CLK("davinci-mcasp.1", NULL, &mcasp1_clk),
-	CLK(NULL, "aemif", &aemif_clk),
-	CLK("davinci_emac.1", NULL, &emac_clk),
-	CLK(NULL, "pwm0", &pwm0_clk),
-	CLK(NULL, "pwm1", &pwm1_clk),
-	CLK(NULL, "timer0", &timer0_clk),
-	CLK(NULL, "timer1", &timer1_clk),
-	CLK("watchdog", NULL, &timer2_clk),
-	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK(NULL, "vpif0", &vpif0_clk),
-	CLK(NULL, "vpif1", &vpif1_clk),
-	CLK(NULL, NULL, NULL),
+	CLKDEV_INIT(NULL, "ref", &ref_clk),
+	CLKDEV_INIT(NULL, "aux", &aux_clkin),
+	CLKDEV_INIT(NULL, "pll1", &pll1_clk),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk1),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk2),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk3),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk4),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk5),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk6),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk8),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclk9),
+	CLKDEV_INIT(NULL, "pll1_sysclk", &pll1_sysclkbp),
+	CLKDEV_INIT(NULL, "pll1_aux", &pll1_aux_clk),
+	CLKDEV_INIT(NULL, "pll2", &pll2_clk),
+	CLKDEV_INIT(NULL, "pll2_sysclk1", &pll2_sysclk1),
+	CLKDEV_INIT(NULL, "dsp", &dsp_clk),
+	CLKDEV_INIT(NULL, "arm", &arm_clk),
+	CLKDEV_INIT(NULL, "edma_cc", &edma_cc_clk),
+	CLKDEV_INIT(NULL, "edma_tc0", &edma_tc0_clk),
+	CLKDEV_INIT(NULL, "edma_tc1", &edma_tc1_clk),
+	CLKDEV_INIT(NULL, "edma_tc2", &edma_tc2_clk),
+	CLKDEV_INIT(NULL, "edma_tc3", &edma_tc3_clk),
+	CLKDEV_INIT(NULL, "uart0", &uart0_clk),
+	CLKDEV_INIT(NULL, "uart1", &uart1_clk),
+	CLKDEV_INIT(NULL, "uart2", &uart2_clk),
+	CLKDEV_INIT("i2c_davinci.1", NULL, &i2c_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT("davinci-mcasp.0", NULL, &mcasp0_clk),
+	CLKDEV_INIT("davinci-mcasp.1", NULL, &mcasp1_clk),
+	CLKDEV_INIT(NULL, "aemif", &aemif_clk),
+	CLKDEV_INIT("davinci_emac.1", NULL, &emac_clk),
+	CLKDEV_INIT(NULL, "pwm0", &pwm0_clk),
+	CLKDEV_INIT(NULL, "pwm1", &pwm1_clk),
+	CLKDEV_INIT(NULL, "timer0", &timer0_clk),
+	CLKDEV_INIT(NULL, "timer1", &timer1_clk),
+	CLKDEV_INIT("watchdog", NULL, &timer2_clk),
+	CLKDEV_INIT("palm_bk3710", NULL, &ide_clk),
+	CLKDEV_INIT(NULL, "vpif0", &vpif0_clk),
+	CLKDEV_INIT(NULL, "vpif1", &vpif1_clk),
+	CLKDEV_INIT(NULL, NULL, NULL),
 };
 
 static struct emac_platform_data dm646x_emac_pdata = {
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 409bb86..c2f53f0 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/clkdev.h>
 
 #include <asm/mach/map.h>
 
@@ -230,72 +231,72 @@ static struct clk clk_rng = { .name = "rng", .parent = &clk_pktsec };
 static struct clk clk_pka = { .name = "pka", .parent = &clk_pktsec };
 
 static struct clk_lookup clks[] = {
-	CLK(NULL,		"pll_sys_clk",		&pll_sys_clk),
-	CLK(NULL,		"pll_eth_clk",		&pll_eth_clk),
-	CLK(NULL,		"pll_tdm_clk",		&pll_tdm_clk),
-	CLK(NULL,		"sys_arm1176_clk",	&sys_arm1176_clk),
-	CLK(NULL,		"sys_dsp_clk",		&sys_dsp_clk),
-	CLK(NULL,		"sys_ddr_clk",		&sys_ddr_clk),
-	CLK(NULL,		"sys_full_clk",		&sys_full_clk),
-	CLK(NULL,		"sys_lcd_clk",		&sys_lcd_clk),
-	CLK(NULL,		"sys_vlynq_ref_clk",	&sys_vlynq_ref_clk),
-	CLK(NULL,		"sys_tsc_clk",		&sys_tsc_clk),
-	CLK(NULL,		"sys_half_clk",		&sys_half_clk),
-	CLK(NULL,		"eth_5mhz_clk",		&eth_5mhz_clk),
-	CLK(NULL,		"eth_50mhz_clk",	&eth_50mhz_clk),
-	CLK(NULL,		"eth_125mhz_clk",	&eth_125mhz_clk),
-	CLK(NULL,		"eth_250mhz_clk",	&eth_250mhz_clk),
-	CLK(NULL,		"eth_25mhz_clk",	&eth_25mhz_clk),
-	CLK(NULL,		"tdm_0_clk",		&tdm_0_clk),
-	CLK(NULL,		"tdm_extra_clk",	&tdm_extra_clk),
-	CLK(NULL,		"tdm_1_clk",		&tdm_1_clk),
-	CLK(NULL,		"clk_arm",		&clk_arm),
-	CLK(NULL,		"clk_gem",		&clk_gem),
-	CLK(NULL,		"clk_ddr2_phy",		&clk_ddr2_phy),
-	CLK(NULL,		"clk_tpcc",		&clk_tpcc),
-	CLK(NULL,		"clk_tptc0",		&clk_tptc0),
-	CLK(NULL,		"clk_tptc1",		&clk_tptc1),
-	CLK(NULL,		"clk_ram",		&clk_ram),
-	CLK(NULL,		"clk_mbx_lite",		&clk_mbx_lite),
-	CLK("tnetv107x-fb.0",	NULL,			&clk_lcd),
-	CLK(NULL,		"clk_ethss",		&clk_ethss),
-	CLK(NULL,		"aemif",		&clk_aemif),
-	CLK(NULL,		"clk_chipcfg",		&clk_chipcfg),
-	CLK("tnetv107x-ts.0",	NULL,			&clk_tsc),
-	CLK(NULL,		"clk_rom",		&clk_rom),
-	CLK(NULL,		"uart2",		&clk_uart2),
-	CLK(NULL,		"clk_pktsec",		&clk_pktsec),
-	CLK("tnetv107x-rng.0",	NULL,			&clk_rng),
-	CLK("tnetv107x-pka.0",	NULL,			&clk_pka),
-	CLK(NULL,		"clk_secctl",		&clk_secctl),
-	CLK(NULL,		"clk_keymgr",		&clk_keymgr),
-	CLK("tnetv107x-keypad.0", NULL,			&clk_keypad),
-	CLK(NULL,		"clk_gpio",		&clk_gpio),
-	CLK(NULL,		"clk_mdio",		&clk_mdio),
-	CLK("davinci_mmc.0",	NULL,			&clk_sdio0),
-	CLK(NULL,		"uart0",		&clk_uart0),
-	CLK(NULL,		"uart1",		&clk_uart1),
-	CLK(NULL,		"timer0",		&clk_timer0),
-	CLK(NULL,		"timer1",		&clk_timer1),
-	CLK("tnetv107x_wdt.0",	NULL,			&clk_wdt_arm),
-	CLK(NULL,		"clk_wdt_dsp",		&clk_wdt_dsp),
-	CLK("ti-ssp",		NULL,			&clk_ssp),
-	CLK(NULL,		"clk_tdm0",		&clk_tdm0),
-	CLK(NULL,		"clk_vlynq",		&clk_vlynq),
-	CLK(NULL,		"clk_mcdma",		&clk_mcdma),
-	CLK(NULL,		"clk_usbss",		&clk_usbss),
-	CLK(NULL,		"clk_usb0",		&clk_usb0),
-	CLK(NULL,		"clk_usb1",		&clk_usb1),
-	CLK(NULL,		"clk_tdm1",		&clk_tdm1),
-	CLK(NULL,		"clk_debugss",		&clk_debugss),
-	CLK(NULL,		"clk_ethss_rgmii",	&clk_ethss_rgmii),
-	CLK(NULL,		"clk_system",		&clk_system),
-	CLK(NULL,		"clk_imcop",		&clk_imcop),
-	CLK(NULL,		"clk_spare",		&clk_spare),
-	CLK("davinci_mmc.1",	NULL,			&clk_sdio1),
-	CLK(NULL,		"clk_ddr2_vrst",	&clk_ddr2_vrst),
-	CLK(NULL,		"clk_ddr2_vctl_rst",	&clk_ddr2_vctl_rst),
-	CLK(NULL,		NULL,			NULL),
+	CLKDEV_INIT(NULL,		"pll_sys_clk",		&pll_sys_clk),
+	CLKDEV_INIT(NULL,		"pll_eth_clk",		&pll_eth_clk),
+	CLKDEV_INIT(NULL,		"pll_tdm_clk",		&pll_tdm_clk),
+	CLKDEV_INIT(NULL,		"sys_arm1176_clk",	&sys_arm1176_clk),
+	CLKDEV_INIT(NULL,		"sys_dsp_clk",		&sys_dsp_clk),
+	CLKDEV_INIT(NULL,		"sys_ddr_clk",		&sys_ddr_clk),
+	CLKDEV_INIT(NULL,		"sys_full_clk",		&sys_full_clk),
+	CLKDEV_INIT(NULL,		"sys_lcd_clk",		&sys_lcd_clk),
+	CLKDEV_INIT(NULL,		"sys_vlynq_ref_clk",	&sys_vlynq_ref_clk),
+	CLKDEV_INIT(NULL,		"sys_tsc_clk",		&sys_tsc_clk),
+	CLKDEV_INIT(NULL,		"sys_half_clk",		&sys_half_clk),
+	CLKDEV_INIT(NULL,		"eth_5mhz_clk",		&eth_5mhz_clk),
+	CLKDEV_INIT(NULL,		"eth_50mhz_clk",	&eth_50mhz_clk),
+	CLKDEV_INIT(NULL,		"eth_125mhz_clk",	&eth_125mhz_clk),
+	CLKDEV_INIT(NULL,		"eth_250mhz_clk",	&eth_250mhz_clk),
+	CLKDEV_INIT(NULL,		"eth_25mhz_clk",	&eth_25mhz_clk),
+	CLKDEV_INIT(NULL,		"tdm_0_clk",		&tdm_0_clk),
+	CLKDEV_INIT(NULL,		"tdm_extra_clk",	&tdm_extra_clk),
+	CLKDEV_INIT(NULL,		"tdm_1_clk",		&tdm_1_clk),
+	CLKDEV_INIT(NULL,		"clk_arm",		&clk_arm),
+	CLKDEV_INIT(NULL,		"clk_gem",		&clk_gem),
+	CLKDEV_INIT(NULL,		"clk_ddr2_phy",		&clk_ddr2_phy),
+	CLKDEV_INIT(NULL,		"clk_tpcc",		&clk_tpcc),
+	CLKDEV_INIT(NULL,		"clk_tptc0",		&clk_tptc0),
+	CLKDEV_INIT(NULL,		"clk_tptc1",		&clk_tptc1),
+	CLKDEV_INIT(NULL,		"clk_ram",		&clk_ram),
+	CLKDEV_INIT(NULL,		"clk_mbx_lite",		&clk_mbx_lite),
+	CLKDEV_INIT("tnetv107x-fb.0",	NULL,			&clk_lcd),
+	CLKDEV_INIT(NULL,		"clk_ethss",		&clk_ethss),
+	CLKDEV_INIT(NULL,		"aemif",		&clk_aemif),
+	CLKDEV_INIT(NULL,		"clk_chipcfg",		&clk_chipcfg),
+	CLKDEV_INIT("tnetv107x-ts.0",	NULL,			&clk_tsc),
+	CLKDEV_INIT(NULL,		"clk_rom",		&clk_rom),
+	CLKDEV_INIT(NULL,		"uart2",		&clk_uart2),
+	CLKDEV_INIT(NULL,		"clk_pktsec",		&clk_pktsec),
+	CLKDEV_INIT("tnetv107x-rng.0",	NULL,			&clk_rng),
+	CLKDEV_INIT("tnetv107x-pka.0",	NULL,			&clk_pka),
+	CLKDEV_INIT(NULL,		"clk_secctl",		&clk_secctl),
+	CLKDEV_INIT(NULL,		"clk_keymgr",		&clk_keymgr),
+	CLKDEV_INIT("tnetv107x-keypad.0", NULL,			&clk_keypad),
+	CLKDEV_INIT(NULL,		"clk_gpio",		&clk_gpio),
+	CLKDEV_INIT(NULL,		"clk_mdio",		&clk_mdio),
+	CLKDEV_INIT("davinci_mmc.0",	NULL,			&clk_sdio0),
+	CLKDEV_INIT(NULL,		"uart0",		&clk_uart0),
+	CLKDEV_INIT(NULL,		"uart1",		&clk_uart1),
+	CLKDEV_INIT(NULL,		"timer0",		&clk_timer0),
+	CLKDEV_INIT(NULL,		"timer1",		&clk_timer1),
+	CLKDEV_INIT("tnetv107x_wdt.0",	NULL,			&clk_wdt_arm),
+	CLKDEV_INIT(NULL,		"clk_wdt_dsp",		&clk_wdt_dsp),
+	CLKDEV_INIT("ti-ssp",		NULL,			&clk_ssp),
+	CLKDEV_INIT(NULL,		"clk_tdm0",		&clk_tdm0),
+	CLKDEV_INIT(NULL,		"clk_vlynq",		&clk_vlynq),
+	CLKDEV_INIT(NULL,		"clk_mcdma",		&clk_mcdma),
+	CLKDEV_INIT(NULL,		"clk_usbss",		&clk_usbss),
+	CLKDEV_INIT(NULL,		"clk_usb0",		&clk_usb0),
+	CLKDEV_INIT(NULL,		"clk_usb1",		&clk_usb1),
+	CLKDEV_INIT(NULL,		"clk_tdm1",		&clk_tdm1),
+	CLKDEV_INIT(NULL,		"clk_debugss",		&clk_debugss),
+	CLKDEV_INIT(NULL,		"clk_ethss_rgmii",	&clk_ethss_rgmii),
+	CLKDEV_INIT(NULL,		"clk_system",		&clk_system),
+	CLKDEV_INIT(NULL,		"clk_imcop",		&clk_imcop),
+	CLKDEV_INIT(NULL,		"clk_spare",		&clk_spare),
+	CLKDEV_INIT("davinci_mmc.1",	NULL,			&clk_sdio1),
+	CLKDEV_INIT(NULL,		"clk_ddr2_vrst",	&clk_ddr2_vrst),
+	CLKDEV_INIT(NULL,		"clk_ddr2_vctl_rst",	&clk_ddr2_vctl_rst),
+	CLKDEV_INIT(NULL,		NULL,			NULL),
 };
 
 static const struct mux_config pins[] = {
-- 
1.7.4.4
