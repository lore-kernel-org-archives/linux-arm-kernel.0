From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Sep 2013 14:24:38 +0200
Subject: [PATCH v2] ARM: sa1100: remove complex GPIO interface
Message-ID: <1380025478-24831-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SA1100 was implementing its own variants of gpio_get_value()
and gpio_set_value() and only selectively falling back to
gpiolib for extended (EGPIO) handling. However the driver in
gpio/gpio-sa1100.c already handles the same functionality for
these lines, yet remain unused.

The only upside would be things like a timing-critical hotpath
on bit-banged GPIO, but that kind of things does not seem to
happen on these GPIOs, so it is not worth having the extra
complexity.

Tested with some buttons on the Compaq iPAQ H3630.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- #include <linux/io.h> instead of <asm/io.h>.
---
 arch/arm/Kconfig                          |  1 -
 arch/arm/mach-sa1100/include/mach/gpio.h  | 55 -------------------------------
 arch/arm/mach-sa1100/include/mach/h3xxx.h |  2 ++
 drivers/gpio/gpio-sa1100.c                |  2 +-
 4 files changed, 3 insertions(+), 57 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3f7714d..74bf29f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -692,7 +692,6 @@ config ARCH_SA1100
 	select GENERIC_CLOCKEVENTS
 	select HAVE_IDE
 	select ISA
-	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
 	select SPARSE_IRQ
 	help
diff --git a/arch/arm/mach-sa1100/include/mach/gpio.h b/arch/arm/mach-sa1100/include/mach/gpio.h
deleted file mode 100644
index 6a9eecf..0000000
--- a/arch/arm/mach-sa1100/include/mach/gpio.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/gpio.h
- *
- * SA1100 GPIO wrappers for arch-neutral GPIO calls
- *
- * Written by Philipp Zabel <philipp.zabel@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-
-#ifndef __ASM_ARCH_SA1100_GPIO_H
-#define __ASM_ARCH_SA1100_GPIO_H
-
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <asm/irq.h>
-#include <asm-generic/gpio.h>
-
-#define __ARM_GPIOLIB_COMPLEX
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	if (__builtin_constant_p(gpio) && (gpio <= GPIO_MAX))
-		return GPLR & GPIO_GPIO(gpio);
-	else
-		return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	if (__builtin_constant_p(gpio) && (gpio <= GPIO_MAX))
-		if (value)
-			GPSR = GPIO_GPIO(gpio);
-		else
-			GPCR = GPIO_GPIO(gpio);
-	else
-		__gpio_set_value(gpio, value);
-}
-
-#define gpio_cansleep	__gpio_cansleep
-
-#endif
diff --git a/arch/arm/mach-sa1100/include/mach/h3xxx.h b/arch/arm/mach-sa1100/include/mach/h3xxx.h
index 7d9df16..c810620 100644
--- a/arch/arm/mach-sa1100/include/mach/h3xxx.h
+++ b/arch/arm/mach-sa1100/include/mach/h3xxx.h
@@ -13,6 +13,8 @@
 #ifndef _INCLUDE_H3XXX_H_
 #define _INCLUDE_H3XXX_H_
 
+#include "hardware.h" /* Gives GPIO_MAX */
+
 /* Physical memory regions corresponding to chip selects */
 #define H3600_EGPIO_PHYS	(SA1100_CS5_PHYS + 0x01000000)
 #define H3600_BANK_2_PHYS	SA1100_CS2_PHYS
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 8ea3b33..a90be34 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -10,7 +10,7 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/module.h>
-
+#include <linux/io.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
-- 
1.8.3.1
