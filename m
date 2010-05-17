From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 17 May 2010 08:22:37 +0100
Subject: [PATCH 5/6] ARM: S3C24XX: Remove macros mapping GPIO number to base
In-Reply-To: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
References: <1274080958-369-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274080958-369-5-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the cleanup, remove the old macros mapping GPIO numbers
to the base of the register now we have gpiolib to manage the GPIO
mappings for us.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/gpio-nrs.h   |    1 -
 arch/arm/mach-s3c2410/include/mach/gpio-track.h |    2 +-
 arch/arm/mach-s3c2410/include/mach/regs-gpio.h  |   22 ++--------------------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
index ad94e1a..ad4a04a 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-nrs.h
@@ -16,7 +16,6 @@
 
 #define S3C2410_GPIONO(bank,offset) ((bank) + (offset))
 
-#define S3C2410_GPIO_BANKC   (32*2)
 #define S3C2410_GPIO_BANKG   (32*6)
 #define S3C2410_GPIO_BANKH   (32*7)
 
diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-track.h b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
index 6371eaa..d67819d 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-track.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-track.h
@@ -27,7 +27,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
 		return NULL;
 
 	chip = &s3c24xx_gpios[pin/32];
-	return (S3C2410_GPIO_OFFSET(pin) < chip->chip.ngpio) ? chip : NULL;
+	return ((pin - chip->chip.base) < chip->chip.ngpio) ? chip : NULL;
 }
 
 #endif /* __ASM_ARCH_GPIO_CORE_H */
diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
index 821b966..95e29fe 100644
--- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
@@ -17,29 +17,11 @@
 #include <mach/gpio-nrs.h>
 
 #ifdef CONFIG_CPU_S3C2400
-#define S3C24XX_GPIO_BASE(x)  S3C2400_GPIO_BASE(x)
-#define S3C24XX_MISCCR        S3C2400_MISCCR
+#define S3C24XX_MISCCR		S3C2400_MISCCR
 #else
-#define S3C24XX_GPIO_BASE(x)  S3C2410_GPIO_BASE(x)
-#define S3C24XX_MISCCR	      S3C24XX_GPIOREG2(0x80)
+#define S3C24XX_MISCCR		S3C24XX_GPIOREG2(0x80)
 #endif /* CONFIG_CPU_S3C2400 */
 
-
-/* S3C2400 doesn't have a 1:1 mapping to S3C2410 gpio base pins */
-
-#define S3C2400_BANKNUM(pin)     (((pin) & ~31) / 32)
-#define S3C2400_BASEA2B(pin)     ((((pin) & ~31) >> 2))
-#define S3C2400_BASEC2H(pin)     ((S3C2400_BANKNUM(pin) * 10) + \
-                                 (2 * (S3C2400_BANKNUM(pin)-2)))
-
-#define S3C2400_GPIO_BASE(pin)   (pin < S3C2410_GPIO_BANKC ? \
-                                 S3C2400_BASEA2B(pin)+S3C24XX_VA_GPIO : \
-                                 S3C2400_BASEC2H(pin)+S3C24XX_VA_GPIO)
-
-
-#define S3C2410_GPIO_BASE(pin)   ((((pin) & ~31) >> 1) + S3C24XX_VA_GPIO)
-#define S3C2410_GPIO_OFFSET(pin) ((pin) & 31)
-
 /* general configuration options */
 
 #define S3C2410_GPIO_LEAVE   (0xFFFFFFFF)
-- 
1.6.3.3
