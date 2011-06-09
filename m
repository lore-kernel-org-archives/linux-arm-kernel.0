From: thomas.ab@samsung.com (Thomas Abraham)
Date: Thu, 09 Jun 2011 10:08:39 +0530
Subject: [PATCH 4/9] ARM: S3C24XX: Add clkdev support
In-Reply-To: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
References: <1307594324-11053-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1307594324-11053-5-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clkdev support for Samsung's s3c24xx platforms.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-s3c2412/clock.c         |   36 ++---------------------------
 arch/arm/mach-s3c2416/clock.c         |   10 ++++----
 arch/arm/mach-s3c2440/clock.c         |    3 --
 arch/arm/mach-s3c2443/clock.c         |   16 +++----------
 arch/arm/plat-s3c24xx/clock-dclk.c    |    4 ---
 arch/arm/plat-s3c24xx/s3c2410-clock.c |   21 ++---------------
 arch/arm/plat-s3c24xx/s3c2443-clock.c |   39 +++-----------------------------
 arch/arm/plat-samsung/clock.c         |   10 --------
 arch/arm/plat-samsung/pwm-clock.c     |   10 ++++++++
 arch/arm/plat-samsung/time.c          |    2 +
 11 files changed, 32 insertions(+), 120 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2aa4563..11418d9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -687,6 +687,7 @@ config ARCH_S3C2410
 	select GENERIC_GPIO
 	select ARCH_HAS_CPUFREQ
 	select HAVE_CLK
+	select CLKDEV_LOOKUP
 	select ARCH_USES_GETTIMEOFFSET
 	select HAVE_S3C2410_I2C if I2C
 	help
diff --git a/arch/arm/mach-s3c2412/clock.c b/arch/arm/mach-s3c2412/clock.c
index 0c0505b..140711d 100644
--- a/arch/arm/mach-s3c2412/clock.c
+++ b/arch/arm/mach-s3c2412/clock.c
@@ -95,12 +95,10 @@ static int s3c2412_upll_enable(struct clk *clk, int enable)
 
 static struct clk clk_erefclk = {
 	.name		= "erefclk",
-	.id		= -1,
 };
 
 static struct clk clk_urefclk = {
 	.name		= "urefclk",
-	.id		= -1,
 };
 
 static int s3c2412_setparent_usysclk(struct clk *clk, struct clk *parent)
