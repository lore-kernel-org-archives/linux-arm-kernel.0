From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:01 +0900
Subject: [PATCH 04/27] ARM: S5P6442: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
[kgene.kim at samsung.com: fixed wrong change]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/dev-audio.c |   30 ++++++++++--------------------
 arch/arm/mach-s5p6442/dev-spi.c   |    3 +--
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
index 7a4e347..3462197 100644
--- a/arch/arm/mach-s5p6442/dev-audio.c
+++ b/arch/arm/mach-s5p6442/dev-audio.c
@@ -21,22 +21,16 @@
 
 static int s5p6442_cfg_i2s(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
 	case 1:
-		s3c_gpio_cfgpin(S5P6442_GPC1(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC1(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC1(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(2));
+		base = S5P6442_GPC1(0);
 		break;
 
 	case -1:
-		s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(2));
+		base = S5P6442_GPC0(0);
 		break;
 
 	default:
@@ -44,6 +38,7 @@ static int s5p6442_cfg_i2s(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
 	return 0;
 }
 
@@ -111,21 +106,15 @@ struct platform_device s5p6442_device_iis1 = {
 
 static int s5p6442_pcm_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5P6442_GPC0(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC0(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC0(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC0(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC0(4), S3C_GPIO_SFN(3));
+		base = S5P6442_GPC0(0);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5P6442_GPC1(0), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC1(1), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC1(2), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC1(3), S3C_GPIO_SFN(3));
-		s3c_gpio_cfgpin(S5P6442_GPC1(4), S3C_GPIO_SFN(3));
+		base = S5P6442_GPC1(0);
 		break;
 
 	default:
@@ -133,6 +122,7 @@ static int s5p6442_pcm_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
 	return 0;
 }
 
diff --git a/arch/arm/mach-s5p6442/dev-spi.c b/arch/arm/mach-s5p6442/dev-spi.c
index e894651..547c570 100644
--- a/arch/arm/mach-s5p6442/dev-spi.c
+++ b/arch/arm/mach-s5p6442/dev-spi.c
@@ -38,8 +38,7 @@ static int s5p6442_spi_cfg_gpio(struct platform_device *pdev)
 	switch (pdev->id) {
 	case 0:
 		s3c_gpio_cfgpin(S5P6442_GPB(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPB(2), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6442_GPB(3), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5P6442_GPB(2), 2, S3C_GPIO_SFN(2));
 		s3c_gpio_setpull(S5P6442_GPB(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6442_GPB(2), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6442_GPB(3), S3C_GPIO_PULL_UP);
-- 
1.6.2.5
