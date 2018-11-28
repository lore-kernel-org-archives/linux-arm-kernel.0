From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 29 Nov 2018 00:48:41 +0200
Subject: [PATCH 2/2] gpio: lpc18xx: add GPIO pin interrupt controller support
In-Reply-To: <20181128224841.3646-1-vz@mleia.com>
References: <20181128224841.3646-1-vz@mleia.com>
Message-ID: <20181128224841.3646-3-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds support of LPC18xx/LPC43xx GPIO pin interrupt controller
block within SoC GPIO controller. The new interrupt controller driver
allows to configure and capture edge or level interrupts on 8 arbitrary
selectedinput GPIO pins, and lift the signals to be reported as NVIC rising
edge interrupts. Configuration of a particular GPIO pin to serve as
interrupt and its mapping to an interrupt on NVIC is done by SCU pin
controller, for more details see description of 'nxp,gpio-pin-interrupt'
device tree property of a GPIO pin [1].

>From LPC18xx and LPC43xx User Manuals the GPIO controller consists of
the following blocks:
* GPIO pin interrupt block at 0x40087000, this change adds its support,
* GPIO GROUP0 interrupt block at 0x40088000,
* GPIO GROUP1 interrupt block at 0x40089000,
* GPIO port block at 0x400F4000, it is supported by the original driver.

While all 4 sub-controller blocks have their own I/O addresses, moreover
all 3 interrupt blocks are APB0 peripherals and high-speed GPIO block is
an AHB slave, according to the hardware manual the GPIO controller is
seen as a single block, and 4 sub-controllers have the shared reset signal
RGU #28 and clock to register interface CLK_CPU_GPIO on CCU1.

Likely support of two GPIO group interrupt blocks won't be added in short
term, because the mechanism to mask several interrupt sources is not well
defined.

[1] Documentation/devicetree/bindings/pinctrl/nxp,lpc1850-scu.txt

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-lpc18xx.c | 267 +++++++++++++++++++++++++++++++++++-
 2 files changed, 264 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 833a1b51c948..a1876c39a7b7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -288,6 +288,7 @@ config GPIO_LPC18XX
 	tristate "NXP LPC18XX/43XX GPIO support"
 	default y if ARCH_LPC18XX
 	depends on OF_GPIO && (ARCH_LPC18XX || COMPILE_TEST)
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	  Select this option to enable GPIO driver for
 	  NXP LPC18XX/43XX devices.
diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index dc33185a89b1..040fb59d06f7 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -2,6 +2,7 @@
 /*
  * GPIO driver for NXP LPC18xx/43xx.
  *
+ * Copyright (C) 2018 Vladimir Zapolskiy <vz@mleia.com>
  * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
  *
  */
@@ -9,9 +10,13 @@
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
@@ -21,13 +26,247 @@
 #define LPC18XX_MAX_PORTS	8
 #define LPC18XX_PINS_PER_PORT	32
 
+/* LPC18xx GPIO pin interrupt controller register offsets */
+#define LPC18XX_GPIO_PIN_IC_ISEL	0x00
+#define LPC18XX_GPIO_PIN_IC_IENR	0x04
+#define LPC18XX_GPIO_PIN_IC_SIENR	0x08
+#define LPC18XX_GPIO_PIN_IC_CIENR	0x0c
+#define LPC18XX_GPIO_PIN_IC_IENF	0x10
+#define LPC18XX_GPIO_PIN_IC_SIENF	0x14
+#define LPC18XX_GPIO_PIN_IC_CIENF	0x18
+#define LPC18XX_GPIO_PIN_IC_RISE	0x1c
+#define LPC18XX_GPIO_PIN_IC_FALL	0x20
+#define LPC18XX_GPIO_PIN_IC_IST		0x24
+
+#define NR_LPC18XX_GPIO_PIN_IC_IRQS	8
+
+struct lpc18xx_gpio_pin_ic {
+	void __iomem *base;
+	struct irq_domain *domain;
+	struct raw_spinlock lock;
+};
+
 struct lpc18xx_gpio_chip {
 	struct gpio_chip gpio;
 	void __iomem *base;
 	struct clk *clk;
+	struct lpc18xx_gpio_pin_ic *pin_ic;
 	spinlock_t lock;
 };
 
