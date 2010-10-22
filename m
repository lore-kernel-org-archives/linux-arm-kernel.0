From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 22 Oct 2010 17:44:49 +0900
Subject: [PATCHv2 1/6] ARM: S3C64XX: I2S: Upgrade platform device
Message-ID: <1287737094-23868-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order to
prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c     |    2 +-
 arch/arm/mach-s3c64xx/dev-audio.c |   57 ++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7e03f0a..1c98d2f 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -695,7 +695,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "audio-bus",
-			.id		= -1,  /* There's only one IISv4 port */
+			.id		= 2,
 			.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 4a5c682..8ee12a9 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -22,7 +22,12 @@
 #include <plat/audio.h>
 #include <plat/gpio-cfg.h>
 
-static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
+static const char *rclksrc[] = {
+	[0] = "iis",
+	[1] = "audio-bus",
+};
+
+static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 {
 	unsigned int base;
 
@@ -33,6 +38,12 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 	case 1:
 		base = S3C64XX_GPE(0);
 		break;
+	case 2:
+		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));
+		break;
 	default:
 		printk(KERN_DEBUG "Invalid I2S Controller number!");
 		return -EINVAL;
@@ -43,16 +54,6 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 	return 0;
 }
 
-static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
-{
-	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
-	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
-	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
-	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));
-
-	return 0;
-}
-
 static struct resource s3c64xx_iis0_resource[] = {
 	[0] = {
 		.start = S3C64XX_PA_IIS0,
@@ -71,8 +72,13 @@ static struct resource s3c64xx_iis0_resource[] = {
 	},
 };
 
-static struct s3c_audio_pdata s3c_i2s0_pdata = {
-	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
+static struct s3c_audio_pdata i2sv3_pdata = {
+	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.type = {
+		.i2s = {
+			.src_clk = rclksrc,
+		},
+	},
 };
 
 struct platform_device s3c64xx_device_iis0 = {
@@ -81,7 +87,7 @@ struct platform_device s3c64xx_device_iis0 = {
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis0_resource),
 	.resource	  = s3c64xx_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s0_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis0);
@@ -104,17 +110,13 @@ static struct resource s3c64xx_iis1_resource[] = {
 	},
 };
 
-static struct s3c_audio_pdata s3c_i2s1_pdata = {
-	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
-};
-
 struct platform_device s3c64xx_device_iis1 = {
 	.name		  = "s3c64xx-iis",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis1_resource),
 	.resource	  = s3c64xx_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s1_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis1);
@@ -137,17 +139,22 @@ static struct resource s3c64xx_iisv4_resource[] = {
 	},
 };
 
-static struct s3c_audio_pdata s3c_i2sv4_pdata = {
-	.cfg_gpio = s3c64xx_i2sv4_cfg_gpio,
-};
+static struct s3c_audio_pdata i2sv4_pdata = {
+	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN,
+			.src_clk = rclksrc,
+		},
+},
 
 struct platform_device s3c64xx_device_iisv4 = {
-	.name		  = "s3c64xx-iis-v4",
-	.id		  = -1,
+	.name		  = "samsung-i2s",
+	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
 	.resource	  = s3c64xx_iisv4_resource,
 	.dev = {
-		.platform_data = &s3c_i2sv4_pdata,
+		.platform_data = &i2sv4_pdata,
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iisv4);
-- 
1.6.2.5
