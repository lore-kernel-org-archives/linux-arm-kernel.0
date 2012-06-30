From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Sat, 30 Jun 2012 14:08:59 +0200
Subject: [PATCH 07/10] ARM: S3C24XX: Remove unused GPIO definitions for port J
In-Reply-To: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
References: <1341058142-30438-1-git-send-email-sylvester.nawrocki@gmail.com>
Message-ID: <1341058142-30438-8-git-send-email-sylvester.nawrocki@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need now for individual GPIO port J pin control bit
definitions, the GPIO0..12 pins can be configured using the gpiolib
API. The GPJ* register address offset definitions for S3C2413 are
moved to the common mach-s3c24xx/include/mach/regs-gpio.h header.
These are still used outside of the gpio-samsung driver by PM code.

Switching GPJ port to camera function can be done for example with:
s3c_gpio_cfgall_range(S3C2410_GPJ(0), 13, S3C_GPIO_SFN(2), S3C_GPIO_PULL_NONE);

Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
---
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h  |   17 +++++-
 arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h |   70 -----------------------
 arch/arm/mach-s3c24xx/mach-gta02.c              |    1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c             |    1 -
 arch/arm/mach-s3c24xx/pm-s3c2412.c              |    1 -
 arch/arm/mach-s3c24xx/s3c2412.c                 |    1 -
 arch/arm/mach-s3c24xx/s3c244x.c                 |    1 -
 7 files changed, 15 insertions(+), 77 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h

diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
index cac1ad6..a11a638 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
@@ -302,7 +302,7 @@
 /* S3C2410:
  * Port G consists of 8 GPIO/IRQ/Special function
  *
- * GPGCON has 2 bits for each of the input pins on port F
+ * GPGCON has 2 bits for each of the input pins on port G
  *   00 = 0 input, 1 output, 2 interrupt (EINT0..7), 3 special func
  *
  * pull up works like all other ports.
@@ -366,7 +366,7 @@
 
 /* Port H consists of11 GPIO/serial/Misc pins
  *
- * GPGCON has 2 bits for each of the input pins on port F
+ * GPHCON has 2 bits for each of the input pins on port H
  *   00 = 0 input, 1 output, 2 interrupt (EINT0..7), 3 special func
  *
  * pull up works like all other ports.
@@ -427,6 +427,19 @@
  * for the 2412/2413 from the 2410/2440/2442
 */
 