+static inline void lpc18xx_gpio_pin_ic_isel(struct lpc18xx_gpio_pin_ic *ic,
+					    u32 pin, bool set)
+{
+	u32 val = readl_relaxed(ic->base + LPC18XX_GPIO_PIN_IC_ISEL);
+
+	if (set)
+		val &= ~BIT(pin);
+	else
+		val |= BIT(pin);
+
+	writel_relaxed(val, ic->base + LPC18XX_GPIO_PIN_IC_ISEL);
+}
+
+static inline void lpc18xx_gpio_pin_ic_set(struct lpc18xx_gpio_pin_ic *ic,
+					   u32 pin, u32 reg)
+{
+	writel_relaxed(BIT(pin), ic->base + reg);
+}
+
+static void lpc18xx_gpio_pin_ic_mask(struct irq_data *d)
+{
+	struct lpc18xx_gpio_pin_ic *ic = d->chip_data;
+	u32 type = irqd_get_trigger_type(d);
+
+	raw_spin_lock(&ic->lock);
+
+	if (type & IRQ_TYPE_LEVEL_MASK || type & IRQ_TYPE_EDGE_RISING)
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_CIENR);
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_CIENF);
+
+	raw_spin_unlock(&ic->lock);
+
+	irq_chip_mask_parent(d);
+}
+
+static void lpc18xx_gpio_pin_ic_unmask(struct irq_data *d)
+{
+	struct lpc18xx_gpio_pin_ic *ic = d->chip_data;
+	u32 type = irqd_get_trigger_type(d);
+
+	raw_spin_lock(&ic->lock);
+
+	if (type & IRQ_TYPE_LEVEL_MASK || type & IRQ_TYPE_EDGE_RISING)
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_SIENR);
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_SIENF);
+
+	raw_spin_unlock(&ic->lock);
+
+	irq_chip_unmask_parent(d);
+}
+
+static void lpc18xx_gpio_pin_ic_eoi(struct irq_data *d)
+{
+	struct lpc18xx_gpio_pin_ic *ic = d->chip_data;
+	u32 type = irqd_get_trigger_type(d);
+
+	raw_spin_lock(&ic->lock);
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_IST);
+
+	raw_spin_unlock(&ic->lock);
+
+	irq_chip_eoi_parent(d);
+}
+
+static int lpc18xx_gpio_pin_ic_set_type(struct irq_data *d, unsigned int type)
+{
+	struct lpc18xx_gpio_pin_ic *ic = d->chip_data;
+
+	raw_spin_lock(&ic->lock);
+
+	if (type & IRQ_TYPE_LEVEL_HIGH) {
+		lpc18xx_gpio_pin_ic_isel(ic, d->hwirq, true);
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_SIENF);
+	} else if (type & IRQ_TYPE_LEVEL_LOW) {
+		lpc18xx_gpio_pin_ic_isel(ic, d->hwirq, true);
+		lpc18xx_gpio_pin_ic_set(ic, d->hwirq,
+					LPC18XX_GPIO_PIN_IC_CIENF);
+	} else {
+		lpc18xx_gpio_pin_ic_isel(ic, d->hwirq, false);
+	}
+
+	raw_spin_unlock(&ic->lock);
+
+	return 0;
+}
+
+static struct irq_chip lpc18xx_gpio_pin_ic = {
+	.name		= "LPC18xx GPIO pin",
+	.irq_mask	= lpc18xx_gpio_pin_ic_mask,
+	.irq_unmask	= lpc18xx_gpio_pin_ic_unmask,
+	.irq_eoi	= lpc18xx_gpio_pin_ic_eoi,
+	.irq_set_type	= lpc18xx_gpio_pin_ic_set_type,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+	.flags		= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int lpc18xx_gpio_pin_ic_domain_alloc(struct irq_domain *domain,
+					    unsigned int virq,
+					    unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec parent_fwspec, *fwspec = data;
+	struct lpc18xx_gpio_pin_ic *ic = domain->host_data;
+	irq_hw_number_t hwirq;
+	int ret;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	hwirq = fwspec->param[0];
+	if (hwirq >= NR_LPC18XX_GPIO_PIN_IC_IRQS)
+		return -EINVAL;
+
+	/*
+	 * All LPC18xx/LPC43xx GPIO pin hardware interrupts are translated
+	 * into edge interrupts 32...39 on parent Cortex-M3/M4 NVIC
+	 */
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 1;
+	parent_fwspec.param[0] = hwirq + 32;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+	if (ret < 0) {
+		pr_err("failed to allocate parent irq %u: %d\n",
+		       parent_fwspec.param[0], ret);
+		return ret;
+	}
+
+	return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+					     &lpc18xx_gpio_pin_ic, ic);
+}
+
+static const struct irq_domain_ops lpc18xx_gpio_pin_ic_domain_ops = {
+	.alloc	= lpc18xx_gpio_pin_ic_domain_alloc,
+	.xlate	= irq_domain_xlate_twocell,
+	.free	= irq_domain_free_irqs_common,
+};
+
+static int lpc18xx_gpio_pin_ic_probe(struct lpc18xx_gpio_chip *gc)
+{
+	struct device *dev = gc->gpio.parent;
+	struct irq_domain *parent_domain;
+	struct device_node *parent_node;
+	struct lpc18xx_gpio_pin_ic *ic;
+	struct resource res;
+	int ret, index;
+
+	parent_node = of_irq_find_parent(dev->of_node);
+	if (!parent_node)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
+	if (!parent_domain)
+		return -ENXIO;
+
+	ic = devm_kzalloc(dev, sizeof(*ic), GFP_KERNEL);
+	if (!ic)
+		return -ENOMEM;
+
+	index = of_property_match_string(dev->of_node, "reg-names",
+					 "gpio-pin-ic");
+	if (index < 0) {
+		ret = -ENODEV;
+		goto free_ic;
+	}
+
+	ret = of_address_to_resource(dev->of_node, index, &res);
+	if (ret < 0)
+		goto free_ic;
+
+	ic->base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(ic->base)) {
+		ret = PTR_ERR(ic->base);
+		goto free_ic;
+	}
+
+	raw_spin_lock_init(&ic->lock);
+
+	ic->domain = irq_domain_add_hierarchy(parent_domain, 0,
+					      NR_LPC18XX_GPIO_PIN_IC_IRQS,
+					      dev->of_node,
+					      &lpc18xx_gpio_pin_ic_domain_ops,
+					      ic);
+	if (!ic->domain) {
+		pr_err("unable to add irq domain\n");
+		ret = -ENODEV;
+		goto free_iomap;
+	}
+
+	gc->pin_ic = ic;
+
+	return 0;
+
+free_iomap:
+	devm_iounmap(dev, ic->base);
+free_ic:
+	devm_kfree(dev, ic);
+
+	return ret;
+}
+
 static void lpc18xx_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct lpc18xx_gpio_chip *gc = gpiochip_get_data(chip);
