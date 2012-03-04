From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 4 Mar 2012 19:05:40 +0100
Subject: [PATCH 4/6] ARM: S3C24XX: Add clock-lookup entries required by
 s3c64xx-spi
In-Reply-To: <201203041902.38318.heiko@sntech.de>
References: <201203041902.38318.heiko@sntech.de>
Message-ID: <201203041905.41146.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently usable are busclk0 and busclk2.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/clock-s3c2416.c  |    1 +
 arch/arm/mach-s3c24xx/clock-s3c2443.c  |    1 +
 arch/arm/mach-s3c24xx/common-s3c2443.c |   15 ++++++++++-----
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/clock-s3c2416.c b/arch/arm/mach-s3c24xx/clock-s3c2416.c
index dbc9ab4..8702ecf 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2416.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2416.c
@@ -144,6 +144,7 @@ static struct clk_lookup s3c2416_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
 	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &hsspi_mux.clk),
 };
 
 void __init s3c2416_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c24xx/clock-s3c2443.c b/arch/arm/mach-s3c24xx/clock-s3c2443.c
index bce1cd3..bb3231d 100644
--- a/arch/arm/mach-s3c24xx/clock-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2443.c
@@ -181,6 +181,7 @@ static struct clk *clks[] __initdata = {
 
 static struct clk_lookup s3c2443_clk_lookup[] = {
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &clk_hsmmc),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk2", &clk_hsspi),
 };
 
 void __init s3c2443_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c24xx/common-s3c2443.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
index 4604315..aeeb2be 100644
--- a/arch/arm/mach-s3c24xx/common-s3c2443.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -424,11 +424,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_IIS,
 	}, {
-		.name		= "hsspi",
-		.parent		= &clk_p,
-		.enable		= s3c2443_clkcon_enable_p,
-		.ctrlbit	= S3C2443_PCLKCON_HSSPI,
-	}, {
 		.name		= "adc",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
@@ -562,6 +557,14 @@ static struct clk hsmmc1_clk = {
 	.ctrlbit	= S3C2443_HCLKCON_HSMMC,
 };
 
+static struct clk hsspi_clk = {
+	.name		= "spi",
+	.devname	= "s3c64xx-spi.0",
+	.parent		= &clk_p,
+	.enable		= s3c2443_clkcon_enable_p,
+	.ctrlbit	= S3C2443_PCLKCON_HSSPI,
+};
+
 /* EPLLCON compatible enough to get on/off information */
 
 void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
@@ -612,6 +615,7 @@ static struct clk *clks[] __initdata = {
 	&clk_usb_bus,
 	&clk_armdiv,
 	&hsmmc1_clk,
+	&hsspi_clk,
 };
 
 static struct clksrc_clk *clksrcs[] __initdata = {
@@ -629,6 +633,7 @@ static struct clk_lookup s3c2443_clk_lookup[] = {
 	CLKDEV_INIT(NULL, "clk_uart_baud2", &clk_p),
 	CLKDEV_INIT(NULL, "clk_uart_baud3", &clk_esys_uart.clk),
 	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.0", &hsmmc1_clk),
+	CLKDEV_INIT("s3c64xx-spi.0", "spi_busclk0", &hsspi_clk),
 };
 
 void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
-- 
1.7.2.3
