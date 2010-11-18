From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 18 Nov 2010 18:21:01 +0900
Subject: [PATCH 5/9] ARM: S5P64X0: I2S: Upgrade platform device
In-Reply-To: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
References: <AANLkTinPtkFccbrZ+-2244-=uK-83M_FSB3ZXOTuiNFw@mail.gmail.com>
Message-ID: <1290072061-17441-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order
to prepare them for new controller driver.
Also, discard duplicated gpio-cfg.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p64x0/clock-s5p6440.c |    2 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c |    2 +-
 arch/arm/mach-s5p64x0/dev-audio.c     |   55 ++++++++++++--------------------
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
index e4883dc..409c5fc 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6440.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -261,7 +261,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 25),
 	}, {
-		.name		= "i2s_v40",
+		.name		= "iis",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
index 7dbf3c9..7fc6abd 100644
--- a/arch/arm/mach-s5p64x0/clock-s5p6450.c
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -256,7 +256,7 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= (1 << 22),
 	}, {
 		.name		= "iis",
-		.id		= -1,
+		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p64x0_pclk_ctrl,
 		.ctrlbit	= (1 << 26),
diff --git a/arch/arm/mach-s5p64x0/dev-audio.c b/arch/arm/mach-s5p64x0/dev-audio.c
index fb613d0..14f89e7 100644
--- a/arch/arm/mach-s5p64x0/dev-audio.c
+++ b/arch/arm/mach-s5p64x0/dev-audio.c
@@ -19,15 +19,19 @@
 #include <mach/dma.h>
 #include <mach/irqs.h>
 
-static int s5p6440_cfg_i2s(struct platform_device *pdev)
+static const char *rclksrc[] = {
+	[0] = "iis",
+	[1] = "sclk_audio2",
+};
+
+static int s5p64x0_cfg_i2s(struct platform_device *pdev)
 {
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
-	case -1:
+	case 0:
 		s3c_gpio_cfgpin_range(S5P6440_GPR(4), 5, S3C_GPIO_SFN(5));
 		s3c_gpio_cfgpin_range(S5P6440_GPR(13), 2, S3C_GPIO_SFN(5));
 		break;
-
 	default:
 		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
 		return -EINVAL;
@@ -36,31 +40,14 @@ static int s5p6440_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static int s5p6450_cfg_i2s(struct platform_device *pdev)
-{
-	/* configure GPIO for i2s port */
-	switch (pdev->id) {
-	case -1:
-		s3c_gpio_cfgpin(S5P6450_GPB(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin_range(S5P6450_GPR(4), 5, S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin_range(S5P6450_GPR(13), 2, S3C_GPIO_SFN(5));
-
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static struct s3c_audio_pdata s5p6440_i2s_pdata = {
-	.cfg_gpio = s5p6440_cfg_i2s,
-};
-
-static struct s3c_audio_pdata s5p6450_i2s_pdata = {
-	.cfg_gpio = s5p6450_cfg_i2s,
+static struct s3c_audio_pdata s5p64x0_i2s_pdata = {
+	.cfg_gpio = s5p64x0_cfg_i2s,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN,
+			.src_clk = rclksrc,
+		},
+	},
 };
 
 static struct resource s5p64x0_iis0_resource[] = {
@@ -82,22 +69,22 @@ static struct resource s5p64x0_iis0_resource[] = {
 };
 
 struct platform_device s5p6440_device_iis = {
-	.name		= "samsung-i2s-v4",
-	.id		= -1,
+	.name		= "samsung-i2s",
+	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
 	.resource	= s5p64x0_iis0_resource,
 	.dev = {
-		.platform_data = &s5p6440_i2s_pdata,
+		.platform_data = &s5p64x0_i2s_pdata,
 	},
 };
 
 struct platform_device s5p6450_device_iis0 = {
-	.name		= "samsung-i2s-v4",
-	.id		= -1,
+	.name		= "samsung-i2s",
+	.id		= 0,
 	.num_resources	= ARRAY_SIZE(s5p64x0_iis0_resource),
 	.resource	= s5p64x0_iis0_resource,
 	.dev = {
-		.platform_data = &s5p6450_i2s_pdata,
+		.platform_data = &s5p64x0_i2s_pdata,
 	},
 };
 
-- 
1.6.2.5
