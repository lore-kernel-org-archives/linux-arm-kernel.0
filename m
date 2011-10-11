From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 11 Oct 2011 17:15:30 +0530
Subject: [RESEND][PATCH V2 2/2] ARM: Using CLKDEV_INIT for creating clk_lookup
	instance
In-Reply-To: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
References: <1318333530-7023-1-git-send-email-padma.v@samsung.com>
Message-ID: <1318333530-7023-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Padmavathi Venna <padma.v@samsung.com> 

Replace platform specific macros that creates struct clk_lookup
instance with the new common CLKDEV_INIT macro

Suggested by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Hans J. Koch <hjk@hansjkoch.de>
Acked-by: Amit Kucheria <amit.kucheria@canonical.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
---
 arch/arm/mach-davinci/board-dm646x-evm.c |    5 +-
 arch/arm/mach-davinci/clock.h            |    7 --
 arch/arm/mach-davinci/da830.c            |  101 ++++++++++----------
 arch/arm/mach-davinci/da850.c            |   95 ++++++++++----------
 arch/arm/mach-davinci/dm355.c            |   87 +++++++++---------
 arch/arm/mach-davinci/dm365.c            |  113 +++++++++++-----------
 arch/arm/mach-davinci/dm644x.c           |   77 ++++++++--------
 arch/arm/mach-davinci/dm646x.c           |   81 ++++++++--------
 arch/arm/mach-davinci/tnetv107x.c        |  133 +++++++++++++-------------
 arch/arm/mach-ep93xx/clock.c             |   61 ++++++-------
 arch/arm/mach-imx/clock-imx1.c           |   38 +++-----
 arch/arm/mach-imx/clock-imx21.c          |   91 +++++++++----------
 arch/arm/mach-imx/clock-imx25.c          |   79 +++++++---------
 arch/arm/mach-imx/clock-imx27.c          |  111 ++++++++++------------
 arch/arm/mach-imx/clock-imx31.c          |  103 ++++++++++-----------
 arch/arm/mach-imx/clock-imx35.c          |  117 +++++++++++------------
 arch/arm/mach-lpc32xx/clock.c            |   75 +++++++--------
 arch/arm/mach-mx5/clock-mx51-mx53.c      |  149 ++++++++++++++----------------
 arch/arm/mach-mxs/clock-mx23.c           |   39 +++-----
 arch/arm/mach-mxs/clock-mx28.c           |   71 +++++++--------
 arch/arm/mach-tcc8k/clock.c              |  107 ++++++++++-----------
 21 files changed, 831 insertions(+), 909 deletions(-)

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
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index ca4de71..60fc2f3 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -198,39 +198,36 @@ static struct clk clk_m2m1 = {
 	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M1,
 };
 
