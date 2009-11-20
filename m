From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 20 Nov 2009 14:42:36 +0100
Subject: [PATCH 04/20] ARM: S5PC1XX: prepare common gpiolib code for S5PC110
	sub-platform
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258724572-19176-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PC100 GPIOlib support has been rewriten to make it possible to reuse
most of the common code in the upcoming S5PC110 sub-platform.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Makefile                     |    1 +
 arch/arm/mach-s5pc100/gpio-chips.c                 |  106 ++++++
 arch/arm/mach-s5pc100/include/mach/gpio.h          |   46 +++
 .../include/plat/irqs.h                            |    2 +-
 .../include/plat/regs-gpio.h                       |    2 +-
 arch/arm/plat-s5pc1xx/gpiolib.c                    |  374 ++------------------
 arch/arm/plat-s5pc1xx/include/plat/gpio-s5pc1xx.h  |   79 ++++
 arch/arm/plat-s5pc1xx/irq-eint.c                   |   13 +-
 arch/arm/plat-s5pc1xx/irq-gpio.c                   |  105 +-----
 9 files changed, 292 insertions(+), 436 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/gpio-chips.c
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/include/plat/irqs.h (99%)
 rename arch/arm/{plat-s5pc1xx => mach-s5pc100}/include/plat/regs-gpio.h (98%)
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-s5pc1xx.h

diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index dc6b0ff..8d29ea1 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 
 obj-$(CONFIG_CPU_S5PC100)	+= cpu.o
 obj-$(CONFIG_CPU_S5PC100)	+= clocks.o
+obj-$(CONFIG_CPU_S5PC100)	+= gpio-chips.o
 obj-$(CONFIG_CPU_S5PC100)	+= plls.o
 obj-$(CONFIG_CPU_S5PC100)	+= uarts.o
 