+/*
+ * Port J consists of 13 GPIO/Camera pins. GPJCON has 2 bits
+ * for each of the pins on port J.
+ *   00 - input, 01 output, 10 - camera
+ *
+ * Pull up works like all other ports.
+ */
+
+#define S3C2413_GPJCON	   S3C2410_GPIOREG(0x80)
+#define S3C2413_GPJDAT	   S3C2410_GPIOREG(0x84)
+#define S3C2413_GPJUP	   S3C2410_GPIOREG(0x88)
+#define S3C2413_GPJSLPCON  S3C2410_GPIOREG(0x8C)
+
 /* S3C2443 and above */
 #define S3C2440_GPJCON	   S3C2410_GPIOREG(0xD0)
 #define S3C2440_GPJDAT	   S3C2410_GPIOREG(0xD4)
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h b/arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h
deleted file mode 100644
index 19575e0..0000000
--- a/arch/arm/mach-s3c24xx/include/mach/regs-gpioj.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-gpioj.h
- *
- * Copyright (c) 2004 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2440 GPIO J register definitions
-*/
-
-
-#ifndef __ASM_ARCH_REGS_GPIOJ_H
-#define __ASM_ARCH_REGS_GPIOJ_H "gpioj"
-
-/* Port J consists of 13 GPIO/Camera pins
- *
- * GPJCON has 2 bits for each of the input pins on port F
- *   00 = 0 input, 1 output, 2 Camera
- *
- * pull up works like all other ports.
-*/
-
-#define S3C2413_GPJCON		S3C2410_GPIOREG(0x80)
-#define S3C2413_GPJDAT		S3C2410_GPIOREG(0x84)
-#define S3C2413_GPJUP		S3C2410_GPIOREG(0x88)
-#define S3C2413_GPJSLPCON	S3C2410_GPIOREG(0x8C)
-
-#define S3C2440_GPJ0_OUTP       (0x01 << 0)
-#define S3C2440_GPJ0_CAMDATA0   (0x02 << 0)
-
-#define S3C2440_GPJ1_OUTP       (0x01 << 2)
-#define S3C2440_GPJ1_CAMDATA1   (0x02 << 2)
-
-#define S3C2440_GPJ2_OUTP       (0x01 << 4)
-#define S3C2440_GPJ2_CAMDATA2   (0x02 << 4)
-
-#define S3C2440_GPJ3_OUTP       (0x01 << 6)
-#define S3C2440_GPJ3_CAMDATA3   (0x02 << 6)
-
-#define S3C2440_GPJ4_OUTP       (0x01 << 8)
-#define S3C2440_GPJ4_CAMDATA4   (0x02 << 8)
-
-#define S3C2440_GPJ5_OUTP       (0x01 << 10)
-#define S3C2440_GPJ5_CAMDATA5   (0x02 << 10)
-
-#define S3C2440_GPJ6_OUTP       (0x01 << 12)
-#define S3C2440_GPJ6_CAMDATA6   (0x02 << 12)
-
-#define S3C2440_GPJ7_OUTP       (0x01 << 14)
-#define S3C2440_GPJ7_CAMDATA7   (0x02 << 14)
-
-#define S3C2440_GPJ8_OUTP       (0x01 << 16)
-#define S3C2440_GPJ8_CAMPCLK    (0x02 << 16)
-
-#define S3C2440_GPJ9_OUTP       (0x01 << 18)
-#define S3C2440_GPJ9_CAMVSYNC   (0x02 << 18)
-
-#define S3C2440_GPJ10_OUTP      (0x01 << 20)
-#define S3C2440_GPJ10_CAMHREF   (0x02 << 20)
-
-#define S3C2440_GPJ11_OUTP      (0x01 << 22)
-#define S3C2440_GPJ11_CAMCLKOUT (0x02 << 22)
-
-#define S3C2440_GPJ12_OUTP      (0x01 << 24)
-#define S3C2440_GPJ12_CAMRESET  (0x02 << 24)
-
-#endif	/* __ASM_ARCH_REGS_GPIOJ_H */
-
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 0f29f64..92e1f93 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -71,7 +71,6 @@
 
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-gpioj.h>
 #include <mach/fb.h>
 
 #include <plat/usb-control.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index a6762aa..7ee73f2 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -42,7 +42,6 @@
 #include <asm/mach-types.h>
 
 #include <mach/regs-gpio.h>
-#include <mach/regs-gpioj.h>
 #include <mach/regs-lcd.h>
 #include <mach/h1940.h>
 #include <mach/fb.h>
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index d045885..c60f67a 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -26,7 +26,6 @@
 #include <asm/irq.h>
 
 #include <mach/regs-power.h>
-#include <mach/regs-gpioj.h>
 #include <mach/regs-gpio.h>
 #include <mach/regs-dsc.h>
 
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index d4bc7f9..6c5f403 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -39,7 +39,6 @@
 #include <plat/regs-serial.h>
 #include <mach/regs-power.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-gpioj.h>
 #include <mach/regs-dsc.h>
 #include <plat/regs-spi.h>
 #include <mach/regs-s3c2412.h>
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index 6f74118..b0b60a1 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -36,7 +36,6 @@
 #include <mach/regs-clock.h>
 #include <plat/regs-serial.h>
 #include <mach/regs-gpio.h>
-#include <mach/regs-gpioj.h>
 #include <mach/regs-dsc.h>
 
 #include <plat/s3c2410.h>
-- 
1.7.4.1
