From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 21 Aug 2017 18:36:55 +0900
Subject: [PATCH v2] gpio: uniphier: add UniPhier GPIO controller driver
Message-ID: <1503308215-3349-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This GPIO controller device is used on UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Remove +32 offset for parent interrupts to follow the GIC
    binding convention
  - Let uniphier_gpio_irq_alloc() fail if nr_irqs != 1
  - Allocate gpio_chip statically because just one instance is
    supported
  - Fix suspend and resume hooks

 .../devicetree/bindings/gpio/gpio-uniphier.txt     |  42 ++
 MAINTAINERS                                        |   1 +
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-uniphier.c                       | 591 +++++++++++++++++++++
 include/dt-bindings/gpio/uniphier-gpio.h           |  18 +
 6 files changed, 660 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 create mode 100644 drivers/gpio/gpio-uniphier.c
 create mode 100644 include/dt-bindings/gpio/uniphier-gpio.h

diff --git a/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
new file mode 100644
index 000000000000..8e3e1fe0d072
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
@@ -0,0 +1,42 @@
+UniPhier GPIO controller
+
+Required properties:
+- compatible: Should be one of the following:
+    "socionext,uniphier-ld4-gpio"  - for LD4 SoC
+    "socionext,uniphier-pro4-gpio" - for Pro4 SoC
+    "socionext,uniphier-sld8-gpio" - for sLD8 SoC
+    "socionext,uniphier-pro5-gpio" - for Pro5 SoC
+    "socionext,uniphier-pxs2-gpio" - for PXs2/LD6b SoC
+    "socionext,uniphier-ld11-gpio" - for LD11 SoC
+    "socionext,uniphier-ld20-gpio" - for LD20 SoC
+    "socionext,uniphier-pxs3-gpio" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be 2.  The first cell is the pin number and the second
+  cell is used to specify optional parameters
+- interrupt-parent: Specifies the parent interrupt controller.
+- interrupt-controller: Marks the device node as an interrupt controller
+- #interrupt-cells: Should be 2.  The first cell defines the interrupt number.
+  The second cell bits[3:0] is used to specify trigger type as follows:
+    1 = low-to-high edge triggered
+    2 = high-to-low edge triggered
+    4 = active high level-sensitive
+    8 = active low level-sensitive
+  Valid combinations are 1, 2, 3, 4, 8.
+- gpio-ranges: Mapping to pin controller pins (as described in gpio.txt)
+
+Optional properties:
+- gpio-ranges-group-names: Used for named gpio ranges (as described in gpio.txt)
+
+Example:
+	gpio: gpio at 55000000 {
+		compatible = "socionext,uniphier-pro4-gpio";
+		reg = <0x55000000 0x200>;
+		interrupt-parent = <&aidet>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pinctrl 0 0 0>;
+		gpio-ranges-group-names = "gpio_range";
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b84f047b3fd..9a1f94ff99a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1992,6 +1992,7 @@ F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/
 F:	drivers/bus/uniphier-system-bus.c
 F:	drivers/clk/uniphier/
+F:	drivers/gpio/gpio-uniphier.c
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/irqchip/irq-uniphier-aidet.c
 F:	drivers/pinctrl/uniphier/
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 461d6fc3688b..5f6d2e984bb6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -465,6 +465,13 @@ config GPIO_TZ1090_PDC
 	help
 	  Say yes here to support Toumaz Xenif TZ1090 PDC GPIOs.
 
+config GPIO_UNIPHIER
+	tristate "UniPhier GPIO support"
+	depends on ARCH_UNIPHIER
+	depends on OF_GPIO
+	help
+	  Say yes here to support UniPhier GPIOs.
+
 config GPIO_VF610
 	def_bool y
 	depends on ARCH_MXC && SOC_VF610
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a9fda6c55113..1de9fdb8cff9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_GPIO_TWL6040)	+= gpio-twl6040.o
 obj-$(CONFIG_GPIO_TZ1090)	+= gpio-tz1090.o
 obj-$(CONFIG_GPIO_TZ1090_PDC)	+= gpio-tz1090-pdc.o
 obj-$(CONFIG_GPIO_UCB1400)	+= gpio-ucb1400.o
