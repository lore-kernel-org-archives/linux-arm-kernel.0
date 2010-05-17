From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 08:22:34 +0100
Subject: [PATCH 2/6] ARM: S3C244X: fix gpiolib port J support
In-Reply-To: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
References: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274080958-369-2-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

Increase GPIOs number for S3C244X, and make S3C_GPIO_END
point to BANKJ end, otherwise gpiolib refuses to register
BANKJ

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/gpio-track.h |    2 +-
 arch/arm/mach-s3c2410/include/mach/gpio.h       |    8 ++++++++
 arch/arm/plat-samsung/pm-gpio.c                 |    2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-track.h b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
index acb2591..6371eaa 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-track.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
@@ -23,7 +23,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
 {
 	struct s3c_gpio_chip *chip;
 
-	if (pin > S3C2410_GPG(10))
+	if (pin > S3C_GPIO_END)
 		return NULL;
 
 	chip = &s3c24xx_gpios[pin/32];
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio.h b/arch/arm/mach-s3c2410/include/mach/gpio.h
index 15f0b3e..b649bf2 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio.h
@@ -20,10 +20,18 @@
  * devices that need GPIO.
  */
 
+#ifdef CONFIG_CPU_S3C244X
+#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
+#else
 #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
+#endif
 
 #include <asm-generic/gpio.h>
 #include <mach/gpio-nrs.h>
 #include <mach/gpio-fns.h>
 
+#ifdef CONFIG_CPU_S3C24XX
+#define S3C_GPIO_END	(S3C2410_GPIO_BANKJ + 32)
+#else
 #define S3C_GPIO_END	(S3C2410_GPIO_BANKH + 32)
+#endif
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
index 69a4c7f..1aac746 100644
--- a/arch/arm/plat-samsung/pm-gpio.c
+++ b/arch/arm/plat-samsung/pm-gpio.c
@@ -343,7 +343,7 @@ void s3c_pm_save_gpios(void)
 			  ourchip->pm_save[2],
 			  ourchip->pm_save[3]);
 
-		gpio_nr += ourchip->chip.ngpio;
+		gpio_nr += ourchip->chip.ngpio - 1;
 		gpio_nr += CONFIG_S3C_GPIO_SPACE;
 	}
 }
-- 
1.6.3.3
