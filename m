From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 11 Oct 2011 21:17:30 +0800
Subject: [PATCH v3 6/7] ARM: pxa: move gpio-pxa.h into include directory
In-Reply-To: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318339051-19096-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge the gpio-pxa.h in arch-pxa and arch-mmp. Move the new gpio-pxa.h
into include directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio-pxa.h  |   12 ----
 arch/arm/mach-mmp/include/mach/gpio.h      |    3 +-
 arch/arm/mach-mmp/mmp2.c                   |    3 +-
 arch/arm/mach-mmp/pxa168.c                 |    3 +-
 arch/arm/mach-mmp/pxa910.c                 |    3 +-
 arch/arm/mach-pxa/include/mach/gpio-pxa.h  |   61 ---------------------
 arch/arm/mach-pxa/include/mach/gpio.h      |    2 -
 arch/arm/mach-pxa/include/mach/littleton.h |    2 -
 arch/arm/mach-pxa/irq.c                    |    3 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c             |    2 +-
 arch/arm/mach-pxa/pxa25x.c                 |    2 +-
 arch/arm/mach-pxa/pxa27x.c                 |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                 |    4 +-
 arch/arm/mach-pxa/pxa95x.c                 |    2 +-
 arch/arm/plat-pxa/include/plat/gpio-pxa.h  |   80 ---------------------------
 drivers/gpio/gpio-pxa.c                    |   42 ++++++++++++++-
 include/linux/gpio-pxa.h                   |   81 ++++++++++++++++++++++++++++
 17 files changed, 135 insertions(+), 172 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio-pxa.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/gpio-pxa.h
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio-pxa.h
 create mode 100644 include/linux/gpio-pxa.h

diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
deleted file mode 100644
index f8448b5..0000000
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef __ASM_MACH_GPIO_PXA_H
-#define __ASM_MACH_GPIO_PXA_H
-
-#include <mach/addr-map.h>
-#include <mach/cputype.h>
-#include <mach/irqs.h>
-
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
-
-#include <plat/gpio-pxa.h>
-
-#endif /* __ASM_MACH_GPIO_PXA_H */
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 904466d..13219eb 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -3,7 +3,6 @@
 
 #include <asm-generic/gpio.h>
 
-#define __gpio_is_inverted(gpio)	(0)
-#define __gpio_is_occupied(gpio)	(0)
+#include <mach/cputype.h>
 
 #endif /* __ASM_MACH_GPIO_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 01e5c73..1291364 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
@@ -25,13 +26,13 @@
 #include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
-#include <mach/gpio-pxa.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
 
 #include "common.h"
 #include "clock.h"
 
+#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
 #define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x9c)
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index f0da013..61395c6 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
@@ -21,7 +22,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
 #include <mach/irqs.h>
-#include <mach/gpio-pxa.h>
 #include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
@@ -29,6 +29,7 @@
 #include "common.h"
 #include "clock.h"
 
+#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
 static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 4654e62..0b0e3db 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
@@ -20,7 +21,6 @@
 #include <mach/regs-apmu.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/gpio-pxa.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
@@ -28,6 +28,7 @@
 #include "common.h"
 #include "clock.h"
 
+#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
 static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
