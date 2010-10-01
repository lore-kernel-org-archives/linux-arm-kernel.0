From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:08 +0900
Subject: [PATCH 11/27] ARM: S3C64XX: Change to using s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-12-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change the code setting a range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgall_range().

Mop up a few missed s3c_gpio_cfgpin_range() changes.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[kgene.kim at samsung.com: Fix small comments]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c   |   14 ++------
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c |   45 ++++++++----------------------
 2 files changed, 16 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 0007368..3b0dd12 100644
--- a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
+++ b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
@@ -23,15 +23,9 @@
 
 extern void s3c64xx_fb_gpio_setup_24bpp(void)
 {
-	unsigned int gpio;
+	s3c_gpio_cfgall_range(S3C64XX_GPI(0), 16,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
-	for (gpio = S3C64XX_GPI(0); gpio <= S3C64XX_GPI(15); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	for (gpio = S3C64XX_GPJ(0); gpio <= S3C64XX_GPJ(11); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPJ(0), 12,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 }
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
index 0655c7a..4262f78 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -24,16 +24,10 @@
 void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-	unsigned int end;
 
-	end = S3C64XX_GPG(2 + width);
-
-	/* Set all the necessary GPG pins to special-function 0 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPG(0), 2 + width, S3C_GPIO_SFN(2));
-	for (gpio = S3C64XX_GPG(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	/* Set all the necessary GPG pins to special-function 2 */
+	s3c_gpio_cfgall_range(S3C64XX_GPG(0), 2 + width,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
@@ -44,16 +38,10 @@ void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
 	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
-	unsigned int gpio;
-	unsigned int end;
 
-	end = S3C64XX_GPH(2 + width);
-
-	/* Set all the necessary GPG pins to special-function 0 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPH(0), 2 + width, S3C_GPIO_SFN(2));
-	for (gpio = S3C64XX_GPH(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	/* Set all the necessary GPH pins to special-function 2 */
+	s3c_gpio_cfgall_range(S3C64XX_GPH(0), 2 + width,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
@@ -63,20 +51,11 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 
 void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
+	/* Set all the necessary GPH pins to special-function 3 */
+	s3c_gpio_cfgall_range(S3C64XX_GPH(6), width,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 
-	end = S3C64XX_GPH(6 + width);
-
-	/* Set all the necessary GPH pins to special-function 1 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), width, S3C_GPIO_SFN(3));
-	for (gpio = S3C64XX_GPH(6); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	/* Set all the necessary GPC pins to special-function 1 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPC(4), 2, S3C_GPIO_SFN(3));
-	for (gpio = S3C64XX_GPC(4); gpio < S3C64XX_GPC(6); gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	/* Set all the necessary GPC pins to special-function 3 */
+	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 2,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 }
-- 
1.6.2.5
