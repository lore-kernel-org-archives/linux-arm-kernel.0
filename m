From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 12 Nov 2009 09:21:51 +0100
Subject: [PATCH 07/18] ARM: S5PC1xx: add gpiolib and external/gpio interrupt
	support
In-Reply-To: <1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-3-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-4-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-5-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-6-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258014122-18185-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

From: Kyungmin Park <kyungmin.park@samsung.com>

Add support for gpiolib calls. This is based on the gpiolib implementation
from plat-s3c64xx tree.
Add support for external interrupts for GPIO H banks.
Add support for GPIO interrupts for all banks.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-s3c/Kconfig                          |    6 +
 arch/arm/plat-s3c/include/plat/gpio-cfg.h          |    1 +
 arch/arm/plat-s5pc1xx/Kconfig                      |    3 +
 arch/arm/plat-s5pc1xx/Makefile                     |    4 +-
 arch/arm/plat-s5pc1xx/cpu.c                        |    5 +
 arch/arm/plat-s5pc1xx/gpio-config.c                |   60 +++
 arch/arm/plat-s5pc1xx/gpiolib.c                    |  503 ++++++++++++++++++++
 .../plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h   |   32 ++
 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h      |   44 ++
 arch/arm/plat-s5pc1xx/include/plat/irqs.h          |   15 +-
 arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h     |   70 +++
 arch/arm/plat-s5pc1xx/irq-eint.c                   |  281 +++++++++++
 arch/arm/plat-s5pc1xx/irq-gpio.c                   |  266 +++++++++++
 arch/arm/plat-s5pc1xx/irq.c                        |    2 +-
 14 files changed, 1287 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-s5pc1xx/gpio-config.c
 create mode 100644 arch/arm/plat-s5pc1xx/gpiolib.c
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
 create mode 100644 arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
 create mode 100644 arch/arm/plat-s5pc1xx/irq-eint.c
 create mode 100644 arch/arm/plat-s5pc1xx/irq-gpio.c

diff --git a/arch/arm/plat-s3c/Kconfig b/arch/arm/plat-s3c/Kconfig
index 8931c5f..f155a84 100644
--- a/arch/arm/plat-s3c/Kconfig
+++ b/arch/arm/plat-s3c/Kconfig
@@ -159,6 +159,12 @@ config S3C_GPIO_CFG_S3C64XX
 	  Internal configuration to enable S3C64XX style GPIO configuration
 	  functions.
 
