From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Oct 2010 10:41:09 +0900
Subject: [PATCH 7/9] ARM: S5PC100: I2S: Upgrade platform device
Message-ID: <1288057269-25571-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order to
prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pc100/dev-audio.c |   50 ++++++++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index bf0c90f..10ab275 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -23,17 +23,14 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 {
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
+	case 0: /* Dedicated pins */
+		break;
 	case 1:
 		s3c_gpio_cfgpin_range(S5PC100_GPC(0), 5, S3C_GPIO_SFN(2));
 		break;
-
 	case 2:
 		s3c_gpio_cfgpin_range(S5PC100_GPG3(0), 5, S3C_GPIO_SFN(4));
 		break;
-
-	case -1: /* Dedicated pins */
-		break;
-
 	default:
 		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
 		return -EINVAL;
@@ -42,8 +39,20 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static struct s3c_audio_pdata s3c_i2s_pdata = {
+static const char *rclksrc_v5[] = {
+	[0] = "iis",
+	[1] = "i2sclkd2",
+};
+
+static struct s3c_audio_pdata i2sv5_pdata = {
 	.cfg_gpio = s5pc100_cfg_i2s,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
+					 | QUIRK_NEED_RSTCLR,
+			.src_clk = rclksrc_v5,
+		},
+	},
 };
 
 static struct resource s5pc100_iis0_resource[] = {
@@ -62,15 +71,34 @@ static struct resource s5pc100_iis0_resource[] = {
 		.end   = DMACH_I2S0_RX,
 		.flags = IORESOURCE_DMA,
 	},
+	[3] = {
+		.start = DMACH_I2S0S_TX,
+		.end = DMACH_I2S0S_TX,
+		.flags = IORESOURCE_DMA,
+	},
 };
 
 struct platform_device s5pc100_device_iis0 = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name = "samsung-i2s",
+	.id = 0,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis0_resource),
 	.resource	  = s5pc100_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv5_pdata,
+	},
+};
+
+static const char *rclksrc_v3[] = {
+	[0] = "iis",
+	[1] = "sclk_audio",
+};
+
+static struct s3c_audio_pdata i2sv3_pdata = {
+	.cfg_gpio = s5pc100_cfg_i2s,
+	.type = {
+		.i2s = {
+			.src_clk = rclksrc_v3,
+		},
 	},
 };
 
@@ -98,7 +126,7 @@ struct platform_device s5pc100_device_iis1 = {
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis1_resource),
 	.resource	  = s5pc100_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
@@ -126,7 +154,7 @@ struct platform_device s5pc100_device_iis2 = {
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis2_resource),
 	.resource	  = s5pc100_iis2_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
-- 
1.6.2.5