@@ -91,8 +330,7 @@ static int lpc18xx_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct lpc18xx_gpio_chip *gc;
-	struct resource *res;
-	int ret;
+	int index, ret;
 
 	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
 	if (!gc)
@@ -101,8 +339,22 @@ static int lpc18xx_gpio_probe(struct platform_device *pdev)
 	gc->gpio = lpc18xx_chip;
 	platform_set_drvdata(pdev, gc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	gc->base = devm_ioremap_resource(dev, res);
+	index = of_property_match_string(dev->of_node, "reg-names", "gpio");
+	if (index < 0) {
+		/* To support backward compatibility take the first resource */
+		struct resource *res;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		gc->base = devm_ioremap_resource(dev, res);
+	} else {
+		struct resource res;
+
+		ret = of_address_to_resource(dev->of_node, index, &res);
+		if (ret < 0)
+			return ret;
+
+		gc->base = devm_ioremap_resource(dev, &res);
+	}
 	if (IS_ERR(gc->base))
 		return PTR_ERR(gc->base);
 
@@ -129,6 +381,9 @@ static int lpc18xx_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* On error GPIO pin interrupt controller just won't be registered */
+	lpc18xx_gpio_pin_ic_probe(gc);
+
 	return 0;
 }
 
@@ -136,6 +391,9 @@ static int lpc18xx_gpio_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_gpio_chip *gc = platform_get_drvdata(pdev);
 
+	if (gc->pin_ic)
+		irq_domain_remove(gc->pin_ic->domain);
+
 	clk_disable_unprepare(gc->clk);
 
 	return 0;
@@ -158,5 +416,6 @@ static struct platform_driver lpc18xx_gpio_driver = {
 module_platform_driver(lpc18xx_gpio_driver);
 
 MODULE_AUTHOR("Joachim Eastwood <manabian@gmail.com>");
+MODULE_AUTHOR("Vladimir Zapolskiy <vz@mleia.com>");
 MODULE_DESCRIPTION("GPIO driver for LPC18xx/43xx");
 MODULE_LICENSE("GPL v2");
-- 
2.17.1
