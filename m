From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:40 +0530
Subject: [PATCH 5/9] ARM: S3C64XX: Add clkdev support
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1307594324-11053-6-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clkdev support for Samsung's s3c64xx platforms.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/mach-s3c64xx/clock.c |   86 ++++++++++++-----------------------------
 2 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 11418d9..73d5228 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -705,6 +705,7 @@ config ARCH_S3C64XX
 	select CPU_V6
 	select ARM_VIC
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	select NO_IOPORT
 	select ARCH_USES_GETTIMEOFFSET
 	select ARCH_HAS_CPUFREQ
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index fdfc4d5..8cf39e3 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -39,7 +39,6 @@
 
 static struct clk clk_ext_xtal_mux = {
 	.name		= "ext_xtal",
-	.id		= -1,
 };
 
 #define clk_fin_apll clk_ext_xtal_mux
@@ -51,13 +50,11 @@ static struct clk clk_ext_xtal_mux = {
 
 struct clk clk_h2 = {
 	.name		= "hclk2",
-	.id		= -1,
 	.rate		= 0,
 };
 
 struct clk clk_27m = {
 	.name		= "clk_27m",
-	.id		= -1,
 	.rate		= 27000000,
 };
 
@@ -83,14 +80,12 @@ static int clk_48m_ctrl(struct clk *clk, int enable)
 
 struct clk clk_48m = {
 	.name		= "clk_48m",
-	.id		= -1,
 	.rate		= 48000000,
 	.enable		= clk_48m_ctrl,
 };
 
 struct clk clk_xusbxti = {
 	.name		= "xusbxti",
-	.id		= -1,
 	.rate		= 48000000,
 };
 
@@ -130,109 +125,101 @@ int s3c64xx_sclk_ctrl(struct clk *clk, int enable)
 static struct clk init_clocks_off[] = {
 	{
 		.name		= "nand",
-		.id		= -1,
 		.parent		= &clk_h,
 	}, {
 		.name		= "rtc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_RTC,
 	}, {
 		.name		= "adc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_TSADC,
 	}, {
 		.name		= "i2c",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIC,
 	}, {
 		.name		= "i2c",
-		.id		= 1,
+		.devname	= "s3c2440-i2c.1",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C6410_CLKCON_PCLK_I2C1,
 	}, {
 		.name		= "iis",
-		.id		= 0,
+		.devname	= "samsung-i2s.0",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIS0,
 	}, {
 		.name		= "iis",
-		.id		= 1,
+		.devname	= "samsung-i2s.1",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_IIS1,
 	}, {
 #ifdef CONFIG_CPU_S3C6410
 		.name		= "iis",
-		.id		= -1,  /* There's only one IISv4 port */
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
 	}, {
 #endif
 		.name		= "keypad",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_KEYPAD,
 	}, {
 		.name		= "spi",
-		.id		= 0,
+		.devname	= "s3c64xx-spi.0",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_SPI0,
 	}, {
 		.name		= "spi",
-		.id		= 1,
+		.devname	= "s3c64xx-spi.1",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_SPI1,
 	}, {
 		.name		= "spi_48m",
-		.id		= 0,
+		.devname	= "s3c64xx-spi.0",
 		.parent		= &clk_48m,
 		.enable		= s3c64xx_sclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_SCLK_SPI0_48,
 	}, {
 		.name		= "spi_48m",
-		.id		= 1,
+		.devname	= "s3c64xx-spi.1",
 		.parent		= &clk_48m,
 		.enable		= s3c64xx_sclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_SCLK_SPI1_48,
 	}, {
 		.name		= "48m",
-		.id		= 0,
+		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_48m,
 		.enable		= s3c64xx_sclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_SCLK_MMC0_48,
 	}, {
 		.name		= "48m",
-		.id		= 1,
+		.devname	= "s3c-sdhci.1",
 		.parent		= &clk_48m,
 		.enable		= s3c64xx_sclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_SCLK_MMC1_48,
 	}, {
 		.name		= "48m",
-		.id		= 2,
+		.devname	= "s3c-sdhci.2",
 		.parent		= &clk_48m,
 		.enable		= s3c64xx_sclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_SCLK_MMC2_48,
 	}, {
 		.name		= "dma0",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_DMA0,
 	}, {
 		.name		= "dma1",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_DMA1,
@@ -242,89 +229,81 @@ static struct clk init_clocks_off[] = {
 static struct clk init_clocks[] = {
 	{
 		.name		= "lcd",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_LCD,
 	}, {
 		.name		= "gpio",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_GPIO,
 	}, {
 		.name		= "usb-host",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_UHOST,
 	}, {
 		.name		= "hsmmc",
-		.id		= 0,
+		.devname	= "s3c-sdhci.0",
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC0,
 	}, {
 		.name		= "hsmmc",
-		.id		= 1,
+		.devname	= "s3c-sdhci.1",
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC1,
 	}, {
 		.name		= "hsmmc",
-		.id		= 2,
+		.devname	= "s3c-sdhci.2",
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_HSMMC2,
 	}, {
 		.name		= "otg",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_USB,
 	}, {
 		.name		= "timers",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_PWM,
 	}, {
 		.name		= "uart",
-		.id		= 0,
+		.devname	= "s3c6400-uart.0",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_UART0,
 	}, {
 		.name		= "uart",
-		.id		= 1,
+		.devname	= "s3c6400-uart.1",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_UART1,
 	}, {
 		.name		= "uart",
-		.id		= 2,
+		.devname	= "s3c6400-uart.2",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_UART2,
 	}, {
 		.name		= "uart",
-		.id		= 3,
+		.devname	= "s3c6400-uart.3",
 		.parent		= &clk_p,
 		.enable		= s3c64xx_pclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_PCLK_UART3,
 	}, {
 		.name		= "watchdog",
-		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= S3C_CLKCON_PCLK_WDT,
 	}, {
 		.name		= "ac97",
-		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= S3C_CLKCON_PCLK_AC97,
 	}, {
 		.name		= "cfcon",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c64xx_hclk_ctrl,
 		.ctrlbit	= S3C_CLKCON_HCLK_IHOST,
@@ -334,7 +313,6 @@ static struct clk init_clocks[] = {
 
 static struct clk clk_fout_apll = {
 	.name		= "fout_apll",
-	.id		= -1,
 };
 
 static struct clk *clk_src_apll_list[] = {
@@ -350,7 +328,6 @@ static struct clksrc_sources clk_src_apll = {
 static struct clksrc_clk clk_mout_apll = {
 	.clk	= {
 		.name		= "mout_apll",
-		.id		= -1,
 	},
 	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 0, .size = 1  },
 	.sources	= &clk_src_apll,
@@ -369,7 +346,6 @@ static struct clksrc_sources clk_src_epll = {
 static struct clksrc_clk clk_mout_epll = {
 	.clk	= {
 		.name		= "mout_epll",
-		.id		= -1,
 	},
 	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 2, .size = 1  },
 	.sources	= &clk_src_epll,
@@ -388,7 +364,6 @@ static struct clksrc_sources clk_src_mpll = {
 static struct clksrc_clk clk_mout_mpll = {
 	.clk = {
 		.name		= "mout_mpll",
-		.id		= -1,
 	},
 	.reg_src	= { .reg = S3C_CLK_SRC, .shift = 1, .size = 1  },
 	.sources	= &clk_src_mpll,
@@ -446,7 +421,6 @@ static int s3c64xx_clk_arm_set_rate(struct clk *clk, unsigned long rate)
 
 static struct clk clk_arm = {
 	.name		= "armclk",
-	.id		= -1,
 	.parent		= &clk_mout_apll.clk,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c64xx_clk_arm_get_rate,
@@ -473,7 +447,6 @@ static struct clk_ops clk_dout_ops = {
 
 static struct clk clk_dout_mpll = {
 	.name		= "dout_mpll",
-	.id		= -1,
 	.parent		= &clk_mout_mpll.clk,
 	.ops		= &clk_dout_ops,
 };
@@ -540,22 +513,18 @@ static struct clksrc_sources clkset_uhost = {
 
 static struct clk clk_iis_cd0 = {
 	.name		= "iis_cdclk0",
-	.id		= -1,
 };
 
 static struct clk clk_iis_cd1 = {
 	.name		= "iis_cdclk1",
-	.id		= -1,
 };
 
 static struct clk clk_iisv4_cd = {
 	.name		= "iis_cdclk_v4",
-	.id		= -1,
 };
 
 static struct clk clk_pcm_cd = {
 	.name		= "pcm_cdclk",
-	.id		= -1,
 };
 
 static struct clk *clkset_audio0_list[] = {
@@ -610,7 +579,7 @@ static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
 			.name		= "mmc_bus",
-			.id		= 0,
+			.devname	= "s3c-sdhci.0",
 			.ctrlbit        = S3C_CLKCON_SCLK_MMC0,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -620,7 +589,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "mmc_bus",
-			.id		= 1,
+			.devname	= "s3c-sdhci.1",
 			.ctrlbit        = S3C_CLKCON_SCLK_MMC1,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -630,7 +599,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "mmc_bus",
-			.id		= 2,
+			.devname	= "s3c-sdhci.2",
 			.ctrlbit        = S3C_CLKCON_SCLK_MMC2,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -640,7 +609,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "usb-bus-host",
-			.id		= -1,
 			.ctrlbit        = S3C_CLKCON_SCLK_UHOST,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -650,7 +618,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "uclk1",
-			.id		= -1,
 			.ctrlbit        = S3C_CLKCON_SCLK_UART,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -661,7 +628,7 @@ static struct clksrc_clk clksrcs[] = {
 /* Where does UCLK0 come from? */
 		.clk	= {
 			.name		= "spi-bus",
-			.id		= 0,
+			.devname	= "s3c64xx-spi.0",
 			.ctrlbit        = S3C_CLKCON_SCLK_SPI0,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -671,8 +638,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "spi-bus",
-			.id		= 1,
-			.ctrlbit        = S3C_CLKCON_SCLK_SPI1,
+			.devname	= "s3c64xx-spi.1",
 			.enable		= s3c64xx_sclk_ctrl,
 		},
 		.reg_src	= { .reg = S3C_CLK_SRC, .shift = 16, .size = 2  },
@@ -681,7 +647,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "audio-bus",
-			.id		= 0,
+			.devname	= "samsung-i2s.0",
 			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO0,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -691,7 +657,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "audio-bus",
-			.id		= 1,
+			.devname	= "samsung-i2s.1",
 			.ctrlbit        = S3C_CLKCON_SCLK_AUDIO1,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -701,7 +667,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "audio-bus",
-			.id		= 2,
+			.devname	= "samsung-i2s.2",
 			.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -711,7 +677,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "irda-bus",
-			.id		= 0,
 			.ctrlbit        = S3C_CLKCON_SCLK_IRDA,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
@@ -721,7 +686,6 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "camera",
-			.id		= -1,
 			.ctrlbit        = S3C_CLKCON_SCLK_CAM,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
-- 
1.6.6.rc2
