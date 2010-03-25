From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 25 Mar 2010 12:15:14 +0100
Subject: [PATCH 3/8] ARM: S5PV210: add gpiolib support
In-Reply-To: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
References: <1269515719-18519-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1269515719-18519-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for gpiolib calls. This is based on the gpiolib implementation
from mach-s5c6440/mach-s3c64xx directories.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Makefile                 |    2 +-
 arch/arm/mach-s5pv210/gpio.c                   |  375 ++++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/gpio.h      |   25 ++-
 arch/arm/mach-s5pv210/include/mach/regs-gpio.h |   59 ++++
 4 files changed, 458 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/gpio.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/regs-gpio.h

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 8ebf51c..cb1553c 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5PV210 system
 
-obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/gpio.c b/arch/arm/mach-s5pv210/gpio.c
new file mode 100644
index 0000000..4bfd21c
--- /dev/null
+++ b/arch/arm/mach-s5pv210/gpio.c
@@ -0,0 +1,375 @@
+/* arch/arm/mach-s5pv210/gpio.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5PV210/S5PC110 - GPIOlib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <mach/map.h>
+#include <mach/gpio.h>
+#include <mach/regs-gpio.h>
+#include <plat/gpio-core.h>
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
+
+#define OFF_GPCON	(0x00)
+#define OFF_GPDAT	(0x04)
+
+#define con_4bit_shift(__off) ((__off) * 4)
+
+#if 1
+#define gpio_dbg(x...) do { } while (0)
+#else
+#define gpio_dbg(x...) printk(KERN_DEBUG x)
+#endif
+
+static int s5pv210_gpiolib_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long con;
+
+	con = __raw_readl(base + OFF_GPCON);
+	con &= ~(0xf << con_4bit_shift(offset));
+	__raw_writel(con, base + OFF_GPCON);
+
+	gpio_dbg("%s: %p: CON now %08lx\n", __func__, base, con);
+
+	return 0;
+}
+
+static int s5pv210_gpiolib_output(struct gpio_chip *chip,
+				       unsigned offset, int value)
+{
+	struct s3c_gpio_chip *ourchip = to_s3c_gpio(chip);
+	void __iomem *base = ourchip->base;
+	unsigned long con;
+	unsigned long dat;
+
+	con = __raw_readl(base + OFF_GPCON);
+	con &= ~(0xf << con_4bit_shift(offset));
+	con |= 0x1 << con_4bit_shift(offset);
+
+	dat = __raw_readl(base + OFF_GPDAT);
+	if (value)
+		dat |= 1 << offset;
+	else
+		dat &= ~(1 << offset);
+
+	__raw_writel(dat, base + OFF_GPDAT);
+	__raw_writel(con, base + OFF_GPCON);
+	__raw_writel(dat, base + OFF_GPDAT);
+
+	gpio_dbg("%s: %p: CON %08lx, DAT %08lx\n", __func__, base, con, dat);
+
+	return 0;
+}
+
+static struct s3c_gpio_cfg s5pv210_gpio_cfgs[] = {
+	{
+		/* standard */
+		.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+		.set_pull	= s3c_gpio_setpull_updown,
+		.get_pull	= s3c_gpio_getpull_updown,
+	}, {
+		/* eint */
+		.cfg_eint	= 0xf,
+		.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+		.set_pull	= s3c_gpio_setpull_updown,
+		.get_pull	= s3c_gpio_getpull_updown,
+	}, {
+		/* noint */
+		.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+		.set_pull	= s3c_gpio_setpull_updown,
+		.get_pull	= s3c_gpio_getpull_updown,
+	},
+};
+
+static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
+	{
+		.base	= S5PV210_GPA0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPA0(0),
+			.ngpio	= S5PV210_GPIO_A0_NR,
+			.label	= "GPA0",
+		},
+	}, {
+		.base	= S5PV210_GPA1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPA1(0),
+			.ngpio	= S5PV210_GPIO_A1_NR,
+			.label	= "GPA1",
+		},
+	}, {
+		.base	= S5PV210_GPB_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPB(0),
+			.ngpio	= S5PV210_GPIO_B_NR,
+			.label	= "GPB",
+		},
+	}, {
+		.base	= S5PV210_GPC0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPC0(0),
+			.ngpio	= S5PV210_GPIO_C0_NR,
+			.label	= "GPC0",
+		},
+	}, {
+		.base	= S5PV210_GPC1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPC1(0),
+			.ngpio	= S5PV210_GPIO_C1_NR,
+			.label	= "GPC1",
+		},
+	}, {
+		.base	= S5PV210_GPD0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPD0(0),
+			.ngpio	= S5PV210_GPIO_D0_NR,
+			.label	= "GPD0",
+		},
+	}, {
+		.base	= S5PV210_GPD1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPD1(0),
+			.ngpio	= S5PV210_GPIO_D1_NR,
+			.label	= "GPD1",
+		},
+	}, {
+		.base	= S5PV210_GPE0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPE0(0),
+			.ngpio	= S5PV210_GPIO_E0_NR,
+			.label	= "GPE0",
+		},
+	}, {
+		.base	= S5PV210_GPE1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPE1(0),
+			.ngpio	= S5PV210_GPIO_E1_NR,
+			.label	= "GPE1",
+		},
+	}, {
+		.base	= S5PV210_GPF0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPF0(0),
+			.ngpio	= S5PV210_GPIO_F0_NR,
+			.label	= "GPF0",
+		},
+	}, {
+		.base	= S5PV210_GPF1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPF1(0),
+			.ngpio	= S5PV210_GPIO_F1_NR,
+			.label	= "GPF1",
+		},
+	}, {
+		.base	= S5PV210_GPF2_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPF2(0),
+			.ngpio	= S5PV210_GPIO_F2_NR,
+			.label	= "GPF2",
+		},
+	}, {
+		.base	= S5PV210_GPF3_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPF3(0),
+			.ngpio	= S5PV210_GPIO_F3_NR,
+			.label	= "GPF3",
+		},
+	}, {
+		.base	= S5PV210_GPG0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPG0(0),
+			.ngpio	= S5PV210_GPIO_G0_NR,
+			.label	= "GPG0",
+		},
+	}, {
+		.base	= S5PV210_GPG1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPG1(0),
+			.ngpio	= S5PV210_GPIO_G1_NR,
+			.label	= "GPG1",
+		},
+	}, {
+		.base	= S5PV210_GPG2_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPG2(0),
+			.ngpio	= S5PV210_GPIO_G2_NR,
+			.label	= "GPG2",
+		},
+	}, {
+		.base	= S5PV210_GPG3_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPG3(0),
+			.ngpio	= S5PV210_GPIO_G3_NR,
+			.label	= "GPG3",
+		},
+	}, {
+		.base	= S5PV210_GPH0_BASE,
+		.config	= &s5pv210_gpio_cfgs[1],
+		.chip	= {
+			.base	= S5PV210_GPH0(0),
+			.ngpio	= S5PV210_GPIO_H0_NR,
+			.label	= "GPH0",
+		},
+	}, {
+		.base	= S5PV210_GPH1_BASE,
+		.config	= &s5pv210_gpio_cfgs[1],
+		.chip	= {
+			.base	= S5PV210_GPH1(0),
+			.ngpio	= S5PV210_GPIO_H1_NR,
+			.label	= "GPH1",
+		},
+	}, {
+		.base	= S5PV210_GPH2_BASE,
+		.config	= &s5pv210_gpio_cfgs[1],
+		.chip	= {
+			.base	= S5PV210_GPH2(0),
+			.ngpio	= S5PV210_GPIO_H2_NR,
+			.label	= "GPH2",
+		},
+	}, {
+		.base	= S5PV210_GPH3_BASE,
+		.config	= &s5pv210_gpio_cfgs[1],
+		.chip	= {
+			.base	= S5PV210_GPH3(0),
+			.ngpio	= S5PV210_GPIO_H3_NR,
+			.label	= "GPH3",
+		},
+	}, {
+		.base	= S5PV210_GPI_BASE,
+		.config	= &s5pv210_gpio_cfgs[2],
+		.chip	= {
+			.base	= S5PV210_GPI(0),
+			.ngpio	= S5PV210_GPIO_I_NR,
+			.label	= "GPI",
+		},
+	}, {
+		.base	= S5PV210_GPJ0_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPJ0(0),
+			.ngpio	= S5PV210_GPIO_J0_NR,
+			.label	= "GPJ0",
+		},
+	}, {
+		.base	= S5PV210_GPJ1_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPJ1(0),
+			.ngpio	= S5PV210_GPIO_J1_NR,
+			.label	= "GPJ1",
+		},
+	}, {
+		.base	= S5PV210_GPJ2_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPJ2(0),
+			.ngpio	= S5PV210_GPIO_J2_NR,
+			.label	= "GPJ2",
+		},
+	}, {
+		.base	= S5PV210_GPJ3_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPJ3(0),
+			.ngpio	= S5PV210_GPIO_J3_NR,
+			.label	= "GPJ3",
+		},
+	}, {
+		.base	= S5PV210_GPJ4_BASE,
+		.config	= &s5pv210_gpio_cfgs[0],
+		.chip	= {
+			.base	= S5PV210_GPJ4(0),
+			.ngpio	= S5PV210_GPIO_J4_NR,
+			.label	= "GPJ4",
+		},
+	}, {
+		.base	= S5PV210_MP0_1_BASE,
+		.config	= &s5pv210_gpio_cfgs[2],
+		.chip	= {
+			.base	= S5PV210_MP0_1(0),
+			.ngpio	= S5PV210_GPIO_MP0_1_NR,
+			.label	= "MP0_1",
+		},
+	}, {
+		.base	= S5PV210_MP0_2_BASE,
+		.config	= &s5pv210_gpio_cfgs[2],
+		.chip	= {
+			.base	= S5PV210_MP0_2(0),
+			.ngpio	= S5PV210_GPIO_MP0_2_NR,
+			.label	= "MP0_2",
+		},
+	}, {
+		.base	= S5PV210_MP0_3_BASE,
+		.config	= &s5pv210_gpio_cfgs[2],
+		.chip	= {
+			.base	= S5PV210_MP0_3(0),
+			.ngpio	= S5PV210_GPIO_MP0_3_NR,
+			.label	= "MP0_3",
+		},
+	}, {
+		.base	= S5PV210_MP0_4_BASE,
+		.config	= &s5pv210_gpio_cfgs[2],
+		.chip	= {
+			.base	= S5PV210_MP0_4(0),
+			.ngpio	= S5PV210_GPIO_MP0_4_NR,
+			.label	= "MP0_4",
+		},
+	}, {
+		.base	= S5PV210_MP0_5_BASE,
+		.config	= &s5pv210_gpio_cfgs[2],
+		.chip	= {
+			.base	= S5PV210_MP0_5(0),
+			.ngpio	= S5PV210_GPIO_MP0_5_NR,
+			.label	= "MP0_5",
+		},
+	},
+};
+
+static void __init s5pv210_gpio_add(struct s3c_gpio_chip *chip, int nr_chips)
+{
+	for (; nr_chips > 0; nr_chips--, chip++) {
+		chip->chip.direction_input = s5pv210_gpiolib_input;
+		chip->chip.direction_output = s5pv210_gpiolib_output;
+		s3c_gpiolib_add(chip);
+	}
+}
+
+
+static int __init s5pv210_gpiolib_init(void)
+{
+	struct s3c_gpio_chip *chips = s5pv210_gpio_4bit;
+	int nr_chips = ARRAY_SIZE(s5pv210_gpio_4bit);
+
+	s5pv210_gpio_add(chips, nr_chips);
+
+	return 0;
+}
+arch_initcall(s5pv210_gpiolib_init);
diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index 533b020..d6046c7 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -46,6 +46,13 @@
 #define S5PV210_GPIO_J2_NR	(8)
 #define S5PV210_GPIO_J3_NR	(8)
 #define S5PV210_GPIO_J4_NR	(5)