+config S5P_GPIO_CFG_S5PC1XX
+	bool
+	help
+	  Internal configuration to enable S5PC1XX style GPIO configuration
+	  functions.
+
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-s3c/include/plat/gpio-cfg.h b/arch/arm/plat-s3c/include/plat/gpio-cfg.h
index 29cd6a8..7e73429 100644
--- a/arch/arm/plat-s3c/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-s3c/include/plat/gpio-cfg.h
@@ -62,6 +62,7 @@ struct s3c_gpio_cfg {
 #define S3C_GPIO_INPUT	(S3C_GPIO_SPECIAL(0))
 #define S3C_GPIO_OUTPUT	(S3C_GPIO_SPECIAL(1))
 #define S3C_GPIO_SFN(x)	(S3C_GPIO_SPECIAL(x))
+#define S3C_GPIO_IRQ	(S3C_GPIO_SPECIAL(0xf))
 
 #define s3c_gpio_is_cfg_special(_cfg) \
 	(((_cfg) & S3C_GPIO_SPECIAL_MARK) == S3C_GPIO_SPECIAL_MARK)
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index a8a711c..86edd27 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -15,6 +15,9 @@ config PLAT_S5PC1XX
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_GPIO_TRACK
 	select S3C_GPIO_PULL_UPDOWN
+	select S3C_GPIO_CFG_S3C24XX
+	select S3C_GPIO_CFG_S3C64XX
+	select S5P_GPIO_CFG_S5PC1XX
 	help
 	  Base platform code for any Samsung S5PC1XX device
 
diff --git a/arch/arm/plat-s5pc1xx/Makefile b/arch/arm/plat-s5pc1xx/Makefile
index ebbf364..e860813 100644
--- a/arch/arm/plat-s5pc1xx/Makefile
+++ b/arch/arm/plat-s5pc1xx/Makefile
@@ -13,8 +13,9 @@ obj-				:=
 
 obj-y				+= dev-uart.o
 obj-y				+= cpu.o
-obj-y				+= irq.o
+obj-y				+= irq.o irq-gpio.o irq-eint.o
 obj-y				+= clock.o
+obj-y				+= gpiolib.o
 
 # CPU support
 
@@ -23,5 +24,6 @@ obj-$(CONFIG_CPU_S5PC100_CLOCK)	+= s5pc100-clock.o
 
 # Device setup
 
+obj-$(CONFIG_S5P_GPIO_CFG_S5PC1XX) += gpio-config.o
 obj-$(CONFIG_S5PC100_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S5PC100_SETUP_I2C1) += setup-i2c1.o
diff --git a/arch/arm/plat-s5pc1xx/cpu.c b/arch/arm/plat-s5pc1xx/cpu.c
index e8f3472..02baeaa 100644
--- a/arch/arm/plat-s5pc1xx/cpu.c
+++ b/arch/arm/plat-s5pc1xx/cpu.c
@@ -60,6 +60,11 @@ static struct map_desc s5pc1xx_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type		= MT_DEVICE,
 	}, {
+		.virtual	= (unsigned long)S5PC1XX_VA_GPIO,
+		.pfn		= __phys_to_pfn(S5PC100_PA_GPIO),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	}, {
 		.virtual	= (unsigned long)S5PC1XX_VA_CHIPID,
 		.pfn		= __phys_to_pfn(S5PC1XX_PA_CHIPID),
 		.length		= SZ_16,
diff --git a/arch/arm/plat-s5pc1xx/gpio-config.c b/arch/arm/plat-s5pc1xx/gpio-config.c
new file mode 100644
index 0000000..1f36581
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/gpio-config.c
@@ -0,0 +1,60 @@
+/* linux/arch/arm/plat-s5pc1xx/gpio-config.c
+ *
+ * Copyright 2009 Samsung Electronics
+ *
+ * S5PC1XX GPIO Configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+
+#include <mach/gpio-core.h>
+#include <plat/gpio-cfg-s5pc1xx.h>
+
+s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin, unsigned int off)
+{
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	void __iomem *reg;
+	int shift = off * 2;
+	u32 drvstr;
+
+	if (!chip)
+		return -EINVAL;
+
+	reg = chip->base + 0x0C;
+
+	drvstr = __raw_readl(reg);
+	drvstr = 0xffff & (0x3 << shift);
+	drvstr = drvstr >> shift;
+
+	return (__force s5p_gpio_drvstr_t)drvstr;
+}
+EXPORT_SYMBOL(s5p_gpio_get_drvstr);
+
+int s5p_gpio_set_drvstr(unsigned int pin, unsigned int off,
+			s5p_gpio_drvstr_t drvstr)
+{
+	struct s3c_gpio_chip *chip = s3c_gpiolib_getchip(pin);
+	void __iomem *reg;
+	int shift = off * 2;
+	u32 tmp;
+
+	if (!chip)
+		return -EINVAL;
+
+	reg = chip->base + 0x0C;
+
+	tmp = __raw_readl(reg);
+	tmp |= drvstr << shift;
+
+	__raw_writel(tmp, reg);
+
+	return 0;
+}
+EXPORT_SYMBOL(s5p_gpio_set_drvstr);
diff --git a/arch/arm/plat-s5pc1xx/gpiolib.c b/arch/arm/plat-s5pc1xx/gpiolib.c
new file mode 100644
index 0000000..9da8efc
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/gpiolib.c
@@ -0,0 +1,503 @@
+/*
+ * arch/arm/plat-s5pc1xx/gpiolib.c
+ *
+ *  Copyright 2009 Samsung Electronics Co
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * S5PC1XX - GPIOlib support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+#include <mach/gpio.h>
+#include <mach/gpio-core.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-cfg-helpers.h>
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
+/* The s5pc1xx_gpiolib routines are to control the gpio banks where
+ * the gpio configuration register (GPxCON) has 4 bits per GPIO, as the
+ * following example:
+ *
+ * base + 0x00: Control register, 4 bits per gpio
+ *	        gpio n: 4 bits starting at (4*n)
+ *		0000 = input, 0001 = output, others mean special-function
+ * base + 0x04: Data register, 1 bit per gpio
+ *		bit n: data bit n
+ *
+ * Note, since the data register is one bit per gpio and is at base + 0x4
+ * we can use s3c_gpiolib_get and s3c_gpiolib_set to change the state of
+ * the output.
+ */
+
+static int s5pc1xx_gpiolib_input(struct gpio_chip *chip, unsigned offset)
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
+static int s5pc1xx_gpiolib_output(struct gpio_chip *chip,
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
+static int s5pc1xx_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	return S3C_IRQ_GPIO(chip->base + offset);
+}
+
+static int s5pc1xx_gpiolib_to_eint(struct gpio_chip *chip, unsigned int offset)
+{
+	int base;
+
+	base = chip->base - S5PC100_GPH0(0);
+	if (base == 0)
+		return IRQ_EINT(offset);
+	base = chip->base - S5PC100_GPH1(0);
+	if (base == 0)
+		return IRQ_EINT(8 + offset);
+	base = chip->base - S5PC100_GPH2(0);
+	if (base == 0)
+		return IRQ_EINT(16 + offset);
+	base = chip->base - S5PC100_GPH3(0);
+	if (base == 0)
+		return IRQ_EINT(24 + offset);
+	return -EINVAL;
+}
+
+static struct s3c_gpio_cfg gpio_cfg = {
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
+static struct s3c_gpio_cfg gpio_cfg_eint = {
+	.cfg_eint	= 0xf,
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
+static struct s3c_gpio_cfg gpio_cfg_noint = {
+	.set_config	= s3c_gpio_setcfg_s3c64xx_4bit,
+	.set_pull	= s3c_gpio_setpull_updown,
+	.get_pull	= s3c_gpio_getpull_updown,
+};
+
+static struct s3c_gpio_chip s5pc100_gpio_chips[] = {
+	{
+		.base	= S5PC100_GPA0_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPA0(0),
+			.ngpio	= S5PC100_GPIO_A0_NR,
+			.label	= "GPA0",
+		},
+	}, {
+		.base	= S5PC100_GPA1_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPA1(0),
+			.ngpio	= S5PC100_GPIO_A1_NR,
+			.label	= "GPA1",
+		},
+	}, {
+		.base	= S5PC100_GPB_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPB(0),
+			.ngpio	= S5PC100_GPIO_B_NR,
+			.label	= "GPB",
+		},
+	}, {
+		.base	= S5PC100_GPC_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPC(0),
+			.ngpio	= S5PC100_GPIO_C_NR,
+			.label	= "GPC",
+		},
+	}, {
+		.base	= S5PC100_GPD_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPD(0),
+			.ngpio	= S5PC100_GPIO_D_NR,
+			.label	= "GPD",
+		},
+	}, {
+		.base	= S5PC100_GPE0_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPE0(0),
+			.ngpio	= S5PC100_GPIO_E0_NR,
+			.label	= "GPE0",
+		},
+	}, {
+		.base	= S5PC100_GPE1_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPE1(0),
+			.ngpio	= S5PC100_GPIO_E1_NR,
+			.label	= "GPE1",
+		},
+	}, {
+		.base	= S5PC100_GPF0_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPF0(0),
+			.ngpio	= S5PC100_GPIO_F0_NR,
+			.label	= "GPF0",
+		},
+	}, {
+		.base	= S5PC100_GPF1_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPF1(0),
+			.ngpio	= S5PC100_GPIO_F1_NR,
+			.label	= "GPF1",
+		},
+	}, {
+		.base	= S5PC100_GPF2_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPF2(0),
+			.ngpio	= S5PC100_GPIO_F2_NR,
+			.label	= "GPF2",
+		},
+	}, {
+		.base	= S5PC100_GPF3_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPF3(0),
+			.ngpio	= S5PC100_GPIO_F3_NR,
+			.label	= "GPF3",
+		},
+	}, {
+		.base	= S5PC100_GPG0_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPG0(0),
+			.ngpio	= S5PC100_GPIO_G0_NR,
+			.label	= "GPG0",
+		},
+	}, {
+		.base	= S5PC100_GPG1_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPG1(0),
+			.ngpio	= S5PC100_GPIO_G1_NR,
+			.label	= "GPG1",
+		},
+	}, {
+		.base	= S5PC100_GPG2_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPG2(0),
+			.ngpio	= S5PC100_GPIO_G2_NR,
+			.label	= "GPG2",
+		},
+	}, {
+		.base	= S5PC100_GPG3_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPG3(0),
+			.ngpio	= S5PC100_GPIO_G3_NR,
+			.label	= "GPG3",
+		},
+	}, {
+		.base	= S5PC100_GPH0_BASE,
+		.config	= &gpio_cfg_eint,
+		.chip	= {
+			.base	= S5PC100_GPH0(0),
+			.ngpio	= S5PC100_GPIO_H0_NR,
+			.label	= "GPH0",
+		},
+	}, {
+		.base	= S5PC100_GPH1_BASE,
+		.config	= &gpio_cfg_eint,
+		.chip	= {
+			.base	= S5PC100_GPH1(0),
+			.ngpio	= S5PC100_GPIO_H1_NR,
+			.label	= "GPH1",
+		},
+	}, {
+		.base	= S5PC100_GPH2_BASE,
+		.config	= &gpio_cfg_eint,
+		.chip	= {
+			.base	= S5PC100_GPH2(0),
+			.ngpio	= S5PC100_GPIO_H2_NR,
+			.label	= "GPH2",
+		},
+	}, {
+		.base	= S5PC100_GPH3_BASE,
+		.config	= &gpio_cfg_eint,
+		.chip	= {
+			.base	= S5PC100_GPH3(0),
+			.ngpio	= S5PC100_GPIO_H3_NR,
+			.label	= "GPH3",
+		},
+	}, {
+		.base	= S5PC100_GPI_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPI(0),
+			.ngpio	= S5PC100_GPIO_I_NR,
+			.label	= "GPI",
+		},
+	}, {
+		.base	= S5PC100_GPJ0_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPJ0(0),
+			.ngpio	= S5PC100_GPIO_J0_NR,
+			.label	= "GPJ0",
+		},
+	}, {
+		.base	= S5PC100_GPJ1_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPJ1(0),
+			.ngpio	= S5PC100_GPIO_J1_NR,
+			.label	= "GPJ1",
+		},
+	}, {
+		.base	= S5PC100_GPJ2_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPJ2(0),
+			.ngpio	= S5PC100_GPIO_J2_NR,
+			.label	= "GPJ2",
+		},
+	}, {
+		.base	= S5PC100_GPJ3_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPJ3(0),
+			.ngpio	= S5PC100_GPIO_J3_NR,
+			.label	= "GPJ3",
+		},
+	}, {
+		.base	= S5PC100_GPJ4_BASE,
+		.config	= &gpio_cfg,
+		.chip	= {
+			.base	= S5PC100_GPJ4(0),
+			.ngpio	= S5PC100_GPIO_J4_NR,
+			.label	= "GPJ4",
+		},
+	}, {
+		.base	= S5PC100_GPK0_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPK0(0),
+			.ngpio	= S5PC100_GPIO_K0_NR,
+			.label	= "GPK0",
+		},
+	}, {
+		.base	= S5PC100_GPK1_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPK1(0),
+			.ngpio	= S5PC100_GPIO_K1_NR,
+			.label	= "GPK1",
+		},
+	}, {
+		.base	= S5PC100_GPK2_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPK2(0),
+			.ngpio	= S5PC100_GPIO_K2_NR,
+			.label	= "GPK2",
+		},
+	}, {
+		.base	= S5PC100_GPK3_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPK3(0),
+			.ngpio	= S5PC100_GPIO_K3_NR,
+			.label	= "GPK3",
+		},
+	}, {
+		.base	= S5PC100_GPL0_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPL0(0),
+			.ngpio	= S5PC100_GPIO_L0_NR,
+			.label	= "GPL0",
+		},
+	}, {
+		.base	= S5PC100_GPL1_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPL1(0),
+			.ngpio	= S5PC100_GPIO_L1_NR,
+			.label	= "GPL1",
+		},
+	}, {
+		.base	= S5PC100_GPL2_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPL2(0),
+			.ngpio	= S5PC100_GPIO_L2_NR,
+			.label	= "GPL2",
+		},
+	}, {
+		.base	= S5PC100_GPL3_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPL3(0),
+			.ngpio	= S5PC100_GPIO_L3_NR,
+			.label	= "GPL3",
+		},
+	}, {
+		.base	= S5PC100_GPL4_BASE,
+		.config	= &gpio_cfg_noint,
+		.chip	= {
+			.base	= S5PC100_GPL4(0),
+			.ngpio	= S5PC100_GPIO_L4_NR,
+			.label	= "GPL4",
+		},
+	},
+};
+
+/* FIXME move from irq-gpio.c */
+extern struct irq_chip s5pc1xx_gpioint;
+extern void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc);
+
+static __init void s5pc1xx_gpiolib_link(struct s3c_gpio_chip *chip)
+{
+	chip->chip.direction_input = s5pc1xx_gpiolib_input;
+	chip->chip.direction_output = s5pc1xx_gpiolib_output;
+	chip->pm = __gpio_pm(&s3c_gpio_pm_4bit);
+
+	/* Interrupt */
+	if (chip->config == &gpio_cfg) {
+		int i, irq;
+
+		chip->chip.to_irq = s5pc1xx_gpiolib_to_irq;
+
+		for (i = 0;  i < chip->chip.ngpio; i++) {
+			irq = S3C_IRQ_GPIO_BASE + chip->chip.base + i;
+			set_irq_chip(irq, &s5pc1xx_gpioint);
+			set_irq_data(irq, &chip->chip);
+			set_irq_handler(irq, handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID);
+		}
+	} else if (chip->config == &gpio_cfg_eint)
+		chip->chip.to_irq = s5pc1xx_gpiolib_to_eint;
+}
+
+static __init void s5pc1xx_gpiolib_add(struct s3c_gpio_chip *chips,
+				       int nr_chips,
+				       void (*fn)(struct s3c_gpio_chip *))
+{
+	for (; nr_chips > 0; nr_chips--, chips++) {
+		if (fn)
+			(fn)(chips);
+		s3c_gpiolib_add(chips);
+	}
+}
+
+static __init int s5pc1xx_gpiolib_init(void)
+{
+	struct s3c_gpio_chip *chips;
+	int nr_chips;
+
+		chips = s5pc100_gpio_chips;
+		nr_chips = ARRAY_SIZE(s5pc100_gpio_chips);
+
+	s5pc1xx_gpiolib_add(chips, nr_chips, s5pc1xx_gpiolib_link);
+	/* Interrupt */
+	set_irq_chained_handler(IRQ_GPIOINT, s5pc1xx_irq_gpioint_handler);
+
+	return 0;
+}
+core_initcall(s5pc1xx_gpiolib_init);
diff --git a/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h b/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
new file mode 100644
index 0000000..72ad59f
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg-s5pc1xx.h
@@ -0,0 +1,32 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/gpio-cfg.h
+ *
+ * Copyright 2009 Samsung Electronic
+ *
+ * S5PC1XX Platform - GPIO pin configuration
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/* This file contains the necessary definitions to get the basic gpio
+ * pin configuration done such as setting a pin to input or output or
+ * changing the pull-{up,down} configurations.
+ */
+
+#ifndef __GPIO_CFG_S5PC1XX_H
+#define __GPIO_CFG_S5PC1XX_H __FILE__
+
+typedef unsigned int __bitwise__ s5p_gpio_drvstr_t;
+
+#define S5P_GPIO_DRVSTR_LV1	0x00
+#define S5P_GPIO_DRVSTR_LV2	0x01
+#define S5P_GPIO_DRVSTR_LV3	0x10
+#define S5P_GPIO_DRVSTR_LV4	0x11
+
+extern s5p_gpio_drvstr_t s5p_gpio_get_drvstr(unsigned int pin, unsigned int off);
+
+extern int s5p_gpio_set_drvstr(unsigned int pin, unsigned int off,
+			s5p_gpio_drvstr_t drvstr);
+
+#endif /* __GPIO_CFG_S5PC1XX_H */
diff --git a/arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h b/arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
new file mode 100644
index 0000000..33ad267
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/plat/gpio-ext.h
@@ -0,0 +1,44 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/gpio-eint.h
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
+#define S5PC1XX_WKUP_INT_CON0_7		(S5PC1XX_EINT_BASE + 0x0)
+#define S5PC1XX_WKUP_INT_CON8_15	(S5PC1XX_EINT_BASE + 0x4)
+#define S5PC1XX_WKUP_INT_CON16_23	(S5PC1XX_EINT_BASE + 0x8)
+#define S5PC1XX_WKUP_INT_CON24_31	(S5PC1XX_EINT_BASE + 0xC)
+#define S5PC1XX_WKUP_INT_CON(x)		(S5PC1XX_WKUP_INT_CON0_7 + (x * 0x4))
+
+#define S5PC1XX_WKUP_INT_FLTCON0_3	(S5PC1XX_EINT_BASE + 0x80)
+#define S5PC1XX_WKUP_INT_FLTCON4_7	(S5PC1XX_EINT_BASE + 0x84)
+#define S5PC1XX_WKUP_INT_FLTCON8_11	(S5PC1XX_EINT_BASE + 0x88)
+#define S5PC1XX_WKUP_INT_FLTCON12_15	(S5PC1XX_EINT_BASE + 0x8C)
+#define S5PC1XX_WKUP_INT_FLTCON16_19	(S5PC1XX_EINT_BASE + 0x90)
+#define S5PC1XX_WKUP_INT_FLTCON20_23	(S5PC1XX_EINT_BASE + 0x94)
+#define S5PC1XX_WKUP_INT_FLTCON24_27	(S5PC1XX_EINT_BASE + 0x98)
+#define S5PC1XX_WKUP_INT_FLTCON28_31	(S5PC1XX_EINT_BASE + 0x9C)
+#define S5PC1XX_WKUP_INT_FLTCON(x)	(S5PC1XX_WKUP_INT_FLTCON0_3 + (x * 0x4))
+
+#define S5PC1XX_WKUP_INT_MASK0_7	(S5PC1XX_EINT_BASE + 0x100)
+#define S5PC1XX_WKUP_INT_MASK8_15	(S5PC1XX_EINT_BASE + 0x104)
+#define S5PC1XX_WKUP_INT_MASK16_23	(S5PC1XX_EINT_BASE + 0x108)
+#define S5PC1XX_WKUP_INT_MASK24_31	(S5PC1XX_EINT_BASE + 0x10C)
+#define S5PC1XX_WKUP_INT_MASK(x)	(S5PC1XX_WKUP_INT_MASK0_7 + (x * 0x4))
+
+#define S5PC1XX_WKUP_INT_PEND0_7	(S5PC1XX_EINT_BASE + 0x140)
+#define S5PC1XX_WKUP_INT_PEND8_15	(S5PC1XX_EINT_BASE + 0x144)
+#define S5PC1XX_WKUP_INT_PEND16_23	(S5PC1XX_EINT_BASE + 0x148)
+#define S5PC1XX_WKUP_INT_PEND24_31	(S5PC1XX_EINT_BASE + 0x14C)
+#define S5PC1XX_WKUP_INT_PEND(x)	(S5PC1XX_WKUP_INT_PEND0_7 + (x * 0x4))
+
+#define S5PC1XX_WKUP_INT_LOWLEV		(0x00)
+#define S5PC1XX_WKUP_INT_HILEV		(0x01)
+#define S5PC1XX_WKUP_INT_FALLEDGE	(0x02)
+#define S5PC1XX_WKUP_INT_RISEEDGE	(0x03)
+#define S5PC1XX_WKUP_INT_BOTHEDGE	(0x04)
diff --git a/arch/arm/plat-s5pc1xx/include/plat/irqs.h b/arch/arm/plat-s5pc1xx/include/plat/irqs.h
index f07d8c3..ef87363 100644
--- a/arch/arm/plat-s5pc1xx/include/plat/irqs.h
+++ b/arch/arm/plat-s5pc1xx/include/plat/irqs.h
@@ -171,12 +171,21 @@
 #define IRQ_SDMIRQ		S5PC1XX_IRQ_VIC2(30)
 #define IRQ_SDMFIQ		S5PC1XX_IRQ_VIC2(31)
 
