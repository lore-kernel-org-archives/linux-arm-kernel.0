From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Sep 2013 17:40:51 +0200
Subject: [PATCH 5/8] ARM: plat-iop: remove custom complex GPIO implementation
Message-ID: <1378741251-13032-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel will now only use gpiolib to access GPIOs, so remove
the complex GPIO flag and the custom implementation.

Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/hardware/iop3xx-gpio.h | 43 -----------------------------
 arch/arm/include/asm/hardware/iop3xx.h      |  3 --
 drivers/gpio/gpio-iop.c                     |  9 ++----
 3 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/hardware/iop3xx-gpio.h b/arch/arm/include/asm/hardware/iop3xx-gpio.h
index 9eda7dc..e2a0970 100644
--- a/arch/arm/include/asm/hardware/iop3xx-gpio.h
+++ b/arch/arm/include/asm/hardware/iop3xx-gpio.h
@@ -28,48 +28,5 @@
 #include <mach/hardware.h>
 #include <asm-generic/gpio.h>
 
-#define __ARM_GPIOLIB_COMPLEX
-
-#define IOP3XX_N_GPIOS	8
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	if (gpio > IOP3XX_N_GPIOS)
-		return __gpio_get_value(gpio);
-
-	return gpio_line_get(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	if (gpio > IOP3XX_N_GPIOS) {
-		__gpio_set_value(gpio, value);
-		return;
-	}
-	gpio_line_set(gpio, value);
-}
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	if (gpio < IOP3XX_N_GPIOS)
-		return 0;
-	else
-		return __gpio_cansleep(gpio);
-}
-
-/*
- * The GPIOs are not generating any interrupt
- * Note : manuals are not clear about this
- */
-static inline int gpio_to_irq(int gpio)
-{
-	return -EINVAL;
-}
-
-static inline int irq_to_gpio(int gpio)
-{
-	return -EINVAL;
-}
-
 #endif
 
diff --git a/arch/arm/include/asm/hardware/iop3xx.h b/arch/arm/include/asm/hardware/iop3xx.h
index 423744b..6af9c28 100644
--- a/arch/arm/include/asm/hardware/iop3xx.h
+++ b/arch/arm/include/asm/hardware/iop3xx.h
@@ -25,9 +25,6 @@
 #define IOP3XX_GPIO_LINE(x)	(x)
 
 #ifndef __ASSEMBLY__
-extern void gpio_line_config(int line, int direction);
-extern int  gpio_line_get(int line);
-extern void gpio_line_set(int line, int value);
 extern int init_atu;
 extern int iop3xx_get_init_atu(void);
 #endif
diff --git a/drivers/gpio/gpio-iop.c b/drivers/gpio/gpio-iop.c
index d4a170d..17cc701 100644
--- a/drivers/gpio/gpio-iop.c
+++ b/drivers/gpio/gpio-iop.c
@@ -19,7 +19,7 @@
 
 #define IOP3XX_N_GPIOS	8
 
-void gpio_line_config(int line, int direction)
+static void gpio_line_config(int line, int direction)
 {
 	unsigned long flags;
 
@@ -31,15 +31,13 @@ void gpio_line_config(int line, int direction)
 	}
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(gpio_line_config);
 
-int gpio_line_get(int line)
+static int gpio_line_get(int line)
 {
 	return !!(*IOP3XX_GPID & (1 << line));
 }
-EXPORT_SYMBOL(gpio_line_get);
 
-void gpio_line_set(int line, int value)
+static void gpio_line_set(int line, int value)
 {
 	unsigned long flags;
 
@@ -51,7 +49,6 @@ void gpio_line_set(int line, int value)
 	}
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL(gpio_line_set);
 
 static int iop3xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-- 
1.8.3.1
