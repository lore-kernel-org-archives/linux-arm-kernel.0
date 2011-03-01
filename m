From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 1 Mar 2011 06:38:23 +0000
Subject: [PATCH 1/1] GPIO support for WM8505
Message-ID: <76F764B079F92A4E843589C893D0A0229382@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to correct the GPIO support for WM8505.
Current version was written for VT8500, but the WM8505 registers are located in different locations.

Signed-off-by: Tony Prisk (linux at prisktech.co.nz)
diff --git a/arch/arm/mach-vt8500/Makefile b/arch/arm/mach-vt8500/Makefile
index c0ae083..7422e8a 100644
--- a/arch/arm/mach-vt8500/Makefile
+++ b/arch/arm/mach-vt8500/Makefile
@@ -1,7 +1,7 @@
-obj-y += clock.o devices.o gpio.o irq.o timer.o
+obj-y += clock.o devices.o irq.o timer.o
 
-obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o clocks-vt8500.o
-obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o clocks-wm8505.o
+obj-$(CONFIG_VTWM_VERSION_VT8500) += devices-vt8500.o clocks-vt8500.o gpio.o
+obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o clocks-wm8505.o gpio-wm8505.o
 
 obj-$(CONFIG_MACH_BV07) += bv07.o
 obj-$(CONFIG_MACH_WM8505_7IN_NETBOOK) += wm8505_7in.o