+/* External interrupt */
 #define S3C_IRQ_EINT_BASE	(IRQ_SDMFIQ + 1)
 
-#define S3C_EINT(x)		((x) + S3C_IRQ_EINT_BASE)
-#define IRQ_EINT(x)		S3C_EINT(x)
+#define S3C_EINT(x)		(S3C_IRQ_EINT_BASE + (x - 16))
+#define IRQ_EINT(x)		(x < 16 ? IRQ_EINT0 + x : S3C_EINT(x))
+#define IRQ_EINT_BIT(x)		(x < IRQ_EINT16_31 ? x - IRQ_EINT0 : x - S3C_EINT(0))
 
-#define NR_IRQS 		(IRQ_EINT(31)+1)
+/* GPIO interrupt */
+#define S3C_IRQ_GPIO_BASE	(IRQ_EINT(31) + 1)
+#define S3C_IRQ_GPIO(x)		(S3C_IRQ_GPIO_BASE + (x))
+
+/*
+ * Until MP04 Groups -> 40 (exactly 39) Groups * 8 ~= 320 GPIOs
+ */
+#define NR_IRQS			(S3C_IRQ_GPIO(320) + 1)
 
 #endif /* __ASM_PLAT_S5PC1XX_IRQS_H */
 
diff --git a/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h b/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
new file mode 100644
index 0000000..43c7bc8
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
@@ -0,0 +1,70 @@
+/* linux/arch/arm/plat-s5pc1xx/include/plat/regs-gpio.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *      Byungho Min <bhmin@samsung.com>
+ *
+ * S5PC1XX - GPIO register definitions
+ */
+
+#ifndef __ASM_PLAT_S5PC1XX_REGS_GPIO_H
+#define __ASM_PLAT_S5PC1XX_REGS_GPIO_H __FILE__
+
+#include <mach/map.h>
+
+/* S5PC100 */
+#define S5PC100_GPIO_BASE	S5PC1XX_VA_GPIO
+#define S5PC100_GPA0_BASE	(S5PC100_GPIO_BASE + 0x0000)
+#define S5PC100_GPA1_BASE	(S5PC100_GPIO_BASE + 0x0020)
+#define S5PC100_GPB_BASE	(S5PC100_GPIO_BASE + 0x0040)
+#define S5PC100_GPC_BASE	(S5PC100_GPIO_BASE + 0x0060)
+#define S5PC100_GPD_BASE	(S5PC100_GPIO_BASE + 0x0080)
+#define S5PC100_GPE0_BASE	(S5PC100_GPIO_BASE + 0x00A0)
+#define S5PC100_GPE1_BASE	(S5PC100_GPIO_BASE + 0x00C0)
+#define S5PC100_GPF0_BASE	(S5PC100_GPIO_BASE + 0x00E0)
+#define S5PC100_GPF1_BASE	(S5PC100_GPIO_BASE + 0x0100)
+#define S5PC100_GPF2_BASE	(S5PC100_GPIO_BASE + 0x0120)
+#define S5PC100_GPF3_BASE	(S5PC100_GPIO_BASE + 0x0140)
+#define S5PC100_GPG0_BASE	(S5PC100_GPIO_BASE + 0x0160)
+#define S5PC100_GPG1_BASE	(S5PC100_GPIO_BASE + 0x0180)
+#define S5PC100_GPG2_BASE	(S5PC100_GPIO_BASE + 0x01A0)
+#define S5PC100_GPG3_BASE	(S5PC100_GPIO_BASE + 0x01C0)
+#define S5PC100_GPH0_BASE	(S5PC100_GPIO_BASE + 0x0C00)
+#define S5PC100_GPH1_BASE	(S5PC100_GPIO_BASE + 0x0C20)
+#define S5PC100_GPH2_BASE	(S5PC100_GPIO_BASE + 0x0C40)
+#define S5PC100_GPH3_BASE	(S5PC100_GPIO_BASE + 0x0C60)
+#define S5PC100_GPI_BASE	(S5PC100_GPIO_BASE + 0x01E0)
+#define S5PC100_GPJ0_BASE	(S5PC100_GPIO_BASE + 0x0200)
+#define S5PC100_GPJ1_BASE	(S5PC100_GPIO_BASE + 0x0220)
+#define S5PC100_GPJ2_BASE	(S5PC100_GPIO_BASE + 0x0240)
+#define S5PC100_GPJ3_BASE	(S5PC100_GPIO_BASE + 0x0260)
+#define S5PC100_GPJ4_BASE	(S5PC100_GPIO_BASE + 0x0280)
+#define S5PC100_GPK0_BASE	(S5PC100_GPIO_BASE + 0x02A0)
+#define S5PC100_GPK1_BASE	(S5PC100_GPIO_BASE + 0x02C0)
+#define S5PC100_GPK2_BASE	(S5PC100_GPIO_BASE + 0x02E0)
+#define S5PC100_GPK3_BASE	(S5PC100_GPIO_BASE + 0x0300)
+#define S5PC100_GPL0_BASE	(S5PC100_GPIO_BASE + 0x0320)
+#define S5PC100_GPL1_BASE	(S5PC100_GPIO_BASE + 0x0340)
+#define S5PC100_GPL2_BASE	(S5PC100_GPIO_BASE + 0x0360)
+#define S5PC100_GPL3_BASE	(S5PC100_GPIO_BASE + 0x0380)
+#define S5PC100_GPL4_BASE	(S5PC100_GPIO_BASE + 0x03A0)
+#define S5PC100_EINT_BASE	(S5PC100_GPIO_BASE + 0x0E00)
+
+#define S5PC100_UHOST		(S5PC100_GPIO_BASE + 0x0B68)
+#define S5PC100_PDNEN		(S5PC100_GPIO_BASE + 0x0F80)
+
+/* PDNEN */
+#define S5PC100_PDNEN_CFG_PDNEN	(1 << 1)
+#define S5PC100_PDNEN_CFG_AUTO	(0 << 1)
+#define S5PC100_PDNEN_POWERDOWN	(1 << 0)
+#define S5PC100_PDNEN_NORMAL	(0 << 0)
+
+/* Common part */
+/* External interrupt base is same at both s5pc100 and s5pc110 */
+#define S5PC1XX_EINT_BASE	(S5PC100_EINT_BASE)
+
+#define S5PC100_GPx_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
+#define S5PC100_GPx_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
+#define S5PC100_GPx_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
+
+#endif /* __ASM_PLAT_S5PC1XX_REGS_GPIO_H */
+
diff --git a/arch/arm/plat-s5pc1xx/irq-eint.c b/arch/arm/plat-s5pc1xx/irq-eint.c
new file mode 100644
index 0000000..34f9443
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/irq-eint.c
@@ -0,0 +1,281 @@
+/*
+ * linux/arch/arm/plat-s5pc1xx/irq-eint.c
+ *
+ *  Copyright 2009 Samsung Electronics Co.
+ *  Byungho Min <bhmin@samsung.com>
+ *  Kyungin Park <kyungmin.park@samsung.com>
+ *
+ * Based on plat-s3c64xx/irq-eint.c
+ *
+ * S5PC1XX - Interrupt handling for IRQ_EINT(x)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/sysdev.h>
+#include <linux/pm.h>
+
+#include <asm/hardware/vic.h>
+
+#include <mach/map.h>
+#include <mach/gpio.h>
+
+#include <plat/gpio-cfg.h>
+#include <plat/gpio-ext.h>
+#include <plat/pm.h>
+#include <plat/regs-gpio.h>
+#include <plat/regs-irqtype.h>
+
+/*
+ * bank is a group of external interrupt
+ * bank0 means EINT0 ... EINT7
+ * bank1 means EINT8 ... EINT15
+ * bank2 means EINT16 ... EINT23
+ * bank3 means EINT24 ... EINT31
+ */
+
+static inline int s3c_get_eint(unsigned int irq)
+{
+	int real;
+
+	if (irq < IRQ_EINT16_31)
+		real = (irq - IRQ_EINT0);
+	else
+		real = (irq - S3C_IRQ_EINT_BASE) + IRQ_EINT16_31 - IRQ_EINT0;
+
+	return real;
+}
+
+static inline int s3c_get_bank(unsigned int irq)
+{
+	return s3c_get_eint(irq) >> 3;
+}
+
+static inline int s3c_eint_to_bit(unsigned int irq)
+{
+	int real, bit;
+
+	real = s3c_get_eint(irq);
+	bit = 1 << (real & (8 - 1));
+
+	return bit;
+}
+
+static inline void s3c_irq_eint_mask(unsigned int irq)
+{
+	u32 mask;
+	u32 bank = s3c_get_bank(irq);
+
+	mask = __raw_readl(S5PC1XX_WKUP_INT_MASK(bank));
+	mask |= s3c_eint_to_bit(irq);
+	__raw_writel(mask, S5PC1XX_WKUP_INT_MASK(bank));
+}
+
+static void s3c_irq_eint_unmask(unsigned int irq)
+{
+	u32 mask;
+	u32 bank = s3c_get_bank(irq);
+
+	mask = __raw_readl(S5PC1XX_WKUP_INT_MASK(bank));
+	mask &= ~(s3c_eint_to_bit(irq));
+	__raw_writel(mask, S5PC1XX_WKUP_INT_MASK(bank));
+}
+
+static inline void s3c_irq_eint_ack(unsigned int irq)
+{
+	u32 bank = s3c_get_bank(irq);
+
+	__raw_writel(s3c_eint_to_bit(irq), S5PC1XX_WKUP_INT_PEND(bank));
+}
+
+static void s3c_irq_eint_maskack(unsigned int irq)
+{
+	/* compiler should in-line these */
+	s3c_irq_eint_mask(irq);
+	s3c_irq_eint_ack(irq);
+}
+
+static int s3c_irq_eint_set_type(unsigned int irq, unsigned int type)
+{
+	u32 bank = s3c_get_bank(irq);
+	int real = s3c_get_eint(irq);
+	int gpio, shift, sfn;
+	u32 ctrl, con = 0;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		printk(KERN_WARNING "No edge setting!\n");
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		con = S5PC1XX_WKUP_INT_RISEEDGE;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		con = S5PC1XX_WKUP_INT_FALLEDGE;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		con = S5PC1XX_WKUP_INT_BOTHEDGE;
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		con = S5PC1XX_WKUP_INT_LOWLEV;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		con = S5PC1XX_WKUP_INT_HILEV;
+		break;
+
+	default:
+		printk(KERN_ERR "No such irq type %d", type);
+		return -EINVAL;
+	}
+
+	gpio = real & (8 - 1);
+	shift = gpio << 2;
+
+	ctrl = __raw_readl(S5PC1XX_WKUP_INT_CON(bank));
+	ctrl &= ~(0x7 << shift);
+	ctrl |= con << shift;
+	__raw_writel(ctrl, S5PC1XX_WKUP_INT_CON(bank));
+
+	switch (real) {
+	case 0 ... 7:
+			gpio = S5PC100_GPH0(gpio);
+		break;
+	case 8 ... 15:
+			gpio = S5PC100_GPH1(gpio);
+		break;
+	case 16 ... 23:
+			gpio = S5PC100_GPH2(gpio);
+		break;
+	case 24 ... 31:
+			gpio = S5PC100_GPH3(gpio);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sfn = S3C_GPIO_SFN(0x2);
+	s3c_gpio_cfgpin(gpio, sfn);
+
+	return 0;
+}
+
+static struct irq_chip s3c_irq_eint = {
+	.name		= "EINT",
+	.mask		= s3c_irq_eint_mask,
+	.unmask		= s3c_irq_eint_unmask,
+	.mask_ack	= s3c_irq_eint_maskack,
+	.ack		= s3c_irq_eint_ack,
+	.set_type	= s3c_irq_eint_set_type,
+	.set_wake	= s3c_irqext_wake,
+};
+
+/* s3c_irq_demux_eint
+ *
+ * This function demuxes the IRQ from external interrupts,
+ * from IRQ_EINT(16) to IRQ_EINT(31). It is designed to be inlined into
+ * the specific handlers s3c_irq_demux_eintX_Y.
+ */
+static inline void s3c_irq_demux_eint(unsigned int start, unsigned int end)
+{
+	u32 status = __raw_readl(S5PC1XX_WKUP_INT_PEND((start >> 3)));
+	u32 mask = __raw_readl(S5PC1XX_WKUP_INT_MASK((start >> 3)));
+	unsigned int irq;
+
+	status &= ~mask;
+	status &= (1 << (end - start + 1)) - 1;
+
+	for (irq = IRQ_EINT(start); irq <= IRQ_EINT(end); irq++) {
+		if (status & 1)
+			generic_handle_irq(irq);
+
+		status >>= 1;
+	}
+}
+
+static void s3c_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
+{
+	s3c_irq_demux_eint(16, 23);
+	s3c_irq_demux_eint(24, 31);
+}
+
+/*
+ * Handle EINT0 ... EINT15 at VIC directly
+ */
+static void s3c_irq_vic_eint_mask(unsigned int irq)
+{
+	void __iomem *base = get_irq_chip_data(irq);
+	unsigned int real;
+
+	s3c_irq_eint_mask(irq);
+	real = s3c_get_eint(irq);
+	writel(1 << real, base + VIC_INT_ENABLE_CLEAR);
+}
+
+static void s3c_irq_vic_eint_unmask(unsigned int irq)
+{
+	void __iomem *base = get_irq_chip_data(irq);
+	unsigned int real;
+
+	s3c_irq_eint_unmask(irq);
+	real = s3c_get_eint(irq);
+	writel(1 << real, base + VIC_INT_ENABLE);
+}
+
+static inline void s3c_irq_vic_eint_ack(unsigned int irq)
+{
+	u32 bit;
+	u32 bank = s3c_get_bank(irq);
+
+	bit = s3c_eint_to_bit(irq);
+	__raw_writel(bit, S5PC1XX_WKUP_INT_PEND(bank));
+}
+
+static void s3c_irq_vic_eint_maskack(unsigned int irq)
+{
+	/* compiler should in-line these */
+	s3c_irq_vic_eint_mask(irq);
+	s3c_irq_vic_eint_ack(irq);
+}
+
+static struct irq_chip s3c_irq_vic_eint = {
+	.name		= "EINT",
+	.mask		= s3c_irq_vic_eint_mask,
+	.unmask		= s3c_irq_vic_eint_unmask,
+	.mask_ack	= s3c_irq_vic_eint_maskack,
+	.ack		= s3c_irq_vic_eint_ack,
+	.set_type	= s3c_irq_eint_set_type,
+	.set_wake	= s3c_irqext_wake,
+};
+
+static int __init s5pc1xx_init_irq_eint(void)
+{
+	int irq;
+
+	for (irq = IRQ_EINT0; irq <= IRQ_EINT15; irq++) {
+		set_irq_chip(irq, &s3c_irq_vic_eint);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	for (irq = IRQ_EINT(16); irq <= IRQ_EINT(31); irq++) {
+		set_irq_chip(irq, &s3c_irq_eint);
+		set_irq_handler(irq, handle_level_irq);
+		set_irq_flags(irq, IRQF_VALID);
+	}
+
+	set_irq_chained_handler(IRQ_EINT16_31, s3c_irq_demux_eint16_31);
+
+	return 0;
+}
+
+arch_initcall(s5pc1xx_init_irq_eint);
diff --git a/arch/arm/plat-s5pc1xx/irq-gpio.c b/arch/arm/plat-s5pc1xx/irq-gpio.c
new file mode 100644
index 0000000..843a88e
--- /dev/null
+++ b/arch/arm/plat-s5pc1xx/irq-gpio.c
@@ -0,0 +1,266 @@
+/*
+ * arch/arm/plat-s5pc1xx/irq-gpio.c
+ *
+ * Copyright (C) 2009 Samsung Electronics
+ *
+ * S5PC1XX - Interrupt handling for IRQ_GPIO${group}(x)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <mach/map.h>
+#include <mach/gpio.h>
+#include <plat/gpio-cfg.h>
+
+#define S5PC1XX_GPIOREG(x)		(S5PC1XX_VA_GPIO + (x))
+
+#define CON_OFFSET			0x700
+#define MASK_OFFSET			0x900
+#define PEND_OFFSET			0xA00
+#define CON_OFFSET_2			0xE00
+#define MASK_OFFSET_2			0xF00
+#define PEND_OFFSET_2			0xF40
+
+#define GPIOINT_LEVEL_LOW		0x0
+#define GPIOINT_LEVEL_HIGH		0x1
+#define GPIOINT_EDGE_FALLING		0x2
+#define GPIOINT_EDGE_RISING		0x3
+#define GPIOINT_EDGE_BOTH		0x4
+
+static int group_to_con_offset(int group)
+{
+	return group << 2;
+}
+
+static int group_to_mask_offset(int group)
+{
+	return group << 2;
+}
+
+static int group_to_pend_offset(int group)
+{
+	return group << 2;
+}
+
+static int s5pc1xx_get_start(unsigned int group)
+{
+	switch (group) {
+	case 0: return S5PC100_GPIO_A0_START;
+	case 1: return S5PC100_GPIO_A1_START;
+	case 2: return S5PC100_GPIO_B_START;
+	case 3: return S5PC100_GPIO_C_START;
+	case 4: return S5PC100_GPIO_D_START;
+	case 5: return S5PC100_GPIO_E0_START;
+	case 6: return S5PC100_GPIO_E1_START;
+	case 7: return S5PC100_GPIO_F0_START;
+	case 8: return S5PC100_GPIO_F1_START;
+	case 9: return S5PC100_GPIO_F2_START;
+	case 10: return S5PC100_GPIO_F3_START;
+	case 11: return S5PC100_GPIO_G0_START;
+	case 12: return S5PC100_GPIO_G1_START;
+	case 13: return S5PC100_GPIO_G2_START;
+	case 14: return S5PC100_GPIO_G3_START;
+	case 15: return S5PC100_GPIO_I_START;
+	case 16: return S5PC100_GPIO_J0_START;
+	case 17: return S5PC100_GPIO_J1_START;
+	case 18: return S5PC100_GPIO_J2_START;
+	case 19: return S5PC100_GPIO_J3_START;
+	case 20: return S5PC100_GPIO_J4_START;
+	default:
+		BUG();
+	}
+
+	return -EINVAL;
+}
+
+static int s5pc1xx_get_group(unsigned int irq)
+{
+	irq -= S3C_IRQ_GPIO(0);
+
+	switch (irq) {
+	case S5PC100_GPIO_A0_START ... S5PC100_GPIO_A1_START - 1:
+		return 0;
+	case S5PC100_GPIO_A1_START ... S5PC100_GPIO_B_START - 1:
+		return 1;
+	case S5PC100_GPIO_B_START ... S5PC100_GPIO_C_START - 1:
+		return 2;
+	case S5PC100_GPIO_C_START ... S5PC100_GPIO_D_START - 1:
+		return 3;
+	case S5PC100_GPIO_D_START ... S5PC100_GPIO_E0_START - 1:
+		return 4;
+	case S5PC100_GPIO_E0_START ... S5PC100_GPIO_E1_START - 1:
+		return 5;
+	case S5PC100_GPIO_E1_START ... S5PC100_GPIO_F0_START - 1:
+		return 6;
+	case S5PC100_GPIO_F0_START ... S5PC100_GPIO_F1_START - 1:
+		return 7;
+	case S5PC100_GPIO_F1_START ... S5PC100_GPIO_F2_START - 1:
+		return 8;
+	case S5PC100_GPIO_F2_START ... S5PC100_GPIO_F3_START - 1:
+		return 9;
+	case S5PC100_GPIO_F3_START ... S5PC100_GPIO_G0_START - 1:
+		return 10;
+	case S5PC100_GPIO_G0_START ... S5PC100_GPIO_G1_START - 1:
+		return 11;
+	case S5PC100_GPIO_G1_START ... S5PC100_GPIO_G2_START - 1:
+		return 12;
+	case S5PC100_GPIO_G2_START ... S5PC100_GPIO_G3_START - 1:
+		return 13;
+	case S5PC100_GPIO_G3_START ... S5PC100_GPIO_H0_START - 1:
+		return 14;
+	case S5PC100_GPIO_I_START ... S5PC100_GPIO_J0_START - 1:
+		return 15;
+	case S5PC100_GPIO_J0_START ... S5PC100_GPIO_J1_START - 1:
+		return 16;
+	case S5PC100_GPIO_J1_START ... S5PC100_GPIO_J2_START - 1:
+		return 17;
+	case S5PC100_GPIO_J2_START ... S5PC100_GPIO_J3_START - 1:
+		return 18;
+	case S5PC100_GPIO_J3_START ... S5PC100_GPIO_J4_START - 1:
+		return 19;
+	case S5PC100_GPIO_J4_START ... S5PC100_GPIO_K0_START - 1:
+		return 20;
+	default:
+		BUG();
+	}
+
+	return -EINVAL;
+}
+
+static int s5pc1xx_get_offset(unsigned int irq)
+{
+	struct gpio_chip *chip = get_irq_data(irq);
+	return irq - S3C_IRQ_GPIO(chip->base);
+}
+
+static void s5pc1xx_gpioint_ack(unsigned int irq)
+{
+	int group, offset, pend_offset;
+	unsigned int value;
+
+	group = s5pc1xx_get_group(irq);
+	offset = s5pc1xx_get_offset(irq);
+	pend_offset = group_to_pend_offset(group);
+
+	value = __raw_readl(S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
+	value |= 1 << offset;
+	__raw_writel(value, S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
+}
+
+static void s5pc1xx_gpioint_mask(unsigned int irq)
+{
+	int group, offset, mask_offset;
+	unsigned int value;
+
+	group = s5pc1xx_get_group(irq);
+	offset = s5pc1xx_get_offset(irq);
+	mask_offset = group_to_mask_offset(group);
+
+	value = __raw_readl(S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+	value |= 1 << offset;
+	__raw_writel(value, S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+}
+
+static void s5pc1xx_gpioint_unmask(unsigned int irq)
+{
+	int group, offset, mask_offset;
+	unsigned int value;
+
+	group = s5pc1xx_get_group(irq);
+	offset = s5pc1xx_get_offset(irq);
+	mask_offset = group_to_mask_offset(group);
+
+	value = __raw_readl(S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+	value &= ~(1 << offset);
+	__raw_writel(value, S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+}
+
+static void s5pc1xx_gpioint_mask_ack(unsigned int irq)
+{
+	s5pc1xx_gpioint_mask(irq);
+	s5pc1xx_gpioint_ack(irq);
+}
+
+static int s5pc1xx_gpioint_set_type(unsigned int irq, unsigned int type)
+{
+	int group, offset, con_offset;
+	unsigned int value;
+
+	group = s5pc1xx_get_group(irq);
+	offset = s5pc1xx_get_offset(irq);
+	con_offset = group_to_con_offset(group);
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		printk(KERN_WARNING "No irq type\n");
+		return -EINVAL;
+	case IRQ_TYPE_EDGE_RISING:
+		type = GPIOINT_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = GPIOINT_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		type = GPIOINT_EDGE_BOTH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		type = GPIOINT_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = GPIOINT_LEVEL_LOW;
+		break;
+	default:
+		BUG();
+	}
+
+
+	value = __raw_readl(S5PC1XX_GPIOREG(CON_OFFSET) + con_offset);
+	value &= ~(0xf << (offset * 0x4));
+	value |= (type << (offset * 0x4));
+	__raw_writel(value, S5PC1XX_GPIOREG(CON_OFFSET) + con_offset);
+
+	return 0;
+}
+
+struct irq_chip s5pc1xx_gpioint = {
+	.name		= "GPIO",
+	.ack		= s5pc1xx_gpioint_ack,
+	.mask		= s5pc1xx_gpioint_mask,
+	.mask_ack	= s5pc1xx_gpioint_mask_ack,
+	.unmask		= s5pc1xx_gpioint_unmask,
+	.set_type	= s5pc1xx_gpioint_set_type,
+};
+
+void s5pc1xx_irq_gpioint_handler(unsigned int irq, struct irq_desc *desc)
+{
+	int group, offset, pend_offset, mask_offset;
+	int real_irq, group_end;
+	unsigned int pend, mask;
+
+	group_end = 21;
+
+	for (group = 0; group < group_end; group++) {
+		pend_offset = group_to_pend_offset(group);
+		pend = __raw_readl(S5PC1XX_GPIOREG(PEND_OFFSET) + pend_offset);
+		if (!pend)
+			continue;
+
+		mask_offset = group_to_mask_offset(group);
+		mask = __raw_readl(S5PC1XX_GPIOREG(MASK_OFFSET) + mask_offset);
+		pend &= ~mask;
+
+		for (offset = 0; offset < 8; offset++) {
+			if (pend & (1 << offset)) {
+				real_irq = s5pc1xx_get_start(group) + offset;
+				generic_handle_irq(S3C_IRQ_GPIO(real_irq));
+			}
+		}
+	}
+}
diff --git a/arch/arm/plat-s5pc1xx/irq.c b/arch/arm/plat-s5pc1xx/irq.c
index 80d6dd9..e44fd04 100644
--- a/arch/arm/plat-s5pc1xx/irq.c
+++ b/arch/arm/plat-s5pc1xx/irq.c
@@ -79,7 +79,7 @@ static void s3c_irq_timer_ack(unsigned int irq)
 {
 	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
 
-	reg &= 0x1f;
+	reg &= 0x1f;  /* mask out pending interrupts */
 	reg |= (1 << 5) << (irq - IRQ_TIMER0);
 	__raw_writel(reg, S3C64XX_TINT_CSTAT);
 }
-- 
1.6.5
