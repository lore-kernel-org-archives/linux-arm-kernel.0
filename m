From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 08:19:04 +0200
Subject: [PATCH 13/15] ARM: Samsung: Move external interrupts support from
	plat-s5pc1xx to plat-s5p
In-Reply-To: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1273817946-29404-14-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves external interrupts support code from plat-s5pc1xx to
plat-s5p and enables support for it on ARCH_S5PC100. This code can be easily
reused by S5PV210/S5PC110 and probably S5P6442.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig                  |    1 +
 arch/arm/mach-s5pc100/gpio.c                   |    8 ++--
 arch/arm/mach-s5pc100/include/mach/gpio.h      |    8 +++
 arch/arm/plat-s5p/Kconfig                      |    5 ++
 arch/arm/plat-s5p/Makefile                     |    1 +
 arch/arm/plat-s5p/include/plat/gpio-ext.h      |   44 ++++++++++++++++++
 arch/arm/{plat-s5pc1xx => plat-s5p}/irq-eint.c |   57 ++++++++++++------------
 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h  |   44 ------------------
 8 files changed, 92 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm/plat-s5p/include/plat/gpio-ext.h
 rename arch/arm/{plat-s5pc1xx => plat-s5p}/irq-eint.c (80%)
 delete mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index a6e21b2..86fe699 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -10,6 +10,7 @@ if ARCH_S5PC100
 config CPU_S5PC100
 	bool
 	select PLAT_S5P
+	select S5P_IRQ_EINT
 	help
 	  Enable S5PC100 CPU support
 
diff --git a/arch/arm/mach-s5pc100/gpio.c b/arch/arm/mach-s5pc100/gpio.c
index 494a53b..df539f6 100644
--- a/arch/arm/mach-s5pc100/gpio.c
+++ b/arch/arm/mach-s5pc100/gpio.c
@@ -61,7 +61,6 @@
  * L3	8	4Bit	None
  */
 
-#if 0
 static int s5pc100_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	return S3C_IRQ_GPIO(chip->base + offset);
@@ -85,7 +84,7 @@ static int s5pc100_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
 		return IRQ_EINT(24 + offset);
 	return -EINVAL;
 }
-#endif
+
 static struct s3c_gpio_cfg gpio_cfg = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
@@ -401,9 +400,10 @@ static __init void s5pc100_gpiolib_link(struct s3c_gpio_chip *chip)
 			set_irq_handler(irq, handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID);
 		}
-	} else if (chip->config == &gpio_cfg_eint)
-		chip->chip.to_irq = s5pc100_gpiolib_to_eint;
+	} else
 #endif