diff --git a/arch/arm/mach-s5pc100/gpio-chips.c b/arch/arm/mach-s5pc100/gpio-chips.c
new file mode 100644
index 0000000..f8fa8d7
--- /dev/null
+++ b/arch/arm/mach-s5pc100/gpio-chips.c
@@ -0,0 +1,106 @@
+/*
+ * linux/arch/arm/mach-s5pc100/gpio-chips.c
+ *
+ *  Copyright 2009 Samsung Electronics Co
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *  Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * S5PC100 - GPIOlib chip definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+
+#include <mach/map.h>
+#include <mach/gpio-core.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
+#include <plat/gpio-s5pc1xx.h>
+#include <plat/regs-gpio.h>
+
+/* S5PC100 GPIO bank summary:
+ *
+ * Bank	GPIOs	Style	INT Type
+ * A0	8	4Bit	GPIO_INT0
+ * A1	5	4Bit	GPIO_INT1
+ * B	8	4Bit	GPIO_INT2
+ * C	5	4Bit	GPIO_INT3
+ * D	7	4Bit	GPIO_INT4
+ * E0	8	4Bit	GPIO_INT5
+ * E1	6	4Bit	GPIO_INT6
+ * F0	8	4Bit	GPIO_INT7
+ * F1	8	4Bit	GPIO_INT8
+ * F2	8	4Bit	GPIO_INT9
+ * F3	4	4Bit	GPIO_INT10
+ * G0	8	4Bit	GPIO_INT11
+ * G1	3	4Bit	GPIO_INT12
+ * G2	7	4Bit	GPIO_INT13
+ * G3	7	4Bit	GPIO_INT14
+ * H0	8	4Bit	WKUP_INT
+ * H1	8	4Bit	WKUP_INT
+ * H2	8	4Bit	WKUP_INT
+ * H3	8	4Bit	WKUP_INT
+ * I	8	4Bit	GPIO_INT15
+ * J0	8	4Bit	GPIO_INT16
+ * J1	5	4Bit	GPIO_INT17
+ * J2	8	4Bit	GPIO_INT18
+ * J3	8	4Bit	GPIO_INT19
+ * J4	4	4Bit	GPIO_INT20
+ * K0	8	4Bit	None
+ * K1	6	4Bit	None
+ * K2	8	4Bit	None
+ * K3	8	4Bit	None
+ * L0	8	4Bit	None
+ * L1	8	4Bit	None
+ * L2	8	4Bit	None
+ * L3	8	4Bit	None
+ */
+
+static struct s5pc1xx_gpio_chip s5pc100_gpio_chips[] = {
+	S5PC1XX_INT_CHIP_DEF(S5PC100, A0),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, A1),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, B),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, C),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, D),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, E0),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, E1),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, F0),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, F1),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, F2),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, F3),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, G0),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, G1),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, G2),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, G3),
+	S5PC1XX_EINT_CHIP_DEF(S5PC100, H0),
+	S5PC1XX_EINT_CHIP_DEF(S5PC100, H1),
+	S5PC1XX_EINT_CHIP_DEF(S5PC100, H2),
+	S5PC1XX_EINT_CHIP_DEF(S5PC100, H3),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, I),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, J0),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, J1),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, J2),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, J3),
+	S5PC1XX_INT_CHIP_DEF(S5PC100, J4),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, K0),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, K1),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, K2),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, K3),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, L0),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, L1),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, L2),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, L3),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC100, L4),
+};
+
+struct s5pc1xx_gpio s5pc1xx_gpio_chips = {
+	.chips = s5pc100_gpio_chips,
+	.count = ARRAY_SIZE(s5pc100_gpio_chips),
+};
diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 2c4cbe8..3142c40 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -159,4 +159,50 @@ enum s3c_gpio_number {
 /* define the number of gpios we need to the one after the MP04() range */
 #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
 
+/* Offset of the bank in the interrupt group registers */
+#define S5PC100_GPIO_A0_INT_GROUP	(0)
+#define S5PC100_GPIO_A1_INT_GROUP	(1)
+#define S5PC100_GPIO_B_INT_GROUP	(2)
+#define S5PC100_GPIO_C_INT_GROUP	(3)
+#define S5PC100_GPIO_D_INT_GROUP	(4)
+#define S5PC100_GPIO_E0_INT_GROUP	(5)
+#define S5PC100_GPIO_E1_INT_GROUP	(6)
+#define S5PC100_GPIO_F0_INT_GROUP	(7)
+#define S5PC100_GPIO_F1_INT_GROUP	(8)
+#define S5PC100_GPIO_F2_INT_GROUP	(9)
+#define S5PC100_GPIO_F3_INT_GROUP	(10)
+#define S5PC100_GPIO_G0_INT_GROUP	(11)
+#define S5PC100_GPIO_G1_INT_GROUP	(12)
+#define S5PC100_GPIO_G2_INT_GROUP	(13)
+#define S5PC100_GPIO_G3_INT_GROUP	(14)
+#define S5PC100_GPIO_I_INT_GROUP	(15)
+#define S5PC100_GPIO_J0_INT_GROUP	(16)
+#define S5PC100_GPIO_J1_INT_GROUP	(17)
+#define S5PC100_GPIO_J2_INT_GROUP	(18)
+#define S5PC100_GPIO_J3_INT_GROUP	(19)
+#define S5PC100_GPIO_J4_INT_GROUP	(20)
+#define S5PC100_GPIO_H0_INT_GROUP	(-1)
+#define S5PC100_GPIO_H1_INT_GROUP	(-1)
+#define S5PC100_GPIO_H2_INT_GROUP	(-1)
+#define S5PC100_GPIO_H3_INT_GROUP	(-1)
+#define S5PC100_GPIO_K0_INT_GROUP	(-1)
+#define S5PC100_GPIO_K1_INT_GROUP	(-1)
+#define S5PC100_GPIO_K2_INT_GROUP	(-1)
+#define S5PC100_GPIO_K3_INT_GROUP	(-1)
+#define S5PC100_GPIO_L0_INT_GROUP	(-1)
+#define S5PC100_GPIO_L1_INT_GROUP	(-1)
+#define S5PC100_GPIO_L2_INT_GROUP	(-1)
+#define S5PC100_GPIO_L3_INT_GROUP	(-1)
+#define S5PC100_GPIO_L4_INT_GROUP	(-1)
+
+#define S5PC100_GPIO_INT_GROUP_END	(S5PC100_GPIO_J4_INT_GROUP + 1)
+
+/* Common compatibility defines */
+#define S5PC1XX_GPIO_EINT_SFN	S3C_GPIO_SFN(0x2)
+#define S5PC1XX_GPH0(n)		S5PC100_GPH0(n)
+#define S5PC1XX_GPH1(n)		S5PC100_GPH1(n)
+#define S5PC1XX_GPH2(n)		S5PC100_GPH2(n)
+#define S5PC1XX_GPH3(n)		S5PC100_GPH3(n)
+#define S5PC1XX_GPIO_INT_GROUP_END	S5PC100_GPIO_INT_GROUP_END
+
 #include <asm-generic/gpio.h>
diff --git a/arch/arm/plat-s5pc1xx/include/plat/irqs.h b/arch/arm/mach-s5pc100/include/plat/irqs.h
similarity index 99%
rename from arch/arm/plat-s5pc1xx/include/plat/irqs.h
rename to arch/arm/mach-s5pc100/include/plat/irqs.h
index ef87363..e34e2ef 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/irqs.h
+++ b/arch/arm/mach-s5pc100/include/plat/irqs.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX - Common IRQ support
+ * S5PC100 - Common IRQ support
  *
  * Based on plat-s3c64xx/include/plat/irqs.h
  */
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h b/arch/arm/mach-s5pc100/include/plat/regs-gpio.h
similarity index 98%
rename from arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
rename to arch/arm/mach-s5pc100/include/plat/regs-gpio.h
index 43c7bc8..87e1884 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
+++ b/arch/arm/mach-s5pc100/include/plat/regs-gpio.h
@@ -3,7 +3,7 @@
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
  *
- * S5PC1XX - GPIO register definitions
+ * S5PC100 - GPIO register definitions
  */
 
 #ifndef __ASM_PLAT_S5PC1XX_REGS_GPIO_H
diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/plat-s5pc1xx/gpiolib.c
index facb410..e0eb8e3 100644
--- a/arch/arm/plat-s5pc1xx/gpiolib.c
+++ b/arch/arm/plat-s5pc1xx/gpiolib.c
@@ -3,6 +3,7 @@
  *
  *  Copyright 2009 Samsung Electronics Co
  *  Kyungmin Park <kyungmin.park@samsung.com>
+ *  Marek Szyprowski <m.szyprowski@samsung.com>
  *
  * S5PC1XX - GPIOlib support
  *
@@ -21,46 +22,9 @@
 
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
+#include <plat/gpio-s5pc1xx.h>
 #include <plat/regs-gpio.h>
 
-/* S5PC100 GPIO bank summary:
- *
- * Bank	GPIOs	Style	INT Type
- * A0	8	4Bit	GPIO_INT0
- * A1	5	4Bit	GPIO_INT1
- * B	8	4Bit	GPIO_INT2
- * C	5	4Bit	GPIO_INT3
- * D	7	4Bit	GPIO_INT4
- * E0	8	4Bit	GPIO_INT5
- * E1	6	4Bit	GPIO_INT6
- * F0	8	4Bit	GPIO_INT7
- * F1	8	4Bit	GPIO_INT8
- * F2	8	4Bit	GPIO_INT9
- * F3	4	4Bit	GPIO_INT10
- * G0	8	4Bit	GPIO_INT11
- * G1	3	4Bit	GPIO_INT12
- * G2	7	4Bit	GPIO_INT13
- * G3	7	4Bit	GPIO_INT14
- * H0	8	4Bit	WKUP_INT
- * H1	8	4Bit	WKUP_INT
- * H2	8	4Bit	WKUP_INT
- * H3	8	4Bit	WKUP_INT
- * I	8	4Bit	GPIO_INT15
- * J0	8	4Bit	GPIO_INT16
- * J1	5	4Bit	GPIO_INT17
- * J2	8	4Bit	GPIO_INT18
- * J3	8	4Bit	GPIO_INT19
- * J4	4	4Bit	GPIO_INT20
- * K0	8	4Bit	None
- * K1	6	4Bit	None
- * K2	8	4Bit	None
- * K3	8	4Bit	None
- * L0	8	4Bit	None
- * L1	8	4Bit	None
- * L2	8	4Bit	None
- * L3	8	4Bit	None
- */
-
 #define OFF_GPCON	(0x00)
 #define OFF_GPDAT	(0x04)
 
@@ -138,328 +102,50 @@ static int s5pc1xx_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
 {
 	int base;
 
-	base = chip->base - S5PC100_GPH0(0);
+	base = chip->base - S5PC1XX_GPH0(0);
 	if (base == 0)
 		return IRQ_EINT(offset);
-	base = chip->base - S5PC100_GPH1(0);
+	base = chip->base - S5PC1XX_GPH1(0);
 	if (base == 0)
 		return IRQ_EINT(8 + offset);
-	base = chip->base - S5PC100_GPH2(0);
+	base = chip->base - S5PC1XX_GPH2(0);
 	if (base == 0)
 		return IRQ_EINT(16 + offset);
-	base = chip->base - S5PC100_GPH3(0);
+	base = chip->base - S5PC1XX_GPH3(0);
 	if (base == 0)
 		return IRQ_EINT(24 + offset);
+
 	return -EINVAL;
 }
 
-static struct s3c_gpio_cfg gpio_cfg = {
+struct s3c_gpio_cfg s5pc1xx_gpio_cfg = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
-static struct s3c_gpio_cfg gpio_cfg_eint = {
+struct s3c_gpio_cfg s5pc1xx_gpio_cfg_eint = {
 	.cfg_eint	= 0xf,
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
-static struct s3c_gpio_cfg gpio_cfg_noint = {
+struct s3c_gpio_cfg s5pc1xx_gpio_cfg_noint = {
 	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
 	.set_pull	= s3c_gpio_setpull_updown,
 	.get_pull	= s3c_gpio_getpull_updown,
 };
 
-static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
-	{
-		.base	= S5PC100_GPA0_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPA0(0),
-			.ngpio	= S5PC100_GPIO_A0_NR,
-			.label	= "GPA0",
-		},
-	}, {
-		.base	= S5PC100_GPA1_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPA1(0),
-			.ngpio	= S5PC100_GPIO_A1_NR,
-			.label	= "GPA1",
-		},
-	}, {
-		.base	= S5PC100_GPB_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPB(0),
-			.ngpio	= S5PC100_GPIO_B_NR,
-			.label	= "GPB",
-		},
-	}, {
-		.base	= S5PC100_GPC_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPC(0),
-			.ngpio	= S5PC100_GPIO_C_NR,
-			.label	= "GPC",
-		},
-	}, {
-		.base	= S5PC100_GPD_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPD(0),
-			.ngpio	= S5PC100_GPIO_D_NR,
-			.label	= "GPD",
-		},
-	}, {
-		.base	= S5PC100_GPE0_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPE0(0),
-			.ngpio	= S5PC100_GPIO_E0_NR,
-			.label	= "GPE0",
-		},
-	}, {
-		.base	= S5PC100_GPE1_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPE1(0),
-			.ngpio	= S5PC100_GPIO_E1_NR,
-			.label	= "GPE1",
-		},
-	}, {
-		.base	= S5PC100_GPF0_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPF0(0),
-			.ngpio	= S5PC100_GPIO_F0_NR,
-			.label	= "GPF0",
-		},
-	}, {
-		.base	= S5PC100_GPF1_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPF1(0),
-			.ngpio	= S5PC100_GPIO_F1_NR,
-			.label	= "GPF1",
-		},
-	}, {
-		.base	= S5PC100_GPF2_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPF2(0),
-			.ngpio	= S5PC100_GPIO_F2_NR,
-			.label	= "GPF2",
-		},
-	}, {
-		.base	= S5PC100_GPF3_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPF3(0),
-			.ngpio	= S5PC100_GPIO_F3_NR,
-			.label	= "GPF3",
-		},
-	}, {
-		.base	= S5PC100_GPG0_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPG0(0),
-			.ngpio	= S5PC100_GPIO_G0_NR,
-			.label	= "GPG0",
-		},
-	}, {
-		.base	= S5PC100_GPG1_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPG1(0),
-			.ngpio	= S5PC100_GPIO_G1_NR,
-			.label	= "GPG1",
-		},
-	}, {
-		.base	= S5PC100_GPG2_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPG2(0),
-			.ngpio	= S5PC100_GPIO_G2_NR,
-			.label	= "GPG2",
-		},
-	}, {
-		.base	= S5PC100_GPG3_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPG3(0),
-			.ngpio	= S5PC100_GPIO_G3_NR,
-			.label	= "GPG3",
-		},
-	}, {
-		.base	= S5PC100_GPH0_BASE,
-		.config	= &gpio_cfg_eint,
-		.chip	= {
-			.base	= S5PC100_GPH0(0),
-			.ngpio	= S5PC100_GPIO_H0_NR,
-			.label	= "GPH0",
-		},
-	}, {
-		.base	= S5PC100_GPH1_BASE,
-		.config	= &gpio_cfg_eint,
-		.chip	= {
-			.base	= S5PC100_GPH1(0),
-			.ngpio	= S5PC100_GPIO_H1_NR,
-			.label	= "GPH1",
-		},
-	}, {
-		.base	= S5PC100_GPH2_BASE,
-		.config	= &gpio_cfg_eint,
-		.chip	= {
-			.base	= S5PC100_GPH2(0),
-			.ngpio	= S5PC100_GPIO_H2_NR,
-			.label	= "GPH2",
-		},
-	}, {
-		.base	= S5PC100_GPH3_BASE,
-		.config	= &gpio_cfg_eint,
-		.chip	= {
-			.base	= S5PC100_GPH3(0),
-			.ngpio	= S5PC100_GPIO_H3_NR,
-			.label	= "GPH3",
-		},
-	}, {
-		.base	= S5PC100_GPI_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPI(0),
-			.ngpio	= S5PC100_GPIO_I_NR,
-			.label	= "GPI",
-		},
-	}, {
-		.base	= S5PC100_GPJ0_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPJ0(0),
-			.ngpio	= S5PC100_GPIO_J0_NR,
-			.label	= "GPJ0",
-		},
-	}, {
-		.base	= S5PC100_GPJ1_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPJ1(0),
-			.ngpio	= S5PC100_GPIO_J1_NR,
-			.label	= "GPJ1",
-		},
-	}, {
-		.base	= S5PC100_GPJ2_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPJ2(0),
-			.ngpio	= S5PC100_GPIO_J2_NR,
-			.label	= "GPJ2",
-		},
-	}, {
-		.base	= S5PC100_GPJ3_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPJ3(0),
-			.ngpio	= S5PC100_GPIO_J3_NR,
-			.label	= "GPJ3",
-		},
-	}, {
-		.base	= S5PC100_GPJ4_BASE,
-		.config	= &gpio_cfg,
-		.chip	= {
-			.base	= S5PC100_GPJ4(0),
-			.ngpio	= S5PC100_GPIO_J4_NR,
-			.label	= "GPJ4",
-		},
-	}, {
-		.base	= S5PC100_GPK0_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPK0(0),
-			.ngpio	= S5PC100_GPIO_K0_NR,
-			.label	= "GPK0",
-		},
-	}, {
-		.base	= S5PC100_GPK1_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPK1(0),
-			.ngpio	= S5PC100_GPIO_K1_NR,
-			.label	= "GPK1",
-		},
-	}, {
-		.base	= S5PC100_GPK2_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPK2(0),
-			.ngpio	= S5PC100_GPIO_K2_NR,
-			.label	= "GPK2",
-		},
-	}, {
-		.base	= S5PC100_GPK3_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPK3(0),
-			.ngpio	= S5PC100_GPIO_K3_NR,
-			.label	= "GPK3",
-		},
-	}, {
-		.base	= S5PC100_GPL0_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPL0(0),
-			.ngpio	= S5PC100_GPIO_L0_NR,
-			.label	= "GPL0",
-		},
-	}, {
-		.base	= S5PC100_GPL1_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPL1(0),
-			.ngpio	= S5PC100_GPIO_L1_NR,
-			.label	= "GPL1",
-		},
-	}, {
-		.base	= S5PC100_GPL2_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPL2(0),
-			.ngpio	= S5PC100_GPIO_L2_NR,
-			.label	= "GPL2",
-		},
-	}, {
-		.base	= S5PC100_GPL3_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPL3(0),
-			.ngpio	= S5PC100_GPIO_L3_NR,
-			.label	= "GPL3",
-		},
-	}, {
-		.base	= S5PC100_GPL4_BASE,
-		.config	= &gpio_cfg_noint,
-		.chip	= {
-			.base	= S5PC100_GPL4(0),
-			.ngpio	= S5PC100_GPIO_L4_NR,
-			.label	= "GPL4",
-		},
-	},
-};
-
-/* FIXME move from irq-gpio.c */
-extern struct irq_chip s5pc1xx_gpioint;
-extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
-
-static __init void s5pc1xx_gpiolib_link(struct s3c_gpio_chip *chip)
+static __init void s5pc1xx_gpiolib_link(struct s5pc1xx_gpio_chip *s5pc1xx_chip)
 {
+	struct s3c_gpio_chip *chip = &s5pc1xx_chip->chip;
 	chip->chip.direction_input = s5pc1xx_gpiolib_input;
 	chip->chip.direction_output = s5pc1xx_gpiolib_output;
 	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
 
 	/* Interrupt */
-	if (chip->config == &gpio_cfg) {
+	if (chip->config == &s5pc1xx_gpio_cfg) {
 		int i, irq;
 
 		chip->chip.to_irq = s5pc1xx_gpiolib_to_irq;
@@ -471,31 +157,37 @@ static __init void s5pc1xx_gpiolib_link(struct s3c_gpio_chip *chip)
 			set_irq_handler(irq, handle_level_irq);
 			set_irq_flags(irq, IRQF_VALID);
 		}
-	} else if (chip->config == &gpio_cfg_eint)
+
+		if (s5pc1xx_chip->gpio_group >= 0 &&
+		    s5pc1xx_chip->gpio_group < S5PC1XX_GPIO_INT_GROUP_END)
+			s5pc1xx_gpioint_group_map[s5pc1xx_chip->gpio_group] =
+				s5pc1xx_chip->gpio_start;
+
+	} else if (chip->config == &s5pc1xx_gpio_cfg_eint)
 		chip->chip.to_irq = s5pc1xx_gpiolib_to_eint;
 }
 
