From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 9 Sep 2016 16:42:01 +0200
Subject: [PATCH v5 6/9] pinctrl: Add IRQ support to STM32 gpios
In-Reply-To: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1473432124-6784-7-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds IRQ support to STM32 gpios.

The EXTI controller has 16 lines dedicated to GPIOs.
EXTI line n can be connected to only line n of one of the GPIO ports, for
example EXTI0 can be connected to either PA0, or PB0, or PC0...
This port selection is done by specifying the port number into System
Config registers.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index 4c40dae..24bc683 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -6,6 +6,7 @@ config PINCTRL_STM32
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
+	select MFD_SYSCON
 
 config PINCTRL_STM32F429
 	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 4ae596b..4f01025 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -20,6 +22,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -40,6 +43,7 @@
 #define STM32_GPIO_AFRH		0x24
 
 #define STM32_GPIO_PINS_PER_BANK 16
+#define STM32_GPIO_IRQ_LINE	 16
 
 #define gpio_range_to_bank(chip) \
 		container_of(chip, struct stm32_gpio_bank, range)
@@ -65,6 +69,8 @@ struct stm32_gpio_bank {
 	spinlock_t lock;
 	struct gpio_chip gpio_chip;
 	struct pinctrl_gpio_range range;
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
 };
 
 struct stm32_pinctrl {
@@ -77,6 +83,9 @@ struct stm32_pinctrl {
 	struct stm32_gpio_bank *banks;
 	unsigned nbanks;
 	const struct stm32_pinctrl_match_data *match_data;
+	struct irq_domain	*domain;
+	struct regmap		*regmap;
+	struct regmap_field	*irqmux[STM32_GPIO_PINS_PER_BANK];
 };
 
 static inline int stm32_gpio_pin(int gpio)
@@ -174,6 +183,20 @@ static int stm32_gpio_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+
+static int stm32_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode = bank->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = offset;
+	fwspec.param[1] = IRQ_TYPE_NONE;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
 static struct gpio_chip stm32_gpio_template = {
 	.request		= stm32_gpio_request,
 	.free			= stm32_gpio_free,
@@ -181,10 +204,92 @@ static struct gpio_chip stm32_gpio_template = {
 	.set			= stm32_gpio_set,
 	.direction_input	= stm32_gpio_direction_input,
 	.direction_output	= stm32_gpio_direction_output,
+	.to_irq			= stm32_gpio_to_irq,
 };
 
-/* Pinctrl functions */
+static struct irq_chip stm32_gpio_irq_chip = {
+	.name           = "stm32gpio",
+	.irq_eoi	= irq_chip_eoi_parent,
+	.irq_mask       = irq_chip_mask_parent,
+	.irq_unmask     = irq_chip_unmask_parent,
+	.irq_set_type   = irq_chip_set_type_parent,
+};
+
+static int stm32_gpio_domain_translate(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       unsigned long *hwirq,
+				       unsigned int *type)
+{
+	if ((fwspec->param_count != 2) ||
+	    (fwspec->param[0] >= STM32_GPIO_IRQ_LINE))
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+	return 0;
+}
 
+static void stm32_gpio_domain_activate(struct irq_domain *d,
+				       struct irq_data *irq_data)
+{
+	struct stm32_gpio_bank *bank = d->host_data;
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
+
+	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->range.id);
+}
+
+static int stm32_gpio_domain_alloc(struct irq_domain *d,
+				   unsigned int virq,
+				   unsigned int nr_irqs, void *data)
+{
+	struct stm32_gpio_bank *bank = d->host_data;
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	int ret;
+
+	hwirq = fwspec->param[0];
+	parent_fwspec.fwnode = d->parent->fwnode;
+	parent_fwspec.param_count = 2;
+	parent_fwspec.param[0] = fwspec->param[0];
+	parent_fwspec.param[1] = fwspec->param[1];
+
+	irq_domain_set_hwirq_and_chip(d, virq, hwirq, &stm32_gpio_irq_chip,
+				      bank);
+
+	ret = gpiochip_lock_as_irq(&bank->gpio_chip, hwirq);
+	if (ret) {
+		dev_err(pctl->dev, "Unable to configure STM32 %s%ld as IRQ\n",
+			bank->gpio_chip.label, hwirq);
+		return ret;
+	}
+
+	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
+	if (ret)
+		gpiochip_unlock_as_irq(&bank->gpio_chip, hwirq);
+
+	return ret;
+}
+
+static void stm32_gpio_domain_free(struct irq_domain *d, unsigned int virq,
+				   unsigned int nr_irqs)
+{
+	struct stm32_gpio_bank *bank = d->host_data;
+	struct irq_data *data = irq_get_irq_data(virq);
+
+	irq_domain_free_irqs_common(d, virq, nr_irqs);
+	gpiochip_unlock_as_irq(&bank->gpio_chip, data->hwirq);
+}
+
+static const struct irq_domain_ops stm32_gpio_domain_ops = {
+	.translate      = stm32_gpio_domain_translate,
+	.alloc          = stm32_gpio_domain_alloc,
+	.free           = stm32_gpio_domain_free,
+	.activate	= stm32_gpio_domain_activate,
+};
+
+/* Pinctrl functions */
 static struct stm32_pinctrl_group *
 stm32_pctrl_find_group_by_pin(struct stm32_pinctrl *pctl, u32 pin)
 {
@@ -857,6 +962,17 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	range->pin_base = range->base = range->id * STM32_GPIO_PINS_PER_BANK;
 	range->npins = bank->gpio_chip.ngpio;
 	range->gc = &bank->gpio_chip;
+
+	/* create irq hierarchical domain */
+	bank->fwnode = of_node_to_fwnode(np);
+
+	bank->domain = irq_domain_create_hierarchy(pctl->domain, 0,
+					STM32_GPIO_IRQ_LINE, bank->fwnode,
+					&stm32_gpio_domain_ops, bank);
+
+	if (!bank->domain)
+		return -ENODEV;
+
 	err = gpiochip_add_data(&bank->gpio_chip, bank);
 	if (err) {
 		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
@@ -867,6 +983,47 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	return 0;
 }
 
+static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
+			   struct stm32_pinctrl *pctl)
+{
+	struct device_node *np = pdev->dev.of_node, *parent;
+	struct device *dev = &pdev->dev;
+	struct regmap *rm;
+	int offset, ret, i;
+
+	parent = of_irq_find_parent(np);
+	if (!parent)
+		return -ENXIO;
+
+	pctl->domain = irq_find_host(parent);
+	if (!pctl->domain)
+		return -ENXIO;
+
+	pctl->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(pctl->regmap))
+		return PTR_ERR(pctl->regmap);
+
+	rm = pctl->regmap;
+
+	ret = of_property_read_u32_index(np, "st,syscfg", 1, &offset);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < STM32_GPIO_PINS_PER_BANK; i++) {
+		struct reg_field mux;
+
+		mux.reg = offset + (i / 4) * 4;
+		mux.lsb = (i % 4) * 4;
+		mux.msb = mux.lsb + 3;
+
+		pctl->irqmux[i] = devm_regmap_field_alloc(dev, rm, mux);
+		if (IS_ERR(pctl->irqmux[i]))
+			return PTR_ERR(pctl->irqmux[i]);
+	}
+
+	return 0;
+}
+
 static int stm32_pctrl_build_state(struct platform_device *pdev)
 {
 	struct stm32_pinctrl *pctl = platform_get_drvdata(pdev);
@@ -935,6 +1092,10 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = stm32_pctrl_dt_setup_irq(pdev, pctl);
+	if (ret)
+		return ret;
+
 	for_each_child_of_node(np, child)
 		if (of_property_read_bool(child, "gpio-controller"))
 			banks++;
-- 
1.9.1
