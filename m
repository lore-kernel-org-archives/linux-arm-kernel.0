From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:41 +0100
Subject: [PATCH 04/15] ARM: S5P6440: Change to using s3c_gpio_cfgpin_range()
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the code setting ranges of GPIO pins using s3c_gpio_cfgpin() to
use the recently introduced s3c_gpio_cfgpin_range().

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5p6440/dev-audio.c |   16 ++++------------
 arch/arm/mach-s5p6440/dev-spi.c   |   12 ++++++------
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s5p6440/dev-audio.c b/arch/arm/mach-s5p6440/dev-audio.c
index 0c53679..f929290 100644
--- a/arch/arm/mach-s5p6440/dev-audio.c
+++ b/arch/arm/mach-s5p6440/dev-audio.c
@@ -24,13 +24,8 @@ static int s5p6440_cfg_i2s(struct platform_device *pdev)
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
 	case -1:
-		s3c_gpio_cfgpin(S5P6440_GPR(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(5), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(4), 5, S3C_GPIO_SFN(5));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(13), 2, S3C_GPIO_SFN(5));
 		break;
 
 	default:
@@ -79,11 +74,8 @@ static int s5p6440_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S5P6440_GPR(7), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(13), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(14), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(8), S3C_GPIO_SFN(2));
-		s3c_gpio_cfgpin(S5P6440_GPR(6), S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(13), 2, S3C_GPIO_SFN(2));
+		s3c_gpio_cfgpin_range(S5P6440_GPR(6), 3, S3C_GPIO_SFN(2));
 		break;
 
 	default:
diff --git a/arch/arm/mach-s5p6440/dev-spi.c b/arch/arm/mach-s5p6440/dev-spi.c
index 0a30280..473eae4 100644
--- a/arch/arm/mach-s5p6440/dev-spi.c
+++ b/arch/arm/mach-s5p6440/dev-spi.c
@@ -35,20 +35,18 @@ static char *spi_src_clks[] = {
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
@@ -59,6 +57,8 @@ static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgpin_range(base, 3, S3C_GPIO_SFN(2));
+
 	return 0;
 }
 
-- 
1.6.3.3
