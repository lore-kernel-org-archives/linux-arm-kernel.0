From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:48 +0100
Subject: [PATCH 11/15] ARM: S5PV210: Change to using s3c_gpio_cfgall_range()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-12-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting a range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgall_range().

Mop up a few missed s3c_gpio_cfgpin_range() changes.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pv210/setup-fb-24bpp.c   |   32 +++++------------
 arch/arm/mach-s5pv210/setup-sdhci-gpio.c |   55 +++++++++--------------------
 2 files changed, 27 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-s5pv210/setup-fb-24bpp.c b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
index a50cbac..ac07542 100644
--- a/arch/arm/mach-s5pv210/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pv210/setup-fb-24bpp.c
@@ -21,33 +21,21 @@
 #include <mach/regs-clock.h>
 #include <plat/gpio-cfg.h>
 
-void s5pv210_fb_gpio_setup_24bpp(void)
+static void s5pv210_fb_cfg_gpios(unsigned int base, unsigned int nr)
 {
-	unsigned int gpio = 0;
-
-	for (gpio = S5PV210_GPF0(0); gpio <= S5PV210_GPF0(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+	s3c_gpio_cfgall_range(base, size, S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
-	for (gpio = S5PV210_GPF1(0); gpio <= S5PV210_GPF1(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	for (; nr > 0; nr--, base++)
 		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+}
 
-	for (gpio = S5PV210_GPF2(0); gpio <= S5PV210_GPF2(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
 
-	for (gpio = S5PV210_GPF3(0); gpio <= S5PV210_GPF3(3); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		s5p_gpio_set_drvstr(gpio, S5P_GPIO_DRVSTR_LV4);
-	}
+void s5pv210_fb_gpio_setup_24bpp(void)
+{
+	s5pv210_fb_cfg_gpios(S5PV210_GPF0(0), 8);
+	s5pv210_fb_cfg_gpios(S5PV210_GPF1(0), 8);
+	s5pv210_fb_cfg_gpios(S5PV210_GPF2(0), 8);
+	s5pv210_fb_cfg_gpios(S5PV210_GPF3(0), 4);
 
 	/* Set DISPLAY_CONTROL register for Display path selection.
 	 *
diff --git a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
index 147abd0..38189d1 100644
--- a/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pv210/setup-sdhci-gpio.c
@@ -24,26 +24,19 @@
 
 void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-
 	/* Set all the necessary GPG0/GPG1 pins to special-function 2 */
-	s3c_gpio_cfgpin_range(S5PV210_GPG0(0), 2, S3C_GPIO_SFN(2));
-	for (gpio = S5PV210_GPG0(0); gpio < S5PV210_GPG0(2); gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PV210_GPG0(0), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+
 	switch (width) {
 	case 8:
 		/* GPG1[3:6] special-funtion 3 */
-		s3c_gpio_cfgpin_range(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(3));
-		for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
+		s3c_gpio_cfgall_range(S5PV210_GPG1(3), 4,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 	case 4:
 		/* GPG0[3:6] special-funtion 2 */
-		s3c_gpio_cfgpin_range(S5PV210_GPG0(3), 4, S3C_GPIO_SFN(2));
-		for (gpio = S5PV210_GPG0(3); gpio <= S5PV210_GPG0(6); gpio++) {
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
+		s3c_gpio_cfgall_range(S5PV210_GPG0(3), 4,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 	default:
 		break;
 	}
@@ -54,19 +47,13 @@ void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 
 void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-
 	/* Set all the necessary GPG1[0:1] pins to special-function 2 */
-	s3c_gpio_cfgpin_range(S5PV210_GPG1(0), 2, S3C_GPIO_SFN(2));
-	for (gpio = S5PV210_GPG1(0); gpio < S5PV210_GPG1(2); gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PV210_GPG1(0), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	/* Data pin GPG1[3:6] to special-function 2 */
-	s3c_gpio_cfgpin(S5PV210_GPG1(3), 4, S3C_GPIO_SFN(2));
-	for (gpio = S5PV210_GPG1(3); gpio <= S5PV210_GPG1(6); gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PV210_GPG1(3), 4,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	s3c_gpio_setpull(S5PV210_GPG1(2), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S5PV210_GPG1(2), S3C_GPIO_SFN(2));
@@ -74,27 +61,19 @@ void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 
 void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-
 	/* Set all the necessary GPG2[0:1] pins to special-function 2 */
-	s3c_gpio_cfgpin_range(S5PV210_GPG2(0), 2, S3C_GPIO_SFN(2));
-	for (gpio = S5PV210_GPG2(0); gpio < S5PV210_GPG2(2); gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PV210_GPG2(0), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	switch (width) {
 	case 8:
 		/* Data pin GPG3[3:6] to special-function 3 */
-		s3c_gpio_cfgpin_range(S5PV210_GPG3(3), 4, S3C_GPIO_SFN(3));
-		for (gpio = S5PV210_GPG3(3); gpio <= S5PV210_GPG3(6); gpio++) {
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
+		s3c_gpio_cfgall_range(S5PV210_GPG3(3), 4,
+				      S3C_GPIO_SFN(3), S3C_GPIO_PULL_NONE);
 	case 4:
 		/* Data pin GPG2[3:6] to special-function 2 */
-		s3c_gpio_cfgpin_range(S5PV210_GPG2(3), 4, S3C_GPIO_SFN(2));
-		for (gpio = S5PV210_GPG2(3); gpio <= S5PV210_GPG2(6); gpio++) {
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
+		s3c_gpio_cfgall_range(S5PV210_GPG2(3), 4,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 	default:
 		break;
 	}
-- 
1.6.3.3
