From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:00 +0900
Subject: [PATCH 03/27] ARM: S3C64XX: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c        |   53 ++++++++---------------------
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c |    8 ++--
 2 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 3787811..e4bb023 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -24,25 +24,22 @@
 
 static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C_GPIO_SFN(3));
+		base = S3C64XX_GPD(0);
 		break;
 	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C_GPIO_SFN(3));
+		base = S3C64XX_GPE(0);
+		break;
 	default:
 		printk(KERN_DEBUG "Invalid I2S Controller number!");
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
+
 	return 0;
 }
 
@@ -51,10 +48,7 @@ static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
 	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
 	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
 	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
-	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C_GPIO_SFN(4)); 
+	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(4));
 
 	return 0;
 }
@@ -163,26 +157,21 @@ EXPORT_SYMBOL(s3c64xx_device_iisv4);
 
 static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C_GPIO_SFN(2));
+		base = S3C64XX_GPD(0);
 		break;
 	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C_GPIO_SFN(2));
+		base = S3C64XX_GPE(0);
 		break;
 	default:
 		printk(KERN_DEBUG "Invalid PCM Controller number!");
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
 	return 0;
 }
 
@@ -256,24 +245,12 @@ EXPORT_SYMBOL(s3c64xx_device_pcm1);
 
 static int s3c64xx_ac97_cfg_gpd(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C_GPIO_SFN(4));
-
-	return 0;
+	return s3c_gpio_cfgpin_range(S3C64XX_GPD(0), 5, S3C_GPIO_SFN(4));
 }
 
 static int s3c64xx_ac97_cfg_gpe(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C_GPIO_SFN(4));
-
-	return 0;
+	return s3c_gpio_cfgpin_range(S3C64XX_GPE(0), 5, S3C_GPIO_SFN(4));
 }
 
 static struct resource s3c64xx_ac97_resource[] = {
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index 3223595..0655c7a 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -30,8 +30,8 @@ void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	end = S3C64XX_GPG(2 + width);
 
 	/* Set all the necessary GPG pins to special-function 0 */
+	s3c_gpio_cfgpin_range(S3C64XX_GPG(0), 2 + width, S3C_GPIO_SFN(2));
 	for (gpio = S3C64XX_GPG(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
@@ -50,8 +50,8 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	end = S3C64XX_GPH(2 + width);
 
 	/* Set all the necessary GPG pins to special-function 0 */
+	s3c_gpio_cfgpin_range(S3C64XX_GPH(0), 2 + width, S3C_GPIO_SFN(2));
 	for (gpio = S3C64XX_GPH(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
@@ -69,14 +69,14 @@ void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	end = S3C64XX_GPH(6 + width);
 
 	/* Set all the necessary GPH pins to special-function 1 */
+	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), width, S3C_GPIO_SFN(3));
 	for (gpio = S3C64XX_GPH(6); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
 	/* Set all the necessary GPC pins to special-function 1 */
+	s3c_gpio_cfgpin_range(S3C64XX_GPC(4), 2, S3C_GPIO_SFN(3));
 	for (gpio = S3C64XX_GPC(4); gpio < S3C64XX_GPC(6); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 }
-- 
1.6.2.5
