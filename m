From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 14:28:11 -0400
Subject: [PATCH] pxa: extend gpio pins from 128 to 256
Message-ID: <mailman.15.1253875196.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO pins exceeds 128 pins. So extend the maximum GPIO pins to 256.
And extend MFP pins also.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/gpio.h |    2 +-
 arch/arm/mach-pxa/include/mach/irqs.h |    2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c        |    6 +++---
 arch/arm/mach-pxa/pxa3xx.c            |    2 +-
 arch/arm/plat-pxa/include/plat/mfp.h  |    2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gpio.h
b/arch/arm/mach-pxa/include/mach/gpio.h
index b024a8b..0cd683c 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -99,7 +99,7 @@
 #define GAFR(x)        GPIO_REG(0x54 + (((x) & 0x70) >> 2))


-#define NR_BUILTIN_GPIO 128
+#define NR_BUILTIN_GPIO 256

 #define gpio_to_bank(gpio)    ((gpio) >> 5)
 #define gpio_to_irq(gpio)    IRQ_GPIO(gpio)
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index 3677a9a..9565b0f 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -106,7 +106,7 @@
 #endif

 #define PXA_GPIO_IRQ_BASE    PXA_IRQ(96)
-#define PXA_GPIO_IRQ_NUM    (192)
+#define PXA_GPIO_IRQ_NUM    (256)

 #define GPIO_2_x_TO_IRQ(x)    (PXA_GPIO_IRQ_BASE + (x))
 #define IRQ_GPIO(x)    (((x) < 2) ? (IRQ_GPIO0 + (x)) : GPIO_2_x_TO_IRQ(x))
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index cf6b720..767db92 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -41,7 +41,7 @@ struct gpio_desc {
     unsigned long    config;
 };

-static struct gpio_desc gpio_desc[MFP_PIN_GPIO127 + 1];
+static struct gpio_desc gpio_desc[MFP_PIN_GPIO255 + 1];

 static unsigned long gpdr_lpm[4];

@@ -117,7 +117,7 @@ static inline int __mfp_validate(int mfp)
 {
     int gpio = mfp_to_gpio(mfp);

-    if ((mfp > MFP_PIN_GPIO127) || !gpio_desc[gpio].valid) {
+    if ((mfp > MFP_PIN_GPIO255) || !gpio_desc[gpio].valid) {
         pr_warning("%s: GPIO%d is invalid pin\n", __func__, gpio);
         return -1;
     }
@@ -169,7 +169,7 @@ int gpio_set_wake(unsigned int gpio, unsigned int on)
     struct gpio_desc *d;
     unsigned long c, mux_taken;

-    if (gpio > mfp_to_gpio(MFP_PIN_GPIO127))
+    if (gpio > mfp_to_gpio(MFP_PIN_GPIO255))
         return -EINVAL;

     d = &gpio_desc[gpio];
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 09b7b1a..7783ac9 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -539,7 +539,7 @@ void __init pxa3xx_init_irq(void)
     __asm__ __volatile__("mcr p15, 0, %0, c15, c1, 0\n": :"r"(value));

     pxa_init_irq(56, pxa3xx_set_wake);
-    pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
+    pxa_init_gpio(IRQ_GPIO_2_x, 2, 255, NULL);
 }

 /*
diff --git a/arch/arm/plat-pxa/include/plat/mfp.h
b/arch/arm/plat-pxa/include/plat/mfp.h
index 22086e6..857a683 100644
--- a/arch/arm/plat-pxa/include/plat/mfp.h
+++ b/arch/arm/plat-pxa/include/plat/mfp.h
@@ -16,7 +16,7 @@
 #ifndef __ASM_PLAT_MFP_H
 #define __ASM_PLAT_MFP_H

-#define mfp_to_gpio(m)    ((m) % 128)
+#define mfp_to_gpio(m)    ((m) % 256)

 /* list of all the configurable MFP pins */
 enum {
-- 
1.5.6.5

--0016e646114219b34d0474649139
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