diff --git a/arch/arm/mach-pxa/include/mach/gpio-pxa.h b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
deleted file mode 100644
index 29dfcde..0000000
--- a/arch/arm/mach-pxa/include/mach/gpio-pxa.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
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
-#ifndef __MACH_PXA_GPIO_PXA_H
-#define __MACH_PXA_GPIO_PXA_H
-
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-
-#include <plat/gpio-pxa.h>
-
-#define GPIO_REGS_VIRT	io_p2v(0x40E00000)
-
-#ifdef CONFIG_CPU_PXA26x
-/* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
- * as well as their Alternate Function value being '1' for GPIO in GAFRx.
- */
-static inline int __gpio_is_inverted(unsigned gpio)
-{
-	return cpu_is_pxa25x() && gpio > 85;
-}
-#else
-static inline int __gpio_is_inverted(unsigned gpio) { return 0; }
-#endif
-
-/*
- * On PXA25x and PXA27x, GAFRx and GPDRx together decide the alternate
- * function of a GPIO, and GPDRx cannot be altered once configured. It
- * is attributed as "occupied" here (I know this terminology isn't
- * accurate, you are welcome to propose a better one :-)
- */
-static inline int __gpio_is_occupied(unsigned gpio)
-{
-	if (cpu_is_pxa27x() || cpu_is_pxa25x()) {
-		int af = (PXA_GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
-		int dir = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
-
-		if (__gpio_is_inverted(gpio))
-			return af != 1 || dir == 0;
-		else
-			return af != 0 || dir != 0;
-	} else
-		return PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
-}
-
-#endif /* __MACH_PXA_GPIO_PXA_H */
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 561cdbf..ef8b51f 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -25,7 +25,5 @@
 #define __ASM_ARCH_PXA_GPIO_H
 
 #include <asm-generic/gpio.h>
-/* The defines for the driver are needed for the accelerated accessors */
-#include "gpio-pxa.h"
 
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/littleton.h b/arch/arm/mach-pxa/include/mach/littleton.h
index e20ac1b..8066be5 100644
--- a/arch/arm/mach-pxa/include/mach/littleton.h
+++ b/arch/arm/mach-pxa/include/mach/littleton.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARCH_LITTLETON_H
 #define __ASM_ARCH_LITTLETON_H
 
-#include <mach/gpio-pxa.h>
-
 #define LITTLETON_ETH_PHYS	0x30000000
 
 #define LITTLETON_GPIO_LCD_CS	(17)
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 2d87e64..26ad6cd 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -20,7 +20,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio-pxa.h>
 
 #include "generic.h"
 
@@ -120,7 +119,7 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-void __init pxa_init_irq(int irq_nr, set_wake_t fn)
+void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
 {
 	int irq, i, n;
 
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index af302b4..290af99 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -13,6 +13,7 @@
  *  published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,7 +21,6 @@
 
 #include <mach/pxa2xx-regs.h>
 #include <mach/mfp-pxa2xx.h>
-#include <mach/gpio-pxa.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 10a4fb3..b3641cc 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -17,6 +17,7 @@
  * need be.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -24,7 +25,6 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index a200bae..06fb464 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -21,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index e5c3688..4446d56 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -25,7 +25,6 @@
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
 #include <mach/hardware.h>
-#include <mach/gpio-pxa.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/reset.h>
 #include <mach/ohci.h>
@@ -365,7 +364,8 @@ static struct irq_chip pxa_ext_wakeup_chip = {
 	.irq_set_type	= pxa_set_ext_wakeup_type,
 };
 
-static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
+static void __init pxa_init_ext_wakeup_irq(int (*fn)(struct irq_data *,
+					   unsigned int))
 {
 	int irq;
 
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 5af6a44..dcff331 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -9,6 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,7 +21,6 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
-#include <mach/gpio-pxa.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/pxa930.h>
 #include <mach/reset.h>
diff --git a/arch/arm/plat-pxa/include/plat/gpio-pxa.h b/arch/arm/plat-pxa/include/plat/gpio-pxa.h
deleted file mode 100644
index b74b921..0000000
--- a/arch/arm/plat-pxa/include/plat/gpio-pxa.h
+++ /dev/null
@@ -1,80 +0,0 @@
-#ifndef __PLAT_PXA_GPIO_H
-#define __PLAT_PXA_GPIO_H
-
-struct irq_data;
-
-struct pxa_gpio_regs {
-	u32	gplr;
-	u32	gpdr;
-	u32	gpsr;
-	u32	gpcr;
-	u32	grer;
-	u32	gfer;
-	u32	gedr;
-	u32	gafr;
-};
-
-/*
- * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
- * one set of registers. The register offsets are organized below:
- *
- *           GPLR    GPDR    GPSR    GPCR    GRER    GFER    GEDR
- * BANK 0 - 0x0000  0x000C  0x0018  0x0024  0x0030  0x003C  0x0048
- * BANK 1 - 0x0004  0x0010  0x001C  0x0028  0x0034  0x0040  0x004C
- * BANK 2 - 0x0008  0x0014  0x0020  0x002C  0x0038  0x0044  0x0050
- *
- * BANK 3 - 0x0100  0x010C  0x0118  0x0124  0x0130  0x013C  0x0148
- * BANK 4 - 0x0104  0x0110  0x011C  0x0128  0x0134  0x0140  0x014C
- * BANK 5 - 0x0108  0x0114  0x0120  0x012C  0x0138  0x0144  0x0150
- *
- * NOTE:
- *   BANK 3 is only available on PXA27x and later processors.
- *   BANK 4 and 5 are only available on PXA935
- */
-
-#define PXA_BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-
-#define PXA_GPIO_BANK(n)	(pxa_gpio_regs.gplr + PXA_BANK_OFF(n))
-#define PXA_GPIO_bit(x)		(1 << ((x) & 0x1f))
-#define pxa_gpio_to_bank(gpio)	((gpio) >> 5)
-
-
-/* GPIO Pin Level Registers */
-#define PXA_GPLR(x)	(*(volatile u32 *)(pxa_gpio_regs.gplr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Pin Direction Registers */
-#define PXA_GPDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpdr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Pin Output Set Registers */
-#define PXA_GPSR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpsr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Pin Output Clear Registers */
-#define PXA_GPCR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpcr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Rising Edge Detect Registers */
-#define PXA_GRER(x)	(*(volatile u32 *)(pxa_gpio_regs.grer	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Falling Edge Detect Registers */
-#define PXA_GFER(x)	(*(volatile u32 *)(pxa_gpio_regs.gfer	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Edge Detect Status Registers */
-#define PXA_GEDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gedr	\
-			+ PXA_BANK_OFF((x >> 5))))
-/* GPIO Alternate Function Select Registers */
-#define PXA_GAFR(x)	(*(volatile u32 *)(pxa_gpio_regs.gafr	\
-			+ (((x) & 0x70) >> 2)))
-
-extern struct pxa_gpio_regs pxa_gpio_regs;
-
-/* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
- * Those cases currently cause holes in the GPIO number space, the
- * actual number of the last GPIO is recorded by 'pxa_last_gpio'.
- */
-extern int pxa_last_gpio;
-
-typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
-
-extern void pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn);
-extern int pxa_irq_to_gpio(int irq);
-
-#endif /* __PLAT_PXA_GPIO_H */
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 6731779..92b92e8 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -12,6 +12,7 @@
  *  published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