+#define S5PV210_GPIO_MP0_1_NR	(8)
+#define S5PV210_GPIO_MP0_2_NR	(4)
+#define S5PV210_GPIO_MP0_3_NR	(8)
+#define S5PV210_GPIO_MP0_4_NR	(8)
+#define S5PV210_GPIO_MP0_5_NR	(8)
+#define S5PV210_GPIO_MP0_6_NR	(8)
+#define S5PV210_GPIO_MP0_7_NR	(8)
 
 /* GPIO bank numbers */
 
@@ -85,6 +92,14 @@ enum s5p_gpio_number {
 	S5PV210_GPIO_J2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J1),
 	S5PV210_GPIO_J3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J2),
 	S5PV210_GPIO_J4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J3),
+	S5PV210_GPIO_MP0_1_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_J4),
+	S5PV210_GPIO_MP0_2_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_1),
+	S5PV210_GPIO_MP0_3_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_2),
+	S5PV210_GPIO_MP0_4_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_3),
+	S5PV210_GPIO_MP0_5_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_4),
+	S5PV210_GPIO_MP0_6_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_5),
+	S5PV210_GPIO_MP0_7_START	= S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_6),
+	S5PV210_GPIO_END        = S5PV210_GPIO_NEXT(S5PV210_GPIO_MP0_7),
 };
 
 /* S5PV210 GPIO number definitions */