@@ -122,7 +120,6 @@ static int s3c2412_setparent_usysclk(struct clk *clk, struct clk *parent)
 
 static struct clk clk_usysclk = {
 	.name		= "usysclk",
-	.id		= -1,
 	.parent		= &clk_xtal,
 	.ops		= &(struct clk_ops) {
 		.set_parent	= s3c2412_setparent_usysclk,
@@ -132,13 +129,11 @@ static struct clk clk_usysclk = {
 static struct clk clk_mrefclk = {
 	.name		= "mrefclk",
 	.parent		= &clk_xtal,
-	.id		= -1,
 };
 
 static struct clk clk_mdivclk = {
 	.name		= "mdivclk",
 	.parent		= &clk_xtal,
-	.id		= -1,
 };
 
 static int s3c2412_setparent_usbsrc(struct clk *clk, struct clk *parent)
@@ -200,7 +195,6 @@ static int s3c2412_setrate_usbsrc(struct clk *clk, unsigned long rate)
 
 static struct clk clk_usbsrc = {
 	.name		= "usbsrc",
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c2412_getrate_usbsrc,
 		.set_rate	= s3c2412_setrate_usbsrc,
@@ -228,7 +222,6 @@ static int s3c2412_setparent_msysclk(struct clk *clk, struct clk *parent)
 
 static struct clk clk_msysclk = {
 	.name		= "msysclk",
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.set_parent	= s3c2412_setparent_msysclk,
 	},
@@ -268,7 +261,6 @@ static int s3c2412_setparent_armclk(struct clk *clk, struct clk *parent)
 
 static struct clk clk_armclk = {
 	.name		= "armclk",
-	.id		= -1,
 	.parent		= &clk_msysclk,
 	.ops		= &(struct clk_ops) {
 		.set_parent	= s3c2412_setparent_armclk,
@@ -344,7 +336,6 @@ static int s3c2412_setrate_uart(struct clk *clk, unsigned long rate)
 
 static struct clk clk_uart = {
 	.name		= "uartclk",
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c2412_getrate_uart,
 		.set_rate	= s3c2412_setrate_uart,
@@ -397,7 +388,6 @@ static int s3c2412_setrate_i2s(struct clk *clk, unsigned long rate)
 
 static struct clk clk_i2s = {
 	.name		= "i2sclk",
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c2412_getrate_i2s,
 		.set_rate	= s3c2412_setrate_i2s,
@@ -449,7 +439,6 @@ static int s3c2412_setrate_cam(struct clk *clk, unsigned long rate)
 
 static struct clk clk_cam = {
 	.name		= "camif-upll",	/* same as 2440 name */
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c2412_getrate_cam,
 		.set_rate	= s3c2412_setrate_cam,
@@ -463,37 +452,31 @@ static struct clk clk_cam = {
 static struct clk init_clocks_disable[] = {
 	{
 		.name		= "nand",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_NAND,
 	}, {
 		.name		= "sdi",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_SDI,
 	}, {
 		.name		= "adc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_ADC,
 	}, {
 		.name		= "i2c",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_IIC,
 	}, {
 		.name		= "iis",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_IIS,
 	}, {
 		.name		= "spi",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_SPI,
@@ -503,96 +486,83 @@ static struct clk init_clocks_disable[] = {
 static struct clk init_clocks[] = {
 	{
 		.name		= "dma",
-		.id		= 0,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_DMA0,
 	}, {
 		.name		= "dma",
-		.id		= 1,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_DMA1,
 	}, {
 		.name		= "dma",
-		.id		= 2,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_DMA2,
 	}, {
 		.name		= "dma",
-		.id		= 3,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_DMA3,
 	}, {
 		.name		= "lcd",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_LCDC,
 	}, {
 		.name		= "gpio",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_GPIO,
 	}, {
 		.name		= "usb-host",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_USBH,
 	}, {
 		.name		= "usb-device",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_USBD,
 	}, {
 		.name		= "timers",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_PWMT,
 	}, {
 		.name		= "uart",
-		.id		= 0,
+		.devname	= "s3c2412-uart.0",
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_UART0,
 	}, {
 		.name		= "uart",
-		.id		= 1,
+		.devname	= "s3c2412-uart.1",
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_UART1,
 	}, {
 		.name		= "uart",
-		.id		= 2,
+		.devname	= "s3c2412-uart.2",
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_UART2,
 	}, {
 		.name		= "rtc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_RTC,
 	}, {
 		.name		= "watchdog",
-		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= 0,
 	}, {
 		.name		= "usb-bus-gadget",
-		.id		= -1,
 		.parent		= &clk_usb_bus,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_USB_DEV48,
 	}, {
 		.name		= "usb-bus-host",
-		.id		= -1,
 		.parent		= &clk_usb_bus,
 		.enable		= s3c2412_clkcon_enable,
 		.ctrlbit	= S3C2412_CLKCON_USB_HOST48,
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 3b02d85..21a5e81 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -42,7 +42,7 @@ static struct clksrc_clk hsmmc_div[] = {
 	[0] = {
 		.clk = {
 			.name	= "hsmmc-div",
-			.id	= 0,
+			.devname	= "s3c-sdhci.0",
 			.parent	= &clk_esysclk.clk,
 		},
 		.reg_div = { .reg = S3C2416_CLKDIV2, .size = 2, .shift = 6 },
@@ -50,7 +50,7 @@ static struct clksrc_clk hsmmc_div[] = {
 	[1] = {
 		.clk = {
 			.name	= "hsmmc-div",
-			.id	= 1,
+			.devname	= "s3c-sdhci.1",
 			.parent	= &clk_esysclk.clk,
 		},
 		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6 },
@@ -60,8 +60,8 @@ static struct clksrc_clk hsmmc_div[] = {
 static struct clksrc_clk hsmmc_mux[] = {
 	[0] = {
 		.clk	= {
-			.id	= 0,
 			.name	= "hsmmc-if",
+			.devname	= "s3c-sdhci.0",
 			.ctrlbit = (1 << 6),
 			.enable = s3c2443_clkcon_enable_s,
 		},
@@ -76,8 +76,8 @@ static struct clksrc_clk hsmmc_mux[] = {
 	},
 	[1] = {
 		.clk	= {
-			.id	= 1,
 			.name	= "hsmmc-if",
+			.devname	= "s3c-sdhci.1",
 			.ctrlbit = (1 << 12),
 			.enable = s3c2443_clkcon_enable_s,
 		},
@@ -94,7 +94,7 @@ static struct clksrc_clk hsmmc_mux[] = {
 
 static struct clk hsmmc0_clk = {
 	.name		= "hsmmc",
-	.id		= 0,
+	.devname	= "s3c-sdhci.0",
 	.parent		= &clk_h,
 	.enable		= s3c2443_clkcon_enable_h,
 	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index 3dc2426..554e0d3 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -90,14 +90,12 @@ static int s3c2440_camif_upll_setrate(struct clk *clk, unsigned long rate)
 
 static struct clk s3c2440_clk_cam = {
 	.name		= "camif",
-	.id		= -1,
 	.enable		= s3c2410_clkcon_enable,
 	.ctrlbit	= S3C2440_CLKCON_CAMERA,
 };
 
 static struct clk s3c2440_clk_cam_upll = {
 	.name		= "camif-upll",
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.set_rate	= s3c2440_camif_upll_setrate,
 		.round_rate	= s3c2440_camif_upll_round,
@@ -106,7 +104,6 @@ static struct clk s3c2440_clk_cam_upll = {
 
 static struct clk s3c2440_clk_ac97 = {
 	.name		= "ac97",
-	.id		= -1,
 	.enable		= s3c2410_clkcon_enable,
 	.ctrlbit	= S3C2440_CLKCON_CAMERA,
 };
diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/clock.c
index f4ec6d5..a1a7176 100644
--- a/arch/arm/mach-s3c2443/clock.c
+++ b/arch/arm/mach-s3c2443/clock.c
@@ -59,7 +59,6 @@
 
 static struct clk clk_i2s_ext = {
 	.name		= "i2s-ext",
-	.id		= -1,
 };
 
 /* armdiv
@@ -139,7 +138,6 @@ static int s3c2443_armclk_setrate(struct clk *clk, unsigned long rate)
 
 static struct clk clk_armdiv = {
 	.name		= "armdiv",
-	.id		= -1,
 	.parent		= &clk_msysclk.clk,
 	.ops		= &(struct clk_ops) {
 		.round_rate = s3c2443_armclk_roundrate,
@@ -160,7 +158,6 @@ static struct clk *clk_arm_sources[] = {
 static struct clksrc_clk clk_arm = {
 	.clk	= {
 		.name		= "armclk",
-		.id		= -1,
 	},
 	.sources = &(struct clksrc_sources) {
 		.sources = clk_arm_sources,
@@ -177,7 +174,6 @@ static struct clksrc_clk clk_arm = {
 static struct clksrc_clk clk_hsspi = {
 	.clk	= {
 		.name		= "hsspi",
-		.id		= -1,
 		.parent		= &clk_esysclk.clk,
 		.ctrlbit	= S3C2443_SCLKCON_HSSPICLK,
 		.enable		= s3c2443_clkcon_enable_s,
@@ -196,7 +192,7 @@ static struct clksrc_clk clk_hsspi = {
 static struct clksrc_clk clk_hsmmc_div = {
 	.clk	= {
 		.name		= "hsmmc-div",
-		.id		= 1,
+		.devname	= "s3c-sdhci.1",
 		.parent		= &clk_esysclk.clk,
 	},
 	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 2, .shift = 6 },
@@ -231,7 +227,7 @@ static int s3c2443_enable_hsmmc(struct clk *clk, int enable)
 
 static struct clk clk_hsmmc = {
 	.name		= "hsmmc-if",
-	.id		= 1,
+	.devname	= "s3c-sdhci.1",
 	.parent		= &clk_hsmmc_div.clk,
 	.enable		= s3c2443_enable_hsmmc,
 	.ops		= &(struct clk_ops) {
@@ -248,7 +244,6 @@ static struct clk clk_hsmmc = {
 static struct clksrc_clk clk_i2s_eplldiv = {
 	.clk	= {
 		.name		= "i2s-eplldiv",
-		.id		= -1,
 		.parent		= &clk_esysclk.clk,
 	},
 	.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 12, },
@@ -271,7 +266,6 @@ struct clk *clk_i2s_srclist[] = {
 static struct clksrc_clk clk_i2s = {
 	.clk	= {
 		.name		= "i2s-if",
-		.id		= -1,
 		.ctrlbit	= S3C2443_SCLKCON_I2SCLK,
 		.enable		= s3c2443_clkcon_enable_s,
 
@@ -288,25 +282,23 @@ static struct clksrc_clk clk_i2s = {
 static struct clk init_clocks_off[] = {
 	{
 		.name		= "sdi",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_SDI,
 	}, {
 		.name		= "iis",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_IIS,
 	}, {
 		.name		= "spi",
-		.id		= 0,
+		.devname	= "s3c2410-spi.0",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_SPI0,
 	}, {
 		.name		= "spi",
-		.id		= 1,
+		.devname	= "s3c2410-spi.1",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_SPI1,
diff --git a/arch/arm/plat-s3c24xx/clock-dclk.c b/arch/arm/plat-s3c24xx/clock-dclk.c
index cf97caa..f95d326 100644
--- a/arch/arm/plat-s3c24xx/clock-dclk.c
+++ b/arch/arm/plat-s3c24xx/clock-dclk.c
@@ -169,7 +169,6 @@ static struct clk_ops dclk_ops = {
 
 struct clk s3c24xx_dclk0 = {
 	.name		= "dclk0",
-	.id		= -1,
 	.ctrlbit	= S3C2410_DCLKCON_DCLK0EN,
 	.enable	        = s3c24xx_dclk_enable,
 	.ops		= &dclk_ops,
@@ -177,7 +176,6 @@ struct clk s3c24xx_dclk0 = {
 
 struct clk s3c24xx_dclk1 = {
 	.name		= "dclk1",
-	.id		= -1,
 	.ctrlbit	= S3C2410_DCLKCON_DCLK1EN,
 	.enable		= s3c24xx_dclk_enable,
 	.ops		= &dclk_ops,
@@ -189,12 +187,10 @@ static struct clk_ops clkout_ops = {
 
 struct clk s3c24xx_clkout0 = {
 	.name		= "clkout0",
-	.id		= -1,
 	.ops		= &clkout_ops,
 };
 
 struct clk s3c24xx_clkout1 = {
 	.name		= "clkout1",
-	.id		= -1,
 	.ops		= &clkout_ops,
 };
diff --git a/arch/arm/plat-s3c24xx/s3c2410-clock.c b/arch/arm/plat-s3c24xx/s3c2410-clock.c
index 9ecc5d9..def76aa 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2410-clock.c
@@ -90,37 +90,31 @@ static int s3c2410_upll_enable(struct clk *clk, int enable)
 static struct clk init_clocks_off[] = {
 	{
 		.name		= "nand",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_NAND,
 	}, {
 		.name		= "sdi",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_SDI,
 	}, {
 		.name		= "adc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_ADC,
 	}, {
 		.name		= "i2c",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_IIC,
 	}, {
 		.name		= "iis",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_IIS,
 	}, {
 		.name		= "spi",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_SPI,
@@ -130,70 +124,61 @@ static struct clk init_clocks_off[] = {
 static struct clk init_clocks[] = {
 	{
 		.name		= "lcd",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_LCDC,
 	}, {
 		.name		= "gpio",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_GPIO,
 	}, {
 		.name		= "usb-host",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_USBH,
 	}, {
 		.name		= "usb-device",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_USBD,
 	}, {
 		.name		= "timers",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_PWMT,
 	}, {
 		.name		= "uart",
-		.id		= 0,
+		.devname	= "s3c2410-uart.0",
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_UART0,
 	}, {
 		.name		= "uart",
-		.id		= 1,
+		.devname	= "s3c2410-uart.1",
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_UART1,
 	}, {
 		.name		= "uart",
-		.id		= 2,
+		.devname	= "s3c2410-uart.2",
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_UART2,
 	}, {
 		.name		= "rtc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2410_clkcon_enable,
 		.ctrlbit	= S3C2410_CLKCON_RTC,
 	}, {
 		.name		= "watchdog",
-		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= 0,
 	}, {
 		.name		= "usb-bus-host",
-		.id		= -1,
 		.parent		= &clk_usb_bus,
 	}, {
 		.name		= "usb-bus-gadget",
-		.id		= -1,
 		.parent		= &clk_usb_bus,
 	},
 };
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 82f2d4a..59552c0 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -56,7 +56,6 @@ int s3c2443_clkcon_enable_s(struct clk *clk, int enable)
 struct clk clk_mpllref = {
 	.name		= "mpllref",
 	.parent		= &clk_xtal,
-	.id		= -1,
 };
 
 static struct clk *clk_epllref_sources[] = {
@@ -69,7 +68,6 @@ static struct clk *clk_epllref_sources[] = {
 struct clksrc_clk clk_epllref = {
 	.clk	= {
 		.name		= "epllref",
-		.id		= -1,
 	},
 	.sources = &(struct clksrc_sources) {
 		.sources = clk_epllref_sources,
@@ -92,7 +90,6 @@ struct clksrc_clk clk_esysclk = {
 	.clk	= {
 		.name		= "esysclk",
 		.parent		= &clk_epll,
-		.id		= -1,
 	},
 	.sources = &(struct clksrc_sources) {
 		.sources = clk_sysclk_sources,
@@ -115,7 +112,6 @@ static unsigned long s3c2443_getrate_mdivclk(struct clk *clk)
 static struct clk clk_mdivclk = {
 	.name		= "mdivclk",
 	.parent		= &clk_mpllref,
-	.id		= -1,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c2443_getrate_mdivclk,
 	},
@@ -132,7 +128,6 @@ struct clksrc_clk clk_msysclk = {
 	.clk	= {
 		.name		= "msysclk",
 		.parent		= &clk_xtal,
-		.id		= -1,
 	},
 	.sources = &(struct clksrc_sources) {
 		.sources = clk_msysclk_sources,
@@ -159,7 +154,6 @@ static unsigned long s3c2443_prediv_getrate(struct clk *clk)
 
 static struct clk clk_prediv = {
 	.name		= "prediv",
-	.id		= -1,
 	.parent		= &clk_msysclk.clk,
 	.ops		= &(struct clk_ops) {
 		.get_rate	= s3c2443_prediv_getrate,
@@ -174,7 +168,6 @@ static struct clk clk_prediv = {
 static struct clksrc_clk clk_usb_bus_host = {
 	.clk	= {
 		.name		= "usb-bus-host-parent",
-		.id		= -1,
 		.parent		= &clk_esysclk.clk,
 		.ctrlbit	= S3C2443_SCLKCON_USBHOST,
 		.enable		= s3c2443_clkcon_enable_s,
@@ -189,7 +182,6 @@ static struct clksrc_clk clksrc_clks[] = {
 		/* ART baud-rate clock sourced from esysclk via a divisor */
 		.clk	= {
 			.name		= "uartclk",
-			.id		= -1,
 			.parent		= &clk_esysclk.clk,
 		},
 		.reg_div = { .reg = S3C2443_CLKDIV1, .size = 4, .shift = 8 },
@@ -197,7 +189,6 @@ static struct clksrc_clk clksrc_clks[] = {
 		/* camera interface bus-clock, divided down from esysclk */
 		.clk	= {
 			.name		= "camif-upll",	/* same as 2440 name */
-			.id		= -1,
 			.parent		= &clk_esysclk.clk,
 			.ctrlbit	= S3C2443_SCLKCON_CAMCLK,
 			.enable		= s3c2443_clkcon_enable_s,
@@ -206,7 +197,6 @@ static struct clksrc_clk clksrc_clks[] = {
 	}, {
 		.clk	= {
 			.name		= "display-if",
-			.id		= -1,
 			.parent		= &clk_esysclk.clk,
 			.ctrlbit	= S3C2443_SCLKCON_DISPCLK,
 			.enable		= s3c2443_clkcon_enable_s,
@@ -219,13 +209,11 @@ static struct clksrc_clk clksrc_clks[] = {
 static struct clk init_clocks_off[] = {
 	{
 		.name		= "adc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_ADC,
 	}, {
 		.name		= "i2c",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_IIC,
@@ -235,136 +223,117 @@ static struct clk init_clocks_off[] = {
 static struct clk init_clocks[] = {
 	{
 		.name		= "dma",
-		.id		= 0,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA0,
 	}, {
 		.name		= "dma",
-		.id		= 1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA1,
 	}, {
 		.name		= "dma",
-		.id		= 2,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA2,
 	}, {
 		.name		= "dma",
-		.id		= 3,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA3,
 	}, {
 		.name		= "dma",
-		.id		= 4,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA4,
 	}, {
 		.name		= "dma",
-		.id		= 5,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_DMA5,
 	}, {
 		.name		= "hsmmc",
-		.id		= 1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_HSMMC,
 	}, {
 		.name		= "gpio",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_GPIO,
 	}, {
 		.name		= "usb-host",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_USBH,
 	}, {
 		.name		= "usb-device",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_USBD,
 	}, {
 		.name		= "lcd",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_LCDC,
 
 	}, {
 		.name		= "timers",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_PWMT,
 	}, {
 		.name		= "cfc",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_CFC,
 	}, {
 		.name		= "ssmc",
-		.id		= -1,
 		.parent		= &clk_h,
 		.enable		= s3c2443_clkcon_enable_h,
 		.ctrlbit	= S3C2443_HCLKCON_SSMC,
 	}, {
 		.name		= "uart",
-		.id		= 0,
+		.devname	= "s3c2440-uart.0",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_UART0,
 	}, {
 		.name		= "uart",
-		.id		= 1,
+		.devname	= "s3c2440-uart.1",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_UART1,
 	}, {
 		.name		= "uart",
-		.id		= 2,
+		.devname	= "s3c2440-uart.2",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_UART2,
 	}, {
 		.name		= "uart",
-		.id		= 3,
+		.devname	= "s3c2440-uart.3",
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_UART3,
 	}, {
 		.name		= "rtc",
-		.id		= -1,
 		.parent		= &clk_p,
 		.enable		= s3c2443_clkcon_enable_p,
 		.ctrlbit	= S3C2443_PCLKCON_RTC,
 	}, {
 		.name		= "watchdog",
-		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= S3C2443_PCLKCON_WDT,
 	}, {
 		.name		= "ac97",
-		.id		= -1,
 		.parent		= &clk_p,
 		.ctrlbit	= S3C2443_PCLKCON_AC97,
 	}, {
 		.name		= "nand",
-		.id		= -1,
 		.parent		= &clk_h,
 	}, {
 		.name		= "usb-bus-host",
-		.id		= -1,
 		.parent		= &clk_usb_bus_host.clk,
 	}
 };
diff --git a/arch/arm/plat-samsung/clock.c b/arch/arm/plat-samsung/clock.c
index e30bd45..aecf9e9 100644
--- a/arch/arm/plat-samsung/clock.c
+++ b/arch/arm/plat-samsung/clock.c
@@ -195,7 +195,6 @@ struct clk_ops clk_ops_def_setrate = {
 
 struct clk clk_xtal = {
 	.name		= "xtal",
-	.id		= -1,
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
@@ -203,30 +202,25 @@ struct clk clk_xtal = {
 
 struct clk clk_ext = {
 	.name		= "ext",
-	.id		= -1,
 };
 
 struct clk clk_epll = {
 	.name		= "epll",
-	.id		= -1,
 };
 
 struct clk clk_mpll = {
 	.name		= "mpll",
-	.id		= -1,
 	.ops		= &clk_ops_def_setrate,
 };
 
 struct clk clk_upll = {
 	.name		= "upll",
-	.id		= -1,
 	.parent		= NULL,
 	.ctrlbit	= 0,
 };
 
 struct clk clk_f = {
 	.name		= "fclk",
-	.id		= -1,
 	.rate		= 0,
 	.parent		= &clk_mpll,
 	.ctrlbit	= 0,
@@ -234,7 +228,6 @@ struct clk clk_f = {
 
 struct clk clk_h = {
 	.name		= "hclk",
-	.id		= -1,
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
@@ -243,7 +236,6 @@ struct clk clk_h = {
 
 struct clk clk_p = {
 	.name		= "pclk",
-	.id		= -1,
 	.rate		= 0,
 	.parent		= NULL,
 	.ctrlbit	= 0,
@@ -252,7 +244,6 @@ struct clk clk_p = {
 
 struct clk clk_usb_bus = {
 	.name		= "usb-bus",
-	.id		= -1,
 	.rate		= 0,
 	.parent		= &clk_upll,
 };
@@ -260,7 +251,6 @@ struct clk clk_usb_bus = {
 
 struct clk s3c24xx_uclk = {
 	.name		= "uclk",
-	.id		= -1,
 };
 
 /* initialise the clock system */
diff --git a/arch/arm/plat-samsung/pwm-clock.c b/arch/arm/plat-samsung/pwm-clock.c
index 46c9381..f1bba88 100644
--- a/arch/arm/plat-samsung/pwm-clock.c
+++ b/arch/arm/plat-samsung/pwm-clock.c
@@ -268,6 +268,7 @@ static struct pwm_tdiv_clk clk_timer_tdiv[] = {
 	[0]	= {
 		.clk	= {
 			.name	= "pwm-tdiv",
+			.devname	= "s3c24xx-pwm.0",
 			.ops	= &clk_tdiv_ops,
 			.parent	= &clk_timer_scaler[0],
 		},
@@ -275,6 +276,7 @@ static struct pwm_tdiv_clk clk_timer_tdiv[] = {
 	[1]	= {
 		.clk	= {
 			.name	= "pwm-tdiv",
+			.devname	= "s3c24xx-pwm.1",
 			.ops	= &clk_tdiv_ops,
 			.parent	= &clk_timer_scaler[0],
 		}
@@ -282,6 +284,7 @@ static struct pwm_tdiv_clk clk_timer_tdiv[] = {
 	[2]	= {
 		.clk	= {
 			.name	= "pwm-tdiv",
+			.devname	= "s3c24xx-pwm.2",
 			.ops	= &clk_tdiv_ops,
 			.parent	= &clk_timer_scaler[1],
 		},
@@ -289,6 +292,7 @@ static struct pwm_tdiv_clk clk_timer_tdiv[] = {
 	[3]	= {
 		.clk	= {
 			.name	= "pwm-tdiv",
+			.devname	= "s3c24xx-pwm.3",
 			.ops	= &clk_tdiv_ops,
 			.parent	= &clk_timer_scaler[1],
 		},
@@ -296,6 +300,7 @@ static struct pwm_tdiv_clk clk_timer_tdiv[] = {
 	[4]	= {
 		.clk	= {
 			.name	= "pwm-tdiv",
+			.devname	= "s3c24xx-pwm.4",
 			.ops	= &clk_tdiv_ops,
 			.parent	= &clk_timer_scaler[1],
 		},
@@ -361,26 +366,31 @@ static struct clk_ops clk_tin_ops = {
 static struct clk clk_tin[] = {
 	[0]	= {
 		.name	= "pwm-tin",
+		.devname	= "s3c24xx-pwm.0",
 		.id	= 0,
 		.ops	= &clk_tin_ops,
 	},
 	[1]	= {
 		.name	= "pwm-tin",
+		.devname	= "s3c24xx-pwm.1",
 		.id	= 1,
 		.ops	= &clk_tin_ops,
 	},
 	[2]	= {
 		.name	= "pwm-tin",
+		.devname	= "s3c24xx-pwm.2",
 		.id	= 2,
 		.ops	= &clk_tin_ops,
 	},
 	[3]	= {
 		.name	= "pwm-tin",
+		.devname	= "s3c24xx-pwm.3",
 		.id	= 3,
 		.ops	= &clk_tin_ops,
 	},
 	[4]	= {
 		.name	= "pwm-tin",
+		.devname	= "s3c24xx-pwm.4",
 		.id	= 4,
 		.ops	= &clk_tin_ops,
 	},
diff --git a/arch/arm/plat-samsung/time.c b/arch/arm/plat-samsung/time.c
index 2231d80..e3bb806 100644
--- a/arch/arm/plat-samsung/time.c
+++ b/arch/arm/plat-samsung/time.c
@@ -259,6 +259,8 @@ static void __init s3c2410_timer_resources(void)
 	clk_enable(timerclk);
 
 	if (!use_tclk1_12()) {
+		tmpdev.id = 4;
+		tmpdev.dev.init_name = "s3c24xx-pwm.4";
 		tin = clk_get(&tmpdev.dev, "pwm-tin");
 		if (IS_ERR(tin))
 			panic("failed to get pwm-tin clock for system timer");
-- 
1.6.6.rc2
