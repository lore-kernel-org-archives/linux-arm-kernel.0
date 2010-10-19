From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 19 Oct 2010 16:14:52 +0900
Subject: [PATCH 1/4] ARM: S5P6440: I2S: Upgrade platform device
Message-ID: <1287472492-465-1-git-send-email-jassisinghbrar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

Add more information to I2S platform_devices in order
to prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s5p6440/clock.c     |    2 +-
 arch/arm/mach-s5p6440/dev-audio.c |   21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
index ca6e48d..a80a019 100644
--- a/arch/arm/mach-s5p6440/clock.c
+++ b/arch/arm/mach-s5p6440/clock.c
@@ -371,7 +371,7 @@ static struct clk init_clocks_disable[] = {
 		.enable		= s5p6440_pclk_ctrl,
 		.ctrlbit	= S5P_CLKCON_PCLK_IIC0,
 	}, {
-		.name		= "i2s_v40",
+		.name		= "iis",
 		.id		= 0,
 		.parent		= &clk_pclk_low.clk,
 		.enable		= s5p6440_pclk_ctrl,
diff --git a/arch/arm/mach-s5p6440/dev-audio.c b/arch/arm/mach-s5p6440/dev-audio.c
index 5d98629..9d61f5d 100644
--- a/arch/arm/mach-s5p6440/dev-audio.c
+++ b/arch/arm/mach-s5p6440/dev-audio.c
@@ -19,11 +19,16 @@
 #include <mach/dma.h>
 #include <mach/irqs.h>
 
+static const char *rclksrc[] = {
+	[0] = "iis",
+	[1] = "sclk_audio2",
+};
+
 static int s5p6440_cfg_i2s(struct platform_device *pdev)
 {
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
-	case -1:
+	case 0:
 		s3c_gpio_cfgpin(S5P6440_GPR(4), S3C_GPIO_SFN(5));
 		s3c_gpio_cfgpin(S5P6440_GPR(5), S3C_GPIO_SFN(5));
 		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(5));
@@ -41,8 +46,14 @@ static int s5p6440_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static struct s3c_audio_pdata s3c_i2s_pdata = {
+static struct s3c_audio_pdata i2sv4_pdata = {
 	.cfg_gpio = s5p6440_cfg_i2s,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN,
+			.src_clk = rclksrc,
+		},
+	},
 };
 
 static struct resource s5p6440_iis0_resource[] = {
@@ -64,12 +75,12 @@ static struct resource s5p6440_iis0_resource[] = {
 };
 
 struct platform_device s5p6440_device_iis = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name		  = "samsung-i2s",
+	.id		  = 0,
 	.num_resources	  = ARRAY_SIZE(s5p6440_iis0_resource),
 	.resource	  = s5p6440_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv4_pdata,
 	},
 };
 
-- 
1.6.2.5
