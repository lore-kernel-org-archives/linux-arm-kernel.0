From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:29:55 +0200
Subject: [PATCH 4/4] gpio: lpc32xx: add new LPC32xx GPIO controller driver
In-Reply-To: <1447982995-30231-1-git-send-email-vz@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
Message-ID: <1447982995-30231-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds a replacement to a legacy unmaintainable LPC32xx GPIO
controller driver.

The driver gets all information to configure a GPIO bank from its
device tree node, the driver is capable to assign interrupt controller
roles to its GPIO banks and it has no hardcoded dependencies on
hardware interrupt numbers, control register addresses, mapping of
GPIO lines to interrupts or bitfields.

The new driver is compatible with device tree clients of the legacy
driver, no changes on GPIO client side are needed.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/gpio/Kconfig        |   8 +
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-lpc32xx.c | 660 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 669 insertions(+)
 create mode 100644 drivers/gpio/gpio-lpc32xx.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b18bea0..fce33d3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -246,6 +246,14 @@ config GPIO_LPC18XX
 	  Select this option to enable GPIO driver for
 	  NXP LPC18XX/43XX devices.
 
+config GPIO_LPC32XX
+	bool "NXP LPC32 GPIO support"
+	default y if ARCH_LPC32XX
+	depends on OF_GPIO && (ARCH_LPC32XX || COMPILE_TEST)
+	help
+	  Select this option to enable GPIO driver for
+	  NXP LPC32XX devices.
+
 config GPIO_LYNXPOINT
 	tristate "Intel Lynxpoint GPIO support"
 	depends on ACPI && X86
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index e3ccd99..f71a770 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
 obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
 obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
 obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