+obj-$(CONFIG_GPIO_UNIPHIER)	+= gpio-uniphier.o
 obj-$(CONFIG_GPIO_VF610)	+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)	+= gpio-viperboard.o
 obj-$(CONFIG_GPIO_VR41XX)	+= gpio-vr41xx.o
diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
new file mode 100644
index 000000000000..3c096b41208d
--- /dev/null
+++ b/drivers/gpio/gpio-uniphier.c
@@ -0,0 +1,591 @@
+/*
+ * Copyright (C) 2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+#include <linux/gpio/driver.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <dt-bindings/gpio/uniphier-gpio.h>
+
+#define UNIPHIER_GPIO_BANK_MASK		\
+				GENMASK((UNIPHIER_GPIO_LINES_PER_BANK) - 1, 0)
+
+#define UNIPHIER_GPIO_IRQ_NUM		24
+
+#define UNIPHIER_GPIO_PORT_DATA		0x0	/* data */
+#define UNIPHIER_GPIO_PORT_DIR		0x4	/* direction (1:in, 0:out) */
+#define UNIPHIER_GPIO_IRQ_EN		0x90	/* irq enable */
+#define UNIPHIER_GPIO_IRQ_MODE		0x94	/* irq mode (1: both edge) */
+#define UNIPHIER_GPIO_IRQ_FLT_EN	0x98	/* noise filter enable */
+#define UNIPHIER_GPIO_IRQ_FLT_CYC	0x9c	/* noise filter clock cycle */
+
+struct uniphier_gpio_socdata {
+	unsigned int ngpio;
+	bool (*is_valid_irq)(unsigned int hwirq);
+	bool (*is_input_only)(unsigned int offset);
+};
+
+struct uniphier_gpio_priv {
+	struct irq_domain *domain;
+	const struct uniphier_gpio_socdata *socdata;
+	void __iomem *regs;
+	spinlock_t lock;
+	u32 saved_vals[0];
+};
+
+static unsigned int uniphier_gpio_bank_to_reg(unsigned int bank)
+{
+	unsigned int reg;
+
+	reg = (bank + 1) * 8;
+
+	/*
+	 * Unfortunately, the GPIO port registers are not contiguous because
+	 * offset 0x90-0x9f is used for IRQ.  Add 0x10 when crossing the region.
+	 */
+	if (reg >= UNIPHIER_GPIO_IRQ_EN)
+		reg += 0x10;
+
+	return reg;
+}
+
+static void uniphier_gpio_get_bank_and_mask(unsigned int offset,
+					    unsigned int *bank, u32 *mask)
+{
+	*bank = offset / UNIPHIER_GPIO_LINES_PER_BANK;
+	*mask = BIT(offset % UNIPHIER_GPIO_LINES_PER_BANK);
+}
+
+static void uniphier_gpio_reg_update(struct uniphier_gpio_priv *priv,
+				     unsigned int reg, u32 mask, u32 val)
+{
+	unsigned long flags;
+	u32 tmp;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	tmp = readl(priv->regs + reg);
+	tmp &= ~mask;
+	tmp |= mask & val;
+	writel(tmp, priv->regs + reg);
+	spin_unlock_irqrestore(&priv->lock, flags);
+}
+
+static void uniphier_gpio_bank_write(struct gpio_chip *chip, unsigned int bank,
+				     unsigned int reg, u32 mask, u32 val)
+{
+	struct uniphier_gpio_priv *priv = gpiochip_get_data(chip);
+
+	if (!mask)
+		return;
+
+	uniphier_gpio_reg_update(priv, uniphier_gpio_bank_to_reg(bank) + reg,
+				 mask, val);
+}
+
+static void uniphier_gpio_offset_write(struct gpio_chip *chip,
+				       unsigned int offset, unsigned int reg,
+				       int val)
+{
+	unsigned int bank;
+	u32 mask;
+
+	uniphier_gpio_get_bank_and_mask(offset, &bank, &mask);
+
+	uniphier_gpio_bank_write(chip, bank, reg, mask, val ? mask : 0);
+}
+
+static int uniphier_gpio_offset_read(struct gpio_chip *chip,
+				     unsigned int offset, unsigned int reg)
+{
+	struct uniphier_gpio_priv *priv = gpiochip_get_data(chip);
+	unsigned int bank, reg_offset;
+	u32 mask;
+
+	uniphier_gpio_get_bank_and_mask(offset, &bank, &mask);
+	reg_offset = uniphier_gpio_bank_to_reg(bank) + reg;
+
+	return !!(readl(priv->regs + reg_offset) & mask);
+}
+
+static int uniphier_gpio_get_direction(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	return uniphier_gpio_offset_read(chip, offset, UNIPHIER_GPIO_PORT_DIR);
+}
+
+static int uniphier_gpio_direction_input(struct gpio_chip *chip,
+					 unsigned int offset)
+{
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_PORT_DIR, 1);
+
+	return 0;
+}
+
+static int uniphier_gpio_direction_output(struct gpio_chip *chip,
+					  unsigned int offset, int val)
+{
+	struct uniphier_gpio_priv *priv = gpiochip_get_data(chip);
+
+	if (priv->socdata->is_input_only &&
+	    priv->socdata->is_input_only(offset)) {
+		dev_err(chip->parent, "GPIO%d is input only port\n", offset);
+		return -EINVAL;
+	}
+
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_PORT_DATA, val);
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_PORT_DIR, 0);
+
+	return 0;
+}
+
+static int uniphier_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	return uniphier_gpio_offset_read(chip, offset, UNIPHIER_GPIO_PORT_DATA);
+}
+
+static void uniphier_gpio_set(struct gpio_chip *chip,
+			      unsigned int offset, int val)
+{
+	uniphier_gpio_offset_write(chip, offset, UNIPHIER_GPIO_PORT_DATA, val);
+}
+
+static void uniphier_gpio_set_multiple(struct gpio_chip *chip,
+				       unsigned long *mask, unsigned long *bits)
+{
+	unsigned int bank, shift, bank_mask, bank_bits;
+	int i;
+
+	for (i = 0; i < chip->ngpio; i += UNIPHIER_GPIO_LINES_PER_BANK) {
+		bank = i / UNIPHIER_GPIO_LINES_PER_BANK;
+		shift = i % BITS_PER_LONG;
+		bank_mask = (mask[BIT_WORD(i)] >> shift) &
+						UNIPHIER_GPIO_BANK_MASK;
+		bank_bits = bits[BIT_WORD(i)] >> shift;
+
+		uniphier_gpio_bank_write(chip, bank, UNIPHIER_GPIO_PORT_DATA,
+					 bank_mask, bank_bits);
+	}
+}
+
+static int uniphier_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct irq_fwspec fwspec;
+
+	if (offset < UNIPHIER_GPIO_IRQ_OFFSET)
+		return -ENXIO;
+
+	fwspec.fwnode = of_node_to_fwnode(chip->parent->of_node);
+	fwspec.param_count = 2;
+	fwspec.param[0] = offset - UNIPHIER_GPIO_IRQ_OFFSET;
+	fwspec.param[1] = IRQ_TYPE_NONE;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
+static struct gpio_chip uniphier_gpio_chip = {
+	.label = "UniPhier GPIO",
+	.request = gpiochip_generic_request,
+	.free = gpiochip_generic_free,
+	.get_direction = uniphier_gpio_get_direction,
+	.direction_input = uniphier_gpio_direction_input,
+	.direction_output = uniphier_gpio_direction_output,
+	.get = uniphier_gpio_get,
+	.set = uniphier_gpio_set,
+	.set_multiple = uniphier_gpio_set_multiple,
+	.to_irq = uniphier_gpio_to_irq,
+	.base = -1,
+};
+
+static void uniphier_gpio_irq_mask(struct irq_data *data)
+{
+	struct uniphier_gpio_priv *priv = data->chip_data;
+	u32 mask = BIT(data->hwirq);
+
+	uniphier_gpio_reg_update(priv, UNIPHIER_GPIO_IRQ_EN, mask, 0);
+
+	return irq_chip_mask_parent(data);
+}
+
+static void uniphier_gpio_irq_unmask(struct irq_data *data)
+{
+	struct uniphier_gpio_priv *priv = data->chip_data;
+	u32 mask = BIT(data->hwirq);
+
+	uniphier_gpio_reg_update(priv, UNIPHIER_GPIO_IRQ_EN, mask, mask);
+
+	return irq_chip_unmask_parent(data);
+}
+
+static int uniphier_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct uniphier_gpio_priv *priv = data->chip_data;
+	u32 mask = BIT(data->hwirq);
+	u32 val = 0;
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		val = mask;
+		type = IRQ_TYPE_EDGE_FALLING;
+	}
+
+	uniphier_gpio_reg_update(priv, UNIPHIER_GPIO_IRQ_MODE, mask, val);
+	/* To enable both edge detection, the noise filter must be enabled. */
+	uniphier_gpio_reg_update(priv, UNIPHIER_GPIO_IRQ_FLT_EN, mask, val);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip uniphier_gpio_irq_chip = {
+	.name = "GPIO",
+	.irq_mask = uniphier_gpio_irq_mask,
+	.irq_unmask = uniphier_gpio_irq_unmask,
+	.irq_eoi = irq_chip_eoi_parent,
+	.irq_set_type = uniphier_gpio_irq_set_type,
+};
+
+static const u32 uniphier_gpio_irq_parent_hwirqs[] = {
+	48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
+	154, 155, 156, 157, 158, 217, 218, 219,
+};
+
+static int uniphier_gpio_irq_domain_translate(struct irq_domain *domain,
+					      struct irq_fwspec *fwspec,
+					      unsigned long *out_hwirq,
+					      unsigned int *out_type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+
+	*out_hwirq = fwspec->param[0];
+	*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int uniphier_gpio_irq_domain_alloc(struct irq_domain *domain,
+					  unsigned int virq,
+					  unsigned int nr_irqs, void *arg)
+{
+	struct uniphier_gpio_priv *priv = domain->host_data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = uniphier_gpio_irq_domain_translate(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	if (!priv->socdata->is_valid_irq(hwirq))
+		return -ENXIO;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					    &uniphier_gpio_irq_chip, priv);
+	if (ret)
+		return ret;
+
+	if (type == IRQ_TYPE_EDGE_BOTH)
+		type = IRQ_TYPE_EDGE_FALLING;
+
+	BUILD_BUG_ON(ARRAY_SIZE(uniphier_gpio_irq_parent_hwirqs) >
+		     UNIPHIER_GPIO_IRQ_NUM);
+
+	/* parent is UniPhier AIDET */
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 2;
+	parent_fwspec.param[0] = uniphier_gpio_irq_parent_hwirqs[hwirq];
+	parent_fwspec.param[1] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+}
+
+static void uniphier_gpio_irq_domain_activate(struct irq_domain *domain,
+					      struct irq_data *data)
+{
+	gpiochip_lock_as_irq(&uniphier_gpio_chip,
+			     data->hwirq + UNIPHIER_GPIO_IRQ_OFFSET);
+}
+
+static void uniphier_gpio_irq_domain_deactivate(struct irq_domain *domain,
+						struct irq_data *data)
+{
+	gpiochip_unlock_as_irq(&uniphier_gpio_chip,
+			       data->hwirq + UNIPHIER_GPIO_IRQ_OFFSET);
+}
+
+static const struct irq_domain_ops uniphier_gpio_irq_domain_ops = {
+	.alloc = uniphier_gpio_irq_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.activate = uniphier_gpio_irq_domain_activate,
+	.deactivate = uniphier_gpio_irq_domain_deactivate,
+	.translate = uniphier_gpio_irq_domain_translate,
+};
+
+static void uniphier_gpio_hw_init(struct uniphier_gpio_priv *priv)
+{
+	/*
+	 * To detect both edge interrupts, the noise filter must be enabled.
+	 * This filter is intended to remove the noise from the irq lines.
+	 * It does not work for GPIO input, so GPIO debounce is not supported.
+	 * Unfortunately, the filter period is shared among all irq lines.
+	 * Just choose a sensible period here.
+	 */
+	writel(0xff, priv->regs + UNIPHIER_GPIO_IRQ_FLT_CYC);
+}
+
+static unsigned int uniphier_gpio_get_nbanks(unsigned int ngpio)
+{
+	return DIV_ROUND_UP(ngpio, UNIPHIER_GPIO_LINES_PER_BANK);
+}
+
+static int uniphier_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *parent_np;
+	struct irq_domain *parent_domain;
+	struct uniphier_gpio_priv *priv;
+	const struct uniphier_gpio_socdata *data;
+	struct resource *regs;
+	unsigned int nregs;
+	int ret;
+
+	parent_np = of_irq_find_parent(dev->of_node);
+	if (!parent_np)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_np);
+	of_node_put(parent_np);
+	if (!parent_domain)
+		return -EPROBE_DEFER;
+
+	data = of_device_get_match_data(dev);
+	if (WARN_ON(!data || !data->is_valid_irq))
+		return -EINVAL;
+
+	nregs = DIV_ROUND_UP(data->ngpio, UNIPHIER_GPIO_LINES_PER_BANK) * 2 + 3;
+
+	nregs = uniphier_gpio_get_nbanks(data->ngpio) * 2 + 3;
+	priv = devm_kzalloc(dev,
+			    sizeof(*priv) + sizeof(priv->saved_vals[0]) * nregs,
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->regs = devm_ioremap_resource(dev, regs);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	spin_lock_init(&priv->lock);
+	priv->socdata = data;
+
+	uniphier_gpio_hw_init(priv);
+
+	uniphier_gpio_chip.parent = dev;
+	uniphier_gpio_chip.ngpio = data->ngpio;
+
+	ret = devm_gpiochip_add_data(dev, &uniphier_gpio_chip, priv);
+	if (ret)
+		return ret;
+
+	priv->domain = irq_domain_add_hierarchy(parent_domain, 0,
+						UNIPHIER_GPIO_IRQ_NUM,
+						dev->of_node,
+						&uniphier_gpio_irq_domain_ops,
+						priv);
+	if (!priv->domain)
+		return -ENOMEM;
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
+	irq_domain_remove(priv->domain);
+
+	return 0;
+}
+
+static int __maybe_unused uniphier_gpio_suspend(struct device *dev)
+{
+	struct uniphier_gpio_priv *priv = dev_get_drvdata(dev);
+	unsigned int nbanks = uniphier_gpio_get_nbanks(priv->socdata->ngpio);
+	u32 *val = priv->saved_vals;
+	unsigned int reg;
+	int i;
+
+	for (i = 0; i < nbanks; i++) {
+		reg = uniphier_gpio_bank_to_reg(i);
+
+		*val++ = readl(priv->regs + reg + UNIPHIER_GPIO_PORT_DATA);
+		*val++ = readl(priv->regs + reg + UNIPHIER_GPIO_PORT_DIR);
+	}
+
+	*val++ = readl(priv->regs + UNIPHIER_GPIO_IRQ_EN);
+	*val++ = readl(priv->regs + UNIPHIER_GPIO_IRQ_MODE);
+	*val++ = readl(priv->regs + UNIPHIER_GPIO_IRQ_FLT_EN);
+
+	return 0;
+}
+
+static int __maybe_unused uniphier_gpio_resume(struct device *dev)
+{
+	struct uniphier_gpio_priv *priv = dev_get_drvdata(dev);
+	unsigned int nbanks = uniphier_gpio_get_nbanks(priv->socdata->ngpio);
+	const u32 *val = priv->saved_vals;
+	unsigned int reg;
+	int i;
+
+	for (i = 0; i < nbanks; i++) {
+		reg = uniphier_gpio_bank_to_reg(i);
+
+		writel(*val++, priv->regs + reg + UNIPHIER_GPIO_PORT_DATA);
+		writel(*val++, priv->regs + reg + UNIPHIER_GPIO_PORT_DIR);
+	}
+
+	writel(*val++, priv->regs + UNIPHIER_GPIO_IRQ_EN);
+	writel(*val++, priv->regs + UNIPHIER_GPIO_IRQ_MODE);
+	writel(*val++, priv->regs + UNIPHIER_GPIO_IRQ_FLT_EN);
+
+	uniphier_gpio_hw_init(priv);
+
+	return 0;
+}
+
+static const struct dev_pm_ops uniphier_gpio_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(uniphier_gpio_suspend,
+				     uniphier_gpio_resume)
+};
+
+static bool uniphier_ld4_gpio_is_valid_irq(unsigned int hwirq)
+{
+	return hwirq < 16 && hwirq != 13;
+}
+
+static const struct uniphier_gpio_socdata uniphier_ld4_gpio_data = {
+	.ngpio = 136,
+	.is_valid_irq = uniphier_ld4_gpio_is_valid_irq,
+};
+
+static bool uniphier_pro4_gpio_is_valid_irq(unsigned int hwirq)
+{
+	return hwirq < 21;
+}
+
+static const struct uniphier_gpio_socdata uniphier_pro4_gpio_data = {
+	.ngpio = 248,
+	.is_valid_irq = uniphier_pro4_gpio_is_valid_irq,
+};
+
+static bool uniphier_pxs2_gpio_is_valid_irq(unsigned int hwirq)
+{
+	return hwirq < 24;
+}
+
+static const struct uniphier_gpio_socdata uniphier_pxs2_gpio_data = {
+	.ngpio = 232,
+	.is_valid_irq = uniphier_pxs2_gpio_is_valid_irq,
+};
+
+static bool uniphier_ld11_gpio_is_input_only(unsigned int offset)
+{
+	return offset >= 144 && offset <= 151;
+}
+
+static const struct uniphier_gpio_socdata uniphier_ld11_gpio_data = {
+	.ngpio = 200,
+	.is_valid_irq = uniphier_pxs2_gpio_is_valid_irq,
+	.is_input_only = uniphier_ld11_gpio_is_input_only,
+};
+
+static const struct uniphier_gpio_socdata uniphier_ld20_gpio_data = {
+	.ngpio = 205,
+	.is_valid_irq = uniphier_pxs2_gpio_is_valid_irq,
+	.is_input_only = uniphier_ld11_gpio_is_input_only,
+};
+
+static bool uniphier_pxs3_gpio_is_input_only(unsigned int offset)
+{
+	return offset >= 144 && offset <= 161;
+}
+
+static const struct uniphier_gpio_socdata uniphier_pxs3_gpio_data = {
+	.ngpio = 286,
+	.is_valid_irq = uniphier_pxs2_gpio_is_valid_irq,
+	.is_input_only = uniphier_pxs3_gpio_is_input_only,
+};
+
+static const struct of_device_id uniphier_gpio_match[] = {
+	{
+		.compatible = "socionext,uniphier-ld4-gpio",
+		.data = &uniphier_ld4_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-gpio",
+		.data = &uniphier_pro4_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-gpio",
+		.data = &uniphier_ld4_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-gpio",
+		.data = &uniphier_pro4_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-gpio",
+		.data = &uniphier_pxs2_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-gpio",
+		.data = &uniphier_ld11_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-gpio",
+		.data = &uniphier_ld20_gpio_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs3-gpio",
+		.data = &uniphier_pxs3_gpio_data,
+	},
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
+		.pm = &uniphier_gpio_pm_ops,
+	},
+};
+module_platform_driver(uniphier_gpio_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier GPIO driver");
+MODULE_LICENSE("GPL");
diff --git a/include/dt-bindings/gpio/uniphier-gpio.h b/include/dt-bindings/gpio/uniphier-gpio.h
new file mode 100644
index 000000000000..9f0ad174f61c
--- /dev/null
+++ b/include/dt-bindings/gpio/uniphier-gpio.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) 2017 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ */
+
+#ifndef _DT_BINDINGS_GPIO_UNIPHIER_H
+#define _DT_BINDINGS_GPIO_UNIPHIER_H
+
+#define UNIPHIER_GPIO_LINES_PER_BANK	8
+
+#define UNIPHIER_GPIO_IRQ_OFFSET	((UNIPHIER_GPIO_LINES_PER_BANK) * 15)
+
+#define UNIPHIER_GPIO_PORT(bank, line)	\
+			((UNIPHIER_GPIO_LINES_PER_BANK) * (bank) + (line))
+
+#define UNIPHIER_GPIO_IRQ(n)		((UNIPHIER_GPIO_IRQ_OFFSET) + (n))
+
+#endif /* _DT_BINDINGS_GPIO_UNIPHIER_H */
-- 
2.7.4
