From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 26 Oct 2010 10:41:14 +0900
Subject: [PATCH 8/9] ARM: S5PV210: I2S: Upgrade platform device
Message-ID: <1288057274-25603-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order
to prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c     |   10 +++---
 arch/arm/mach-s5pv210/dev-audio.c |   52 ++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index 019c3a6..b774ff1 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -467,20 +467,20 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<21),
 	}, {
-		.name		= "i2s_v50",
+		.name		= "iis",
 		.id		= 0,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1<<4),
 	}, {
-		.name		= "i2s_v32",
-		.id		= 0,
+		.name		= "iis",
+		.id		= 1,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 5),
 	}, {
-		.name		= "i2s_v32",
-		.id		= 1,
+		.name		= "iis",
+		.id		= 2,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
 		.ctrlbit	= (1 << 6),
diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index 961477a..ddd2704 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -19,22 +19,24 @@
 #include <mach/dma.h>
 #include <mach/irqs.h>
 
+static const char *rclksrc[] = {
+	[0] = "busclk",
+	[1] = "i2sclk",
+};
+
 static int s5pv210_cfg_i2s(struct platform_device *pdev)
 {
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin_range(S5PV210_GPI(0), 7, S3C_GPIO_SFN(2));
+		break;
 	case 1:
 		s3c_gpio_cfgpin_range(S5PV210_GPC0(0), 5, S3C_GPIO_SFN(2));
 		break;
-
 	case 2:
 		s3c_gpio_cfgpin_range(S5PV210_GPC1(0), 5, S3C_GPIO_SFN(4));
 		break;
-
-	case -1:
-		s3c_gpio_cfgpin_range(S5PV210_GPI(0), 7, S3C_GPIO_SFN(2));
-		break;
-
 	default:
 		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
 		return -EINVAL;
@@ -43,8 +45,15 @@ static int s5pv210_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static struct s3c_audio_pdata s3c_i2s_pdata = {
+static struct s3c_audio_pdata i2sv5_pdata = {
 	.cfg_gpio = s5pv210_cfg_i2s,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
+					 | QUIRK_NEED_RSTCLR,
+			.src_clk = rclksrc,
+		},
+	},
 };
 
 static struct resource s5pv210_iis0_resource[] = {
@@ -63,15 +72,34 @@ static struct resource s5pv210_iis0_resource[] = {
 		.end   = DMACH_I2S0_RX,
 		.flags = IORESOURCE_DMA,
 	},
+	[3] = {
+		.start = DMACH_I2S0S_TX,
+		.end = DMACH_I2S0S_TX,
+		.flags = IORESOURCE_DMA,
+	},
 };
 
 struct platform_device s5pv210_device_iis0 = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name = "samsung-i2s",
+	.id = 0,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis0_resource),
 	.resource	  = s5pv210_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv5_pdata,
+	},
+};
+
+static const char *rclksrc_v3[] = {
+	[0] = "iis",
+	[1] = "audio-bus",
+};
+
+static struct s3c_audio_pdata i2sv3_pdata = {
+	.cfg_gpio = s5pv210_cfg_i2s,
+	.type = {
+		.i2s = {
+			.src_clk = rclksrc_v3,
+		},
 	},
 };
 
@@ -99,7 +127,7 @@ struct platform_device s5pv210_device_iis1 = {
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis1_resource),
 	.resource	  = s5pv210_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
@@ -127,7 +155,7 @@ struct platform_device s5pv210_device_iis2 = {
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis2_resource),
 	.resource	  = s5pv210_iis2_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
-- 
1.6.2.5
