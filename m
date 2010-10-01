From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:10 +0900
Subject: [PATCH 13/27] ARM: S5P64X0: Change to using s3c_gpio_cfgall_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-14-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting a range of GPIO pins' configuration and
pull state to use the recently introduced s3c_gpio_cfgall_range().

Mop up a few missed s3c_gpio_cfgpin_range() changes.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/dev-spi.c    |   18 ++++--------------
 arch/arm/mach-s5p64x0/setup-i2c0.c |   10 ++++------
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/dev-spi.c b/arch/arm/mach-s5p64x0/dev-spi.c
index be64fee..e78ee18 100644
--- a/arch/arm/mach-s5p64x0/dev-spi.c
+++ b/arch/arm/mach-s5p64x0/dev-spi.c
@@ -44,16 +44,10 @@ static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
 	switch (pdev->id) {
 	case 0:
 		base = S5P6440_GPC(0);
-		s3c_gpio_setpull(S5P6440_GPC(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(1), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
 		base = S5P6440_GPC(4);
-		s3c_gpio_setpull(S5P6440_GPC(4), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(5), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6440_GPC(6), S3C_GPIO_PULL_UP);
 		break;
 
 	default:
@@ -61,7 +55,8 @@ static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s3c_gpio_cfgpin_range(base, 3, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgall_range(base, 3,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 
 	return 0;
 }
@@ -73,16 +68,10 @@ static int s5p6450_spi_cfg_gpio(struct platform_device *pdev)
 	switch (pdev->id) {
 	case 0:
 		base = S5P6450_GPC(0);
-		s3c_gpio_setpull(S5P6450_GPC(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6450_GPC(1), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6450_GPC(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
 		base = S5P6450_GPC(4);
-		s3c_gpio_setpull(S5P6450_GPC(4), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6450_GPC(5), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S5P6450_GPC(6), S3C_GPIO_PULL_UP);
 		break;
 
 	default:
@@ -90,7 +79,8 @@ static int s5p6450_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s3c_gpio_cfgpin_range(base, 3, S3C_GPIO_SFN(2));
+	s3c_gpio_cfgall_range(base, 3,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 
 	return 0;
 }
diff --git a/arch/arm/mach-s5p64x0/setup-i2c0.c b/arch/arm/mach-s5p64x0/setup-i2c0.c
index 75ef9e5..46b4639 100644
--- a/arch/arm/mach-s5p64x0/setup-i2c0.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c0.c
@@ -25,16 +25,14 @@ struct platform_device; /* don't need the contents */
 
 void s5p6440_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin_range(S5P6440_GPB(5), 2, S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5P6440_GPB(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_setpull(S5P6440_GPB(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5P6440_GPB(5), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
 
 void s5p6450_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin_range(S5P6450_GPB(5), 2, S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5P6450_GPB(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_setpull(S5P6450_GPB(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S5P6450_GPB(5), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev) { }
-- 
1.6.2.5