@@ -19,8 +20,6 @@
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
-#include <mach/gpio-pxa.h>
-
 #define GPLR_OFFSET	0x00
 #define GPDR_OFFSET	0x0C
 #define GPSR_OFFSET	0x18
@@ -91,6 +90,45 @@ static inline int gpio_is_mmp_type(int type)
 	return 0;
 }
 
+/* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
+ * as well as their Alternate Function value being '1' for GPIO in GAFRx.
+ */
+static inline int __gpio_is_inverted(int gpio)
+{
+	if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
+		return 1;
+	return 0;
+}
+
+/*
+ * On PXA25x and PXA27x, GAFRx and GPDRx together decide the alternate
+ * function of a GPIO, and GPDRx cannot be altered once configured. It
+ * is attributed as "occupied" here (I know this terminology isn't
+ * accurate, you are welcome to propose a better one :-)
+ */
+static inline int __gpio_is_occupied(unsigned gpio)
+{
+	int ret, af = 0, dir = 0;
+
+	switch (gpio_type) {
+	case PXA25X_GPIO:
+	case PXA26X_GPIO:
+	case PXA27X_GPIO:
+		af = (PXA_GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
+		dir = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
+
+		if (__gpio_is_inverted(gpio))
+			ret = (af != 1) || (dir == 0);
+		else
+			ret = (af != 0) || (dir != 0);
+		break;
+	default:
+		ret = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
+		break;
+	}
+	return ret;
+}
+
 static int pxa_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	int gpio;
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
new file mode 100644
index 0000000..6cebf6c
--- /dev/null
+++ b/include/linux/gpio-pxa.h
@@ -0,0 +1,81 @@
+#ifndef __GPIO_PXA_H
+#define __GPIO_PXA_H
+
+#include <linux/kernel.h>
+
+struct irq_data;
+
+struct pxa_gpio_regs {
+	u32	gplr;
+	u32	gpdr;
+	u32	gpsr;
+	u32	gpcr;
+	u32	grer;
+	u32	gfer;
+	u32	gedr;
+	u32	gafr;
+};
+
+/*
+ * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
+ * one set of registers. The register offsets are organized below:
+ *
+ *           GPLR    GPDR    GPSR    GPCR    GRER    GFER    GEDR
+ * BANK 0 - 0x0000  0x000C  0x0018  0x0024  0x0030  0x003C  0x0048
+ * BANK 1 - 0x0004  0x0010  0x001C  0x0028  0x0034  0x0040  0x004C
+ * BANK 2 - 0x0008  0x0014  0x0020  0x002C  0x0038  0x0044  0x0050
+ *
+ * BANK 3 - 0x0100  0x010C  0x0118  0x0124  0x0130  0x013C  0x0148
+ * BANK 4 - 0x0104  0x0110  0x011C  0x0128  0x0134  0x0140  0x014C
+ * BANK 5 - 0x0108  0x0114  0x0120  0x012C  0x0138  0x0144  0x0150
+ *
+ * NOTE:
+ *   BANK 3 is only available on PXA27x and later processors.
+ *   BANK 4 and 5 are only available on PXA935
+ */
+
+#define PXA_BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
+
+#define PXA_GPIO_BANK(n)	(pxa_gpio_regs.gplr + PXA_BANK_OFF(n))
+#define PXA_GPIO_bit(x)		(1 << ((x) & 0x1f))
+#define pxa_gpio_to_bank(gpio)	((gpio) >> 5)
+
+
+/* GPIO Pin Level Registers */
+#define PXA_GPLR(x)	(*(volatile u32 *)(pxa_gpio_regs.gplr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Pin Direction Registers */
+#define PXA_GPDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpdr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Pin Output Set Registers */
+#define PXA_GPSR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpsr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Pin Output Clear Registers */
+#define PXA_GPCR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpcr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Rising Edge Detect Registers */
+#define PXA_GRER(x)	(*(volatile u32 *)(pxa_gpio_regs.grer	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Falling Edge Detect Registers */
+#define PXA_GFER(x)	(*(volatile u32 *)(pxa_gpio_regs.gfer	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Edge Detect Status Registers */
+#define PXA_GEDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gedr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Alternate Function Select Registers */
+#define PXA_GAFR(x)	(*(volatile u32 *)(pxa_gpio_regs.gafr	\
+			+ (((x) & 0x70) >> 2)))
+
+extern struct pxa_gpio_regs pxa_gpio_regs;
+
+/* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
+ * Those cases currently cause holes in the GPIO number space, the
+ * actual number of the last GPIO is recorded by 'pxa_last_gpio'.
+ */
+extern int pxa_last_gpio;
+
+typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
+
+extern int pxa_irq_to_gpio(int irq);
+
+#endif /* __GPIO_PXA_H */
-- 
1.7.2.5
