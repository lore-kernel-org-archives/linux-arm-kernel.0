From: xerofoify@gmail.com (Nicholas Krause)
Date: Wed, 16 Sep 2015 23:00:35 -0400
Subject: [PATCH RFT] mach-s3c64xx:Fix error handling for certain calls to
 s3c_gpio_cfgpin_range in the file dev-audio.c
Message-ID: <1442458835-25520-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes error handling for calls to the function 
s3c_gpio_cfgpin_range in the file dev-audio.c that
assume calls to this particular function always run 
successfully to properly check now if these calls
fail by returning a error code and if so return it 
directly as otherwise we fail to signal that the
pins have failed to changed their configuration to 
future function users of the gpio configuration
of this device, therefore making them incorrectly 
access a misconfigured gpio subsystem on the board
using this gpio driver.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index ff780a8..81fabdb 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -27,6 +27,7 @@
 static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 {
 	unsigned int base;
+	int ret;
 
 	switch (pdev->id) {
 	case 0:
@@ -47,9 +48,9 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
-
-	return 0;
+	ret = s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
+
+	return ret;
 }
 
 static struct resource s3c64xx_iis0_resource[] = {
@@ -122,6 +123,7 @@ EXPORT_SYMBOL(s3c64xx_device_iisv4);
 static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 {
 	unsigned int base;
+	int ret;
 
 	switch (pdev->id) {
 	case 0:
@@ -136,8 +138,8 @@ static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
-	return 0;
+	ret = s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
+	return ret;
 }
 
 static struct resource s3c64xx_pcm0_resource[] = {
-- 
2.1.4
