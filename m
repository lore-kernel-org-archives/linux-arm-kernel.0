From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed,  1 Jul 2015 21:41:53 +0900
Subject: [PATCH] gpio: UniPhier: add driver for UniPhier GPIO controller
Message-ID: <1435754513-19813-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This GPIO controller device is used on UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/gpio/Kconfig         |   6 +
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-uniphier.c | 274 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 drivers/gpio/gpio-uniphier.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 4c9fa58..37cb4f2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -462,6 +462,12 @@ config GPIO_TZ1090_PDC
 	help
 	  Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
 
+config GPIO_UNIPHIER
+	tristate "UniPhier GPIO"
+	depends on ARCH_UNIPHIER && OF_GPIO
+	help
+	  Say yes here to support UniPhier GPIOs.
+
 config GPIO_VF610
 	def_bool y
 	depends on ARCH_MXC && SOC_VF610
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index f82cd67..3538b0c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
 obj-$(CONFIG_GPIO_TZ1090)	+= gpio-tz1090.o
 obj-$(CONFIG_GPIO_TZ1090_PDC)	+= gpio-tz1090-pdc.o
 obj-$(CONFIG_GPIO_UCB1400)	+= gpio-ucb1400.o
+obj-$(CONFIG_GPIO_UNIPHIER)	+= gpio-uniphier.o
 obj-$(CONFIG_GPIO_VF610)	+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)	+= gpio-viperboard.o
 obj-$(CONFIG_GPIO_VR41XX)	+= gpio-vr41xx.o
diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
new file mode 100644
index 0000000..9107999
--- /dev/null
+++ b/drivers/gpio/gpio-uniphier.c
@@ -0,0 +1,274 @@
+/*
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/*
+ * Unfortunately, the hardware specification adopts weird GPIO pin labeling.
+ * The ports are named as
+ *   PORT00,  PORT01,  PORT02,  ..., PORT07,
+ *   PORT10,  PORT11,  PORT12,  ..., PORT17,
+ *   PORT20,  PORT21,  PORT22,  ..., PORT27,
+ *    ...
+ *   PORT90,  PORT91,  PORT92,  ..., PORT97,
+ *   PORT100, PORT101, PORT102, ..., PORT107,
+ *    ...
+ *
+ * The PORTs with 8 or 9 in the one's place are missing, i.e. the ne's place is
+ * octal, while the other places are decimal.  If we handle the port numbers as
+ * you see in the hardware documents, the GPIO offsets must be noncontiguous.
+ * Yeah, it is possible to have sparse GPIO pins, but not handy for GPIO range
+ * mapping, register accessing, etc.
+ *
+ * To make things simpler (for driver and device tree implementation), this
+ * driver takes GPIO offsets numbered contiguously.  GPIO consumers should make
+ * sure to convert the PORT number into the one that fits in this driver.
+ * The conversion logic is very easy math, for example,
+ *   PORT15  -->  GPIO offset 13   (8 * 1 + 5)
+ *   PORT123 -->  GPIO offset 99   (8 * 12 + 3)
+ */
+
+#define UNIPHIER_GPIO_PORTS_PER_BANK	8
+#define UNIPHIER_GPIO_BANK_MASK		\
+				((1UL << (UNIPHIER_GPIO_PORTS_PER_BANK)) - 1)
+
+#define UNIPHIER_GPIO_REG_DATA		0	/* data */
+#define UNIPHIER_GPIO_REG_DIR		4	/* direction (1:in, 0:out) */
+
+struct uniphier_gpio_priv {
+	struct of_mm_gpio_chip mmchip;
+	spinlock_t lock;
+};
+
+static unsigned uniphier_gpio_bank_to_reg(unsigned bank, unsigned reg_type)
+{
+	unsigned reg;
+
+	reg = (bank + 1) * 8 + reg_type;
+
+	/*
+	 * Unfortunately, there is a register hole@offset 0x90-0x9f.
+	 * Add 0x10 when crossing the hole.
+	 */
+	if (reg >= 0x90)
+		reg += 0x10;
+
+	return reg;
+}
+
+static void uniphier_gpio_bank_write(struct gpio_chip *chip,
+				     unsigned bank, unsigned reg_type,
+				     unsigned mask, unsigned value)
+{
+	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
+	struct uniphier_gpio_priv *priv;
+	unsigned long flags;
+	unsigned reg;
+	u32 tmp;
+
+	if (!mask)
+		return;
+
+	priv = container_of(mmchip, struct uniphier_gpio_priv, mmchip);
+
+	reg = uniphier_gpio_bank_to_reg(bank, reg_type);
+
+	/*
+	 * Note
+	 * regmap_update_bits() should not be used here.
+	 *
+	 * The DATA registers return the current readback of pins, not the
+	 * previously written data when they are configured as "input".
+	 * The DATA registers must be overwritten even if the data you are
+	 * going to write is the same as what readl() has returned.
+	 *
+	 * regmap_update_bits() does not write back if the data is not changed.
+	 */
+	spin_lock_irqsave(&priv->lock, flags);
+	tmp = readl(mmchip->regs + reg);
+	tmp &= ~mask;
+	tmp |= mask & value;
+	writel(tmp, mmchip->regs + reg);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void uniphier_gpio_offset_write(struct gpio_chip *chip, unsigned offset,
+				       unsigned reg_type, int value)
+{
+	unsigned bank = offset / UNIPHIER_GPIO_PORTS_PER_BANK;
+	unsigned bit = offset % UNIPHIER_GPIO_PORTS_PER_BANK;
+
+	uniphier_gpio_bank_write(chip, bank, reg_type, BIT(bit), value << bit);
+}
+
+static int uniphier_gpio_offset_read(struct gpio_chip *chip, unsigned offset,
+				     unsigned reg_type)
+{
+	struct of_mm_gpio_chip *mmchip = to_of_mm_gpio_chip(chip);
+	unsigned bank = offset / UNIPHIER_GPIO_PORTS_PER_BANK;
+	unsigned bit = offset % UNIPHIER_GPIO_PORTS_PER_BANK;
+	unsigned reg;
+
+	reg = uniphier_gpio_bank_to_reg(bank, reg_type);
+
+	return readl(mmchip->regs + reg) & BIT(bit) ? 1 : 0;
+}
+
+static int uniphier_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void uniphier_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+}
+
+static int uniphier_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	return uniphier_gpio_offset_read(chip, UNIPHIER_GPIO_REG_DIR, offset) ?
+		GPIOF_DIR_IN : GPIOF_DIR_OUT;
+}
+
+static int uniphier_gpio_direction_input(struct gpio_chip *chip,
+					 unsigned offset)
+{
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_REG_DIR, 1);
+
+	return 0;
+}
+
+static int uniphier_gpio_direction_output(struct gpio_chip *chip,
+					  unsigned offset, int value)
+{
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_REG_DATA, value);
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_REG_DIR, 0);
+
+	return 0;
+}
+
+static int uniphier_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return uniphier_gpio_offset_read(chip, offset, UNIPHIER_GPIO_REG_DATA);
+}
+
+static void uniphier_gpio_set(struct gpio_chip *chip,
+			      unsigned offset, int value)
+{
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_REG_DATA, value);
+}
+
+static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
+				       unsigned long *mask,
+				       unsigned long *bits)
+{
+	unsigned bank, shift, bank_mask, bank_bits;
+	int i;
+
+	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_PORTS_PER_BANK) {
+		bank = i / UNIPHIER_GPIO_PORTS_PER_BANK;
+		shift = i % BITS_PER_LONG;
+		bank_mask = (mask[BIT_WORD(i)] >> shift) &
+						UNIPHIER_GPIO_BANK_MASK;
+		bank_bits = bits[BIT_WORD(i)] >> shift;
+
+		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_REG_DATA,
+					 bank_mask, bank_bits);
+	}
+}
+
+static int uniphier_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_gpio_priv *priv;
+	u32 ngpio;
+	int ret;
+
+	ret = of_property_read_u32(dev->of_node, "ngpio", &ngpio);
+	if (ret) {
+		dev_err(dev, "failed to get ngpio property\n");
+		return ret;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+
+	priv->mmchip.gc.dev = dev;
+	priv->mmchip.gc.owner = THIS_MODULE;
+	priv->mmchip.gc.request = uniphier_gpio_request;
+	priv->mmchip.gc.free = uniphier_gpio_free;
+	priv->mmchip.gc.get_direction = uniphier_gpio_get_direction;
+	priv->mmchip.gc.direction_input = uniphier_gpio_direction_input;
+	priv->mmchip.gc.direction_output = uniphier_gpio_direction_output;
+	priv->mmchip.gc.get = uniphier_gpio_get;
+	priv->mmchip.gc.set = uniphier_gpio_set;
+	priv->mmchip.gc.set_multiple = uniphier_gpio_set_multiple;
+	priv->mmchip.gc.ngpio = ngpio;
+
+	ret = of_mm_gpiochip_add(dev->of_node, &priv->mmchip);
+	if (ret) {
+		dev_err(dev, "failed to add memory mapped gpiochip\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int uniphier_gpio_remove(struct platform_device *pdev)
+{
+	struct uniphier_gpio_priv *priv = platform_get_drvdata(pdev);
+
+	of_mm_gpiochip_remove(&priv->mmchip);
+
+	return 0;
+}
+
+static const struct of_device_id uniphier_gpio_match[] = {
+	{ .compatible = "socionext,uniphier-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_gpio_match);
+
+static struct platform_driver uniphier_gpio_driver = {
+	.probe = uniphier_gpio_probe,
+	.remove = uniphier_gpio_remove,
+	.driver = {
+		.name = "uniphier-gpio",
+		.of_match_table = uniphier_gpio_match,
+	},
+};
+
+static int __init uniphier_gpio_init(void)
+{
+	return platform_driver_register(&uniphier_gpio_driver);
+}
+subsys_initcall(uniphier_gpio_init);
+
+static void __exit uniphier_gpio_exit(void)
+{
+	platform_driver_unregister(&uniphier_gpio_driver);
+}
+module_exit(uniphier_gpio_exit);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier GPIO driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
