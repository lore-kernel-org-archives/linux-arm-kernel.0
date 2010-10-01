From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:03 +0900
Subject: [PATCH 06/27] ARM: S5P64X0: 2nd Change to using
	s3c_gpio_cfgpin_range()
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the code setting ranges of GPIO pins in mach-s5p64x0 using
s3c_gpio_cfgpin() to use the recently introduced s3c_gpio_cfgpin_range().
NOTE: This is for missed things from the previous patch.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/dev-spi.c    |   24 ++++++++++++------------
 arch/arm/mach-s5p64x0/setup-i2c0.c |    6 ++----
 arch/arm/mach-s5p64x0/setup-i2c1.c |    6 ++----
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-s5p64x0/dev-spi.c b/arch/arm/mach-s5p64x0/dev-spi.c
index 5b69ec4..be64fee 100644
--- a/arch/arm/mach-s5p64x0/dev-spi.c
+++ b/arch/arm/mach-s5p64x0/dev-spi.c
@@ -39,20 +39,18 @@ static char *s5p64x0_spi_src_clks[] = {
  */
 static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5P6440_GPC(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(2), S3C_GPIO_SFN(2));
+		base = S5P6440_GPC(0);
 		s3c_gpio_setpull(S5P6440_GPC(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6440_GPC(1), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6440_GPC(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5P6440_GPC(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPC(6), S3C_GPIO_SFN(2));
+		base = S5P6440_GPC(4);
 		s3c_gpio_setpull(S5P6440_GPC(4), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6440_GPC(5), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6440_GPC(6), S3C_GPIO_PULL_UP);
@@ -63,25 +61,25 @@ static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 3, S3C_GPIO_SFN(2));
+
 	return 0;
 }
 
 static int s5p6450_spi_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5P6450_GPC(0), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6450_GPC(1), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6450_GPC(2), S3C_GPIO_SFN(2));
+		base = S5P6450_GPC(0);
 		s3c_gpio_setpull(S5P6450_GPC(0), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6450_GPC(1), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6450_GPC(2), S3C_GPIO_PULL_UP);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S5P6450_GPC(4), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6450_GPC(5), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6450_GPC(6), S3C_GPIO_SFN(2));
+		base = S5P6450_GPC(4);
 		s3c_gpio_setpull(S5P6450_GPC(4), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6450_GPC(5), S3C_GPIO_PULL_UP);
 		s3c_gpio_setpull(S5P6450_GPC(6), S3C_GPIO_PULL_UP);
@@ -92,6 +90,8 @@ static int s5p6450_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 3, S3C_GPIO_SFN(2));
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-s5p64x0/setup-i2c0.c b/arch/arm/mach-s5p64x0/setup-i2c0.c
index dc4cc65..75ef9e5 100644
--- a/arch/arm/mach-s5p64x0/setup-i2c0.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c0.c
@@ -25,17 +25,15 @@ struct platform_device; /* don't need the contents */
 
 void s5p6440_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5P6440_GPB(5), S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5P6440_GPB(5), 2, S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5P6440_GPB(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5P6440_GPB(6), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5P6440_GPB(6), S3C_GPIO_PULL_UP);
 }
 
 void s5p6450_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5P6450_GPB(5), S3C_GPIO_SFN(2));
+	s3c_gpio_cfgpin_range(S5P6450_GPB(5), 2, S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5P6450_GPB(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5P6450_GPB(6), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5P6450_GPB(6), S3C_GPIO_PULL_UP);
 }
 
diff --git a/arch/arm/mach-s5p64x0/setup-i2c1.c b/arch/arm/mach-s5p64x0/setup-i2c1.c
index 2edd791..5d5dd3c 100644
--- a/arch/arm/mach-s5p64x0/setup-i2c1.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c1.c
@@ -25,17 +25,15 @@ struct platform_device; /* don't need the contents */
 
 void s5p6440_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5P6440_GPR(9), S3C_GPIO_SFN(6));
+	s3c_gpio_cfgpin_range(S5P6440_GPR(9), 2, S3C_GPIO_SFN(6));
 	s3c_gpio_setpull(S5P6440_GPR(9), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5P6440_GPR(10), S3C_GPIO_SFN(6));
 	s3c_gpio_setpull(S5P6440_GPR(10), S3C_GPIO_PULL_UP);
 }
 
 void s5p6450_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S5P6450_GPR(9), S3C_GPIO_SFN(6));
+	s3c_gpio_cfgpin_range(S5P6450_GPR(9), 2, S3C_GPIO_SFN(6));
 	s3c_gpio_setpull(S5P6450_GPR(9), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5P6450_GPR(10), S3C_GPIO_SFN(6));
 	s3c_gpio_setpull(S5P6450_GPR(10), S3C_GPIO_PULL_UP);
 }
 
-- 
1.6.2.5
