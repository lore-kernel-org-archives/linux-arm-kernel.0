From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 18 Dec 2011 10:13:48 +0000
Subject: [PATCH 1/2] gpio: add a driver for the Synopsys DesignWare APB GPIO
 block
Message-ID: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Synopsys DesignWare block is used in some ARM devices (picoxcell)
and can be configured to provide multiple banks of GPIO pins.  The first
bank (A) can also provide IRQ capabilities.

Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

I was originally working on a generic binding for the generic gpio
driver, but this doesn't scale well when there are interrupt
capabilities in the controller, so here's a driver specifically for the
Synopsys block.

 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |   63 ++++
 drivers/gpio/Kconfig                               |   10 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-dwapb.c                          |  337 ++++++++++++++++++++
 4 files changed, 411 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 create mode 100644 drivers/gpio/gpio-dwapb.c

diff --git a/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
new file mode 100644
index 0000000..62943fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
@@ -0,0 +1,63 @@
+* Synopsys DesignWare APB GPIO controller
+
+Required properties:
+- compatible : Should be "snps,dw-apb-gpio"
+- reg : Address and length of the register set for the device
+
+The GPIO controller has a configurable number of banks, each of which are
+represented as child nodes with the following properties:
+
+Required properties:
+- compatible : "snps,dw-apb-gpio-bank"
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two.  The first cell is the pin number and
+  the second cell is used to specify optional parameters (currently
+  unused).
+- snps,gpio-bank : The integer bank index of the bank, a single cell.
+- nr-gpio : The number of pins in the bank, a single cell.
+
+Optional properties:
+- interrupt-controller : The first bank may be configured to be an interrupt
+controller.
+- #interrupt-cells : Specifies the number of cells needed to encode an
+interrupt.  Shall be set to 2.  The first cell defines the interrupt number,
+the second encodes the triger flags encoded as:
+
+	bits[3:0] trigger type and level flags.
+		1 = low-to-high edge triggered
+		2 = high-to-low edge triggered
+		4 = active high level-sensitive
+		8 = active low level-sensitive
+
+- interrupt-parent : The parent interrupt controller.
+- interrupts : The interrupts to the parent controller raised when GPIOs
+generate the interrupts.
+
+Example:
+
+gpio: gpio at 20000 {
+	compatible = "snps,dw-apb-gpio";
+	reg = <0x20000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	banka: gpio-controller at 0 {
+		compatible = "snps,dw-apb-gpio-bank";
+		gpio-controller;
+		#gpio-cells = <2>;
+		nr-gpio = <8>;
+		snps,gpio-bank = <0>
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&vic1>;
+		interrupts = <0 1 2 3 4 5 6 7>;
+	};
+
+	bankb: gpio-controller at 1 {
+		compatible = "snps,dw-apb-gpio-bank";
+		gpio-controller;
+		#gpio-cells = <2>;
+		nr-gpio = <8>;
+		snps,gpio-bank = <1>
+	};
+};
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 573532f..93fd69d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -85,6 +85,16 @@ config GPIO_GENERIC_PLATFORM
 	help
 	  Say yes here to support basic platform_device memory-mapped GPIO controllers.
 
+config GPIO_DWAPB
+	bool "Synopsys DesignWare APB GPIO driver"
+	select GPIO_GENERIC
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	depends on OF_GPIO
+	help
+	  Say Y or M here to build support for the Synopsys DesignWare APB
+	  GPIO block.  This requires device tree support.
+
 config GPIO_IT8761E
 	tristate "IT8761E GPIO support"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 62e641e..8c2fdd4 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_DA9052)	+= gpio-da9052.o
 obj-$(CONFIG_ARCH_DAVINCI)	+= gpio-davinci.o
+obj-$(CONFIG_GPIO_DWAPB)	+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EP93XX)	+= gpio-ep93xx.o
 obj-$(CONFIG_GPIO_IT8761E)	+= gpio-it8761e.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
