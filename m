From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:43 +0100
Subject: [PATCH 06/15] ARM: S5PC100: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pc100/dev-audio.c        |   32 ++++-------------------------
 arch/arm/mach-s5pc100/dev-spi.c          |   17 +++++++--------
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c |    6 ++--
 3 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 18cfe9a..078b938 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -24,19 +24,11 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
 	case 1:
-		s3c_gpio_cfgpin(S5PC100_GPC(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPC(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPC(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPC(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPC(4), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PC100_GPC(0), 5, S3C_GPIO_SFN(2));
 		break;
 
 	case 2:
-		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PC100_GPG3(1), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PC100_GPG3(2), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PC100_GPG3(3), S3C_GPIO_SFN(4));
-		s3c_gpio_cfgpin(S5PC100_GPG3(4), S3C_GPIO_SFN(4));
+		s3c_gpio_cfgpin_range(S5PC100_GPG3(0), 5, S3C_GPIO_SFN(4));
 		break;
 
 	case -1: /* Dedicated pins */
@@ -144,19 +136,11 @@ static int s5pc100_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5PC100_GPG3(1), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5PC100_GPG3(2), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5PC100_GPG3(3), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5PC100_GPG3(4), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5PC100_GPG3(0), 5, S3C_GPIO_SFN(5));
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5PC100_GPC(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPC(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPC(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPC(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPC(4), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(S5PC100_GPC(0), 5, S3C_GPIO_SFN(3));
 		break;
 
 	default:
@@ -231,13 +215,7 @@ struct platform_device s5pc100_device_pcm1 = {
 
 static int s5pc100_ac97_cfg_gpio(struct platform_device *pdev)
 {
-	s3c_gpio_cfgpin(S5PC100_GPC(0), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PC100_GPC(1), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PC100_GPC(2), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PC100_GPC(3), S3C_GPIO_SFN(4));
-	s3c_gpio_cfgpin(S5PC100_GPC(4), S3C_GPIO_SFN(4));
-
-	return 0;
+	return s3c_gpio_cfgpin_range(S5PC100_GPC(0), 5, S3C_GPIO_SFN(4));
 }
 
 static struct resource s5pc100_ac97_resource[] = {
diff --git a/arch/arm/mach-s5pc100/dev-spi.c b/arch/arm/mach-s5pc100/dev-spi.c
index 14618c3..e04c431 100644
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ b/arch/arm/mach-s5pc100/dev-spi.c
@@ -36,29 +36,25 @@ static char *spi_src_clks[] = {
  */
 static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base, type;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5PC100_GPB(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(2), S3C_GPIO_SFN(2));
+		base = S5PC100_GPB(0);
 		s3c_gpio_setpull(S5PC100_GPB(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(1), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5PC100_GPB(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(6), S3C_GPIO_SFN(2));
+		base = S5PC100_GPB(4);
 		s3c_gpio_setpull(S5PC100_GPB(4), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(5), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(6), S3C_GPIO_PULL_UP);
 		break;
 
 	case 2:
-		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPG3(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPG3(3), S3C_GPIO_SFN(3));
+		base = S5PC100_GPG3(0);
 		s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPG3(2), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPG3(3), S3C_GPIO_PULL_UP);
@@ -69,6 +65,9 @@ static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	type = (pdev->id == 2) ? S3C_GPIO_SFN(3) : S3C_GPIO_SFN(2);
+	s3c_gpio_cfgpin_range(base, 3, type);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index 7769c76..320dc64 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -35,8 +35,8 @@ void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	end = S5PC100_GPG0(2 + num);
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
+	s3c_gpio_cfgpin_range(S5PC100_GPG0(0), 2 + num, S3C_GPIO_SFN(2));
 	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
@@ -57,10 +57,10 @@ void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int end;
 
 	end = S5PC100_GPG2(2 + width);
+	s3c_gpio_cfgpin_range(S5PC100_GPG2(0), 2 + width, S3C_GPIO_SFN(2));
 
 	/* Set all the necessary GPG2 pins to special-function 2 */
 	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
@@ -74,10 +74,10 @@ void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	unsigned int end;
 
 	end = S5PC100_GPG3(2 + width);
+	s3c_gpio_cfgpin_range(S5PC100_GPG3(0), 2 + width, S3C_GPIO_SFN(2));
 
 	/* Set all the necessary GPG3 pins to special-function 2 */
 	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
 	}
 
-- 
1.6.3.3