diff --git a/arch/arm/mach-vt8500/gpio-wm8505.c b/arch/arm/mach-vt8500/gpio-wm8505.c
new file mode 100644
index 0000000..cd2eee9
--- /dev/null
+++ b/arch/arm/mach-vt8500/gpio-wm8505.c
@@ -0,0 +1,246 @@
+/* linux/arch/arm/mach-wm8505/gpio-wm8505.c
+ *
+ * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
+ * Copyright (C) 2011 Tony Prisk <linux@prisktech.co.nz>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include "devices.h"
+
+#define to_wm8505(__chip) container_of(__chip, struct wm8505_gpio_chip, chip)
+
+#define WM8505_ENABLE_REGS	0x40
+#define WM8505_DIRECTION_REGS	0x68
+#define WM8505_OUTVALUE_REGS	0x90
+#define WM8505_INVALUE_REGS	0xB8
+
+#define WM8505_EXT_REGOFF	0x24
+
+static void __iomem *regbase;
+
+struct wm8505_gpio_chip {
+	struct gpio_chip	chip;
+	unsigned int		shift;
+	unsigned int		regoff;
+};
+
+static int gpio_to_irq_map[8];
+
+static int wm8505_muxed_gpio_request(struct gpio_chip *chip,
+				     unsigned offset)
+{
+	struct wm8505_gpio_chip *wm8505_chip = to_wm8505(chip);
+	unsigned val = readl(regbase + WM8505_ENABLE_REGS + \
+				wm8505_chip->regoff);
+
+	val |= (1 << wm8505_chip->shift << offset);
+	writel(val, regbase + WM8505_ENABLE_REGS + wm8505_chip->regoff);
+
+	return 0;
+}
+
+static void wm8505_muxed_gpio_free(struct gpio_chip *chip,
+				   unsigned offset)
+{
+	struct wm8505_gpio_chip *wm8505_chip = to_wm8505(chip);
+	unsigned val = readl(regbase + WM8505_ENABLE_REGS + \
+				wm8505_chip->regoff);
+
+	val &= ~(1 << wm8505_chip->shift << offset);
+	writel(val, regbase + WM8505_ENABLE_REGS + wm8505_chip->regoff);
+}
+
+static int wm8505_muxed_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	struct wm8505_gpio_chip *wm8505_chip = to_wm8505(chip);
+	unsigned val = readl(regbase + WM8505_DIRECTION_REGS + \
+				wm8505_chip->regoff);
+
+	val &= ~(1 << wm8505_chip->shift << offset);
+	writel(val, regbase + WM8505_DIRECTION_REGS + wm8505_chip->regoff);
+
+	return 0;
+}
+
+static int wm8505_muxed_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	struct wm8505_gpio_chip *wm8505_chip = to_wm8505(chip);
+	unsigned val = readl(regbase + WM8505_DIRECTION_REGS + \
+				wm8505_chip->regoff);
+
+	val |= (1 << wm8505_chip->shift << offset);
+	writel(val, regbase + WM8505_DIRECTION_REGS + wm8505_chip->regoff);
+
+	if (value) {
+		val = readl(regbase + WM8505_OUTVALUE_REGS + \
+				wm8505_chip->regoff);
+		val |= (1 << wm8505_chip->shift << offset);
+		writel(val, regbase + WM8505_OUTVALUE_REGS + \
+				wm8505_chip->regoff);
+	}
+	return 0;
+}
+
+static int wm8505_muxed_gpio_get_value(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	struct wm8505_gpio_chip *wm8505_chip = to_wm8505(chip);
+
+	return (readl(regbase + WM8505_INVALUE_REGS + wm8505_chip->regoff)
+		>> wm8505_chip->shift >> offset) & 1;
+}
+
+static void wm8505_muxed_gpio_set_value(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	struct wm8505_gpio_chip *wm8505_chip = to_wm8505(chip);
+	unsigned val = readl(regbase + WM8505_INVALUE_REGS + \
+				wm8505_chip->regoff);
+
+	if (value)
+		val |= (1 << wm8505_chip->shift << offset);
+	else
+		val &= ~(1 << wm8505_chip->shift << offset);
+
+	writel(val, regbase + WM8505_INVALUE_REGS + wm8505_chip->regoff);
+}
+
+#define WM8505_GPIO_BANK(__name, __shift, __off, __base, __num)		\
+{									\
+	.chip = {							\
+		.label			= __name,			\
+		.request		= wm8505_muxed_gpio_request,	\
+		.free			= wm8505_muxed_gpio_free,	\
+		.direction_input  = wm8505_muxed_gpio_direction_input,	\
+		.direction_output = wm8505_muxed_gpio_direction_output,	\
+		.get			= wm8505_muxed_gpio_get_value,	\
+		.set			= wm8505_muxed_gpio_set_value,	\
+		.can_sleep		= 0,				\
+		.base			= __base,			\
+		.ngpio			= __num,			\
+	},								\
+	.shift		= __shift,					\
+	.regoff		= __off,					\
+}
+
+static struct wm8505_gpio_chip wm8505_muxed_gpios[] = {
+	WM8505_GPIO_BANK("uart0",	0,	0x20,	8,	4),
+	WM8505_GPIO_BANK("uart1",	4,	0x20,	12,	4),
+
+	WM8505_GPIO_BANK("spi0",	0,	0x1C,	16,	4),
+	WM8505_GPIO_BANK("spi1",	12,	0x1C,	20,	4),
+	WM8505_GPIO_BANK("spi2",	16,	0x1C,	24,	4),
+	WM8505_GPIO_BANK("sdmmc",	0,	0x0,	30,	8),
+
+	WM8505_GPIO_BANK("uart2",	8,	0x20,	38,	4),
+	WM8505_GPIO_BANK("uart3",	12,	0x20,	42,	4),
+	WM8505_GPIO_BANK("ac97",	0,	0x14,	48,	5),
+	WM8505_GPIO_BANK("spiflash",	0,	0x18,	53,	5),
+};
+
+static int wm8505_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	unsigned val = readl(regbase + WM8505_DIRECTION_REGS + \
+				WM8505_EXT_REGOFF);
+
+	val &= ~(1 << offset);
+	writel(val, regbase + WM8505_DIRECTION_REGS + WM8505_EXT_REGOFF);
+	return 0;
+}
+
+static int wm8505_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	unsigned val = readl(regbase + WM8505_DIRECTION_REGS + \
+				WM8505_EXT_REGOFF);
+
+	val |= (1 << offset);
+	writel(val, regbase + WM8505_DIRECTION_REGS + WM8505_EXT_REGOFF);
+
+	if (value) {
+		val = readl(regbase + WM8505_OUTVALUE_REGS + \
+				WM8505_EXT_REGOFF);
+		val |= (1 << offset);
+		writel(val, regbase + WM8505_OUTVALUE_REGS + \
+				WM8505_EXT_REGOFF);
+	}
+	return 0;
+}
+
+static int wm8505_gpio_get_value(struct gpio_chip *chip,
+				       unsigned offset)
+{
+	u32 reg_tmp;
+	reg_tmp = readl(regbase + WM8505_INVALUE_REGS + WM8505_EXT_REGOFF);
+	return (reg_tmp >> offset) & 1;
+}
+
+static void wm8505_gpio_set_value(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	unsigned val = readl(regbase + WM8505_OUTVALUE_REGS + \
+				WM8505_EXT_REGOFF);
+
+	if (value)
+		val |= (1 << offset);
+	else
+		val &= ~(1 << offset);
+
+	writel(val, regbase + WM8505_OUTVALUE_REGS + WM8505_EXT_REGOFF);
+}
+
+static int wm8505_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset > 7)
+		return -EINVAL;
+
+	return gpio_to_irq_map[offset];
+}
+
+static struct gpio_chip wm8505_external_gpios = {
+	.label			= "extgpio",
+	.direction_input	= wm8505_gpio_direction_input,
+	.direction_output	= wm8505_gpio_direction_output,
+	.get			= wm8505_gpio_get_value,
+	.set			= wm8505_gpio_set_value,
+	.to_irq			= wm8505_gpio_to_irq,
+	.can_sleep		= 0,
+	.base			= 0,
+	.ngpio			= 8,
+};
+
+void __init wm8505_gpio_init(void)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		gpio_to_irq_map[i] = wmt_gpio_ext_irq[i];
+
+	regbase = ioremap(wmt_gpio_base, SZ_64K);
+	if (!regbase) {
+		printk(KERN_ERR "Failed to map MMIO registers for GPIO\n");
+		return;
+	}
+
+	gpiochip_add(&wm8505_external_gpios);
+
+	for (i = 0; i < ARRAY_SIZE(wm8505_muxed_gpios); i++)
+		gpiochip_add(&wm8505_muxed_gpios[i].chip);
+}
