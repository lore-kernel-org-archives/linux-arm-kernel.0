From: marek.belisko@open-nandra.com (Marek Belisko)
Date: Fri, 19 Nov 2010 10:15:39 +0100
Subject: [PATCH] ARM: s3x24xx: Fix gpiochip_add complaining.
Message-ID: <1290158139-16105-1-git-send-email-marek.belisko@open-nandra.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make mini2440_defconfig. During kernel startup there is:
gpiochip_add: gpios 288..303 (GPIOK) failed to register
gpiochip_add: gpios 320..334 (GPIOL) failed to register
gpiochip_add: gpios 352..353 (GPIOM) failed to register

because s3c2440 doesn't have following gpios. Gpios are
available only at upper cpu version (s3c2443).

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/plat-s3c24xx/gpiolib.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 24c6f5a..0428a92 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -182,7 +182,9 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.label			= "GPIOJ",
 			.ngpio			= 16,
 		},
-	}, {
+	},
+#ifdef CONFIG_CPU_S3C2443
+	{
 		.base	= S3C2443_GPKCON,
 		.pm	= __gpio_pm(&s3c_gpio_pm_2bit),
 		.chip	= {
@@ -210,6 +212,7 @@ struct s3c_gpio_chip s3c24xx_gpios[] = {
 			.ngpio			= 2,
 		},
 	},
+#endif
 };
 
 
-- 
1.7.1
