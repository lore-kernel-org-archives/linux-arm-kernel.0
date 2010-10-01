From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:04 +0900
Subject: [PATCH 07/27] ARM: S5PC100: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[kgene.kim at samsung.com: Fixed wrong change]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/dev-audio.c        |   32 ++++-------------------------
 arch/arm/mach-s5pc100/dev-spi.c          |   11 ++-------
 arch/arm/mach-s5pc100/setup-sdhci-gpio.c |   15 +++++--------
 3 files changed, 14 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index a699ed6..7f6d01e 100644
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
index a0ef7c3..c1c5aed 100644
--- a/arch/arm/mach-s5pc100/dev-spi.c
+++ b/arch/arm/mach-s5pc100/dev-spi.c
@@ -38,18 +38,14 @@ static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5PC100_GPB(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(2), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PC100_GPB(0), 3, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(S5PC100_GPB(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(1), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5PC100_GPB(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5PC100_GPB(6), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5PC100_GPB(4), 3, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(S5PC100_GPB(4), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(5), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPB(6), S3C_GPIO_PULL_UP);
@@ -57,8 +53,7 @@ static int s5pc100_spi_cfg_gpio(struct platform_device *pdev)
 
 	case 2:
 		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPG3(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5PC100_GPG3(3), S3C_GPIO_SFN(3));
+		s3c_gpio_cfgpin_range(S5PC100_GPB(2), 2, S3C_GPIO_SFN(3));
 		s3c_gpio_setpull(S5PC100_GPG3(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPG3(2), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5PC100_GPG3(3), S3C_GPIO_PULL_UP);
diff --git a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
index dc7208c..79b031f 100644
--- a/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
+++ b/arch/arm/mach-s5pc100/setup-sdhci-gpio.c
@@ -37,10 +37,9 @@ void s5pc100_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 	end = S5PC100_GPG0(2 + num);
 
 	/* Set all the necessary GPG0/GPG1 pins to special-function 0 */
-	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PC100_GPG0(0), 2 + num, S3C_GPIO_SFN(2));
+	for (gpio = S5PC100_GPG0(0); gpio < end; gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	if (width == 8) {
 		for (gpio = S5PC100_GPG1(0); gpio <= S5PC100_GPG1(1); gpio++) {
@@ -64,10 +63,9 @@ void s5pc100_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
 	end = S5PC100_GPG2(2 + width);
 
 	/* Set all the necessary GPG2 pins to special-function 2 */
-	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PC100_GPG2(0), 2 + width, S3C_GPIO_SFN(2));
+	for (gpio = S5PC100_GPG2(0); gpio < end; gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PC100_GPG2(6), S3C_GPIO_PULL_UP);
@@ -84,10 +82,9 @@ void s5pc100_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
 	end = S5PC100_GPG3(2 + width);
 
 	/* Set all the necessary GPG3 pins to special-function 2 */
-	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++) {
-		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5PC100_GPG3(0), 2 + width, S3C_GPIO_SFN(2));
+	for (gpio = S5PC100_GPG3(0); gpio < end; gpio++)
 		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
-	}
 
 	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
 		s3c_gpio_setpull(S5PC100_GPG3(6), S3C_GPIO_PULL_UP);
-- 
1.6.2.5