-static __init void s5pc1xx_gpiolib_add(struct s3c_gpio_chip *chips,
-				       int nr_chips,
-				       void (*fn)(struct s3c_gpio_chip *))
+static __init void s5pc1xx_gpiolib_add(struct s5pc1xx_gpio *chips)
 {
-	for (; nr_chips > 0; nr_chips--, chips++) {
-		if (fn)
-			(fn)(chips);
-		s3c_gpiolib_add(chips);
+	struct s5pc1xx_gpio_chip *chip;
+	int i;
+
+	for (chip = chips->chips; i < chips->count; i++, chip++) {
+		s5pc1xx_gpiolib_link(chip);
+		s3c_gpiolib_add(&chip->chip);
 	}
 }
 
 static __init int s5pc1xx_gpiolib_init(void)
 {
-	struct s3c_gpio_chip *chips;
-	int nr_chips;
+	int i;
 
-		chips = s5pc100_gpio_chips;
-		nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
+	for (i = 0; i < S5PC1XX_GPIO_INT_GROUP_END; i++)
+		s5pc1xx_gpioint_group_map[i] = -1;
 
-	s5pc1xx_gpiolib_add(chips, nr_chips, s5pc1xx_gpiolib_link);
-	/* Interrupt */
+	s5pc1xx_gpiolib_add(&s5pc1xx_gpio_chips);
+
+	/* register gpio interrupt handler */
 	set_irq_chained_handler(IRQ_GPIOINT, s5pc1xx_irq_gpioint_handler);
 
 	return 0;
diff --git a/arch/arm/plat-s5pc1xx/include/plat/gpio-s5pc1xx.h b/arch/arm/plat-s5pc1xx/include/plat/gpio-s5pc1xx.h
new file mode 100644
index 0000000..ad7c174
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/plat/gpio-s5pc1xx.h
@@ -0,0 +1,79 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/gpio-s5pc1xx.h
+ *
+ *  Copyright 2009 Samsung Electronics Co
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *  Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * GPIOlib support for S5PC1XX
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __GPIO_S5PC1XX_H
+#define __GPIO_S5PC1XX_H __FILE__
+
+struct s5pc1xx_gpio_chip {
+       struct s3c_gpio_chip chip;
+       unsigned int gpio_group;
+       unsigned int gpio_start;
+};
+
+extern struct irq_chip s5pc1xx_gpioint;
+extern int s5pc1xx_gpioint_group_map[S5PC1XX_GPIO_INT_GROUP_END];
+extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
+
+#define S5PC1XX_CHIP_DEF(plat, bank, cfg) \
+	{ \
+		.base	= plat ## _GP ## bank ## _BASE, \
+		.config	= &cfg, \
+		.chip	= { \
+			.base	= plat ## _GP ## bank(0), \
+			.ngpio	= plat ## _GPIO_ ## bank ## _NR, \
+			.label	= "GP" # bank, \
+		}, \
+	}
+
+#define S5PC1XX_INT_CHIP_DEF(plat, bank) \
+	{ \
+		.chip = S5PC1XX_CHIP_DEF(plat, bank, s5pc1xx_gpio_cfg), \
+		.gpio_start = plat ## _GPIO_## bank ## _START, \
+		.gpio_group = plat ## _GPIO_## bank ## _INT_GROUP, \
+	}
+
+#define S5PC1XX_EINT_CHIP_DEF(plat, bank) \
+	{ \
+		.chip = S5PC1XX_CHIP_DEF(plat, bank, s5pc1xx_gpio_cfg_eint), \
+	}
+
+#define S5PC1XX_NOINT_CHIP_DEF(plat, bank) \
+	{ \
+		.chip = S5PC1XX_CHIP_DEF(plat, bank, s5pc1xx_gpio_cfg_noint), \
+	}
+
+#define S5PC1XX_MP_CHIP_DEF(plat, bank) \
+	{ \
+		.chip = { \
+			.base	= plat ## _ ## bank ## _BASE, \
+			.config	= &s5pc1xx_gpio_cfg_noint, \
+			.chip	= { \
+				.base	= plat ## _ ## bank(0), \
+				.ngpio	= plat ## _GPIO_ ## bank ## _NR, \
+				.label	= "" # bank, \
+			}, \
+		}, \
+	}
+
+extern struct s3c_gpio_cfg s5pc1xx_gpio_cfg;
+extern struct s3c_gpio_cfg s5pc1xx_gpio_cfg_eint;
+extern struct s3c_gpio_cfg s5pc1xx_gpio_cfg_noint;
+
+struct s5pc1xx_gpio {
+	struct s5pc1xx_gpio_chip *chips;
+	int count;
+};
+
+extern struct s5pc1xx_gpio s5pc1xx_gpio_chips;
+
+#endif /* __GPIO_S5PC1XX_H */
diff --git a/arch/arm/plat-s5pc1xx/irq-eint.c b/arch/arm/plat-s5pc1xx/irq-eint.c
index 373122f..9e8bc12 100644
--- a/arch/arm/plat-s5pc1xx/irq-eint.c
+++ b/arch/arm/plat-s5pc1xx/irq-eint.c
@@ -105,7 +105,7 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 {
 	u32 bank = s3c_get_bank(irq);
 	int real = s3c_get_eint(irq);
-	int gpio, shift, sfn;
+	int gpio, shift;
 	u32 ctrl, con = 0;
 
 	switch (type) {
@@ -148,23 +148,22 @@ static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
 
 	switch (real) {
 	case 0 ... 7:
-			gpio = S5PC100_GPH0(gpio);
+		gpio = S5PC1XX_GPH0(gpio);
 		break;
 	case 8 ... 15:
-			gpio = S5PC100_GPH1(gpio);
+		gpio = S5PC1XX_GPH1(gpio);
 		break;
 	case 16 ... 23:
-			gpio = S5PC100_GPH2(gpio);
+		gpio = S5PC1XX_GPH2(gpio);
 		break;
 	case 24 ... 31:
-			gpio = S5PC100_GPH3(gpio);
+		gpio = S5PC1XX_GPH3(gpio);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	sfn = S3C_GPIO_SFN(0x2);
-	s3c_gpio_cfgpin(gpio, sfn);
+	s3c_gpio_cfgpin(gpio, S5PC1XX_GPIO_EINT_SFN);
 
 	return 0;
 }
diff --git a/arch/arm/plat-s5pc1xx/irq-gpio.c b/arch/arm/plat-s5pc1xx/irq-gpio.c
index fecca7a..117cb8d 100644
--- a/arch/arm/plat-s5pc1xx/irq-gpio.c
+++ b/arch/arm/plat-s5pc1xx/irq-gpio.c
@@ -17,7 +17,9 @@
 #include <linux/gpio.h>
 
 #include <mach/map.h>
+#include <mach/gpio-core.h>
 #include <plat/gpio-cfg.h>
+#include <plat/gpio-s5pc1xx.h>
 
 #define S5PC1XX_GPIOREG(x)		(S5PC1XX_VA_GPIO + (x))
 
@@ -49,88 +51,19 @@ static int group_to_pend_offset(int group)
 	return group << 2;
 }
 
-static int s5pc1xx_get_start(unsigned int group)
-{
-	switch (group) {
-	case 0: return S5PC100_GPIO_A0_START;
-	case 1: return S5PC100_GPIO_A1_START;
-	case 2: return S5PC100_GPIO_B_START;
-	case 3: return S5PC100_GPIO_C_START;
-	case 4: return S5PC100_GPIO_D_START;
-	case 5: return S5PC100_GPIO_E0_START;
-	case 6: return S5PC100_GPIO_E1_START;
-	case 7: return S5PC100_GPIO_F0_START;
-	case 8: return S5PC100_GPIO_F1_START;
-	case 9: return S5PC100_GPIO_F2_START;
-	case 10: return S5PC100_GPIO_F3_START;
-	case 11: return S5PC100_GPIO_G0_START;
-	case 12: return S5PC100_GPIO_G1_START;
-	case 13: return S5PC100_GPIO_G2_START;
-	case 14: return S5PC100_GPIO_G3_START;
-	case 15: return S5PC100_GPIO_I_START;
-	case 16: return S5PC100_GPIO_J0_START;
-	case 17: return S5PC100_GPIO_J1_START;
-	case 18: return S5PC100_GPIO_J2_START;
-	case 19: return S5PC100_GPIO_J3_START;
-	case 20: return S5PC100_GPIO_J4_START;
-	default:
-		BUG();
-	}
-
-	return -EINVAL;
-}
-
 static int s5pc1xx_get_group(unsigned int irq)
 {
-	irq -= S3C_IRQ_GPIO(0);
-
-	switch (irq) {
-	case S5PC100_GPIO_A0_START ... S5PC100_GPIO_A1_START - 1:
-		return 0;
-	case S5PC100_GPIO_A1_START ... S5PC100_GPIO_B_START - 1:
-		return 1;
-	case S5PC100_GPIO_B_START ... S5PC100_GPIO_C_START - 1:
-		return 2;
-	case S5PC100_GPIO_C_START ... S5PC100_GPIO_D_START - 1:
-		return 3;
-	case S5PC100_GPIO_D_START ... S5PC100_GPIO_E0_START - 1:
-		return 4;
-	case S5PC100_GPIO_E0_START ... S5PC100_GPIO_E1_START - 1:
-		return 5;
-	case S5PC100_GPIO_E1_START ... S5PC100_GPIO_F0_START - 1:
-		return 6;
-	case S5PC100_GPIO_F0_START ... S5PC100_GPIO_F1_START - 1:
-		return 7;
-	case S5PC100_GPIO_F1_START ... S5PC100_GPIO_F2_START - 1:
-		return 8;
-	case S5PC100_GPIO_F2_START ... S5PC100_GPIO_F3_START - 1:
-		return 9;
-	case S5PC100_GPIO_F3_START ... S5PC100_GPIO_G0_START - 1:
-		return 10;
-	case S5PC100_GPIO_G0_START ... S5PC100_GPIO_G1_START - 1:
-		return 11;
-	case S5PC100_GPIO_G1_START ... S5PC100_GPIO_G2_START - 1:
-		return 12;
-	case S5PC100_GPIO_G2_START ... S5PC100_GPIO_G3_START - 1:
-		return 13;
-	case S5PC100_GPIO_G3_START ... S5PC100_GPIO_H0_START - 1:
-		return 14;
-	case S5PC100_GPIO_I_START ... S5PC100_GPIO_J0_START - 1:
-		return 15;
-	case S5PC100_GPIO_J0_START ... S5PC100_GPIO_J1_START - 1:
-		return 16;
-	case S5PC100_GPIO_J1_START ... S5PC100_GPIO_J2_START - 1:
-		return 17;
-	case S5PC100_GPIO_J2_START ... S5PC100_GPIO_J3_START - 1:
-		return 18;
-	case S5PC100_GPIO_J3_START ... S5PC100_GPIO_J4_START - 1:
-		return 19;
-	case S5PC100_GPIO_J4_START ... S5PC100_GPIO_K0_START - 1:
-		return 20;
-	default:
-		BUG();
-	}
-
+	struct gpio_chip *chip = get_irq_data(irq);
+	struct s3c_gpio_chip *s3c_chip = container_of(chip,
+					 struct s3c_gpio_chip, chip);
+	struct s5pc1xx_gpio_chip *s5pc1xx_chip = container_of(s3c_chip,
+						 struct s5pc1xx_gpio_chip,
+						 chip);
+
+	if (s5pc1xx_chip->gpio_group >= 0 &&
+	    s5pc1xx_chip->gpio_group < S5PC1XX_GPIO_INT_GROUP_END)
+		return s5pc1xx_chip->gpio_group;
+	BUG();
 	return -EINVAL;
 }
 
@@ -220,7 +153,6 @@ static int s5pc1xx_gpioint_set_type(unsigned int irq, unsigned int type)
 		BUG();
 	}
 
-
 	value = __raw_readl(S5PC1XX_GPIOREG(CON_OFFSET) + con_offset);
 	value &= ~(0xf << (offset * 0x4));
 	value |= (type << (offset * 0x4));
@@ -238,15 +170,15 @@ struct irq_chip s5pc1xx_gpioint = {
 	.set_type	= s5pc1xx_gpioint_set_type,
 };
 
+int s5pc1xx_gpioint_group_map[S5PC1XX_GPIO_INT_GROUP_END];
+
 void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 {
 	int group, offset, pend_offset, mask_offset;
-	int real_irq, group_end;
+	int real_irq;
 	unsigned int pend, mask;
 
-	group_end = 21;
-
-	for (group = 0; group < group_end; group++) {
+	for (group = 0; group < S5PC1XX_GPIO_INT_GROUP_END; group++) {
 		pend_offset = group_to_pend_offset(group);
 		pend = __raw_readl(S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
 		if (!pend)
@@ -258,7 +190,8 @@ void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
 
 		for (offset = 0; offset < 8; offset++) {
 			if (pend & (1 << offset)) {
-				real_irq = s5pc1xx_get_start(group) + offset;
+				real_irq = s5pc1xx_gpioint_group_map[group] +
+					   offset;
 				generic_handle_irq(S3C_IRQ_GPIO(real_irq));
 			}
 		}
-- 
1.6.4