new file mode 100644
index 0000000..2e742e1
--- /dev/null
+++ b/drivers/gpio/gpio-dwapb.c
@@ -0,0 +1,337 @@
+/*
+ * Copyright (c) 2011 Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/basic_mmio_gpio.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+
+#define INT_EN_REG_OFFS		0x30
+#define INT_MASK_REG_OFFS	0x34
+#define INT_TYPE_REG_OFFS	0x38
+#define INT_POLARITY_REG_OFFS	0x3c
+#define INT_STATUS_REG_OFFS	0x40
+#define EOI_REG_OFFS		0x4c
+
+struct dwapb_gpio_bank {
+	struct bgpio_chip	bgc;
+	unsigned int		bank_idx;
+	bool			is_registered;
+	struct irq_domain	domain;
+};
+
+struct dwapb_gpio {
+	struct device_node	*of_node;
+	struct	device		*dev;
+	void __iomem		*regs;
+	struct dwapb_gpio_bank	*banks;
+	unsigned int		nr_banks;
+};
+
+static unsigned int dwapb_gpio_nr_banks(struct device_node *of_node)
+{
+	unsigned int nr_banks = 0;
+	struct device_node *np;
+
+	for_each_child_of_node(of_node, np)
+		++nr_banks;
+
+	return nr_banks;
+}
+
+static int dwapb_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	struct dwapb_gpio_bank *bank = container_of(bgc, struct
+						    dwapb_gpio_bank, bgc);
+
+	return irq_domain_to_irq(&bank->domain, offset);
+}
+
+static void dwapb_irq_handler(u32 irq, struct irq_desc *desc)
+{
+	struct dwapb_gpio *gpio = irq_get_handler_data(irq);
+	u32 irq_status = readl(gpio->regs + INT_STATUS_REG_OFFS);
+
+	while (irq_status) {
+		int irqoffset = fls(irq_status) - 1;
+
+		generic_handle_irq(irq_domain_to_irq(&gpio->banks[0].domain,
+						     irqoffset));
+		irq_status &= ~(1 << irqoffset);
+	}
+}
+
+static void dwapb_irq_enable(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct dwapb_gpio *gpio = gc->private;
+
+	u32 val = readl(gpio->regs + INT_EN_REG_OFFS);
+	val |= 1 << d->hwirq;
+	writel(val, gpio->regs + INT_EN_REG_OFFS);
+}
+
+static void dwapb_irq_disable(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct dwapb_gpio *gpio = gc->private;
+
+	u32 val = readl(gpio->regs + INT_EN_REG_OFFS);
+	val &= ~(1 << d->hwirq);
+	writel(val, gpio->regs + INT_EN_REG_OFFS);
+}
+
+static int dwapb_irq_set_type(struct irq_data *d, u32 type)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct dwapb_gpio *gpio = gc->private;
+	int bit = d->hwirq;
+	unsigned long level, polarity;
+
+	if (type & ~(IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING |
+		     IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		return -EINVAL;
+
+	level = readl(gpio->regs + INT_TYPE_REG_OFFS);
+	polarity = readl(gpio->regs + INT_POLARITY_REG_OFFS);
+
+	if (type & IRQ_TYPE_EDGE_RISING) {
+		level |= (1 << bit);
+		polarity |= (1 << bit);
+	} else if (type & IRQ_TYPE_EDGE_FALLING) {
+		level |= (1 << bit);
+		polarity &= ~(1 << bit);
+	} else if (type & IRQ_TYPE_LEVEL_HIGH) {
+		level &= ~(1 << bit);
+		polarity |= (1 << bit);
+	} else if (type & IRQ_TYPE_LEVEL_LOW) {
+		level &= ~(1 << bit);
+		polarity &= ~(1 << bit);
+	}
+
+	writel(level, gpio->regs + INT_TYPE_REG_OFFS);
+	writel(polarity, gpio->regs + INT_POLARITY_REG_OFFS);
+
+	return 0;
+}
+
+static void dwapb_add_domain(struct dwapb_gpio_bank *bank,
+			     unsigned int irq_base)
+{
+	bank->domain.ops = &irq_domain_simple_ops;
+	bank->domain.of_node = bank->bgc.gc.of_node;
+	bank->domain.nr_irq = bank->bgc.gc.ngpio;
+	bank->domain.irq_base = irq_base;
+	irq_domain_add(&bank->domain);
+}
+
+static int dwapb_create_irqchip(struct dwapb_gpio *gpio,
+				struct dwapb_gpio_bank *bank,
+				unsigned int irq_base)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("gpio-dwapb", 1, irq_base, gpio->regs,
+				    handle_level_irq);
+	if (!gc)
+		return -EIO;
+
+	gc->private = gpio;
+	ct = gc->chip_types;
+	ct->chip.irq_ack = irq_gc_ack_set_bit;
+	ct->chip.irq_mask = irq_gc_mask_set_bit;
+	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
+	ct->chip.irq_set_type = dwapb_irq_set_type;
+	ct->chip.irq_enable = dwapb_irq_enable;
+	ct->chip.irq_disable = dwapb_irq_disable;
+	ct->regs.ack = EOI_REG_OFFS;
+	ct->regs.mask = INT_MASK_REG_OFFS;
+	irq_setup_generic_chip(gc, IRQ_MSK(bank->bgc.gc.ngpio),
+			       IRQ_GC_INIT_NESTED_LOCK, IRQ_NOREQUEST, 0);
+
+	return 0;
+}
+
+static int dwapb_configure_irqs(struct dwapb_gpio *gpio,
+				struct dwapb_gpio_bank *bank)
+{
+	unsigned int m, irq, ngpio = bank->bgc.gc.ngpio;
+	int irq_base;
+
+	for (m = 0; m < ngpio; ++m) {
+		irq = irq_of_parse_and_map(bank->bgc.gc.of_node, m);
+		if (!irq && m == 0) {
+			dev_warn(gpio->dev, "no irq for bank %s\n",
+				 bank->bgc.gc.of_node->full_name);
+			return -ENXIO;
+		} else if (!irq) {
+			break;
+		}
+
+		irq_set_chained_handler(irq, dwapb_irq_handler);
+		irq_set_handler_data(irq, gpio);
+	}
+	bank->bgc.gc.to_irq = dwapb_gpio_to_irq;
+
+	irq_base = irq_alloc_descs(-1, 0, ngpio, NUMA_NO_NODE);
+	if (irq_base < 0)
+		return irq_base;
+
+	dwapb_add_domain(bank, irq_base);
+	if (dwapb_create_irqchip(gpio, bank, irq_base))
+		goto out_free_descs;
+
+	return 0;
+
+out_free_descs:
+	irq_free_descs(irq_base, ngpio);
+	irq_domain_del(&bank->domain);
+
+	return -EIO;
+}
+
+static int dwapb_gpio_add_bank(struct dwapb_gpio *gpio,
+			       struct device_node *bank_np)
+{
+	struct dwapb_gpio_bank *bank;
+	u32 bank_idx, ngpio;
+	int err;
+
+	if (of_property_read_u32(bank_np, "snps,gpio-bank", &bank_idx)) {
+		dev_err(gpio->dev, "invalid bank idx for %s\n",
+			bank_np->full_name);
+		return -EINVAL;
+	}
+	bank = &gpio->banks[bank_idx];
+
+	if (of_property_read_u32(bank_np, "nr-gpio", &ngpio)) {
+		dev_err(gpio->dev, "failed to get number of gpios for %s\n",
+			bank_np->full_name);
+		return -EINVAL;
+	}
+
+	bank->bank_idx = bank_idx;
+	err = bgpio_init(&bank->bgc, gpio->dev, 4,
+			 gpio->regs + 0x50 + (bank_idx * 0x4),
+			 gpio->regs + 0x00 + (bank_idx * 0xc),
+			 NULL, gpio->regs + 0x04 + (bank_idx * 0xc), NULL,
+			 false);
+	if (err) {
+		dev_err(gpio->dev, "failed to init gpio chip for %s\n",
+			bank_np->full_name);
+		return err;
+	}
+
+	bank->bgc.gc.ngpio = ngpio;
+	bank->bgc.gc.of_node = bank_np;
+
+	/*
+	 * Only bank A can provide interrupts in all configurations of the IP.
+	 */
+	if (bank_idx == 0 &&
+	    of_get_property(bank_np, "interrupt-controller", NULL))
+		dwapb_configure_irqs(gpio, bank);
+
+	err = gpiochip_add(&bank->bgc.gc);
+	if (err)
+		dev_err(gpio->dev, "failed to register gpiochip for %s\n",
+			bank_np->full_name);
+	else
+		bank->is_registered = true;
+
+	return err;
+}
+
+static void dwapb_gpio_unregister(struct dwapb_gpio *gpio)
+{
+	unsigned int m;
+
+	for (m = 0; m < gpio->nr_banks; ++m)
+		if (gpio->banks[m].is_registered)
+			gpiochip_remove(&gpio->banks[m].bgc.gc);
+	of_node_put(gpio->of_node);
+}
+
+static int __devinit dwapb_gpio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct dwapb_gpio *gpio;
+	struct device_node *np;
+	int err;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+	gpio->dev = &pdev->dev;
+
+	gpio->nr_banks = dwapb_gpio_nr_banks(pdev->dev.of_node);
+	if (!gpio->nr_banks)
+		return -EINVAL;
+	gpio->banks = devm_kzalloc(&pdev->dev, gpio->nr_banks *
+				   sizeof(*gpio->banks), GFP_KERNEL);
+	if (!gpio->banks)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get iomem\n");
+		return -ENXIO;
+	}
+	gpio->regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!gpio->regs)
+		return -ENOMEM;
+
+	gpio->of_node = of_node_get(pdev->dev.of_node);
+	for_each_child_of_node(pdev->dev.of_node, np) {
+		err = dwapb_gpio_add_bank(gpio, np);
+		if (err)
+			goto out_unregister;
+	}
+	platform_set_drvdata(pdev, gpio);
+
+	return 0;
+
+out_unregister:
+	dwapb_gpio_unregister(gpio);
+
+	return err;
+}
+
+static const struct of_device_id dwapb_of_match_table[] = {
+	{ .compatible = "snps,dw-apb-gpio" },
+	{ /* Sentinel */ }
+};
+
+static struct platform_driver dwapb_gpio_driver = {
+	.driver		= {
+		.name	= "gpio-dwapb",
+		.owner	= THIS_MODULE,
+		.of_match_table = dwapb_of_match_table,
+	},
+	.probe		= dwapb_gpio_probe,
+};
+
+static int __init dwapb_gpio_init(void)
+{
+	return platform_driver_register(&dwapb_gpio_driver);
+}
+postcore_initcall(dwapb_gpio_init);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jamie Iles");
+MODULE_DESCRIPTION("Synopsys DesignWare APB GPIO driver");
-- 
1.7.5.4
