From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 08:18:57 +0200
Subject: [PATCH 06/15] ARM: S5PC100: Move gpio support from plat-s5pc1xx to
	mach-s5pc100
In-Reply-To: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1273817946-29404-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move gpio-lib support from plat-s5pc1xx to mach-s5pc100. Only basic gpio
functionality is now supported. Gpio interrupts are disabled temporarly
and will be added later.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Makefile                     |    2 +-
 .../gpiolib.c => mach-s5pc100/gpio.c}              |   11 +++++++----
 .../plat => mach-s5pc100/include/mach}/regs-gpio.h |    0
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    1 -
 arch/arm/plat-s5pc1xx/Makefile                     |    3 +--
 5 files changed, 9 insertions(+), 8 deletions(-)
 rename arch/arm/{plat-s5pc1xx/gpiolib.c => mach-s5pc100/gpio.c} (99%)
 rename arch/arm/{plat-s5pc1xx/include/plat => mach-s5pc100/include/mach}/regs-gpio.h (100%)

diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 809ff10..e1afdbf 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -11,7 +11,7 @@ obj-				:=
 
 # Core support for S5PC100 system
 
-obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
+obj-$(CONFIG_CPU_S5PC100)	+= cpu.o gpio.o
 
 # Helper and device support
 
diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/mach-s5pc100/gpio.c
similarity index 99%
rename from arch/arm/plat-s5pc1xx/gpiolib.c
rename to arch/arm/mach-s5pc100/gpio.c
index 5a97a8f..c8e8336 100644
--- a/arch/arm/plat-s5pc1xx/gpiolib.c
+++ b/arch/arm/mach-s5pc100/gpio.c
@@ -17,11 +17,11 @@
 #include <linux/gpio.h>
 
 #include <mach/map.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/regs-gpio.h>
 
 /* S5PC100 GPIO bank summary:
  *
@@ -61,6 +61,7 @@
  * L3	8	4Bit	None
  */
 
+#if 0
 static int s5pc1xx_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	return S3C_IRQ_GPIO(chip->base + offset);
@@ -84,7 +85,7 @@ static int s5pc1xx_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
 		return IRQ_EINT(24 + offset);
 	return -EINVAL;
 }
-
+#endif
 static struct s3c_gpio_cfg gpio_cfg = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
@@ -386,7 +387,7 @@ extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 
 static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 {
-
+#if 0
 	/* Interrupt */
 	if (chip->config == &gpio_cfg) {
 		int i, irq;
@@ -402,6 +403,7 @@ static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 		}
 	} else if (chip->config == &gpio_cfg_eint)
 		chip->chip.to_irq = s5pc1xx_gpiolib_to_eint;
+#endif
 }
 
 static __init int s5pc1xx_gpiolib_init(void)
@@ -417,9 +419,10 @@ static __init int s5pc1xx_gpiolib_init(void)
 
 	samsung_gpiolib_add_4bit_chips(s5pc100_gpio_chips,
 				       ARRAY_SIZE(s5pc100_gpio_chips));
+#if 0
 	/* Interrupt */
 	set_irq_chained_handler(IRQ_GPIOINT, s5pc1xx_irq_gpioint_handler);
-
+#endif
 	return 0;
 }
 core_initcall(s5pc1xx_gpiolib_init);
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
similarity index 100%
rename from arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
rename to arch/arm/mach-s5pc100/include/mach/regs-gpio.h
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index ae3c52c..bfe67db 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -35,7 +35,6 @@
 
 #include <plat/regs-serial.h>
 #include <plat/gpio-cfg.h>
-#include <plat/regs-gpio.h>
 
 #include <plat/clock.h>
 #include <plat/devs.h>
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index 66a8f3e..540fca5 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -13,9 +13,8 @@ obj-				:=
 
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
-obj-y				+= irq.o irq-gpio.o irq-eint.o
+obj-y				+= irq.o
 obj-y				+= clock.o
-obj-y				+= gpiolib.o
 
 # CPU support
 
-- 
1.6.4