-#define INIT_CK(dev,con,ck)					\
-	{ .dev_id = dev, .con_id = con, .clk = ck }
-
 static struct clk_lookup clocks[] = {
-	INIT_CK(NULL,			"xtali",	&clk_xtali),
-	INIT_CK("apb:uart1",		NULL,		&clk_uart1),
-	INIT_CK("apb:uart2",		NULL,		&clk_uart2),
-	INIT_CK("apb:uart3",		NULL,		&clk_uart3),
-	INIT_CK(NULL,			"pll1",		&clk_pll1),
-	INIT_CK(NULL,			"fclk",		&clk_f),
-	INIT_CK(NULL,			"hclk",		&clk_h),
-	INIT_CK(NULL,			"apb_pclk",	&clk_p),
-	INIT_CK(NULL,			"pll2",		&clk_pll2),
-	INIT_CK("ep93xx-ohci",		NULL,		&clk_usb_host),
-	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
-	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
-	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
-	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
-	INIT_CK("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
-	INIT_CK("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
-	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
-	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
-	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
-	INIT_CK(NULL,			"m2p2",		&clk_m2p2),
-	INIT_CK(NULL,			"m2p3",		&clk_m2p3),
-	INIT_CK(NULL,			"m2p4",		&clk_m2p4),
-	INIT_CK(NULL,			"m2p5",		&clk_m2p5),
-	INIT_CK(NULL,			"m2p6",		&clk_m2p6),
-	INIT_CK(NULL,			"m2p7",		&clk_m2p7),
-	INIT_CK(NULL,			"m2p8",		&clk_m2p8),
-	INIT_CK(NULL,			"m2p9",		&clk_m2p9),
-	INIT_CK(NULL,			"m2m0",		&clk_m2m0),
-	INIT_CK(NULL,			"m2m1",		&clk_m2m1),
+	CLKDEV_INIT(NULL,			"xtali",	&clk_xtali),
+	CLKDEV_INIT("apb:uart1",		NULL,		&clk_uart1),
+	CLKDEV_INIT("apb:uart2",		NULL,		&clk_uart2),
+	CLKDEV_INIT("apb:uart3",		NULL,		&clk_uart3),
+	CLKDEV_INIT(NULL,			"pll1",		&clk_pll1),
+	CLKDEV_INIT(NULL,			"fclk",		&clk_f),
+	CLKDEV_INIT(NULL,			"hclk",		&clk_h),
+	CLKDEV_INIT(NULL,			"apb_pclk",	&clk_p),
+	CLKDEV_INIT(NULL,			"pll2",		&clk_pll2),
+	CLKDEV_INIT("ep93xx-ohci",		NULL,		&clk_usb_host),
+	CLKDEV_INIT("ep93xx-keypad",	NULL,		&clk_keypad),
+	CLKDEV_INIT("ep93xx-fb",		NULL,		&clk_video),
+	CLKDEV_INIT("ep93xx-spi.0",		NULL,		&clk_spi),
+	CLKDEV_INIT("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
+	CLKDEV_INIT("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
+	CLKDEV_INIT("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
+	CLKDEV_INIT(NULL,			"pwm_clk",	&clk_pwm),
+	CLKDEV_INIT(NULL,			"m2p0",		&clk_m2p0),
+	CLKDEV_INIT(NULL,			"m2p1",		&clk_m2p1),
+	CLKDEV_INIT(NULL,			"m2p2",		&clk_m2p2),
+	CLKDEV_INIT(NULL,			"m2p3",		&clk_m2p3),
+	CLKDEV_INIT(NULL,			"m2p4",		&clk_m2p4),
+	CLKDEV_INIT(NULL,			"m2p5",		&clk_m2p5),
+	CLKDEV_INIT(NULL,			"m2p6",		&clk_m2p6),
+	CLKDEV_INIT(NULL,			"m2p7",		&clk_m2p7),
+	CLKDEV_INIT(NULL,			"m2p8",		&clk_m2p8),
+	CLKDEV_INIT(NULL,			"m2p9",		&clk_m2p9),
+	CLKDEV_INIT(NULL,			"m2m0",		&clk_m2m0),
+	CLKDEV_INIT(NULL,			"m2m1",		&clk_m2m1),
 };
 
 static DEFINE_SPINLOCK(clk_lock);
diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
index 4aabeb2..8bdcfa2 100644
--- a/arch/arm/mach-imx/clock-imx1.c
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -575,29 +575,23 @@ static struct clk rtc_clk = {
 	.parent = &clk32,
 };
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
 static struct clk_lookup lookups[] __initdata = {
-	_REGISTER_CLOCK(NULL, "dma", dma_clk)
-	_REGISTER_CLOCK("mx1-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK(NULL, "mma", mma_clk)
-	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
-	_REGISTER_CLOCK("imx1-uart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("imx1-uart.1", NULL, uart_clk)
-	_REGISTER_CLOCK("imx1-uart.2", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
-	_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
-	_REGISTER_CLOCK("imx-mmc.0", NULL, sdhc_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
-	_REGISTER_CLOCK(NULL, "ssi", ssi_clk)
-	_REGISTER_CLOCK("mxc_rtc.0", NULL, rtc_clk)
+	CLKDEV_INIT(NULL, "dma", &dma_clk),
+	CLKDEV_INIT("mx1-camera.0", NULL, &csi_clk),
+	CLKDEV_INIT(NULL, "mma", &mma_clk),
+	CLKDEV_INIT("imx_udc.0", NULL, &usbd_clk),
+	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
+	CLKDEV_INIT("imx1-uart.0", NULL, &uart_clk),
+	CLKDEV_INIT("imx1-uart.1", NULL, &uart_clk),
+	CLKDEV_INIT("imx1-uart.2", NULL, &uart_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c_clk),
+	CLKDEV_INIT("imx1-cspi.0", NULL, &spi_clk),
+	CLKDEV_INIT("imx1-cspi.1", NULL, &spi_clk),
+	CLKDEV_INIT("imx-mmc.0", NULL, &sdhc_clk),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk),
+	CLKDEV_INIT(NULL, "mshc", &mshc_clk),
+	CLKDEV_INIT(NULL, "ssi", &ssi_clk),
+	CLKDEV_INIT("mxc_rtc.0", NULL, &rtc_clk),
 };
 
 int __init mx1_clocks_init(unsigned long fref)
diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index ee15d8c..2a7747d 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -1139,58 +1139,51 @@ static struct clk clko_clk = {
 	.set_parent = _clk_clko_set_parent,
 };
 
-
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
 static struct clk_lookup lookups[] = {
 /* It's unlikely that any driver wants one of them directly:
-	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
-	_REGISTER_CLOCK(NULL, "ckil", ckil_clk)
-	_REGISTER_CLOCK(NULL, "fpm", fpm_clk)
-	_REGISTER_CLOCK(NULL, "mpll", mpll_clk)
-	_REGISTER_CLOCK(NULL, "spll", spll_clk)
-	_REGISTER_CLOCK(NULL, "fclk", fclk_clk)
-	_REGISTER_CLOCK(NULL, "hclk", hclk_clk)
-	_REGISTER_CLOCK(NULL, "ipg", ipg_clk)
+	CLKDEV_INIT(NULL, "ckih", &ckih_clk),
+	CLKDEV_INIT(NULL, "ckil", &ckil_clk),
+	CLKDEV_INIT(NULL, "fpm", &fpm_clk),
+	CLKDEV_INIT(NULL, "mpll", &mpll_clk),
+	CLKDEV_INIT(NULL, "spll", &spll_clk),
+	CLKDEV_INIT(NULL, "fclk", &fclk_clk),
+	CLKDEV_INIT(NULL, "hclk", &hclk_clk),
+	CLKDEV_INIT(NULL, "ipg", &ipg_clk),
 */
-	_REGISTER_CLOCK(NULL, "perclk1", per_clk[0])
-	_REGISTER_CLOCK(NULL, "perclk2", per_clk[1])
-	_REGISTER_CLOCK(NULL, "perclk3", per_clk[2])
-	_REGISTER_CLOCK(NULL, "perclk4", per_clk[3])
-	_REGISTER_CLOCK(NULL, "clko", clko_clk)
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart_clk[0])
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart_clk[1])
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart_clk[2])
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart_clk[3])
-	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[0])
-	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[1])
-	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[2])
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk[0])
-	_REGISTER_CLOCK(NULL, "sdhc1", sdhc_clk[0])
-	_REGISTER_CLOCK(NULL, "sdhc2", sdhc_clk[1])
-	_REGISTER_CLOCK("imx21-cspi.0", NULL, cspi_clk[0])
-	_REGISTER_CLOCK("imx21-cspi.1", NULL, cspi_clk[1])
-	_REGISTER_CLOCK("imx21-cspi.2", NULL, cspi_clk[2])
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk[0])
-	_REGISTER_CLOCK(NULL, "csi", csi_clk[0])
-	_REGISTER_CLOCK("imx21-hcd.0", NULL, usb_clk[0])
-	_REGISTER_CLOCK(NULL, "ssi1", ssi_clk[0])
-	_REGISTER_CLOCK(NULL, "ssi2", ssi_clk[1])
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK(NULL, "dma", dma_clk[0])
-	_REGISTER_CLOCK(NULL, "brom", brom_clk)
-	_REGISTER_CLOCK(NULL, "emma", emma_clk[0])
-	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk[0])
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
-	_REGISTER_CLOCK(NULL, "owire", owire_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
+	CLKDEV_INIT(NULL, "perclk1", &per_clk[0]),
+	CLKDEV_INIT(NULL, "perclk2", &per_clk[1]),
+	CLKDEV_INIT(NULL, "perclk3", &per_clk[2]),
+	CLKDEV_INIT(NULL, "perclk4", &per_clk[3]),
+	CLKDEV_INIT(NULL, "clko", &clko_clk),
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart_clk[0]),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart_clk[1]),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart_clk[2]),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart_clk[3]),
+	CLKDEV_INIT(NULL, "gpt1", &gpt_clk[0]),
+	CLKDEV_INIT(NULL, "gpt1", &gpt_clk[1]),
+	CLKDEV_INIT(NULL, "gpt1", &gpt_clk[2]),
+	CLKDEV_INIT(NULL, "pwm", &pwm_clk[0]),
+	CLKDEV_INIT(NULL, "sdhc1", &sdhc_clk[0]),
+	CLKDEV_INIT(NULL, "sdhc2", &sdhc_clk[1]),
+	CLKDEV_INIT("imx21-cspi.0", NULL, &cspi_clk[0]),
+	CLKDEV_INIT("imx21-cspi.1", NULL, &cspi_clk[1]),
+	CLKDEV_INIT("imx21-cspi.2", NULL, &cspi_clk[2]),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk[0]),
+	CLKDEV_INIT(NULL, "csi", &csi_clk[0]),
+	CLKDEV_INIT("imx21-hcd.0", NULL, &usb_clk[0]),
+	CLKDEV_INIT(NULL, "ssi1", &ssi_clk[0]),
+	CLKDEV_INIT(NULL, "ssi2", &ssi_clk[1]),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
+	CLKDEV_INIT(NULL, "dma", &dma_clk[0]),
+	CLKDEV_INIT(NULL, "brom", &brom_clk),
+	CLKDEV_INIT(NULL, "emma", &emma_clk[0]),
+	CLKDEV_INIT(NULL, "slcdc", &slcdc_clk[0]),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c_clk),
+	CLKDEV_INIT("mxc-keypad", NULL, &kpp_clk),
+	CLKDEV_INIT(NULL, "owire", &owire_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
 };
 
 /*
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index b0fec74c..85508f4 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -265,53 +265,46 @@ DEFINE_CLOCK(can1_clk,	 0, CCM_CGCR1,  2, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
 DEFINE_CLOCK(iim_clk,    0, CCM_CGCR1, 26, NULL, NULL, NULL);
 
-#define _REGISTER_CLOCK(d, n, c)	\
-	{				\
-		.dev_id = d,		\
-		.con_id = n,		\
-		.clk = &c,		\
-	},
-
 static struct clk_lookup lookups[] = {
 	/* i.mx25 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usbotg_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
 	/* i.mx25 has the i.mx35 type cspi */
