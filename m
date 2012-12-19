From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 19 Dec 2012 11:05:50 +0530
Subject: [PATCH 2/5] ARM: S5PC100: Add I2S clkdev support
In-Reply-To: <1355895353-10316-1-git-send-email-padma.v@samsung.com>
References: <1355895353-10316-1-git-send-email-padma.v@samsung.com>
Message-ID: <1355895353-10316-3-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S controller has an internal mux for RCLK source clk. The list
of source clk names were passed through platform data in non-dt case.
Register the existing RCLK source clocks with clkdev using generic
connection id. This is required as part of adding DT support
for I2S controller driver.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Acked-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c     |   48 +++++++++++++++++++++++--------------
 arch/arm/mach-s5pc100/dev-audio.c |   16 ------------
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 9262197..a206dc3 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -606,24 +606,6 @@ static struct clk init_clocks_off[] = {
 		.enable		= s5pc100_d1_4_ctrl,
 		.ctrlbit	= (1 << 13),
 	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.0",
-		.parent		= &clk_div_pclkd1.clk,
-		.enable		= s5pc100_d1_5_ctrl,
-		.ctrlbit	= (1 << 0),
-	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.1",
-		.parent		= &clk_div_pclkd1.clk,
-		.enable		= s5pc100_d1_5_ctrl,
-		.ctrlbit	= (1 << 1),
-	}, {
-		.name		= "iis",
-		.devname	= "samsung-i2s.2",
-		.parent		= &clk_div_pclkd1.clk,
-		.enable		= s5pc100_d1_5_ctrl,
-		.ctrlbit	= (1 << 2),
-	}, {
 		.name		= "ac97",
 		.parent		= &clk_div_pclkd1.clk,
 		.enable		= s5pc100_d1_5_ctrl,
@@ -724,6 +706,30 @@ static struct clk clk_48m_spi2 = {
 	.ctrlbit	= (1 << 9),
 };
 
+static struct clk clk_i2s0 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.0",
+	.parent		= &clk_div_pclkd1.clk,
+	.enable		= s5pc100_d1_5_ctrl,
+	.ctrlbit	= (1 << 0),
+};
+
+static struct clk clk_i2s1 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.1",
+	.parent		= &clk_div_pclkd1.clk,
+	.enable		= s5pc100_d1_5_ctrl,
+	.ctrlbit	= (1 << 1),
+};
+
+static struct clk clk_i2s2 = {
+	.name		= "iis",
+	.devname	= "samsung-i2s.2",
+	.parent		= &clk_div_pclkd1.clk,
+	.enable		= s5pc100_d1_5_ctrl,
+	.ctrlbit	= (1 << 2),
+};
+
 static struct clk clk_vclk54m = {
 	.name		= "vclk_54m",
 	.rate		= 54000000,
@@ -1154,6 +1160,9 @@ static struct clk *clk_cdev[] = {
 	&clk_48m_spi0,
 	&clk_48m_spi1,
 	&clk_48m_spi2,
+	&clk_i2s0,
+	&clk_i2s1,
+	&clk_i2s2,
 };
 
 static struct clksrc_clk *clksrc_cdev[] = {
@@ -1321,6 +1330,9 @@ static struct clk_lookup s5pc100_clk_lookup[] = {
 	CLKDEV_INIT("s5pc100-spi.1", "spi_busclk2", &clk_sclk_spi1.clk),
 	CLKDEV_INIT("s5pc100-spi.2", "spi_busclk1", &clk_48m_spi2),
 	CLKDEV_INIT("s5pc100-spi.2", "spi_busclk2", &clk_sclk_spi2.clk),
+	CLKDEV_INIT("samsung-i2s.0", "i2s_opclk0", &clk_i2s0),
+	CLKDEV_INIT("samsung-i2s.1", "i2s_opclk0", &clk_i2s1),
+	CLKDEV_INIT("samsung-i2s.2", "i2s_opclk0", &clk_i2s2),
 };
 
 void __init s5pc100_register_clocks(void)
diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 1cc252c..46f488b 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -39,18 +39,12 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static const char *rclksrc_v5[] = {
-	[0] = "iis",
-	[1] = "i2sclkd2",
-};
-
 static struct s3c_audio_pdata i2sv5_pdata = {
 	.cfg_gpio = s5pc100_cfg_i2s,
 	.type = {
 		.i2s = {
 			.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
 					 | QUIRK_NEED_RSTCLR,
-			.src_clk = rclksrc_v5,
 		},
 	},
 };
@@ -72,18 +66,8 @@ struct platform_device s5pc100_device_iis0 = {
 	},
 };
 
-static const char *rclksrc_v3[] = {
-	[0] = "iis",
-	[1] = "sclk_audio",
-};
-
 static struct s3c_audio_pdata i2sv3_pdata = {
 	.cfg_gpio = s5pc100_cfg_i2s,
-	.type = {
-		.i2s = {
-			.src_clk = rclksrc_v3,
-		},
-	},
 };
 
 static struct resource s5pc100_iis1_resource[] = {
-- 
1.7.4.4
