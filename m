From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:46 +0100
Subject: [PATCH 09/15] ARM: S3C64XX: Change to using s3c_gpio_cfgall_range()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-10-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting a range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgall_range().

Mop up a few missed s3c_gpio_cfgpin_range() changes.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/setup-fb-24bpp.c   |   14 +++-------
 arch/arm/mach-s3c64xx/setup-sdhci-gpio.c |   39 ++++++-----------------------
 2 files changed, 12 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c64xx/setup-fb-24bpp.c
index 8e28e44..b3ac75f 100644
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
index 384fcda..45640ef 100644
--- a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
@@ -22,16 +22,9 @@
 
 void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S3C64XX_GPG(2 + width);
-
 	/* Set all the necessary GPG pins to special-function 0 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPG(0), 2 + width, S3C_GPIO_SFN(2));
-	for (gpio = S3C64XX_GPG(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPG(0), 2 + width,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(2));
@@ -39,16 +32,9 @@ void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 
 void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S3C64XX_GPH(2 + width);
-
 	/* Set all the necessary GPG pins to special-function 0 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPH(0), 2 + width, S3C_GPIO_SFN(2));
-	for (gpio = S3C64XX_GPH(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPH(0), 2 + width,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	s3c_gpio_setpull(S3C64XX_GPG(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S3C64XX_GPG(6), S3C_GPIO_SFN(3));
@@ -56,20 +42,11 @@ void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 
 void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S3C64XX_GPH(6 + width);
-
 	/* Set all the necessary GPH pins to special-function 1 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPH(6), width, S3C_GPIO_SFN(3));
-	for (gpio = S3C64XX_GPH(6); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPH(6), width,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 
 	/* Set all the necessary GPC pins to special-function 1 */
-	s3c_gpio_cfgpin_range(S3C64XX_GPC(4), 2, S3C_GPIO_SFN(3));
-	for (gpio = S3C64XX_GPC(4); gpio < S3C64XX_GPC(6); gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S3C64XX_GPC(4), 2,
+			      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 }
-- 
1.6.3.3
