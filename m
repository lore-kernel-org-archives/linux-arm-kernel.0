From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:47 +0100
Subject: [PATCH 10/15] ARM: S5PC100: Change to using s3c_gpio_cfgall_range()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-11-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting a range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgall_range().

Mop up a few missed s3c_gpio_cfgpin_range() changes.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pc100/setup-fb-24bpp.c   |   30 +++++++----------------
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c |   38 ++++++-----------------------
 2 files changed, 17 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-s5pc100/setup-fb-24bpp.c b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
index 6eba6cb..5a882d4 100644
--- a/arch/arm/mach-s5pc100/setup-fb-24bpp.c
+++ b/arch/arm/mach-s5pc100/setup-fb-24bpp.c
@@ -22,27 +22,15 @@
 
 #define DISR_OFFSET	0x7008
 
-void s5pc100_fb_gpio_setup_24bpp(void)
+static void s5pc100_fb_setgpios(unsigned int base, unsigned int nr)
 {
-	unsigned int gpio = 0;
-
-	for (gpio = S5PC100_GPF0(0); gpio <= S5PC100_GPF0(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	for (gpio = S5PC100_GPF1(0); gpio <= S5PC100_GPF1(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
-
-	for (gpio = S5PC100_GPF2(0); gpio <= S5PC100_GPF2(7); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(base, nr, S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
+}
 
-	for (gpio = S5PC100_GPF3(0); gpio <= S5PC100_GPF3(3); gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+void s5pc100_fb_gpio_setup_24bpp(void)
+{
+	s5pc100_fb_setgpios(S5PC100_GPF0(0), 8);
+	s5pc100_fb_setgpios(S5PC100_GPF1(0), 8);
+	s5pc100_fb_setgpios(S5PC100_GPF2(0), 8);
+	s5pc100_fb_setgpios(S5PC100_GPF3(0), 4);
 }
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index 320dc64..15cf1ac 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -23,8 +23,6 @@
 
 void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
 	unsigned int num;
 
 	num = width;
@@ -32,19 +30,13 @@ void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	if (width == 8)
 		num = width - 2;
 
-	end = S5PC100_GPG0(2 + num);
-
 	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
-	s3c_gpio_cfgpin_range(S5PC100_GPG0(0), 2 + num, S3C_GPIO_SFN(2));
-	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PC100_GPG0(0), 2 + num,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	if (width == 8) {
-		for (gpio = S5PC100_GPG1(0); gpio <= S5PC100_GPG1(1); gpio++) {
-			s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
-			s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-		}
+		s3c_gpio_cfgall_range(S5PC100_GPG1(0), 2,
+				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 	}
 
 	s3c_gpio_setpull(S5PC100_GPG1(2), S3C_GPIO_PULL_UP);
@@ -53,16 +45,9 @@ void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 
 void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S5PC100_GPG2(2 + width);
-	s3c_gpio_cfgpin_range(S5PC100_GPG2(0), 2 + width, S3C_GPIO_SFN(2));
-
 	/* Set all the necessary GPG2 pins to special-function 2 */
-	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PC100_GPG2(0), 2 + width,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S5PC100_GPG2(6), S3C_GPIO_SFN(2));
@@ -70,16 +55,9 @@ void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 
 void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 {
-	unsigned int gpio;
-	unsigned int end;
-
-	end = S5PC100_GPG3(2 + width);
-	s3c_gpio_cfgpin_range(S5PC100_GPG3(0), 2 + width, S3C_GPIO_SFN(2));
-
 	/* Set all the necessary GPG3 pins to special-function 2 */
-	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++) {
-		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
+	s3c_gpio_cfgall_range(S5PC100_GPG3(0), 2 + width,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);
 
 	s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S5PC100_GPG3(6), S3C_GPIO_SFN(2));
-- 
1.6.3.3
