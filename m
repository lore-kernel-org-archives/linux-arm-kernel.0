From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 1 Mar 2010 15:04:26 +0530
Subject: [PATCH 1/5] nomadik: move gpio to plat-nomadik
In-Reply-To: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
References: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1267436070-10631-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the Nomadik GPIO driver to plat-nomadik so that it can also be used
on the Ux500 platform.

The mach-nomadik include/mach/gpio.h is replaced by one that includes
the one now in plat-nomadik, so that code doesn't need to include the
one in plat specifically, and can instead use <linux/gpio.h> as usual.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-nomadik/Kconfig                      |    1 +
 arch/arm/mach-nomadik/Makefile                     |    2 +-
 arch/arm/mach-nomadik/include/mach/gpio.h          |   67 +-------------------
 arch/arm/plat-nomadik/Kconfig                      |    5 ++
 arch/arm/plat-nomadik/Makefile                     |    1 +
 arch/arm/{mach-nomadik => plat-nomadik}/gpio.c     |    0
 .../mach => plat-nomadik/include/plat}/gpio.h      |    6 +-
 7 files changed, 12 insertions(+), 70 deletions(-)
 rename arch/arm/{mach-nomadik => plat-nomadik}/gpio.c (100%)
 copy arch/arm/{mach-nomadik/include/mach => plat-nomadik/include/plat}/gpio.h (95%)

diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 3c5e0f5..71f3ea6 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -6,6 +6,7 @@ config MACH_NOMADIK_8815NHK
 	bool "ST 8815 Nomadik Hardware Kit (evaluation board)"
 	select NOMADIK_8815
 	select HAS_MTU
+	select NOMADIK_GPIO
 
 endmenu
 
diff --git a/arch/arm/mach-nomadik/Makefile b/arch/arm/mach-nomadik/Makefile
index 36f67fb..a6bbd1a 100644
--- a/arch/arm/mach-nomadik/Makefile
+++ b/arch/arm/mach-nomadik/Makefile
@@ -7,7 +7,7 @@
 
 # Object file lists.
 
-obj-y			+= clock.o gpio.o
+obj-y			+= clock.o
 
 # Cpu revision
 obj-$(CONFIG_NOMADIK_8815) += cpu-8815.o
diff --git a/arch/arm/mach-nomadik/include/mach/gpio.h b/arch/arm/mach-nomadik/include/mach/gpio.h
index 61577c9..7a81a04 100644
--- a/arch/arm/mach-nomadik/include/mach/gpio.h
+++ b/arch/arm/mach-nomadik/include/mach/gpio.h
@@ -1,71 +1,6 @@
-/*
- * Structures and registers for GPIO access in the Nomadik SoC
- *
- * Copyright (C) 2008 STMicroelectronics
- *     Author: Prafulla WADASKAR <prafulla.wadaskar@st.com>
- * Copyright (C) 2009 Alessandro Rubini <rubini@unipv.it>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H
 
-#include <asm-generic/gpio.h>
-
-/*
- * These currently cause a function call to happen, they may be optimized
- * if needed by adding cpu-specific defines to identify blocks
- * (see mach-pxa/include/mach/gpio.h as an example using GPLR etc)
- */
-#define gpio_get_value  __gpio_get_value
-#define gpio_set_value  __gpio_set_value
-#define gpio_cansleep   __gpio_cansleep
-#define gpio_to_irq     __gpio_to_irq
-
-/*
- * "nmk_gpio" and "NMK_GPIO" stand for "Nomadik GPIO", leaving
- * the "gpio" namespace for generic and cross-machine functions
- */
-
-/* Register in the logic block */
-#define NMK_GPIO_DAT	0x00
-#define NMK_GPIO_DATS	0x04
-#define NMK_GPIO_DATC	0x08
-#define NMK_GPIO_PDIS	0x0c
-#define NMK_GPIO_DIR	0x10
-#define NMK_GPIO_DIRS	0x14
-#define NMK_GPIO_DIRC	0x18
-#define NMK_GPIO_SLPC	0x1c
-#define NMK_GPIO_AFSLA	0x20
-#define NMK_GPIO_AFSLB	0x24
-
-#define NMK_GPIO_RIMSC	0x40
-#define NMK_GPIO_FIMSC	0x44
-#define NMK_GPIO_IS	0x48
-#define NMK_GPIO_IC	0x4c
-#define NMK_GPIO_RWIMSC	0x50
-#define NMK_GPIO_FWIMSC	0x54
-#define NMK_GPIO_WKS	0x58
-
-/* Alternate functions: function C is set in hw by setting both A and B */
-#define NMK_GPIO_ALT_GPIO	0
-#define NMK_GPIO_ALT_A	1
-#define NMK_GPIO_ALT_B	2
-#define NMK_GPIO_ALT_C	(NMK_GPIO_ALT_A | NMK_GPIO_ALT_B)
-
-extern int nmk_gpio_set_mode(int gpio, int gpio_mode);
-extern int nmk_gpio_get_mode(int gpio);
-
-/*
- * Platform data to register a block: only the initial gpio/irq number.
- */
-struct nmk_gpio_platform_data {
-	char *name;
-	int first_gpio;
-	int first_irq;
-	int parent_irq;
-};
+#include <plat/gpio.h>
 
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
index 159daf5..5da3f97 100644
--- a/arch/arm/plat-nomadik/Kconfig
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -19,4 +19,9 @@ config HAS_MTU
 	  to multiple interrupt generating programmable
 	  32-bit free running decrementing counters.
 
+config NOMADIK_GPIO
+	bool
+	help
+	  Support for the Nomadik GPIO controller.
+
 endif
diff --git a/arch/arm/plat-nomadik/Makefile b/arch/arm/plat-nomadik/Makefile
index 37c7cdd..c335473 100644
--- a/arch/arm/plat-nomadik/Makefile
+++ b/arch/arm/plat-nomadik/Makefile
@@ -3,3 +3,4 @@
 # Licensed under GPLv2
 
 obj-$(CONFIG_HAS_MTU)	+= timer.o
+obj-$(CONFIG_NOMADIK_GPIO)	+= gpio.o
diff --git a/arch/arm/mach-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
similarity index 100%
rename from arch/arm/mach-nomadik/gpio.c
rename to arch/arm/plat-nomadik/gpio.c
diff --git a/arch/arm/mach-nomadik/include/mach/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
similarity index 95%
copy from arch/arm/mach-nomadik/include/mach/gpio.h
copy to arch/arm/plat-nomadik/include/plat/gpio.h
index 61577c9..1d665a0 100644
--- a/arch/arm/mach-nomadik/include/mach/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -9,8 +9,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __ASM_ARCH_GPIO_H
-#define __ASM_ARCH_GPIO_H
+#ifndef __ASM_PLAT_GPIO_H
+#define __ASM_PLAT_GPIO_H
 
 #include <asm-generic/gpio.h>
 
@@ -68,4 +68,4 @@ struct nmk_gpio_platform_data {
 	int parent_irq;
 };
 
-#endif /* __ASM_ARCH_GPIO_H */
+#endif /* __ASM_PLAT_GPIO_H */
-- 
1.7.0