+obj-$(CONFIG_GPIO_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
new file mode 100644
index 0000000..99db0f8
--- /dev/null
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -0,0 +1,660 @@
+/*
+ * NXP LPC32xx GPIO controller driver
+ *
+ * Copyright (C) 2015 Vladimir Zapolskiy <vz@mleia.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/interrupt.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/slab.h>
+
+#define LPC32XX_GPIO_BANKS		6
+
+#define LPC32XX_GPIO_INPUT		0x00
+#define LPC32XX_GPIO_OUTPUT		0x04
+#define LPC32XX_GPIO_DIR		0x10
+
+#define LPC32XX_GPIO_P2_DIR		0x00
+#define LPC32XX_GPIO_P2_INPUT		0x0C
+#define LPC32XX_GPIO_P2_OUTPUT		0x10
+
+#define LPC32XX_GPIO_CLEAR		0x04
+#define LPC32XX_GPIO_STATE		0x08
+
+#define to_lpc32xx_gpio_chip(c)	container_of(chip, struct lpc32xx_gpio_chip, c)
+
+struct lpc32xx_gpio_chip;
+
+struct lpc32xx_irq_data {
+	struct lpc32xx_gpio_chip *bank;
+	u32 idx;
+	u32 parent;
+	u32 gpio;
+};
+
+struct lpc32xx_gpio_chip {
+	struct gpio_chip chip;
+
+	struct device *dev;
+	void __iomem *base;
+	void __iomem *input;
+	void __iomem *output;
+	void __iomem *dir;
+
+	bool input_only;
+	bool output_only;
+	u32 *output_states;
+	u32 offset;
+	u32 input_mask;
+	u32 interrupt_mask;
+
+	const char **gpio_names;
+
+	u32 nirq;
+	struct resource *irq_res;
+	struct lpc32xx_irq_data *irqs;
+};
+
+static struct lpc32xx_gpio_chip *lpc32xx_gpio_chips[LPC32XX_GPIO_BANKS];
+
+/* Count set bits in mask, i.e. get max relative bit position */
+static int bit_count(u32 mask)
+{
+	int count = 0;
+
+	for (; mask; mask >>= 1)
+		if (mask & 0x1)
+			count++;
+
+	return count;
+}
+
+/*
+ * If mask has less or equal than "rel" set bits, i.e.
+ * relative bit is set, find its abosulute bit position
+ */
+static int bit_abs(u32 rel, u32 mask)
+{
+	int idx, val = 0;
+
+	for (idx = 0; idx <= rel; val++, mask >>= 1) {
+		if (mask & 0x1)
+			idx++;
+		if (!mask)
+			return -EINVAL;
+	}
+	val--;
+
+	return val;
+}
+
+/*
+ * If mask has set bit on absolute position,
+ * find relative bit number in set bits
+ */
+static int bit_rel(u32 abs, u32 mask)
+{
+	int val = 0;
+
+	if (!(BIT(abs) & mask))
+		return -EINVAL;
+
+	for (; abs; abs--, mask >>= 1) {
+		if (mask & 0x1)
+			val++;
+	}
+	return val;
+}
+
+/*
+ * Composition of bit_abs() and bit_rel(),
+ * mapping of one relative bit position into another
+ */
+static int bit_map(u32 rel, u32 from, u32 to)
+{
+	int ret;
+
+	ret = bit_abs(rel, from);
+	if (ret < 0)
+		return ret;
+	return bit_rel(ret, to);
+}
+
+static int lpc32xx_gpio_dir_get(struct gpio_chip *chip, unsigned int gpio)
+{
+	struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
+	u32 val;
+
+	if (c->output_only)
+		return GPIOF_DIR_OUT;
+	if (c->input_only)
+		return GPIOF_DIR_IN;
+
+	val = readl(c->dir + LPC32XX_GPIO_STATE);
+	if (val & BIT(gpio + c->offset))
+		return GPIOF_DIR_OUT;
+	else
+		return GPIOF_DIR_IN;
+}
+
+static int lpc32xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
+{
+	struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
+	u32 val, direction = lpc32xx_gpio_dir_get(chip, gpio);
+	int ret;
+
+	if (direction == GPIOF_DIR_OUT) {
+		/* Return cached value in case of P2 bank */
+		if (c->output_states)
+			return c->output_states[gpio];
+
+		val = readl(c->output + LPC32XX_GPIO_STATE);
+		val >>= gpio + c->offset;
+	} else {
+		if (c->input_mask) {
+			/* Special case of GPI and GPIO decomposition */
+			ret = bit_abs(gpio, c->input_mask);
+			if (ret < 0)
+				return ret;
+		} else {
+			ret = gpio;
+		}
+
+		val = readl(c->input) >> ret;
+	}
+
+	return val & 0x1;
+}
+
+static void lpc32xx_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
+{
+	struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
+
+	if (value)
+		writel(BIT(gpio + c->offset), c->output);
+	else
+		writel(BIT(gpio + c->offset), c->output + LPC32XX_GPIO_CLEAR);
+}
+
+static int lpc32xx_gpio_dir_input(struct gpio_chip *chip, unsigned gpio)
+{
+	struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
+
+	if (c->output_only)
+		return -EINVAL;
+
+	writel(BIT(gpio + c->offset), c->dir + LPC32XX_GPIO_CLEAR);
+
+	return 0;
+}
+
+static int lpc32xx_gpio_dir_output(struct gpio_chip *chip,
+				   unsigned gpio, int value)
+{
+	struct lpc32xx_gpio_chip *c = to_lpc32xx_gpio_chip(chip);
+
+	if (c->input_only)
+		return -EINVAL;
+
+	writel(BIT(gpio + c->offset), c->dir);
+	lpc32xx_gpio_set(chip, gpio, value);
+
+	return 0;
+}
+
+static int lpc32xx_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
+{
+	struct lpc32xx_gpio_chip *bank = to_lpc32xx_gpio_chip(chip);
+	int ret;
+
+	if (!bank->chip.irqchip) {
+		dev_dbg(bank->dev, "%s: no interrupt controller\n",
+			bank->gpio_names[gpio]);
+		return -EINVAL;
+	}
+
+	if (bank->input_mask) {
+		ret = bit_map(gpio, bank->input_mask, bank->interrupt_mask);
+		if (ret >= 0)
+			ret = irq_find_mapping(bank->chip.irqdomain, ret);
+	}
+
+	return ret;
+}
+
+static irqreturn_t lpc32xx_gpio_irq_handler(int irq, void *irqdata)
+{
+	struct lpc32xx_irq_data *data = irqdata;
+	struct lpc32xx_gpio_chip *c = data->bank;
+	int virq = irq_find_mapping(c->chip.irqdomain, data->idx);
+	u32 val;
+
+	if (irq_get_trigger_type(virq) == IRQ_TYPE_EDGE_BOTH) {
+		val = lpc32xx_gpio_get(&c->chip, c->irqs[data->idx].gpio);
+		if (val)
+			irq_set_irq_type(irq, IRQ_TYPE_EDGE_FALLING);
+		else
+			irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+	}
+
+	generic_handle_irq(virq);
+
+	return IRQ_HANDLED;
+}
+
+static int lpc32xx_gpio_irq_set_type(struct irq_data *d, unsigned type)
+{
+	struct irq_domain *id = d->domain;
+	struct lpc32xx_gpio_chip *c = (struct lpc32xx_gpio_chip *)id->host_data;
+	u32 val;
+
+	irqd_set_trigger_type(d, type);
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		val = lpc32xx_gpio_get(&c->chip, c->irqs[d->hwirq].gpio);
+		if (val)
+			type = IRQ_TYPE_EDGE_FALLING;
+		else
+			type = IRQ_TYPE_EDGE_RISING;
+	}
+
+	irq_set_irq_type(c->irqs[d->hwirq].parent, type);
+
+	return 0;
+}
+
+static unsigned int lpc32xx_gpio_irq_startup(struct irq_data *d)
+{
+	struct irq_domain *id = d->domain;
+	struct lpc32xx_gpio_chip *c = (struct lpc32xx_gpio_chip *)id->host_data;
+	int ret;
+
+	ret = request_irq(c->irqs[d->hwirq].parent,
+			  lpc32xx_gpio_irq_handler,
+			  IRQF_TRIGGER_NONE, dev_name(c->dev),
+			  &c->irqs[d->hwirq]);
+	if (ret)
+		dev_err(c->dev, "can not request irq %lu: %d\n", d->hwirq, ret);
+
+	return ret;
+}
+
+static void lpc32xx_gpio_irq_shutdown(struct irq_data *d)
+{
+	struct irq_domain *id = d->domain;
+	struct lpc32xx_gpio_chip *c = (struct lpc32xx_gpio_chip *)id->host_data;
+
+	free_irq(c->irqs[d->hwirq].parent, &c->irqs[d->hwirq]);
+}
+
+static int lpc32xx_gpiochip_irq_map(struct irq_domain *d, unsigned int virq,
+				    irq_hw_number_t hwirq)
+{
+	struct lpc32xx_gpio_chip *bank = d->host_data;
+
+	irq_set_chip_and_handler(virq, bank->chip.irqchip, handle_simple_irq);
+	irq_set_noprobe(virq);
+
+	return 0;
+}
+
+static void lpc32xx_gpiochip_irq_unmap(struct irq_domain *d, unsigned int virq)
+{
+	irq_set_chip_and_handler(virq, NULL, NULL);
+}
+
+static const struct irq_domain_ops lpc32xx_gpiochip_domain_ops = {
+	.map	= lpc32xx_gpiochip_irq_map,
+	.unmap	= lpc32xx_gpiochip_irq_unmap,
+	.xlate	= irq_domain_xlate_twocell,
+};
+
+static int lpc32xx_of_xlate(struct gpio_chip *gc,
+			    const struct of_phandle_args *gpiospec, u32 *flags)
+{
+	u32 idx = gpiospec->args[0];
+
+	if (idx > LPC32XX_GPIO_BANKS || &lpc32xx_gpio_chips[idx]->chip != gc)
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[2];
+
+	return gpiospec->args[1];
+}
+
+static int lpc32xx_add_irqchip(struct lpc32xx_gpio_chip *bank,
+			       struct device_node *node)
+{
+	int idx, virq;
+	struct gpio_chip *gpiochip = &bank->chip;
+	struct irq_chip *irqchip;
+
+	irqchip = devm_kzalloc(bank->dev, sizeof(*irqchip), GFP_KERNEL);
+	if (!irqchip)
+		return -ENOMEM;
+
+	irqchip->name		= bank->chip.label;
+	irqchip->irq_startup	= lpc32xx_gpio_irq_startup;
+	irqchip->irq_shutdown	= lpc32xx_gpio_irq_shutdown;
+	irqchip->irq_set_type	= lpc32xx_gpio_irq_set_type;
+
+	gpiochip->irqdomain = irq_domain_add_linear(node, bank->nirq,
+					  &lpc32xx_gpiochip_domain_ops, bank);
+	if (!gpiochip->irqdomain) {
+		dev_err(bank->dev, "unable to add irq domain\n");
+		return -EINVAL;
+	}
+
+	gpiochip->irqchip = irqchip;
+	for (idx = 0; idx < bank->nirq; idx++) {
+		virq = irq_create_mapping(gpiochip->irqdomain, idx);
+		if (!virq) {
+			dev_err(bank->dev, "can not create irq mapping\n");
+			goto error;
+		}
+	}
+
+	return 0;
+
+ error:
+	for (idx = 0; idx < bank->nirq; idx++)
+		irq_dispose_mapping(irq_find_mapping(gpiochip->irqdomain, idx));
+
+	irq_domain_remove(gpiochip->irqdomain);
+	gpiochip->irqdomain = NULL;
+	gpiochip->irqchip = NULL;
+
+	return -EINVAL;
+}
+
+static int lpc32xx_set_irqs(struct lpc32xx_gpio_chip *bank,
+			    struct device_node *node)
+{
+	int idx, ret;
+	u32 nirq;
+
+	nirq = bit_count(bank->interrupt_mask);
+	if (nirq != of_irq_count(node)) {
+		dev_err(bank->dev, "mismatch in interrupt configuration\n");
+		return -EINVAL;
+	}
+
+	bank->irqs = devm_kzalloc(bank->dev, sizeof(*bank->irqs) * nirq,
+				  GFP_KERNEL);
+	if (!bank->irqs)
+		return -ENOMEM;
+
+	for (idx = 0; idx < nirq; idx++) {
+		bank->irqs[idx].parent = irq_of_parse_and_map(node, idx);
+		if (!bank->irqs[idx].parent) {
+			dev_err(bank->dev, "can not parse irq %d\n", idx);
+			return -EINVAL;
+		}
+
+		bank->irqs[idx].bank = bank;
+		bank->irqs[idx].idx = idx;
+
+		ret = bit_map(idx, bank->interrupt_mask, bank->input_mask);
+		if (ret < 0)
+			return ret;
+		bank->irqs[idx].gpio = ret;
+	}
+
+	bank->nirq = nirq;
+
+	return 0;
+}
+
+static int lpc32xx_set_gpio_names(struct lpc32xx_gpio_chip *bank, u32 ngpio)
+{
+	char *gpio_names;
+	u32 mask, idx, val = 0, step = strlen(bank->chip.label) + 4;
+
+	bank->gpio_names = devm_kzalloc(bank->dev,
+					ngpio * sizeof(*bank->gpio_names),
+					GFP_KERNEL);
+	if (!bank->gpio_names)
+		return -ENOMEM;
+
+	gpio_names = devm_kzalloc(bank->dev, ngpio * step, GFP_KERNEL);
+	if (!gpio_names)
+		return -ENOMEM;
+
+	if (bank->input_mask)
+		mask = bank->input_mask;
+	else
+		mask = BIT(ngpio) - 1;
+
+	for (idx = 0; idx < ngpio; val++, mask >>= 1) {
+		if (mask & 0x1) {
+			/*
+			 * In DT and reference manual GPI pins are referenced
+			 * by bit position, give userspace the same pin names,
+			 * however inside GPIO framework these GPI pins follow
+			 * a different (contiguous) enumeration scheme.
+			 */
+			if (bank->input_only)
+				sprintf(gpio_names + idx * step, "%s.%02u",
+					bank->chip.label, val);
+			else
+				sprintf(gpio_names + idx * step, "%s.%02u",
+					bank->chip.label, idx);
+
+			bank->gpio_names[idx] = gpio_names + idx * step;
+			idx++;
+		}
+		if (!mask) {
+			dev_err(bank->dev, "invalid number of GPIOs\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int of_node_to_gpio(struct device *dev, struct device_node *node)
+{
+	int ret, id;
+	struct lpc32xx_gpio_chip *bank;
+	u32 ngpio = 0;
+
+	bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
+	if (!bank)
+		return -ENOMEM;
+	bank->dev = dev;
+
+	bank->base = of_iomap(node, 0);
+	if (!bank->base) {
+		dev_err(dev, "cannot map GPIO registers\n");
+		return -ENOMEM;
+	}
+
+	bank->input_only = of_property_read_bool(node, "gpio-input-only");
+	bank->output_only = of_property_read_bool(node, "gpio-output-only");
+	if (bank->input_only && bank->output_only) {
+		dev_err(dev, "%s: input-only and output-only is invalid\n",
+			node->full_name);
+		return -EINVAL;
+	}
+
+	of_property_read_u32(node, "gpio-offset", &bank->offset);
+
+	if (of_find_property(node, "gpio-input-mask", &id)) {
+		if (id < 2 * sizeof(u32)) {
+			dev_err(dev, "invalid format of gpio-input-mask\n");
+			return -EINVAL;
+		}
+
+		of_property_read_u32_index(node, "gpio-input-mask",
+					   0, &bank->input_mask);
+		of_property_read_u32_index(node, "gpio-input-mask",
+					   1, &bank->interrupt_mask);
+
+		if ((bank->input_mask & bank->interrupt_mask) !=
+		    bank->interrupt_mask) {
+			dev_err(dev, "interrupt mask must be a subset of input mask\n");
+			return -EINVAL;
+		}
+
+		ret = lpc32xx_set_irqs(bank, node);
+		if (ret)
+			return ret;
+	}
+
+	if (bank->input_mask)
+		ngpio = bit_count(bank->input_mask);
+	else
+		of_property_read_u32(node, "gpios", &ngpio);
+	if (!ngpio) {
+		dev_err(dev, "cannot get number of gpios\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Special handling of P2, the bank does not have output state
+	 * register and its mapping starts from direction control registers
+	 */
+	if (of_property_read_bool(node, "gpio-no-output-state")) {
+		bank->output_states = devm_kzalloc(dev, ngpio * (sizeof(u32)),
+						   GFP_KERNEL);
+		if (!bank->output_states)
+			return -ENOMEM;
+
+		bank->input = bank->base + LPC32XX_GPIO_P2_INPUT;
+		bank->output = bank->base + LPC32XX_GPIO_P2_OUTPUT;
+		bank->dir = bank->base + LPC32XX_GPIO_P2_DIR;
+	} else {
+		bank->input = bank->base + LPC32XX_GPIO_INPUT;
+		bank->output = bank->base + LPC32XX_GPIO_OUTPUT;
+		bank->dir = bank->base + LPC32XX_GPIO_DIR;
+	}
+
+	of_property_read_string(node, "gpio-bank-name", &bank->chip.label);
+	if (bank->chip.label) {
+		ret = lpc32xx_set_gpio_names(bank, ngpio);
+		if (ret)
+			return ret;
+	}
+
+	/* Default GPIO bank enumeration, first address cell from reg */
+	ret = of_property_read_u32(node, "reg", &id);
+	if (ret < 0 || id >= LPC32XX_GPIO_BANKS) {
+		dev_err(dev, "can not get valid GPIO bank id\n");
+		return -EINVAL;
+	}
+
+	lpc32xx_gpio_chips[id] = bank;
+
+	bank->chip.dev = dev;
+
+	bank->chip.direction_input	= lpc32xx_gpio_dir_input;
+	bank->chip.direction_output	= lpc32xx_gpio_dir_output;
+	bank->chip.get_direction	= lpc32xx_gpio_dir_get;
+
+	bank->chip.get			= lpc32xx_gpio_get;
+	bank->chip.set			= lpc32xx_gpio_set;
+
+	bank->chip.to_irq		= lpc32xx_gpio_to_irq;
+
+	bank->chip.base			= id * 32;
+	bank->chip.ngpio		= ngpio;
+	bank->chip.names		= bank->gpio_names;
+	bank->chip.can_sleep		= false;
+
+	bank->chip.of_xlate		= lpc32xx_of_xlate;
+	bank->chip.of_gpio_n_cells	= 3;
+	bank->chip.of_node		= dev->of_node;
+
+	ret = gpiochip_add(&bank->chip);
+	if (ret)
+		return ret;
+
+	if (of_find_property(node, "interrupt-controller", NULL)) {
+		if (bank->input_mask)
+			ret = lpc32xx_add_irqchip(bank, node);
+	}
+
+	return ret;
+}
+
+static int lpc32xx_gpio_remove(struct platform_device *pdev);
+static int lpc32xx_gpio_probe(struct platform_device *pdev)
+{
+	struct device_node *child;
+	int ret;
+
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
+		ret = of_node_to_gpio(&pdev->dev, child);
+		if (ret)
+			goto error;
+	}
+
+	return 0;
+
+ error:
+	of_node_put(child);
+	dev_err(&pdev->dev, "can not register gpio chip: %d\n", ret);
+
+	lpc32xx_gpio_remove(pdev);
+
+	return ret;
+}
+
+static int lpc32xx_gpio_remove(struct platform_device *pdev)
+{
+	u32 idx, i;
+	struct irq_domain *irqd;
+
+	for (idx = 0; idx < LPC32XX_GPIO_BANKS; idx++) {
+		if (!lpc32xx_gpio_chips[idx])
+			continue;
+
+		if (lpc32xx_gpio_chips[idx]->chip.irqchip) {
+			irqd = lpc32xx_gpio_chips[idx]->chip.irqdomain;
+
+			for (i = 0; i < lpc32xx_gpio_chips[idx]->nirq; i++)
+				irq_dispose_mapping(irq_find_mapping(irqd, i));
+
+			irq_domain_remove(irqd);
+			lpc32xx_gpio_chips[idx]->chip.irqdomain = NULL;
+			lpc32xx_gpio_chips[idx]->chip.irqchip = NULL;
+		}
+
+		gpiochip_remove(&lpc32xx_gpio_chips[idx]->chip);
+		lpc32xx_gpio_chips[idx] = NULL;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id lpc32xx_gpio_of_match[] = {
+	{ .compatible = "nxp,lpc3220-gpio", },
+	{ },
+};
+
+static struct platform_driver lpc32xx_gpio_driver = {
+	.probe		= lpc32xx_gpio_probe,
+	.remove		= lpc32xx_gpio_remove,
+	.driver		= {
+		.name	= "lpc32xx-gpio",
+		.of_match_table = of_match_ptr(lpc32xx_gpio_of_match),
+	},
+};
+module_platform_driver(lpc32xx_gpio_driver);
+
+MODULE_AUTHOR("Vladimir Zapolskiy <vz@mleia.com>");
+MODULE_DESCRIPTION("GPIO driver for LPC32xx");
+MODULE_LICENSE("GPL");
-- 
2.1.4
