From: xerofoify@gmail.com (Nicholas Krause)
Date: Tue, 29 Sep 2015 22:07:50 -0400
Subject: [PATCH RESENDv2] mach:-s3c64xx:Output trace information with WARN_ON
 if calls for setting up gpio board configuration fail in s3c64xx_i2s_cfg_gpio
Message-ID: <1443578870-14534-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the function s3c64xx_i2c_cfg_gpio to log output to the 
kernel log buff with WARN_ON if any of the calls to either 
s3c_gpio_cfgpin_range or s3c_gpio_cfgpin fail as we cannot exit 
from s3c64xx_i2s_cfg_gpio if any of these calls fail due to 
other intended function work being required to complete. Therefore
due to this output our failed calls by means of WARN_ON to the
kernel log buffer for failed configuration of gpio devices using
this driver file.
v2:Fix Patch Wording as it was clearly confusing and incorrect

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index ff780a8..5e7538b 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -36,10 +36,10 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 		base = S3C64XX_GPE(0);
 		break;
 	case 2:
-		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5));
-		s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));
+		WARN_ON(s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C_GPIO_SFN(5)));
+		WARN_ON(s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C_GPIO_SFN(5)));
+		WARN_ON(s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C_GPIO_SFN(5)));
+		WARN_ON(s3c_gpio_cfgpin_range(S3C64XX_GPH(6), 4, S3C_GPIO_SFN(5));)
 		return 0;
 	default:
 		printk(KERN_DEBUG "Invalid I2S Controller number: %d\n",
@@ -47,7 +47,7 @@ static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3));
+	WARN_ON(s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(3)));
 
 	return 0;
 }
-- 
2.1.4
