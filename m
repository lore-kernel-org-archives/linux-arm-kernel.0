From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 5 Nov 2009 05:37:26 -0500
Subject: [PATCH] [ARM] pxa: extend gpio pins from 128 to 256
Message-ID: <mailman.108.1257389946.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO pins exceeds 128 pins on PXA935. Extend IRQ GPIO to support it.
Add new macro mfp256_to_gpio() and PXA935_NR_BUILTIN_GPIO.

Original mfp_to_gpio() and NR_BUILTIN_GPIO isn't changed.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/gpio.h |    3 ++-
 arch/arm/mach-pxa/include/mach/irqs.h |    2 +-
 arch/arm/mach-pxa/pxa3xx.c            |    2 +-
 arch/arm/plat-pxa/include/plat/mfp.h  |    3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gpio.h
b/arch/arm/mach-pxa/include/mach/gpio.h
index b024a8b..d08227d 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -99,7 +99,8 @@
 #define GAFR(x)		GPIO_REG(0x54 + (((x) & 0x70) >> 2))


-#define NR_BUILTIN_GPIO 128
+#define NR_BUILTIN_GPIO		128
+#define PXA935_NR_BUILTIN_GPIO	256

 #define gpio_to_bank(gpio)	((gpio) >> 5)
 #define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index 3677a9a..9565b0f 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -106,7 +106,7 @@
 #endif

 #define PXA_GPIO_IRQ_BASE	PXA_IRQ(96)
-#define PXA_GPIO_IRQ_NUM	(192)
+#define PXA_GPIO_IRQ_NUM	(256)

 #define GPIO_2_x_TO_IRQ(x)	(PXA_GPIO_IRQ_BASE + (x))
 #define IRQ_GPIO(x)	(((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 09b7b1a..7783ac9 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -539,7 +539,7 @@ void __init pxa3xx_init_irq(void)
 	__asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));

 	pxa_init_irq(56, pxa3xx_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
+	pxa_init_gpio(IRQ_GPIO_2_x, 2, 255, NULL);
 }

 /*
diff --git a/arch/arm/plat-pxa/include/plat/mfp.h
b/arch/arm/plat-pxa/include/plat/mfp.h
index 22086e6..66a0295 100644
--- a/arch/arm/plat-pxa/include/plat/mfp.h
+++ b/arch/arm/plat-pxa/include/plat/mfp.h
@@ -16,7 +16,8 @@
 #ifndef __ASM_PLAT_MFP_H
 #define __ASM_PLAT_MFP_H

-#define mfp_to_gpio(m)	((m) % 128)
+#define mfp_to_gpio(m)		((m) % 128)
+#define mfp256_to_gpio(m)	((m) % 256)	/* GPIO is more than 128 */

 /* list of all the configurable MFP pins */
 enum {
-- 
1.5.6.5