+	if (chip->config == &gpio_cfg_eint)
+		chip->chip.to_irq = s5pc100_gpiolib_to_eint;
 }
 
 static __init int s5pc100_gpiolib_init(void)
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index fb2f40a..057c47a 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -159,4 +159,12 @@ enum s3c_gpio_number {
 /* define the number of gpios we need to the one after the MP04() range */
 #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
 
+/* Common compatibility defines */
+#define S5P_GPIO_EINT_SFN	S3C_GPIO_SFN(0x2)
+#define S5P_GPH0(n)		S5PC100_GPH0(n)
+#define S5P_GPH1(n)		S5PC100_GPH1(n)
+#define S5P_GPH2(n)		S5PC100_GPH2(n)
+#define S5P_GPH3(n)		S5PC100_GPH3(n)
+#define S5P_GPIO_INT_GROUP_END	S5PC100_GPIO_INT_GROUP_END
+
 #include <asm-generic/gpio.h>
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 189be6e..09d06a2 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -24,3 +24,8 @@ config PLAT_S5P
 	select SAMSUNG_IRQ_UART
 	help
 	  Base platform code for Samsung's S5P series SoC.
+
+config S5P_IRQ_EINT
+	bool
+	help
+	  Common initialisation code for the EINT support on S5P platform
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 0ec09a9..db4801f 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -16,3 +16,4 @@ obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
+obj-$(CONFIG_S5P_IRQ_EINT)	+= irq-eint.o
diff --git a/arch/arm/plat-s5p/include/plat/gpio-ext.h b/arch/arm/plat-s5p/include/plat/gpio-ext.h
new file mode 100644
index 0000000..b298335
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/gpio-ext.h
@@ -0,0 +1,44 @@
+/* linux/arch/arm/plat-s5p/include/plat/gpio-eint.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * External Interrupt (GPH0 ~ GPH3) control register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define S5P_WKUP_INT_CON0_7		(S5P_EINT_BASE + 0x0)
+#define S5P_WKUP_INT_CON8_15		(S5P_EINT_BASE + 0x4)
+#define S5P_WKUP_INT_CON16_23		(S5P_EINT_BASE + 0x8)
+#define S5P_WKUP_INT_CON24_31		(S5P_EINT_BASE + 0xC)
+#define S5P_WKUP_INT_CON(x)		(S5P_WKUP_INT_CON0_7 + (x * 0x4))
+
+#define S5P_WKUP_INT_FLTCON0_3		(S5P_EINT_BASE + 0x80)
+#define S5P_WKUP_INT_FLTCON4_7		(S5P_EINT_BASE + 0x84)
+#define S5P_WKUP_INT_FLTCON8_11		(S5P_EINT_BASE + 0x88)
+#define S5P_WKUP_INT_FLTCON12_15	(S5P_EINT_BASE + 0x8C)
+#define S5P_WKUP_INT_FLTCON16_19	(S5P_EINT_BASE + 0x90)
+#define S5P_WKUP_INT_FLTCON20_23	(S5P_EINT_BASE + 0x94)
+#define S5P_WKUP_INT_FLTCON24_27	(S5P_EINT_BASE + 0x98)
+#define S5P_WKUP_INT_FLTCON28_31	(S5P_EINT_BASE + 0x9C)
+#define S5P_WKUP_INT_FLTCON(x)		(S5P_WKUP_INT_FLTCON0_3 + (x * 0x4))
+
+#define S5P_WKUP_INT_MASK0_7		(S5P_EINT_BASE + 0x100)
+#define S5P_WKUP_INT_MASK8_15		(S5P_EINT_BASE + 0x104)
+#define S5P_WKUP_INT_MASK16_23		(S5P_EINT_BASE + 0x108)
+#define S5P_WKUP_INT_MASK24_31		(S5P_EINT_BASE + 0x10C)
+#define S5P_WKUP_INT_MASK(x)		(S5P_WKUP_INT_MASK0_7 + (x * 0x4))
+
+#define S5P_WKUP_INT_PEND0_7		(S5P_EINT_BASE + 0x140)
+#define S5P_WKUP_INT_PEND8_15		(S5P_EINT_BASE + 0x144)
+#define S5P_WKUP_INT_PEND16_23		(S5P_EINT_BASE + 0x148)
+#define S5P_WKUP_INT_PEND24_31		(S5P_EINT_BASE + 0x14C)
+#define S5P_WKUP_INT_PEND(x)		(S5P_WKUP_INT_PEND0_7 + (x * 0x4))
+
+#define S5P_WKUP_INT_LOWLEV		(0x00)
+#define S5P_WKUP_INT_HILEV		(0x01)
+#define S5P_WKUP_INT_FALLEDGE		(0x02)
+#define S5P_WKUP_INT_RISEEDGE		(0x03)
+#define S5P_WKUP_INT_BOTHEDGE		(0x04)
diff --git a/arch/arm/plat-s5pc1xx/irq-eint.c b/arch/arm/plat-s5p/irq-eint.c
similarity index 80%
rename from arch/arm/plat-s5pc1xx/irq-eint.c
rename to arch/arm/plat-s5p/irq-eint.c
index 373122f..f43aa47 100644
--- a/arch/arm/plat-s5pc1xx/irq-eint.c
+++ b/arch/arm/plat-s5p/irq-eint.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/plat-s5pc1xx/irq-eint.c
+ * linux/arch/arm/plat-s5p/irq-eint.c
  *
  *  Copyright 2009 Samsung Electronics Co.
  *  Byungho Min <bhmin@samsung.com>
@@ -7,7 +7,7 @@
  *
  * Based on plat-s3c64xx/irq-eint.c
  *
- * S5PC1XX - Interrupt handling for IRQ_EINT(x)
+ * S5P - Interrupt handling for IRQ_EINT(x)
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -25,11 +25,12 @@
 #include <asm/hardware/vic.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-ext.h>
 #include <plat/pm.h>
-#include <plat/regs-gpio.h>
 #include <plat/regs-irqtype.h>
 
 /*
@@ -45,9 +46,9 @@ static inline int s3c_get_eint(unsigned int irq)
 	int real;
 
 	if (irq < IRQ_EINT16_31)
-		real = (irq - IRQ_EINT0);
+		real = (irq - IRQ_EINT(0));
 	else
-		real = (irq - S3C_IRQ_EINT_BASE) + IRQ_EINT16_31 - IRQ_EINT0;
+		real = (irq - S5P_IRQ_EINT_BASE) + IRQ_EINT16_31 - IRQ_EINT(0);
 
 	return real;
 }
@@ -72,9 +73,9 @@ static inline void s3c_irq_eint_mask(unsigned int irq)
 	u32 mask;
 	u32 bank = s3c_get_bank(irq);
 
-	mask = __raw_readl(S5PC1XX_WKUP_INT_MASK(bank));
+	mask = __raw_readl(S5P_WKUP_INT_MASK(bank));
 	mask |= s3c_eint_to_bit(irq);
-	__raw_writel(mask, S5PC1XX_WKUP_INT_MASK(bank));
+	__raw_writel(mask, S5P_WKUP_INT_MASK(bank));
 }
 
 static void s3c_irq_eint_unmask(unsigned int irq)
@@ -82,16 +83,16 @@ static void s3c_irq_eint_unmask(unsigned int irq)
 	u32 mask;
 	u32 bank = s3c_get_bank(irq);
 
-	mask = __raw_readl(S5PC1XX_WKUP_INT_MASK(bank));
+	mask = __raw_readl(S5P_WKUP_INT_MASK(bank));
 	mask &= ~(s3c_eint_to_bit(irq));
-	__raw_writel(mask, S5PC1XX_WKUP_INT_MASK(bank));
+	__raw_writel(mask, S5P_WKUP_INT_MASK(bank));
 }
 
 static inline void s3c_irq_eint_ack(unsigned int irq)
 {
 	u32 bank = s3c_get_bank(irq);
 
-	__raw_writel(s3c_eint_to_bit(irq), S5PC1XX_WKUP_INT_PEND(bank));
+	__raw_writel(s3c_eint_to_bit(irq), S5P_WKUP_INT_PEND(bank));
 }
 
 static void s3c_irq_eint_maskack(unsigned int irq)
@@ -114,23 +115,23 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 		break;
 
 	case IRQ_TYPE_EDGE_RISING:
-		con = S5PC1XX_WKUP_INT_RISEEDGE;
+		con = S5P_WKUP_INT_RISEEDGE;
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
-		con = S5PC1XX_WKUP_INT_FALLEDGE;
+		con = S5P_WKUP_INT_FALLEDGE;
 		break;
 
 	case IRQ_TYPE_EDGE_BOTH:
-		con = S5PC1XX_WKUP_INT_BOTHEDGE;
+		con = S5P_WKUP_INT_BOTHEDGE;
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
-		con = S5PC1XX_WKUP_INT_LOWLEV;
+		con = S5P_WKUP_INT_LOWLEV;
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
-		con = S5PC1XX_WKUP_INT_HILEV;
+		con = S5P_WKUP_INT_HILEV;
 		break;
 
 	default:
@@ -141,29 +142,29 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 	gpio = real & (8 - 1);
 	shift = gpio << 2;
 
-	ctrl = __raw_readl(S5PC1XX_WKUP_INT_CON(bank));
+	ctrl = __raw_readl(S5P_WKUP_INT_CON(bank));
 	ctrl &= ~(0x7 << shift);
 	ctrl |= con << shift;
-	__raw_writel(ctrl, S5PC1XX_WKUP_INT_CON(bank));
+	__raw_writel(ctrl, S5P_WKUP_INT_CON(bank));
 
 	switch (real) {
 	case 0 ... 7:
-			gpio = S5PC100_GPH0(gpio);
+			gpio = S5P_GPH0(gpio);
 		break;
 	case 8 ... 15:
-			gpio = S5PC100_GPH1(gpio);
+			gpio = S5P_GPH1(gpio);
 		break;
 	case 16 ... 23:
-			gpio = S5PC100_GPH2(gpio);
+			gpio = S5P_GPH2(gpio);
 		break;
 	case 24 ... 31:
-			gpio = S5PC100_GPH3(gpio);
+			gpio = S5P_GPH3(gpio);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	sfn = S3C_GPIO_SFN(0x2);
+	sfn = S5P_GPIO_EINT_SFN;
 	s3c_gpio_cfgpin(gpio, sfn);
 
 	return 0;
@@ -187,8 +188,8 @@ static struct irq_chip s3c_irq_eint = {
  */
 static inline void s3c_irq_demux_eint(unsigned int start, unsigned int end)
 {
-	u32 status = __raw_readl(S5PC1XX_WKUP_INT_PEND((start >> 3)));
-	u32 mask = __raw_readl(S5PC1XX_WKUP_INT_MASK((start >> 3)));
+	u32 status = __raw_readl(S5P_WKUP_INT_PEND((start >> 3)));
+	u32 mask = __raw_readl(S5P_WKUP_INT_MASK((start >> 3)));
 	unsigned int irq;
 
 	status &= ~mask;
@@ -237,7 +238,7 @@ static inline void s3c_irq_vic_eint_ack(unsigned int irq)
 	u32 bank = s3c_get_bank(irq);
 
 	bit = s3c_eint_to_bit(irq);
-	__raw_writel(bit, S5PC1XX_WKUP_INT_PEND(bank));
+	__raw_writel(bit, S5P_WKUP_INT_PEND(bank));
 }
 
 static void s3c_irq_vic_eint_maskack(unsigned int irq)
@@ -257,11 +258,11 @@ static struct irq_chip s3c_irq_vic_eint = {
 	.set_wake	= s3c_irqext_wake,
 };
 
-static int __init s5pc1xx_init_irq_eint(void)
+static int __init s5p_init_irq_eint(void)
 {
 	int irq;
 
-	for (irq = IRQ_EINT0; irq <= IRQ_EINT15; irq++) {
+	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(15); irq++) {
 		set_irq_chip(irq, &s3c_irq_vic_eint);
 		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
@@ -278,4 +279,4 @@ static int __init s5pc1xx_init_irq_eint(void)
 	return 0;
 }
 
-arch_initcall(s5pc1xx_init_irq_eint);
+arch_initcall(s5p_init_irq_eint);
diff --git a/arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h b/arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
deleted file mode 100644
index 33ad267..0000000
--- a/arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* linux/arch/arm/plat-s5pc1xx/include/plat/gpio-eint.h
- *
- * Copyright 2009 Samsung Electronics Co.
- *
- * External Interrupt (GPH0 ~ GPH3) control register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S5PC1XX_WKUP_INT_CON0_7		(S5PC1XX_EINT_BASE + 0x0)
-#define S5PC1XX_WKUP_INT_CON8_15	(S5PC1XX_EINT_BASE + 0x4)
-#define S5PC1XX_WKUP_INT_CON16_23	(S5PC1XX_EINT_BASE + 0x8)
-#define S5PC1XX_WKUP_INT_CON24_31	(S5PC1XX_EINT_BASE + 0xC)
-#define S5PC1XX_WKUP_INT_CON(x)		(S5PC1XX_WKUP_INT_CON0_7 + (x * 0x4))
-
-#define S5PC1XX_WKUP_INT_FLTCON0_3	(S5PC1XX_EINT_BASE + 0x80)
-#define S5PC1XX_WKUP_INT_FLTCON4_7	(S5PC1XX_EINT_BASE + 0x84)
-#define S5PC1XX_WKUP_INT_FLTCON8_11	(S5PC1XX_EINT_BASE + 0x88)
-#define S5PC1XX_WKUP_INT_FLTCON12_15	(S5PC1XX_EINT_BASE + 0x8C)
-#define S5PC1XX_WKUP_INT_FLTCON16_19	(S5PC1XX_EINT_BASE + 0x90)
-#define S5PC1XX_WKUP_INT_FLTCON20_23	(S5PC1XX_EINT_BASE + 0x94)
-#define S5PC1XX_WKUP_INT_FLTCON24_27	(S5PC1XX_EINT_BASE + 0x98)
-#define S5PC1XX_WKUP_INT_FLTCON28_31	(S5PC1XX_EINT_BASE + 0x9C)
-#define S5PC1XX_WKUP_INT_FLTCON(x)	(S5PC1XX_WKUP_INT_FLTCON0_3 + (x * 0x4))
-
-#define S5PC1XX_WKUP_INT_MASK0_7	(S5PC1XX_EINT_BASE + 0x100)
-#define S5PC1XX_WKUP_INT_MASK8_15	(S5PC1XX_EINT_BASE + 0x104)
-#define S5PC1XX_WKUP_INT_MASK16_23	(S5PC1XX_EINT_BASE + 0x108)
-#define S5PC1XX_WKUP_INT_MASK24_31	(S5PC1XX_EINT_BASE + 0x10C)
-#define S5PC1XX_WKUP_INT_MASK(x)	(S5PC1XX_WKUP_INT_MASK0_7 + (x * 0x4))
-
-#define S5PC1XX_WKUP_INT_PEND0_7	(S5PC1XX_EINT_BASE + 0x140)
-#define S5PC1XX_WKUP_INT_PEND8_15	(S5PC1XX_EINT_BASE + 0x144)
-#define S5PC1XX_WKUP_INT_PEND16_23	(S5PC1XX_EINT_BASE + 0x148)
-#define S5PC1XX_WKUP_INT_PEND24_31	(S5PC1XX_EINT_BASE + 0x14C)
-#define S5PC1XX_WKUP_INT_PEND(x)	(S5PC1XX_WKUP_INT_PEND0_7 + (x * 0x4))
-
-#define S5PC1XX_WKUP_INT_LOWLEV		(0x00)
-#define S5PC1XX_WKUP_INT_HILEV		(0x01)
-#define S5PC1XX_WKUP_INT_FALLEDGE	(0x02)
-#define S5PC1XX_WKUP_INT_RISEEDGE	(0x03)
-#define S5PC1XX_WKUP_INT_BOTHEDGE	(0x04)
-- 
1.6.4
