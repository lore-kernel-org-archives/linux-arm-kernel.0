From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 19 Oct 2010 16:15:00 +0900
Subject: [PATCH 2/4] ARM: S5P6442: I2S: Upgrade platform device
Message-ID: <1287472500-497-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order
to prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/dev-audio.c |   44 ++++++++++++++++++++++++++++++------
 1 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
index 1419442..b91463e 100644
--- a/arch/arm/mach-s5p6442/dev-audio.c
+++ b/arch/arm/mach-s5p6442/dev-audio.c
@@ -30,15 +30,13 @@ static int s5p6442_cfg_i2s(struct platform_device *pdev)
 		s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(2));
 		break;
-
-	case -1:
+	case 0:
 		s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(2));
 		break;
-
 	default:
 		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
 		return -EINVAL;
@@ -47,8 +45,19 @@ static int s5p6442_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static struct s3c_audio_pdata s3c_i2s_pdata = {
+static const char *rclksrc_v35[] = {
+	[0] = "busclk",
+	[1] = "i2sclk",
+};
+
+static struct s3c_audio_pdata i2sv35_pdata = {
 	.cfg_gpio = s5p6442_cfg_i2s,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_SEC_DAI | QUIRK_NEED_RSTCLR,
+			.src_clk = rclksrc_v35,
+		},
+	},
 };
 
 static struct resource s5p6442_iis0_resource[] = {
@@ -67,15 +76,34 @@ static struct resource s5p6442_iis0_resource[] = {
 		.end   = DMACH_I2S0_RX,
 		.flags = IORESOURCE_DMA,
 	},
+	[3] = {
+		.start = DMACH_I2S0S_TX,
+		.end   = DMACH_I2S0S_TX,
+		.flags = IORESOURCE_DMA,
+	},
 };
 
 struct platform_device s5p6442_device_iis0 = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name		  = "samsung-i2s",
+	.id		  = 0,
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis0_resource),
 	.resource	  = s5p6442_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv35_pdata,
+	},
+};
+
+static const char *rclksrc_v3[] = {
+	[0] = "iis",
+	[1] = "sclk_audio",
+};
+
+static struct s3c_audio_pdata i2sv3_pdata = {
+	.cfg_gpio = s5p6442_cfg_i2s,
+	.type = {
+		.i2s = {
+			.src_clk = rclksrc_v3,
+		},
 	},
 };
 
@@ -103,7 +131,7 @@ struct platform_device s5p6442_device_iis1 = {
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis1_resource),
 	.resource	  = s5p6442_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
-- 
1.6.2.5
