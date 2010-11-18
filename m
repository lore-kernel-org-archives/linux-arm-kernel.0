From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 18 Nov 2010 18:21:06 +0900
Subject: [PATCH 6/9] ARM: S5P6442: I2S: Upgrade platform device
In-Reply-To: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
References: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
Message-ID: <1290072066-17473-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order
to prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6442/dev-audio.c |   42 +++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
index d0207b7..8719dc4 100644
--- a/arch/arm/mach-s5p6442/dev-audio.c
+++ b/arch/arm/mach-s5p6442/dev-audio.c
@@ -29,7 +29,7 @@ static int s5p6442_cfg_i2s(struct platform_device *pdev)
 		base = S5P6442_GPC1(0);
 		break;
 
-	case -1:
+	case 0:
 		base = S5P6442_GPC0(0);
 		break;
 
@@ -42,8 +42,19 @@ static int s5p6442_cfg_i2s(struct platform_device *pdev)
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
@@ -62,15 +73,34 @@ static struct resource s5p6442_iis0_resource[] = {
 		.end   = DMACH_I2S0_RX,
 		.flags = IORESOURCE_DMA,
 	},
+	[3] = {
+		.start = DMACH_I2S0S_TX,
+		.end = DMACH_I2S0S_TX,
+		.flags = IORESOURCE_DMA,
+	},
 };
 
 struct platform_device s5p6442_device_iis0 = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name = "samsung-i2s",
+	.id = 0,
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
 
@@ -98,7 +128,7 @@ struct platform_device s5p6442_device_iis1 = {
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis1_resource),
 	.resource	  = s5p6442_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
-- 
1.6.2.5
