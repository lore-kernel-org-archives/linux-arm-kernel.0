From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:22 +0200
Subject: [RFC 04/10] pinctrl: meson: allow gpio to request irq
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-5-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ability for gpio to request irq from the gpio interrupt controller
if present. We have to specificaly that the parent interrupt controller is
the gpio interrupt controller because gpio on meson SoCs can't generate
interrupt directly on the GIC.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/Kconfig               |  2 +
 drivers/pinctrl/meson/pinctrl-meson.c | 83 ++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/meson/pinctrl-meson.h |  1 +
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 0e75d94972ba..d5bfbfcddab0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -126,7 +126,9 @@ config PINCTRL_MESON
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB
+	select IRQ_DOMAIN
 	select OF_GPIO
+	select OF_IRQ
 	select REGMAP_MMIO
 
 config PINCTRL_OXNAS
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 57122eda155a..f9be3ff5e11d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -50,6 +50,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -481,6 +482,58 @@ static void meson_gpio_set(struct gpio_chip *chip, unsigned gpio, int value)
 			   value ? BIT(bit) : 0);
 }
 
+static int meson_gpio_to_hwirq(struct meson_bank *bank, unsigned int offset)
+{
+	unsigned int hwirq;
+
+	if (bank->irq_first < 0)
+		/* this bank cannot generate irqs */
+		return -1;
+
+	hwirq = offset - bank->first + bank->irq_first;
+
+	if (hwirq > bank->irq_last)
+		/* this pin cannot generate irqs */
+		return -1;
+
+	return hwirq;
+}
+
+static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct meson_pinctrl *pc = gpiochip_get_data(chip);
+	struct meson_bank *bank;
+	struct irq_fwspec fwspec;
+	unsigned int hwirq;
+	int ret;
+
+	ret = meson_get_bank(pc, offset, &bank);
+	if (ret)
+		return ret;
+
+	/*
+	 * The interrupt controller might be missing, in such case we can't
+	 * provide an interrupt for a pin
+	 */
+	if (is_fwnode_irqchip(pc->fwnode)) {
+		dev_info(pc->dev, "interrupt controller not found\n");
+		return 0;
+	}
+
+	hwirq = meson_gpio_to_hwirq(bank, offset);
+	if (hwirq < 0) {
+		dev_dbg(pc->dev, "no interrupt for pin %u\n", offset);
+		return 0;
+	}
+
+	fwspec.fwnode = pc->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = IRQ_TYPE_NONE;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
 static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 {
 	struct meson_pinctrl *pc = gpiochip_get_data(chip);
@@ -539,6 +592,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 	pc->chip.direction_output = meson_gpio_direction_output;
 	pc->chip.get = meson_gpio_get;
 	pc->chip.set = meson_gpio_set;
+	pc->chip.to_irq = meson_gpio_to_irq;
 	pc->chip.base = pc->data->pin_base;
 	pc->chip.ngpio = pc->data->num_pins;
 	pc->chip.can_sleep = false;
@@ -598,6 +652,33 @@ static struct regmap *meson_map_resource(struct meson_pinctrl *pc,
 	return devm_regmap_init_mmio(pc->dev, base, &meson_regmap_config);
 }
 
+static int meson_pinctrl_get_irq_gpio_intc(struct meson_pinctrl *pc,
+					   struct device_node *node)
+{
+	struct device_node *np;
+
+	/*
+	 * Make sure gpio don't request IRQ directly to the GIC
+	 * TODO: Find a better way to make sure we have a compatible
+	 *       Interrupt controller here
+	 */
+	if (!of_get_property(node, "interrupt-parent", NULL)) {
+		dev_dbg(pc->dev, "interrupt controller not found\n");
+		pc->fwnode = NULL;
+		return 0;
+	}
+
+	np = of_irq_find_parent(node);
+	if (!np) {
+		dev_err(pc->dev, "irq parent not found\n");
+		return -EINVAL;
+	}
+
+	pc->fwnode = of_node_to_fwnode(np);
+
+	return 0;
+}
+
 static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 				  struct device_node *node)
 {
@@ -643,7 +724,7 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 		return PTR_ERR(pc->reg_gpio);
 	}
 
-	return 0;
+	return meson_pinctrl_get_irq_gpio_intc(pc, gpio_np);
 }
 
 static int meson_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 785705996e60..4bcc4900b3eb 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -122,6 +122,7 @@ struct meson_pinctrl {
 	struct regmap *reg_gpio;
 	struct gpio_chip chip;
 	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
 };
 
 #define PIN(x, b)	(b + x)
-- 
2.7.4