@@ -115,13 +130,19 @@ enum s5p_gpio_number {
 #define S5PV210_GPJ2(_nr)	(S5PV210_GPIO_J2_START + (_nr))
 #define S5PV210_GPJ3(_nr)	(S5PV210_GPIO_J3_START + (_nr))
 #define S5PV210_GPJ4(_nr)	(S5PV210_GPIO_J4_START + (_nr))
+#define S5PV210_MP0_1(_nr)	(S5PV210_GPIO_MP0_1_START + (_nr))
+#define S5PV210_MP0_2(_nr)	(S5PV210_GPIO_MP0_2_START + (_nr))
+#define S5PV210_MP0_3(_nr)	(S5PV210_GPIO_MP0_3_START + (_nr))
+#define S5PV210_MP0_4(_nr)	(S5PV210_GPIO_MP0_4_START + (_nr))
+#define S5PV210_MP0_5(_nr)	(S5PV210_GPIO_MP0_5_START + (_nr))
+#define S5PV210_MP0_6(_nr)	(S5PV210_GPIO_MP0_6_START + (_nr))
+#define S5PV210_MP0_7(_nr)	(S5PV210_GPIO_MP0_7_START + (_nr))
 
 /* the end of the S5PV210 specific gpios */
-#define S5PV210_GPIO_END	(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) + 1)
 #define S3C_GPIO_END		S5PV210_GPIO_END
 
 /* define the number of gpios we need to the one after the GPJ4() range */
-#define ARCH_NR_GPIOS		(S5PV210_GPJ4(S5PV210_GPIO_J4_NR) +	\
+#define ARCH_NR_GPIOS		(S5PV210_GPIO_END + \
 				 CONFIG_SAMSUNG_GPIO_EXTRA + 1)
 
 #include <asm-generic/gpio.h>