-	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx35-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", NULL, pwm2_clk)
-	_REGISTER_CLOCK("mxc_pwm.2", NULL, pwm3_clk)
-	_REGISTER_CLOCK("mxc_pwm.3", NULL, pwm4_clk)
-	_REGISTER_CLOCK("imx-keypad", NULL, kpp_clk)
-	_REGISTER_CLOCK("mx25-adc", NULL, tsc_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c_clk)
-	_REGISTER_CLOCK("imx25-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdt_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx25.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx25.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
+	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx35-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT("imx35-cspi.2", NULL, &cspi3_clk),
+	CLKDEV_INIT("mxc_pwm.0", NULL, &pwm1_clk),
+	CLKDEV_INIT("mxc_pwm.1", NULL, &pwm2_clk),
+	CLKDEV_INIT("mxc_pwm.2", NULL, &pwm3_clk),
+	CLKDEV_INIT("mxc_pwm.3", NULL, &pwm4_clk),
+	CLKDEV_INIT("imx-keypad", NULL, &kpp_clk),
+	CLKDEV_INIT("mx25-adc", NULL, &tsc_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c_clk),
+	CLKDEV_INIT("imx25-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT("imxdi_rtc.0", NULL, &dryice_clk),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdt_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx25.0", NULL, &esdhc1_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx25.1", NULL, &esdhc2_clk),
+	CLKDEV_INIT("mx2-camera.0", NULL, &csi_clk),
+	CLKDEV_INIT(NULL, "audmux", &audmux_clk),
+	CLKDEV_INIT("flexcan.0", NULL, &can1_clk),
+	CLKDEV_INIT("flexcan.1", NULL, &can2_clk),
 	/* i.mx25 has the i.mx35 type sdma */
-	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
+	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
 };
 
 int __init mx25_clocks_init(void)
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 88fe00a..940a8cb 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -616,67 +616,60 @@ DEFINE_CLOCK(uart6_clk,    5, NULL,   0, NULL, &uart6_clk1, &per1_clk);
 DEFINE_CLOCK1(lcdc_clk,    0, NULL,   0, parent, &lcdc_clk1, &per3_clk);
 DEFINE_CLOCK1(csi_clk,     0, NULL,   0, parent, &csi_clk1, &per4_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
 	/* i.mx27 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("imx21-uart.5", NULL, uart6_clk)
-	_REGISTER_CLOCK(NULL, "gpt1", gpt1_clk)
-	_REGISTER_CLOCK(NULL, "gpt2", gpt2_clk)
-	_REGISTER_CLOCK(NULL, "gpt3", gpt3_clk)
-	_REGISTER_CLOCK(NULL, "gpt4", gpt4_clk)
-	_REGISTER_CLOCK(NULL, "gpt5", gpt5_clk)
-	_REGISTER_CLOCK(NULL, "gpt6", gpt6_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
-	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
-	_REGISTER_CLOCK("mxc-mmc.2", NULL, sdhc3_clk)
-	_REGISTER_CLOCK("imx27-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx27-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx27-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK(NULL, "vpu", vpu_clk)
-	_REGISTER_CLOCK(NULL, "dma", dma_clk)
-	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-	_REGISTER_CLOCK(NULL, "brom", brom_clk)
-	_REGISTER_CLOCK(NULL, "emma", emma_clk)
-	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk)
-	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK(NULL, "sahara2", sahara2_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
-	_REGISTER_CLOCK(NULL, "mstick", mstick_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
-	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
-	_REGISTER_CLOCK(NULL, "scc", scc_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT("imx21-uart.5", NULL, &uart6_clk),
+	CLKDEV_INIT(NULL, "gpt1", &gpt1_clk),
+	CLKDEV_INIT(NULL, "gpt2", &gpt2_clk),
+	CLKDEV_INIT(NULL, "gpt3", &gpt3_clk),
+	CLKDEV_INIT(NULL, "gpt4", &gpt4_clk),
+	CLKDEV_INIT(NULL, "gpt5", &gpt5_clk),
+	CLKDEV_INIT(NULL, "gpt6", &gpt6_clk),
+	CLKDEV_INIT("mxc_pwm.0", NULL, &pwm_clk),
+	CLKDEV_INIT("mxc-mmc.0", NULL, &sdhc1_clk),
+	CLKDEV_INIT("mxc-mmc.1", NULL, &sdhc2_clk),
+	CLKDEV_INIT("mxc-mmc.2", NULL, &sdhc3_clk),
+	CLKDEV_INIT("imx27-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx27-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT("imx27-cspi.2", NULL, &cspi3_clk),
+	CLKDEV_INIT("imx-fb.0", NULL, &lcdc_clk),
+	CLKDEV_INIT("mx2-camera.0", NULL, &csi_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usb_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usb_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usb_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usb_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb_ahb", &usb_clk1),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
+	CLKDEV_INIT(NULL, "vpu", &vpu_clk),
+	CLKDEV_INIT(NULL, "dma", &dma_clk),
+	CLKDEV_INIT(NULL, "rtic", &rtic_clk),
+	CLKDEV_INIT(NULL, "brom", &brom_clk),
+	CLKDEV_INIT(NULL, "emma", &emma_clk),
+	CLKDEV_INIT(NULL, "slcdc", &slcdc_clk),
+	CLKDEV_INIT("imx27-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT(NULL, "sahara2", &sahara2_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
+	CLKDEV_INIT(NULL, "mstick", &mstick_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
+	CLKDEV_INIT(NULL, "kpp", &kpp_clk),
+	CLKDEV_INIT("mxc_w1.0", NULL, &owire_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT(NULL, "scc", &scc_clk),
 };
 
 /* Adjust the clock path for TO2 and later */
diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index 988a281..56510c5 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -516,63 +516,56 @@ DEFINE_CLOCK(nfc_clk,     0, NULL,          0, nfc_get_rate, NULL, &ahb_clk);
 DEFINE_CLOCK(scc_clk,     0, NULL,          0, NULL, NULL, &ipg_clk);
 DEFINE_CLOCK(ipg_clk,     0, NULL,          0, ipg_get_rate, NULL, &ahb_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK("imx31-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx31-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK("imx31-cspi.2", NULL, cspi3_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
-	_REGISTER_CLOCK(NULL, "epit", epit1_clk)
-	_REGISTER_CLOCK(NULL, "epit", epit2_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
-	_REGISTER_CLOCK("ipu-core", NULL, ipu_clk)
-	_REGISTER_CLOCK("mx3_sdc_fb", NULL, ipu_clk)
-	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk1)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mx3-camera.0", NULL, csi_clk)
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT("imx31-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx31-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT("imx31-cspi.2", NULL, &cspi3_clk),
+	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
+	CLKDEV_INIT(NULL, "pwm", &pwm_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT(NULL, "epit", &epit1_clk),
+	CLKDEV_INIT(NULL, "epit", &epit2_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
+	CLKDEV_INIT("ipu-core", NULL, &ipu_clk),
+	CLKDEV_INIT("mx3_sdc_fb", NULL, &ipu_clk),
+	CLKDEV_INIT(NULL, "kpp", &kpp_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.0", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.1", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usb_clk1),
+	CLKDEV_INIT("mxc-ehci.2", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usb_clk1),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &usb_clk2),
+	CLKDEV_INIT("mx3-camera.0", NULL, &csi_clk),
 	/* i.mx31 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_clk)
-	_REGISTER_CLOCK("mxc_w1.0", NULL, owire_clk)
-	_REGISTER_CLOCK("mxc-mmc.0", NULL, sdhc1_clk)
-	_REGISTER_CLOCK("mxc-mmc.1", NULL, sdhc2_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK(NULL, "firi", firi_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
-	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-	_REGISTER_CLOCK(NULL, "rng", rng_clk)
-	_REGISTER_CLOCK("imx31-sdma", NULL, sdma_clk1)
-	_REGISTER_CLOCK(NULL, "sdma_ipg", sdma_clk2)
-	_REGISTER_CLOCK(NULL, "mstick", mstick1_clk)
-	_REGISTER_CLOCK(NULL, "mstick", mstick2_clk)
-	_REGISTER_CLOCK(NULL, "scc", scc_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
-	_REGISTER_CLOCK(NULL, "mpeg4", mpeg4_clk)
-	_REGISTER_CLOCK(NULL, "mbx", mbx_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c3_clk),
+	CLKDEV_INIT("mxc_w1.0", NULL, &owire_clk),
+	CLKDEV_INIT("mxc-mmc.0", NULL, &sdhc1_clk),
+	CLKDEV_INIT("mxc-mmc.1", NULL, &sdhc2_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT(NULL, "firi", &firi_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
+	CLKDEV_INIT(NULL, "rtic", &rtic_clk),
+	CLKDEV_INIT(NULL, "rng", &rng_clk),
+	CLKDEV_INIT("imx31-sdma", NULL, &sdma_clk1),
+	CLKDEV_INIT(NULL, "sdma_ipg", &sdma_clk2),
+	CLKDEV_INIT(NULL, "mstick", &mstick1_clk),
+	CLKDEV_INIT(NULL, "mstick", &mstick2_clk),
+	CLKDEV_INIT(NULL, "scc", &scc_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
+	CLKDEV_INIT(NULL, "mpeg4", &mpeg4_clk),
+	CLKDEV_INIT(NULL, "mbx", &mbx_clk),
 };
 
 int __init mx31_clocks_init(unsigned long fref)
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 8116f11..8f5e1d9 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -438,71 +438,64 @@ static struct clk nfc_clk = {
 	.disable	= clk_dummy_disable
 };
 
-#define _REGISTER_CLOCK(d, n, c)	\
-	{				\
-		.dev_id = d,		\
-		.con_id = n,		\
-		.clk = &c,		\
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "asrc", asrc_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can1_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can2_clk)
-	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi1_clk)
-	_REGISTER_CLOCK("imx35-cspi.1", NULL, cspi2_clk)
-	_REGISTER_CLOCK(NULL, "ect", ect_clk)
-	_REGISTER_CLOCK(NULL, "edio", edio_clk)
-	_REGISTER_CLOCK(NULL, "emi", emi_clk)
-	_REGISTER_CLOCK("imx-epit.0", NULL, epit1_clk)
-	_REGISTER_CLOCK("imx-epit.1", NULL, epit2_clk)
-	_REGISTER_CLOCK(NULL, "esai", esai_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx35.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx35.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx35.2", NULL, esdhc3_clk)
+	CLKDEV_INIT(NULL, "asrc", &asrc_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
+	CLKDEV_INIT("flexcan.0", NULL, &can1_clk),
+	CLKDEV_INIT("flexcan.1", NULL, &can2_clk),
+	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi1_clk),
+	CLKDEV_INIT("imx35-cspi.1", NULL, &cspi2_clk),
+	CLKDEV_INIT(NULL, "ect", &ect_clk),
+	CLKDEV_INIT(NULL, "edio", &edio_clk),
+	CLKDEV_INIT(NULL, "emi", &emi_clk),
+	CLKDEV_INIT("imx-epit.0", NULL, &epit1_clk),
+	CLKDEV_INIT("imx-epit.1", NULL, &epit2_clk),
+	CLKDEV_INIT(NULL, "esai", &esai_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx35.0", NULL, &esdhc1_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx35.1", NULL, &esdhc2_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx35.2", NULL, &esdhc3_clk),
 	/* i.mx35 has the i.mx27 type fec */
-	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio1_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio2_clk)
-	_REGISTER_CLOCK(NULL, "gpio", gpio3_clk)
-	_REGISTER_CLOCK("gpt.0", NULL, gpt_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_clk)
-	_REGISTER_CLOCK(NULL, "iomuxc", iomuxc_clk)
-	_REGISTER_CLOCK("ipu-core", NULL, ipu_clk)
-	_REGISTER_CLOCK("mx3_sdc_fb", NULL, ipu_clk)
-	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK(NULL, "mlb", mlb_clk)
-	_REGISTER_CLOCK(NULL, "mshc", mshc_clk)
-	_REGISTER_CLOCK("mxc_w1", NULL, owire_clk)
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-	_REGISTER_CLOCK(NULL, "rngc", rngc_clk)
-	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
-	_REGISTER_CLOCK(NULL, "rtic", rtic_clk)
-	_REGISTER_CLOCK(NULL, "scc", scc_clk)
-	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
-	_REGISTER_CLOCK(NULL, "spba", spba_clk)
-	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	CLKDEV_INIT("imx27-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio1_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio2_clk),
+	CLKDEV_INIT(NULL, "gpio", &gpio3_clk),
+	CLKDEV_INIT("gpt.0", NULL, &gpt_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c3_clk),
+	CLKDEV_INIT(NULL, "iomuxc", &iomuxc_clk),
+	CLKDEV_INIT("ipu-core", NULL, &ipu_clk),
+	CLKDEV_INIT("mx3_sdc_fb", NULL, &ipu_clk),
+	CLKDEV_INIT(NULL, "kpp", &kpp_clk),
+	CLKDEV_INIT(NULL, "mlb", &mlb_clk),
+	CLKDEV_INIT(NULL, "mshc", &mshc_clk),
+	CLKDEV_INIT("mxc_w1", NULL, &owire_clk),
+	CLKDEV_INIT(NULL, "pwm", &pwm_clk),
+	CLKDEV_INIT(NULL, "rngc", &rngc_clk),
+	CLKDEV_INIT(NULL, "rtc", &rtc_clk),
+	CLKDEV_INIT(NULL, "rtic", &rtic_clk),
+	CLKDEV_INIT(NULL, "scc", &scc_clk),
+	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
+	CLKDEV_INIT(NULL, "spba", &spba_clk),
+	CLKDEV_INIT(NULL, "spdif", &spdif_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
 	/* i.mx35 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
-	_REGISTER_CLOCK(NULL, "max", max_clk)
-	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
-	_REGISTER_CLOCK(NULL, "csi", csi_clk)
-	_REGISTER_CLOCK(NULL, "iim", iim_clk)
-	_REGISTER_CLOCK(NULL, "gpu2d", gpu2d_clk)
-	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usbotg_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usbotg_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usbotg_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &usbahb_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &wdog_clk),
+	CLKDEV_INIT(NULL, "max", &max_clk),
+	CLKDEV_INIT(NULL, "audmux", &audmux_clk),
+	CLKDEV_INIT(NULL, "csi", &csi_clk),
+	CLKDEV_INIT(NULL, "iim", &iim_clk),
+	CLKDEV_INIT(NULL, "gpu2d", &gpu2d_clk),
+	CLKDEV_INIT("mxc_nand.0", NULL, &nfc_clk),
 };
 
 int __init mx35_clocks_init()
diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
index 1e02751..37034c2 100644
--- a/arch/arm/mach-lpc32xx/clock.c
+++ b/arch/arm/mach-lpc32xx/clock.c
@@ -1041,48 +1041,41 @@ struct clk *clk_get_parent(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_get_parent);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = (d), \
-		.con_id = (n), \
-		.clk = &(c), \
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "osc_32KHz", osc_32KHz)
-	_REGISTER_CLOCK(NULL, "osc_pll397", osc_pll397)
-	_REGISTER_CLOCK(NULL, "osc_main", osc_main)
-	_REGISTER_CLOCK(NULL, "sys_ck", clk_sys)
-	_REGISTER_CLOCK(NULL, "arm_pll_ck", clk_armpll)
-	_REGISTER_CLOCK(NULL, "ck_pll5", clk_usbpll)
-	_REGISTER_CLOCK(NULL, "hclk_ck", clk_hclk)
-	_REGISTER_CLOCK(NULL, "pclk_ck", clk_pclk)
-	_REGISTER_CLOCK(NULL, "timer0_ck", clk_timer0)
-	_REGISTER_CLOCK(NULL, "timer1_ck", clk_timer1)
-	_REGISTER_CLOCK(NULL, "timer2_ck", clk_timer2)
-	_REGISTER_CLOCK(NULL, "timer3_ck", clk_timer3)
-	_REGISTER_CLOCK(NULL, "vfp9_ck", clk_vfp9)
-	_REGISTER_CLOCK(NULL, "clk_dmac", clk_dma)
-	_REGISTER_CLOCK("pnx4008-watchdog", NULL, clk_wdt)
-	_REGISTER_CLOCK(NULL, "uart3_ck", clk_uart3)
-	_REGISTER_CLOCK(NULL, "uart4_ck", clk_uart4)
-	_REGISTER_CLOCK(NULL, "uart5_ck", clk_uart5)
-	_REGISTER_CLOCK(NULL, "uart6_ck", clk_uart6)
-	_REGISTER_CLOCK("pnx-i2c.0", NULL, clk_i2c0)
-	_REGISTER_CLOCK("pnx-i2c.1", NULL, clk_i2c1)
-	_REGISTER_CLOCK("pnx-i2c.2", NULL, clk_i2c2)
-	_REGISTER_CLOCK("dev:ssp0", NULL, clk_ssp0)
-	_REGISTER_CLOCK("dev:ssp1", NULL, clk_ssp1)
-	_REGISTER_CLOCK("lpc32xx_keys.0", NULL, clk_kscan)
-	_REGISTER_CLOCK("lpc32xx-nand.0", "nand_ck", clk_nand)
-	_REGISTER_CLOCK("tbd", "i2s0_ck", clk_i2s0)
-	_REGISTER_CLOCK("tbd", "i2s1_ck", clk_i2s1)
-	_REGISTER_CLOCK("ts-lpc32xx", NULL, clk_tsc)
-	_REGISTER_CLOCK("dev:mmc0", "MCLK", clk_mmc)
-	_REGISTER_CLOCK("lpc-net.0", NULL, clk_net)
-	_REGISTER_CLOCK("dev:clcd", NULL, clk_lcd)
-	_REGISTER_CLOCK("lpc32xx_udc", "ck_usbd", clk_usbd)
-	_REGISTER_CLOCK("lpc32xx_rtc", NULL, clk_rtc)
+	CLKDEV_INIT(NULL, "osc_32KHz", &osc_32KHz),
+	CLKDEV_INIT(NULL, "osc_pll397", &osc_pll397),
+	CLKDEV_INIT(NULL, "osc_main", &osc_main),
+	CLKDEV_INIT(NULL, "sys_ck", &clk_sys),
+	CLKDEV_INIT(NULL, "arm_pll_ck", &clk_armpll),
+	CLKDEV_INIT(NULL, "ck_pll5", &clk_usbpll),
+	CLKDEV_INIT(NULL, "hclk_ck", &clk_hclk),
+	CLKDEV_INIT(NULL, "pclk_ck", &clk_pclk),
+	CLKDEV_INIT(NULL, "timer0_ck", &clk_timer0),
+	CLKDEV_INIT(NULL, "timer1_ck", &clk_timer1),
+	CLKDEV_INIT(NULL, "timer2_ck", &clk_timer2),
+	CLKDEV_INIT(NULL, "timer3_ck", &clk_timer3),
+	CLKDEV_INIT(NULL, "vfp9_ck", &clk_vfp9),
+	CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
+	CLKDEV_INIT("pnx4008-watchdog", NULL, &clk_wdt),
+	CLKDEV_INIT(NULL, "uart3_ck", &clk_uart3),
+	CLKDEV_INIT(NULL, "uart4_ck", &clk_uart4),
+	CLKDEV_INIT(NULL, "uart5_ck", &clk_uart5),
+	CLKDEV_INIT(NULL, "uart6_ck", &clk_uart6),
+	CLKDEV_INIT("pnx-i2c.0", NULL, &clk_i2c0),
+	CLKDEV_INIT("pnx-i2c.1", NULL, &clk_i2c1),
+	CLKDEV_INIT("pnx-i2c.2", NULL, &clk_i2c2),
+	CLKDEV_INIT("dev:ssp0", NULL, &clk_ssp0),
+	CLKDEV_INIT("dev:ssp1", NULL, &clk_ssp1),
+	CLKDEV_INIT("lpc32xx_keys.0", NULL, &clk_kscan),
+	CLKDEV_INIT("lpc32xx-nand.0", "nand_ck", &clk_nand),
+	CLKDEV_INIT("tbd", "i2s0_ck", &clk_i2s0),
+	CLKDEV_INIT("tbd", "i2s1_ck", &clk_i2s1),
+	CLKDEV_INIT("ts-lpc32xx", NULL, &clk_tsc),
+	CLKDEV_INIT("dev:mmc0", "MCLK", &clk_mmc),
+	CLKDEV_INIT("lpc-net.0", NULL, &clk_net),
+	CLKDEV_INIT("dev:clcd", NULL, &clk_lcd),
+	CLKDEV_INIT("lpc32xx_udc", "ck_usbd", &clk_usbd),
+	CLKDEV_INIT("lpc32xx_rtc", NULL, &clk_rtc),
 };
 
 static int __init clk_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2b9bd1f..d198515 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1422,97 +1422,90 @@ DEFINE_CLOCK(ipu_di1_clk, 0, MXC_CCM_CCGR6, MXC_CCM_CCGRx_CG6_OFFSET,
 DEFINE_CLOCK(pata_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG0_OFFSET,
 		NULL, NULL, &ipg_clk, &spba_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-       { \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c,   \
-       },
-
 static struct clk_lookup mx51_lookups[] = {
 	/* i.mx51 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
 	/* i.mx51 has the i.mx27 type fec */
-	_REGISTER_CLOCK("imx27-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
-	_REGISTER_CLOCK("mxc_pwm.1", "pwm", pwm2_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_ahb_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_ahb_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_ahb_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
-	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
-	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
-	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
+	CLKDEV_INIT("imx27-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT("mxc_pwm.0", "pwm", &pwm1_clk),
+	CLKDEV_INIT("mxc_pwm.1", "pwm", &pwm2_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &hsi2c_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb", &usboh3_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb_ahb", &usb_ahb_clk),
+	CLKDEV_INIT("mxc-ehci.0", "usb_phy1", &usb_phy1_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb", &usboh3_clk),
+	CLKDEV_INIT("mxc-ehci.1", "usb_ahb", &usb_ahb_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb", &usboh3_clk),
+	CLKDEV_INIT("mxc-ehci.2", "usb_ahb", &usb_ahb_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb", &usboh3_clk),
+	CLKDEV_INIT("fsl-usb2-udc", "usb_ahb", &ahb_clk),
+	CLKDEV_INIT("imx-keypad", NULL, &dummy_clk),
+	CLKDEV_INIT("mxc_nand", NULL, &nfc_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT("imx-ssi.2", NULL, &ssi3_clk),
 	/* i.mx51 has the i.mx35 type sdma */
-	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
-	_REGISTER_CLOCK(NULL, "ckih", ckih_clk)
-	_REGISTER_CLOCK(NULL, "ckih2", ckih2_clk)
-	_REGISTER_CLOCK(NULL, "gpt_32k", gpt_32k_clk)
-	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
-	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
+	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
+	CLKDEV_INIT(NULL, "ckih", &ckih_clk),
+	CLKDEV_INIT(NULL, "ckih2", &ckih2_clk),
+	CLKDEV_INIT(NULL, "gpt_32k", &gpt_32k_clk),
+	CLKDEV_INIT("imx51-ecspi.0", NULL, &ecspi1_clk),
+	CLKDEV_INIT("imx51-ecspi.1", NULL, &ecspi2_clk),
 	/* i.mx51 has the i.mx35 type cspi */
-	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx51.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx51.1", NULL, esdhc2_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx51.2", NULL, esdhc3_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx51.3", NULL, esdhc4_clk)
-	_REGISTER_CLOCK(NULL, "cpu_clk", cpu_clk)
-	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
-	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
-	_REGISTER_CLOCK(NULL, "mipi_hsp", mipi_hsp_clk)
-	_REGISTER_CLOCK("imx-ipuv3", NULL, ipu_clk)
-	_REGISTER_CLOCK("imx-ipuv3", "di0", ipu_di0_clk)
-	_REGISTER_CLOCK("imx-ipuv3", "di1", ipu_di1_clk)
-	_REGISTER_CLOCK(NULL, "gpc_dvfs", gpc_dvfs_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
+	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx51.0", NULL, &esdhc1_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx51.1", NULL, &esdhc2_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx51.2", NULL, &esdhc3_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx51.3", NULL, &esdhc4_clk),
+	CLKDEV_INIT(NULL, "cpu_clk", &cpu_clk),
+	CLKDEV_INIT(NULL, "iim_clk", &iim_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &dummy_clk),
+	CLKDEV_INIT("imx2-wdt.1", NULL, &dummy_clk),
+	CLKDEV_INIT(NULL, "mipi_hsp", &mipi_hsp_clk),
+	CLKDEV_INIT("imx-ipuv3", NULL, &ipu_clk),
+	CLKDEV_INIT("imx-ipuv3", "di0", &ipu_di0_clk),
+	CLKDEV_INIT("imx-ipuv3", "di1", &ipu_di1_clk),
+	CLKDEV_INIT(NULL, "gpc_dvfs", &gpc_dvfs_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
 };
 
 static struct clk_lookup mx53_lookups[] = {
 	/* i.mx53 has the i.mx21 type uart */
-	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
+	CLKDEV_INIT("imx21-uart.0", NULL, &uart1_clk),
+	CLKDEV_INIT("imx21-uart.1", NULL, &uart2_clk),
+	CLKDEV_INIT("imx21-uart.2", NULL, &uart3_clk),
+	CLKDEV_INIT("imx21-uart.3", NULL, &uart4_clk),
+	CLKDEV_INIT("imx21-uart.4", NULL, &uart5_clk),
+	CLKDEV_INIT(NULL, "gpt", &gpt_clk),
 	/* i.mx53 has the i.mx25 type fec */
-	_REGISTER_CLOCK("imx25-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
-	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
-	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
-	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_mx53_clk)
+	CLKDEV_INIT("imx25-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT(NULL, "iim_clk", &iim_clk),
+	CLKDEV_INIT("imx-i2c.0", NULL, &i2c1_clk),
+	CLKDEV_INIT("imx-i2c.1", NULL, &i2c2_clk),
+	CLKDEV_INIT("imx-i2c.2", NULL, &i2c3_mx53_clk),
 	/* i.mx53 has the i.mx51 type ecspi */
-	_REGISTER_CLOCK("imx51-ecspi.0", NULL, ecspi1_clk)
-	_REGISTER_CLOCK("imx51-ecspi.1", NULL, ecspi2_clk)
+	CLKDEV_INIT("imx51-ecspi.0", NULL, &ecspi1_clk),
+	CLKDEV_INIT("imx51-ecspi.1", NULL, &ecspi2_clk),
 	/* i.mx53 has the i.mx25 type cspi */
-	_REGISTER_CLOCK("imx35-cspi.0", NULL, cspi_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx53.0", NULL, esdhc1_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx53.1", NULL, esdhc2_mx53_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx53.2", NULL, esdhc3_mx53_clk)
-	_REGISTER_CLOCK("sdhci-esdhc-imx53.3", NULL, esdhc4_mx53_clk)
-	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
-	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
+	CLKDEV_INIT("imx35-cspi.0", NULL, &cspi_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx53.0", NULL, &esdhc1_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx53.1", NULL, &esdhc2_mx53_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx53.2", NULL, &esdhc3_mx53_clk),
+	CLKDEV_INIT("sdhci-esdhc-imx53.3", NULL, &esdhc4_mx53_clk),
+	CLKDEV_INIT("imx2-wdt.0", NULL, &dummy_clk),
+	CLKDEV_INIT("imx2-wdt.1", NULL, &dummy_clk),
 	/* i.mx53 has the i.mx35 type sdma */
-	_REGISTER_CLOCK("imx35-sdma", NULL, sdma_clk)
-	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
-	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
-	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
-	_REGISTER_CLOCK("pata_imx", NULL, pata_clk)
+	CLKDEV_INIT("imx35-sdma", NULL, &sdma_clk),
+	CLKDEV_INIT("imx-ssi.0", NULL, &ssi1_clk),
+	CLKDEV_INIT("imx-ssi.1", NULL, &ssi2_clk),
+	CLKDEV_INIT("imx-ssi.2", NULL, &ssi3_clk),
+	CLKDEV_INIT("imx-keypad", NULL, &dummy_clk),
+	CLKDEV_INIT("pata_imx", NULL, &pata_clk),
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 0163b6d..7714dc2 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -430,32 +430,25 @@ _DEFINE_CLOCK(audio_clk, XTAL, FILT_CLK24M_GATE, &ref_xtal_clk);
 _DEFINE_CLOCK(pwm_clk, XTAL, PWM_CLK24M_GATE, &ref_xtal_clk);
 _DEFINE_CLOCK(clk32k_clk, XTAL, TIMROT_CLK32K_GATE, &ref_xtal_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
 	/* for amba bus driver */
-	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
+	CLKDEV_INIT("duart", "apb_pclk", &xbus_clk),
 	/* for amba-pl011 driver */
-	_REGISTER_CLOCK("duart", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
-	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
-	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
-	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp_clk)
-	_REGISTER_CLOCK(NULL, "usb", usb_clk)
-	_REGISTER_CLOCK(NULL, "audio", audio_clk)
-	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
-	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
+	CLKDEV_INIT("duart", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.0", NULL, &uart_clk),
+	CLKDEV_INIT("rtc", NULL, &rtc_clk),
+	CLKDEV_INIT("mxs-dma-apbh", NULL, &hbus_clk),
+	CLKDEV_INIT("mxs-dma-apbx", NULL, &xbus_clk),
+	CLKDEV_INIT("mxs-mmc.0", NULL, &ssp_clk),
+	CLKDEV_INIT("mxs-mmc.1", NULL, &ssp_clk),
+	CLKDEV_INIT(NULL, "usb", &usb_clk),
+	CLKDEV_INIT(NULL, "audio", &audio_clk),
+	CLKDEV_INIT("mxs-pwm.0", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.1", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.2", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.3", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.4", NULL, &pwm_clk),
+	CLKDEV_INIT("imx23-fb", NULL, &lcdif_clk),
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 7b28c2a..1c5c929 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -604,48 +604,41 @@ _DEFINE_CLOCK(clk32k_clk, XTAL, TIMROT_CLK32K_GATE, &ref_xtal_clk);
 _DEFINE_CLOCK(spdif_clk, SPDIF, CLKGATE, &pll0_clk);
 _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
 	/* for amba bus driver */
-	_REGISTER_CLOCK("duart", "apb_pclk", xbus_clk)
+	CLKDEV_INIT("duart", "apb_pclk", &xbus_clk),
 	/* for amba-pl011 driver */
-	_REGISTER_CLOCK("duart", NULL, uart_clk)
-	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
-	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
-	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.3", NULL, uart_clk)
-	_REGISTER_CLOCK("mxs-auart.4", NULL, uart_clk)
-	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
-	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
-	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
-	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
-	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
-	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
-	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
-	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
-	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
-	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.5", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.6", NULL, pwm_clk)
-	_REGISTER_CLOCK("mxs-pwm.7", NULL, pwm_clk)
-	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
-	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
-	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
-	_REGISTER_CLOCK("mxs-saif.0", NULL, saif0_clk)
-	_REGISTER_CLOCK("mxs-saif.1", NULL, saif1_clk)
+	CLKDEV_INIT("duart", NULL, &uart_clk),
+	CLKDEV_INIT("imx28-fec.0", NULL, &fec_clk),
+	CLKDEV_INIT("imx28-fec.1", NULL, &fec_clk),
+	CLKDEV_INIT("mxs-auart.0", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.1", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.2", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.3", NULL, &uart_clk),
+	CLKDEV_INIT("mxs-auart.4", NULL, &uart_clk),
+	CLKDEV_INIT("rtc", NULL, &rtc_clk),
+	CLKDEV_INIT("pll2", NULL, &pll2_clk),
+	CLKDEV_INIT("mxs-dma-apbh", NULL, &hbus_clk),
+	CLKDEV_INIT("mxs-dma-apbx", NULL, &xbus_clk),
+	CLKDEV_INIT("mxs-mmc.0", NULL, &ssp0_clk),
+	CLKDEV_INIT("mxs-mmc.1", NULL, &ssp1_clk),
+	CLKDEV_INIT("flexcan.0", NULL, &can0_clk),
+	CLKDEV_INIT("flexcan.1", NULL, &can1_clk),
+	CLKDEV_INIT(NULL, "usb0", &usb0_clk),
+	CLKDEV_INIT(NULL, "usb1", &usb1_clk),
+	CLKDEV_INIT("mxs-pwm.0", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.1", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.2", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.3", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.4", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.5", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.6", NULL, &pwm_clk),
+	CLKDEV_INIT("mxs-pwm.7", NULL, &pwm_clk),
+	CLKDEV_INIT(NULL, "lradc", &lradc_clk),
+	CLKDEV_INIT(NULL, "spdif", &spdif_clk),
+	CLKDEV_INIT("imx28-fb", NULL, &lcdif_clk),
+	CLKDEV_INIT("mxs-saif.0", NULL, &saif0_clk),
+	CLKDEV_INIT("mxs-saif.1", NULL, &saif1_clk),
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-tcc8k/clock.c b/arch/arm/mach-tcc8k/clock.c
index e7cdae5..6b3dd06 100644
--- a/arch/arm/mach-tcc8k/clock.c
+++ b/arch/arm/mach-tcc8k/clock.c
@@ -468,64 +468,57 @@ DEFINE_BCLOCK(gdma2, BCLKCTR1, 17, NULL, NULL)
 DEFINE_BCLOCK(gdma3, BCLKCTR1, 18, NULL, NULL)
 DEFINE_BCLOCK(ddrc, BCLKCTR1, 19, NULL, NULL)
 
-#define _REGISTER_CLOCK(d, n, c) \
-	{ \
-		.dev_id = d, \
-		.con_id = n, \
-		.clk = &c, \
-	},
-
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK(NULL, "bus", bus)
-	_REGISTER_CLOCK(NULL, "cpu", cpu)
-	_REGISTER_CLOCK(NULL, "tct", tct)
-	_REGISTER_CLOCK(NULL, "tcx", tcx)
-	_REGISTER_CLOCK(NULL, "tcz", tcz)
-	_REGISTER_CLOCK(NULL, "ref", ref)
-	_REGISTER_CLOCK(NULL, "dai0", dai0)
-	_REGISTER_CLOCK(NULL, "pic", pic)
-	_REGISTER_CLOCK(NULL, "tc", tc)
-	_REGISTER_CLOCK(NULL, "gpio", gpio)
-	_REGISTER_CLOCK(NULL, "usbd", usbd)
-	_REGISTER_CLOCK("tcc-uart.0", NULL, uart0)
-	_REGISTER_CLOCK("tcc-uart.2", NULL, uart2)
-	_REGISTER_CLOCK("tcc-i2c", NULL, i2c)
-	_REGISTER_CLOCK("tcc-uart.3", NULL, uart3)
-	_REGISTER_CLOCK(NULL, "ecc", ecc)
-	_REGISTER_CLOCK(NULL, "adc", adc)
-	_REGISTER_CLOCK("tcc-usbh.0", "usb", usbh0)
-	_REGISTER_CLOCK(NULL, "gdma0", gdma0)
-	_REGISTER_CLOCK(NULL, "lcd", lcd)
-	_REGISTER_CLOCK(NULL, "rtc", rtc)
-	_REGISTER_CLOCK(NULL, "nfc", nfc)
-	_REGISTER_CLOCK("tcc-mmc.0", NULL, sd0)
-	_REGISTER_CLOCK(NULL, "g2d", g2d)
-	_REGISTER_CLOCK(NULL, "gdma1", gdma1)
-	_REGISTER_CLOCK("tcc-uart.1", NULL, uart1)
-	_REGISTER_CLOCK("tcc-spi.0", NULL, spi0)
-	_REGISTER_CLOCK(NULL, "mscl", mscl)
-	_REGISTER_CLOCK("tcc-spi.1", NULL, spi1)
-	_REGISTER_CLOCK(NULL, "bdma", bdma)
-	_REGISTER_CLOCK(NULL, "adma0", adma0)
-	_REGISTER_CLOCK(NULL, "spdif", spdif)
-	_REGISTER_CLOCK(NULL, "scfg", scfg)
-	_REGISTER_CLOCK(NULL, "cid", cid)
-	_REGISTER_CLOCK("tcc-mmc.1", NULL, sd1)
-	_REGISTER_CLOCK("tcc-uart.4", NULL, uart4)
-	_REGISTER_CLOCK(NULL, "dai1", dai1)
-	_REGISTER_CLOCK(NULL, "adma1", adma1)
-	_REGISTER_CLOCK(NULL, "c3dec", c3dec)
-	_REGISTER_CLOCK("tcc-can.0", NULL, can0)
-	_REGISTER_CLOCK("tcc-can.1", NULL, can1)
-	_REGISTER_CLOCK(NULL, "gps", gps)
-	_REGISTER_CLOCK("tcc-gsb.0", NULL, gsb0)
-	_REGISTER_CLOCK("tcc-gsb.1", NULL, gsb1)
-	_REGISTER_CLOCK("tcc-gsb.2", NULL, gsb2)
-	_REGISTER_CLOCK("tcc-gsb.3", NULL, gsb3)
-	_REGISTER_CLOCK(NULL, "gdma2", gdma2)
-	_REGISTER_CLOCK(NULL, "gdma3", gdma3)
-	_REGISTER_CLOCK(NULL, "ddrc", ddrc)
-	_REGISTER_CLOCK("tcc-usbh.1", "usb", usbh1)
+	CLKDEV_INIT(NULL, "bus", &bus),
+	CLKDEV_INIT(NULL, "cpu", &cpu),
+	CLKDEV_INIT(NULL, "tct", &tct),
+	CLKDEV_INIT(NULL, "tcx", &tcx),
+	CLKDEV_INIT(NULL, "tcz", &tcz),
+	CLKDEV_INIT(NULL, "ref", &ref),
+	CLKDEV_INIT(NULL, "dai0", &dai0),
+	CLKDEV_INIT(NULL, "pic", &pic),
+	CLKDEV_INIT(NULL, "tc", &tc),
+	CLKDEV_INIT(NULL, "gpio", &gpio),
+	CLKDEV_INIT(NULL, "usbd", &usbd),
+	CLKDEV_INIT("tcc-uart.0", NULL, &uart0),
+	CLKDEV_INIT("tcc-uart.2", NULL, &uart2),
+	CLKDEV_INIT("tcc-i2c", NULL, &i2c),
+	CLKDEV_INIT("tcc-uart.3", NULL, &uart3),
+	CLKDEV_INIT(NULL, "ecc", &ecc),
+	CLKDEV_INIT(NULL, "adc", &adc),
+	CLKDEV_INIT("tcc-usbh.0", "usb", &usbh0),
+	CLKDEV_INIT(NULL, "gdma0", &gdma0),
+	CLKDEV_INIT(NULL, "lcd", &lcd),
+	CLKDEV_INIT(NULL, "rtc", &rtc),
+	CLKDEV_INIT(NULL, "nfc", &nfc),
+	CLKDEV_INIT("tcc-mmc.0", NULL, &sd0),
+	CLKDEV_INIT(NULL, "g2d", &g2d),
+	CLKDEV_INIT(NULL, "gdma1", &gdma1),
+	CLKDEV_INIT("tcc-uart.1", NULL, &uart1),
+	CLKDEV_INIT("tcc-spi.0", NULL, &spi0),
+	CLKDEV_INIT(NULL, "mscl", &mscl),
+	CLKDEV_INIT("tcc-spi.1", NULL, &spi1),
+	CLKDEV_INIT(NULL, "bdma", &bdma),
+	CLKDEV_INIT(NULL, "adma0", &adma0),
+	CLKDEV_INIT(NULL, "spdif", &spdif),
+	CLKDEV_INIT(NULL, "scfg", &scfg),
+	CLKDEV_INIT(NULL, "cid", &cid),
+	CLKDEV_INIT("tcc-mmc.1", NULL, &sd1),
+	CLKDEV_INIT("tcc-uart.4", NULL, &uart4),
+	CLKDEV_INIT(NULL, "dai1", &dai1),
+	CLKDEV_INIT(NULL, "adma1", &adma1),
+	CLKDEV_INIT(NULL, "c3dec", &c3dec),
+	CLKDEV_INIT("tcc-can.0", NULL, &can0),
+	CLKDEV_INIT("tcc-can.1", NULL, &can1),
+	CLKDEV_INIT(NULL, "gps", &gps),
+	CLKDEV_INIT("tcc-gsb.0", NULL, &gsb0),
+	CLKDEV_INIT("tcc-gsb.1", NULL, &gsb1),
+	CLKDEV_INIT("tcc-gsb.2", NULL, &gsb2),
+	CLKDEV_INIT("tcc-gsb.3", NULL, &gsb3),
+	CLKDEV_INIT(NULL, "gdma2", &gdma2),
+	CLKDEV_INIT(NULL, "gdma3", &gdma3),
+	CLKDEV_INIT(NULL, "ddrc", &ddrc),
+	CLKDEV_INIT("tcc-usbh.1", "usb", &usbh1),
 };
 
 static struct clk *root_clk_by_index(enum root_clks src)
-- 
1.7.4.4
