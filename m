From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:33 +0100
Subject: [PATCH 15/21] ARM: S5PC1XX: add support for s5pc110 gpio
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-16-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds gpiolib support for S5PC110 sub-platform.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Byungho Min <bhmin@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc110/Makefile                 |    1 +
 arch/arm/mach-s5pc110/gpio-chips.c             |   66 +++++++++
 arch/arm/mach-s5pc110/include/mach/gpio.h      |  187 ++++++++++++++++++++++++
 arch/arm/mach-s5pc110/include/plat/regs-gpio.h |   65 ++++++++
 4 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/gpio-chips.c
 create mode 100644 arch/arm/mach-s5pc110/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5pc110/include/plat/regs-gpio.h

diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
index 4dfb306..3849e27 100644
--- a/arch/arm/mach-s5pc110/Makefile
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -13,6 +13,7 @@ obj-                            :=
 
 obj-$(CONFIG_CPU_S5PC110)	+= cpu.o
 obj-$(CONFIG_CPU_S5PC110)	+= clocks.o
+obj-$(CONFIG_CPU_S5PC110)	+= gpio-chips.o
 obj-$(CONFIG_CPU_S5PC110)	+= plls.o
 obj-$(CONFIG_CPU_S5PC110)	+= uarts.o
 
diff --git a/arch/arm/mach-s5pc110/gpio-chips.c b/arch/arm/mach-s5pc110/gpio-chips.c
new file mode 100644
index 0000000..4f1e591
--- /dev/null
+++ b/arch/arm/mach-s5pc110/gpio-chips.c
@@ -0,0 +1,66 @@
+/*
+ * linux/arch/arm/mach-s5pc110/gpio-chips.c
+ *
+ *  Copyright 2009 Samsung Electronics Co
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *  Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * S5PC110 - GPIOlib chip definitions
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
+static struct s5pc1xx_gpio_chip s5pc110_gpio_chips[] = {
+	S5PC1XX_INT_CHIP_DEF(S5PC110, A0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, A1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, B),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, C0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, C1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, D0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, D1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, E0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, E1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, F0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, F1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, F2),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, F3),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, G0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, G1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, G2),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, G3),
+	S5PC1XX_EINT_CHIP_DEF(S5PC110, H0),
+	S5PC1XX_EINT_CHIP_DEF(S5PC110, H1),
+	S5PC1XX_EINT_CHIP_DEF(S5PC110, H2),
+	S5PC1XX_EINT_CHIP_DEF(S5PC110, H3),
+	S5PC1XX_NOINT_CHIP_DEF(S5PC110, I),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, J0),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, J1),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, J2),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, J3),
+	S5PC1XX_INT_CHIP_DEF(S5PC110, J4),
+	S5PC1XX_MP_CHIP_DEF(S5PC110, MP0_1),
+	S5PC1XX_MP_CHIP_DEF(S5PC110, MP0_2),
+	S5PC1XX_MP_CHIP_DEF(S5PC110, MP0_3),
+	S5PC1XX_MP_CHIP_DEF(S5PC110, MP0_4),
+	S5PC1XX_MP_CHIP_DEF(S5PC110, MP0_5),
+};
+
+struct s5pc1xx_gpio s5pc1xx_gpio_chips = {
+	.chips = s5pc110_gpio_chips,
+	.count = ARRAY_SIZE(s5pc110_gpio_chips),
+};
diff --git a/arch/arm/mach-s5pc110/include/mach/gpio.h b/arch/arm/mach-s5pc110/include/mach/gpio.h
new file mode 100644
index 0000000..ae36f1e
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/mach/gpio.h
@@ -0,0 +1,187 @@
+/* arch/arm/mach-s5pc110/include/mach/gpio.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC110 - GPIO lib support
+ *
+ * Base on mach-s3c6400/include/mach/gpio.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+
+/* GPIO bank sizes */
+#define S5PC110_GPIO_A0_NR	(8)
+#define S5PC110_GPIO_A1_NR	(8)
+#define S5PC110_GPIO_B_NR	(8)
+#define S5PC110_GPIO_C0_NR	(8)
+#define S5PC110_GPIO_C1_NR	(8)
+#define S5PC110_GPIO_D0_NR	(8)
+#define S5PC110_GPIO_D1_NR	(8)
+#define S5PC110_GPIO_E0_NR	(8)
+#define S5PC110_GPIO_E1_NR	(8)
+#define S5PC110_GPIO_F0_NR	(8)
+#define S5PC110_GPIO_F1_NR	(8)
+#define S5PC110_GPIO_F2_NR	(8)
+#define S5PC110_GPIO_F3_NR	(8)
+#define S5PC110_GPIO_G0_NR	(8)
+#define S5PC110_GPIO_G1_NR	(8)
+#define S5PC110_GPIO_G2_NR	(8)
+#define S5PC110_GPIO_G3_NR	(8)
+#define S5PC110_GPIO_H0_NR	(8)
+#define S5PC110_GPIO_H1_NR	(8)
+#define S5PC110_GPIO_H2_NR	(8)
+#define S5PC110_GPIO_H3_NR	(8)
+#define S5PC110_GPIO_I_NR	(8)
+#define S5PC110_GPIO_J0_NR	(8)
+#define S5PC110_GPIO_J1_NR	(8)
+#define S5PC110_GPIO_J2_NR	(8)
+#define S5PC110_GPIO_J3_NR	(8)
+#define S5PC110_GPIO_J4_NR	(8)
+#define S5PC110_GPIO_MP0_1_NR	(8)
+#define S5PC110_GPIO_MP0_2_NR	(8)
+#define S5PC110_GPIO_MP0_3_NR	(8)
+#define S5PC110_GPIO_MP0_4_NR	(8)
+#define S5PC110_GPIO_MP0_5_NR	(8)
+#define S5PC110_GPIO_MP0_6_NR	(8)
+
+/* GPIO bank numbes */
+
+/* CONFIG_S3C_GPIO_SPACE allows the user to select extra
+ * space for debugging purposes so that any accidental
+ * change from one gpio bank to another can be caught.
+*/
+
+#define S5PC1XX_GPIO_NEXT(__gpio) \
+	((__gpio##_START) + (__gpio##_NR) + CONFIG_S3C_GPIO_SPACE + 1)
+
+enum s5pc110_gpio_number {
+	S5PC110_GPIO_A0_START	= 0,
+	S5PC110_GPIO_A1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_A0),
+	S5PC110_GPIO_B_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_A1),
+	S5PC110_GPIO_C0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_B),
+	S5PC110_GPIO_C1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_C0),
+	S5PC110_GPIO_D0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_C1),
+	S5PC110_GPIO_D1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_D0),
+	S5PC110_GPIO_E0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_D1),
+	S5PC110_GPIO_E1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_E0),
+	S5PC110_GPIO_F0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_E1),
+	S5PC110_GPIO_F1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F0),
+	S5PC110_GPIO_F2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F1),
+	S5PC110_GPIO_F3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F2),
+	S5PC110_GPIO_G0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_F3),
+	S5PC110_GPIO_G1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G0),
+	S5PC110_GPIO_G2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G1),
+	S5PC110_GPIO_G3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G2),
+	S5PC110_GPIO_H0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_G3),
+	S5PC110_GPIO_H1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H0),
+	S5PC110_GPIO_H2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H1),
+	S5PC110_GPIO_H3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H2),
+	S5PC110_GPIO_I_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_H3),
+	S5PC110_GPIO_J0_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_I),
+	S5PC110_GPIO_J1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J0),
+	S5PC110_GPIO_J2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J1),
+	S5PC110_GPIO_J3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J2),
+	S5PC110_GPIO_J4_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J3),
+	S5PC110_GPIO_MP0_1_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_J4),
+	S5PC110_GPIO_MP0_2_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_1),
+	S5PC110_GPIO_MP0_3_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_2),
+	S5PC110_GPIO_MP0_4_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_3),
+	S5PC110_GPIO_MP0_5_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_4),
+	S5PC110_GPIO_MP0_6_START	= S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_5),
+	S5PC110_GPIO_END        = S5PC1XX_GPIO_NEXT(S5PC110_GPIO_MP0_6),
+};
+
+#define S5PC110_GPA0(_nr)	(S5PC110_GPIO_A0_START + (_nr))
+#define S5PC110_GPA1(_nr)	(S5PC110_GPIO_A1_START + (_nr))
+#define S5PC110_GPB(_nr)	(S5PC110_GPIO_B_START + (_nr))
+#define S5PC110_GPC0(_nr)	(S5PC110_GPIO_C0_START + (_nr))
+#define S5PC110_GPC1(_nr)	(S5PC110_GPIO_C1_START + (_nr))
+#define S5PC110_GPD0(_nr)	(S5PC110_GPIO_D0_START + (_nr))
+#define S5PC110_GPD1(_nr)	(S5PC110_GPIO_D1_START + (_nr))
+#define S5PC110_GPE0(_nr)	(S5PC110_GPIO_E0_START + (_nr))
+#define S5PC110_GPE1(_nr)	(S5PC110_GPIO_E1_START + (_nr))
+#define S5PC110_GPF0(_nr)	(S5PC110_GPIO_F0_START + (_nr))
+#define S5PC110_GPF1(_nr)	(S5PC110_GPIO_F1_START + (_nr))
+#define S5PC110_GPF2(_nr)	(S5PC110_GPIO_F2_START + (_nr))
+#define S5PC110_GPF3(_nr)	(S5PC110_GPIO_F3_START + (_nr))
+#define S5PC110_GPG0(_nr)	(S5PC110_GPIO_G0_START + (_nr))
+#define S5PC110_GPG1(_nr)	(S5PC110_GPIO_G1_START + (_nr))
+#define S5PC110_GPG2(_nr)	(S5PC110_GPIO_G2_START + (_nr))
+#define S5PC110_GPG3(_nr)	(S5PC110_GPIO_G3_START + (_nr))
+#define S5PC110_GPH0(_nr)	(S5PC110_GPIO_H0_START + (_nr))
+#define S5PC110_GPH1(_nr)	(S5PC110_GPIO_H1_START + (_nr))
+#define S5PC110_GPH2(_nr)	(S5PC110_GPIO_H2_START + (_nr))
+#define S5PC110_GPH3(_nr)	(S5PC110_GPIO_H3_START + (_nr))
+#define S5PC110_GPI(_nr)	(S5PC110_GPIO_I_START + (_nr))
+#define S5PC110_GPJ0(_nr)	(S5PC110_GPIO_J0_START + (_nr))
+#define S5PC110_GPJ1(_nr)	(S5PC110_GPIO_J1_START + (_nr))
+#define S5PC110_GPJ2(_nr)	(S5PC110_GPIO_J2_START + (_nr))
+#define S5PC110_GPJ3(_nr)	(S5PC110_GPIO_J3_START + (_nr))
+#define S5PC110_GPJ4(_nr)	(S5PC110_GPIO_J4_START + (_nr))
+#define S5PC110_MP0_1(_nr)	(S5PC110_GPIO_MP0_1_START + (_nr))
+#define S5PC110_MP0_2(_nr)	(S5PC110_GPIO_MP0_2_START + (_nr))
+#define S5PC110_MP0_3(_nr)	(S5PC110_GPIO_MP0_3_START + (_nr))
+#define S5PC110_MP0_4(_nr)	(S5PC110_GPIO_MP0_4_START + (_nr))
+#define S5PC110_MP0_5(_nr)	(S5PC110_GPIO_MP0_5_START + (_nr))
+#define S5PC110_MP0_6(_nr)	(S5PC110_GPIO_MP0_6_START + (_nr))
+
+/* It used the end of the S5PC100 gpios */
+#define S3C_GPIO_END		S5PC110_GPIO_END
+
+/* define the number of gpios we need to the one after the MP05() range */
+#define ARCH_NR_GPIOS		(S5PC110_GPIO_END + 1)
+
+/* Offset of the bank in the interrupt group registers */
+#define S5PC110_GPIO_A0_INT_GROUP	(0)
+#define S5PC110_GPIO_A1_INT_GROUP	(1)
+#define S5PC110_GPIO_B_INT_GROUP	(2)
+#define S5PC110_GPIO_C0_INT_GROUP	(3)
+#define S5PC110_GPIO_C1_INT_GROUP	(4)
+#define S5PC110_GPIO_D0_INT_GROUP	(5)
+#define S5PC110_GPIO_D1_INT_GROUP	(6)
+#define S5PC110_GPIO_E0_INT_GROUP	(7)
+#define S5PC110_GPIO_E1_INT_GROUP	(8)
+#define S5PC110_GPIO_F0_INT_GROUP	(9)
+#define S5PC110_GPIO_F1_INT_GROUP	(10)
+#define S5PC110_GPIO_F2_INT_GROUP	(11)
+#define S5PC110_GPIO_F3_INT_GROUP	(12)
+#define S5PC110_GPIO_G0_INT_GROUP	(13)
+#define S5PC110_GPIO_G1_INT_GROUP	(14)
+#define S5PC110_GPIO_G2_INT_GROUP	(15)
+#define S5PC110_GPIO_G3_INT_GROUP	(16)
+#define S5PC110_GPIO_J0_INT_GROUP	(17)
+#define S5PC110_GPIO_J1_INT_GROUP	(18)
+#define S5PC110_GPIO_J2_INT_GROUP	(19)
+#define S5PC110_GPIO_J3_INT_GROUP	(20)
+#define S5PC110_GPIO_J4_INT_GROUP	(21)
+#define S5PC110_GPIO_H0_INT_GROUP	(-1)
+#define S5PC110_GPIO_H1_INT_GROUP	(-1)
+#define S5PC110_GPIO_H2_INT_GROUP	(-1)
+#define S5PC110_GPIO_H3_INT_GROUP	(-1)
+#define S5PC110_GPIO_I_INT_GROUP	(-1)
+#define S5PC110_GPIO_MP0_1_INT_GROUP	(-1)
+#define S5PC110_GPIO_MP0_2_INT_GROUP	(-1)
+#define S5PC110_GPIO_MP0_3_INT_GROUP	(-1)
+#define S5PC110_GPIO_MP0_4_INT_GROUP	(-1)
+#define S5PC110_GPIO_MP0_5_INT_GROUP	(-1)
+#define S5PC110_GPIO_MP0_6_INT_GROUP	(-1)
+
+#define S5PC110_GPIO_INT_GROUP_END	(S5PC110_GPIO_J4_INT_GROUP + 1)
+
+/* Common compatibility defines */
+#define S5PC1XX_GPIO_EINT_SFN	S3C_GPIO_SFN(0xf)
+#define S5PC1XX_GPH0(n)		S5PC110_GPH0(n)
+#define S5PC1XX_GPH1(n)		S5PC110_GPH1(n)
+#define S5PC1XX_GPH2(n)		S5PC110_GPH2(n)
+#define S5PC1XX_GPH3(n)		S5PC110_GPH3(n)
+#define S5PC1XX_GPIO_INT_GROUP_END	S5PC110_GPIO_INT_GROUP_END
+
+#include <asm-generic/gpio.h>
diff --git a/arch/arm/mach-s5pc110/include/plat/regs-gpio.h b/arch/arm/mach-s5pc110/include/plat/regs-gpio.h
new file mode 100644
index 0000000..24663b8
--- /dev/null
+++ b/arch/arm/mach-s5pc110/include/plat/regs-gpio.h
@@ -0,0 +1,65 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC110 - GPIO register definitions
+ */
+
+#ifndef __ASM_PLAT_S5PC1XX_REGS_GPIO_H
+#define __ASM_PLAT_S5PC1XX_REGS_GPIO_H __FILE__
+
+#include <mach/map.h>
+
+/* S5PC110 */
+#define S5PC110_GPIO_BASE	S5PC1XX_VA_GPIO
+#define S5PC110_GPA0_BASE	(S5PC110_GPIO_BASE + 0x0000)
+#define S5PC110_GPA1_BASE	(S5PC110_GPIO_BASE + 0x0020)
+#define S5PC110_GPB_BASE	(S5PC110_GPIO_BASE + 0x0040)
+#define S5PC110_GPC0_BASE	(S5PC110_GPIO_BASE + 0x0060)
+#define S5PC110_GPC1_BASE	(S5PC110_GPIO_BASE + 0x0080)
+#define S5PC110_GPD0_BASE	(S5PC110_GPIO_BASE + 0x00A0)
+#define S5PC110_GPD1_BASE	(S5PC110_GPIO_BASE + 0x00C0)
+#define S5PC110_GPE0_BASE	(S5PC110_GPIO_BASE + 0x00E0)
+#define S5PC110_GPE1_BASE	(S5PC110_GPIO_BASE + 0x0100)
+#define S5PC110_GPF0_BASE	(S5PC110_GPIO_BASE + 0x0120)
+#define S5PC110_GPF1_BASE	(S5PC110_GPIO_BASE + 0x0140)
+#define S5PC110_GPF2_BASE	(S5PC110_GPIO_BASE + 0x0160)
+#define S5PC110_GPF3_BASE	(S5PC110_GPIO_BASE + 0x0180)
+#define S5PC110_GPG0_BASE	(S5PC110_GPIO_BASE + 0x01A0)
+#define S5PC110_GPG1_BASE	(S5PC110_GPIO_BASE + 0x01C0)
+#define S5PC110_GPG2_BASE	(S5PC110_GPIO_BASE + 0x01E0)
+#define S5PC110_GPG3_BASE	(S5PC110_GPIO_BASE + 0x0200)
+#define S5PC110_GPH0_BASE	(S5PC110_GPIO_BASE + 0x0C00)
+#define S5PC110_GPH1_BASE	(S5PC110_GPIO_BASE + 0x0C20)
+#define S5PC110_GPH2_BASE	(S5PC110_GPIO_BASE + 0x0C40)
+#define S5PC110_GPH3_BASE	(S5PC110_GPIO_BASE + 0x0C60)
+#define S5PC110_GPI_BASE	(S5PC110_GPIO_BASE + 0x0220)
+#define S5PC110_GPJ0_BASE	(S5PC110_GPIO_BASE + 0x0240)
+#define S5PC110_GPJ1_BASE	(S5PC110_GPIO_BASE + 0x0260)
+#define S5PC110_GPJ2_BASE	(S5PC110_GPIO_BASE + 0x0280)
+#define S5PC110_GPJ3_BASE	(S5PC110_GPIO_BASE + 0x02A0)
+#define S5PC110_GPJ4_BASE	(S5PC110_GPIO_BASE + 0x02C0)
+#define S5PC110_MP0_1_BASE	(S5PC110_GPIO_BASE + 0x02E0)
+#define S5PC110_MP0_2_BASE	(S5PC110_GPIO_BASE + 0x0300)
+#define S5PC110_MP0_3_BASE	(S5PC110_GPIO_BASE + 0x0320)
+#define S5PC110_MP0_4_BASE	(S5PC110_GPIO_BASE + 0x0340)
+#define S5PC110_MP0_5_BASE	(S5PC110_GPIO_BASE + 0x0360)
+#define S5PC110_EXT_INT_BASE	(S5PC110_GPIO_BASE + 0x0E00)
+#define S5PC110_PDNEN		(S5PC110_GPIO_BASE + 0x0F80)
+#define S5PC100_PDNEN_NORMAL	(0 << 0)
+
+#define S5PC110_PDNEN_CFG_PDNEN	(1 << 1)
+#define S5PC110_PDNEN_CFG_AUTO	(0 << 1)
+#define S5PC110_PDNEN_POWERDOWN	(1 << 0)
+#define S5PC110_PDNEN_NORMAL	(0 << 0)
+
+/* Common part */
+#define S5PC1XX_EINT_BASE	(S5PC110_EXT_INT_BASE)
+
+#define S5PC1XX_GPx_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
+#define S5PC1XX_GPx_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
+#define S5PC1XX_GPx_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
+
+#endif /* __ASM_PLAT_S5PC1XX_REGS_GPIO_H */
+
-- 
1.6.4