diff --git a/arch/arm/mach-s5pv210/include/mach/regs-gpio.h b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
new file mode 100644
index 0000000..24e4b7f
--- /dev/null
+++ b/arch/arm/mach-s5pv210/include/mach/regs-gpio.h
@@ -0,0 +1,59 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC210/S5PC110 - GPIO register definitions
+ */
+
+#ifndef __ASM_PLAT_S5PC1XX_REGS_GPIO_H
+#define __ASM_PLAT_S5PC1XX_REGS_GPIO_H __FILE__
+
+#include <mach/map.h>
+
+#define S5PV210_GPIO_BASE	S5P_VA_GPIO
+#define S5PV210_GPA0_BASE	(S5PV210_GPIO_BASE + 0x0000)
+#define S5PV210_GPA1_BASE	(S5PV210_GPIO_BASE + 0x0020)
+#define S5PV210_GPB_BASE	(S5PV210_GPIO_BASE + 0x0040)
+#define S5PV210_GPC0_BASE	(S5PV210_GPIO_BASE + 0x0060)
+#define S5PV210_GPC1_BASE	(S5PV210_GPIO_BASE + 0x0080)
+#define S5PV210_GPD0_BASE	(S5PV210_GPIO_BASE + 0x00A0)
+#define S5PV210_GPD1_BASE	(S5PV210_GPIO_BASE + 0x00C0)
+#define S5PV210_GPE0_BASE	(S5PV210_GPIO_BASE + 0x00E0)
+#define S5PV210_GPE1_BASE	(S5PV210_GPIO_BASE + 0x0100)
+#define S5PV210_GPF0_BASE	(S5PV210_GPIO_BASE + 0x0120)
+#define S5PV210_GPF1_BASE	(S5PV210_GPIO_BASE + 0x0140)
+#define S5PV210_GPF2_BASE	(S5PV210_GPIO_BASE + 0x0160)
+#define S5PV210_GPF3_BASE	(S5PV210_GPIO_BASE + 0x0180)
+#define S5PV210_GPG0_BASE	(S5PV210_GPIO_BASE + 0x01A0)
+#define S5PV210_GPG1_BASE	(S5PV210_GPIO_BASE + 0x01C0)
+#define S5PV210_GPG2_BASE	(S5PV210_GPIO_BASE + 0x01E0)
+#define S5PV210_GPG3_BASE	(S5PV210_GPIO_BASE + 0x0200)
+#define S5PV210_GPH0_BASE	(S5PV210_GPIO_BASE + 0x0C00)
+#define S5PV210_GPH1_BASE	(S5PV210_GPIO_BASE + 0x0C20)
+#define S5PV210_GPH2_BASE	(S5PV210_GPIO_BASE + 0x0C40)
+#define S5PV210_GPH3_BASE	(S5PV210_GPIO_BASE + 0x0C60)
+#define S5PV210_GPI_BASE	(S5PV210_GPIO_BASE + 0x0220)
+#define S5PV210_GPJ0_BASE	(S5PV210_GPIO_BASE + 0x0240)
+#define S5PV210_GPJ1_BASE	(S5PV210_GPIO_BASE + 0x0260)
+#define S5PV210_GPJ2_BASE	(S5PV210_GPIO_BASE + 0x0280)
+#define S5PV210_GPJ3_BASE	(S5PV210_GPIO_BASE + 0x02A0)
+#define S5PV210_GPJ4_BASE	(S5PV210_GPIO_BASE + 0x02C0)
+#define S5PV210_MP0_1_BASE	(S5PV210_GPIO_BASE + 0x02E0)
+#define S5PV210_MP0_2_BASE	(S5PV210_GPIO_BASE + 0x0300)
+#define S5PV210_MP0_3_BASE	(S5PV210_GPIO_BASE + 0x0320)
+#define S5PV210_MP0_4_BASE	(S5PV210_GPIO_BASE + 0x0340)
+#define S5PV210_MP0_5_BASE	(S5PV210_GPIO_BASE + 0x0360)
+#define S5PV210_MP0_6_BASE	(S5PV210_GPIO_BASE + 0x0380)
+#define S5PV210_MP0_7_BASE	(S5PV210_GPIO_BASE + 0x03A0)
+#define S5PV210_EXT_INT_BASE	(S5PV210_GPIO_BASE + 0x0E00)
+#define S5PV210_PDNEN		(S5PV210_GPIO_BASE + 0x0F80)
+#define S5PC100_PDNEN_NORMAL	(0 << 0)
+
+#define S5PV210_PDNEN_CFG_PDNEN	(1 << 1)
+#define S5PV210_PDNEN_CFG_AUTO	(0 << 1)
+#define S5PV210_PDNEN_POWERDOWN	(1 << 0)
+#define S5PV210_PDNEN_NORMAL	(0 << 0)
+
+#endif /* __ASM_PLAT_S5PC1XX_REGS_GPIO_H */
+
-- 
1.6.4
