From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 Nov 2015 11:16:54 +0100
Subject: [PATCH v2 3/5] pinctrl: meson: enable GPIO IRQs
In-Reply-To: <1448273816-11290-1-git-send-email-carlo@caione.org>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
Message-ID: <1448273816-11290-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

On Meson8 and Meson8b SoCs there are 8 independent filtered GPIO
interrupt modules that can be programmed to use any of the GPIOs in the
chip as an interrupt source.

For each GPIO IRQ we have:

GPIOs --> [mux]--> [polarity]--> [filter]--> [edge select]--> GIC

The eight GPIO interrupts respond to mask/unmask/clear/etc.. just like
any other interrupt in the chip. The difference for the GPIO interrupts
is that they can be filtered and conditioned.

This patch adds support for the external GPIOs interrupts and enables
them for Meson8 and Meson8b SoCs.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>

---

Linus,
I guess it's time to respin this patch and the discussion since I see no better
way to do this. I CCed a bunch of IRQ people to check whether they have a
any suggestions.

Since one of your major concern was that the code must not rely on .to_irq()
being called to request the IRQ from the irqchip side please note that I tested
this patch both using gpiod_to_irq() and using DT, in both case it works just
fine.

The point in this patch is that we cannot allocate anything at probe time
(neither in .irq_request_resources()) since registers configuration is strictly
dependent on the pin / GPIO / hwirq is going to be setup. Following is more
detailed scheme:

GPIO0 -> [mux1 [7:0]]   ->|
GPIO1 -> [mux1 [15:8]]  ->|-|
GPIO2 -> [mux1 [23:16]] ->| |
GPIO3 -> [mux1 [31:24]] ->| |
                            |->[polarity]->[filter]->[edge select]-> GICv2
GPIO4 -> [mux2 [7:0]]   ->| |
GPIO5 -> [mux2 [15:8]]  ->| |
GPIO6 -> [mux2 [23:16]] ->|-|
GPIO7 -> [mux2 [31:24]] ->|

The 8bit bitfields in the mux1 / mux2 registers are used to link the GPIOx IRQ
to the GPIO used to trigger the IRQ (i.e. if we want to use GPIOY0 pin to
trigger the GPIO0 IRQ we set mux1[7:0] = 80).

Thanks,

---
 drivers/pinctrl/Kconfig                 |   1 +
 drivers/pinctrl/meson/pinctrl-meson.c   | 303 ++++++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h   |  18 +-
 drivers/pinctrl/meson/pinctrl-meson8.c  |  36 ++--
 drivers/pinctrl/meson/pinctrl-meson8b.c |  36 ++--
 5 files changed, 363 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 312c78b..47f35b4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -128,6 +128,7 @@ config PINCTRL_MESON
 	select GPIOLIB
 	select OF_GPIO
 	select REGMAP_MMIO
+	select IRQ_DOMAIN_HIERARCHY
 
 config PINCTRL_ROCKCHIP
 	bool
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 84943e4..c3962b9 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -59,11 +59,23 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/seq_file.h>
+#include <linux/of_irq.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
 #include "pinctrl-meson.h"
 
+#define REG_EDGE_POL		0x00
+#define REG_GPIO_SEL0		0x04
+#define REG_GPIO_SEL1		0x08
+#define REG_FILTER		0x0c
+
+#define IRQ_FREE		(-1)
+
+#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
+#define REG_EDGE_POL_EDGE(x)	BIT(x)
+#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
+
 /**
  * meson_get_bank() - find the bank containing a given pin
  *
@@ -540,6 +552,30 @@ static int meson_gpio_get(struct gpio_chip *chip, unsigned gpio)
 	return !!(val & BIT(bit));
 }
 
+static int meson_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct meson_domain *domain = to_meson_domain(chip);
+	struct meson_pinctrl *pc = domain->pinctrl;
+	struct meson_bank *bank;
+	struct irq_fwspec irq_data;
+	unsigned int hwirq, irq;
+
+	hwirq = domain->data->pin_base + offset;
+
+	if (meson_get_bank(domain, hwirq, &bank))
+		return -ENXIO;
+
+	irq_data.param_count = 2;
+	irq_data.param[0] = hwirq;
+
+	/* dummy. It will be changed later in meson_irq_set_type */
+	irq_data.param[1] = IRQ_TYPE_EDGE_RISING;
+
+	irq = irq_domain_alloc_irqs(pc->irq_domain, 1, NUMA_NO_NODE, &irq_data);
+
+	return irq ? irq : -ENXIO;
+}
+
 static const struct of_device_id meson_pinctrl_dt_match[] = {
 	{
 		.compatible = "amlogic,meson8-pinctrl",
@@ -569,6 +605,7 @@ static int meson_gpiolib_register(struct meson_pinctrl *pc)
 		domain->chip.direction_output = meson_gpio_direction_output;
 		domain->chip.get = meson_gpio_get;
 		domain->chip.set = meson_gpio_set;
+		domain->chip.to_irq = meson_gpio_to_irq;
 		domain->chip.base = domain->data->pin_base;
 		domain->chip.ngpio = domain->data->num_pins;
 		domain->chip.can_sleep = false;
@@ -680,6 +717,7 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 		}
 
 		domain->of_node = np;
+		domain->pinctrl = pc;
 
 		domain->reg_mux = meson_map_resource(pc, np, "mux");
 		if (IS_ERR(domain->reg_mux)) {
@@ -710,6 +748,267 @@ static int meson_pinctrl_parse_dt(struct meson_pinctrl *pc,
 	return 0;
 }
 
+static int meson_get_gic_irq(struct meson_pinctrl *pc, int hwirq)
+{
+	int i = 0;
+
+	for (i = 0; i < pc->num_gic_irqs; i++) {
+		if (pc->irq_map[i] == hwirq)
+			return i;
+	}
+
+	return -1;
+}
+
+static int meson_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct meson_pinctrl *pc = irq_data_get_irq_chip_data(data);
+	u32 val = 0;
+	int index;
+
+	dev_dbg(pc->dev, "set type of hwirq %lu to %u\n", data->hwirq, type);
+	spin_lock(&pc->lock);
+	index = meson_get_gic_irq(pc, data->hwirq);
+
+	if (index < 0) {
+		spin_unlock(&pc->lock);
+		dev_err(pc->dev, "hwirq %lu not allocated\n", data->hwirq);
+		return -EINVAL;
+	}
+
+	if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_EDGE_RISING)
+		val |= REG_EDGE_POL_EDGE(index);
+	if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW)
+		val |= REG_EDGE_POL_LOW(index);
+
+	regmap_update_bits(pc->reg_irq, REG_EDGE_POL, REG_EDGE_POL_MASK(index),
+			   val);
+	spin_unlock(&pc->lock);
+
+	if (type == IRQ_TYPE_LEVEL_LOW)
+		type = IRQ_TYPE_LEVEL_HIGH;
+	else if (type == IRQ_TYPE_EDGE_FALLING)
+		type = IRQ_TYPE_EDGE_RISING;
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+int meson_irq_request_resources(struct irq_data *data)
+{
+	struct meson_pinctrl *pc = irq_data_get_irq_chip_data(data);
+	struct meson_domain *domain;
+	struct meson_bank *bank;
+
+	if (meson_get_domain_and_bank(pc, data->hwirq, &domain, &bank))
+		return -EINVAL;
+
+	if (gpiochip_lock_as_irq(&domain->chip, data->hwirq))
+		return -EINVAL;
+
+	return 0;
+}
+
+void meson_irq_release_resources(struct irq_data *data)
+{
+	struct meson_pinctrl *pc = irq_data_get_irq_chip_data(data);
+	struct meson_domain *domain;
+	struct meson_bank *bank;
+
+	if (meson_get_domain_and_bank(pc, data->hwirq, &domain, &bank))
+		return;
+
+	gpiochip_unlock_as_irq(&domain->chip, data->hwirq);
+}
+
+static struct irq_chip meson_irq_chip = {
+	.name			= "meson-gpio-irqchip",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= meson_irq_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_request_resources	= meson_irq_request_resources,
+	.irq_release_resources	= meson_irq_release_resources,
+};
+
+static int meson_map_gic_irq(struct irq_domain *irq_domain,
+			     irq_hw_number_t hwirq)
+{
+	struct meson_pinctrl *pc = irq_domain->host_data;
+	struct meson_domain *domain;
+	struct meson_bank *bank;
+	int index, reg, ret;
+
+	ret = meson_get_domain_and_bank(pc, hwirq, &domain, &bank);
+	if (ret)
+		return ret;
+
+	spin_lock(&pc->lock);
+
+	index = meson_get_gic_irq(pc, IRQ_FREE);
+	if (index < 0) {
+		spin_unlock(&pc->lock);
+		dev_err(pc->dev, "no free GIC interrupt found");
+		return -ENOSPC;
+	}
+
+	dev_dbg(pc->dev, "found free GIC interrupt %d\n", index);
+	pc->irq_map[index] = hwirq;
+
+	/* Setup IRQ mapping */
+	reg = index < 4 ? REG_GPIO_SEL0 : REG_GPIO_SEL1;
+	regmap_update_bits(pc->reg_irq, reg, 0xff << (index % 4) * 8,
+			  (bank->irq + hwirq - bank->first) << (index % 4) * 8);
+
+	/* Set filter to the default, undocumented value of 7 */
+	regmap_update_bits(pc->reg_irq, REG_FILTER, 0xf << index * 4,
+			   7 << index * 4);
+
+	spin_unlock(&pc->lock);
+
+	return index;
+}
+
+static int meson_irq_domain_alloc(struct irq_domain *domain, unsigned int irq,
+				  unsigned int nr_irqs, void *arg)
+{
+	struct meson_pinctrl *pc = domain->host_data;
+	struct irq_fwspec *irq_data = arg;
+	struct irq_fwspec gic_data;
+	irq_hw_number_t hwirq;
+	int index, ret, i;
+
+	if (irq_data->param_count != 2)
+		return -EINVAL;
+
+	hwirq = irq_data->param[0];
+	dev_dbg(pc->dev, "%s irq %d, nr %d, hwirq %lu\n",
+			__func__, irq, nr_irqs, hwirq);
+
+	for (i = 0; i < nr_irqs; i++) {
+		index = meson_map_gic_irq(domain, hwirq + i);
+		if (index < 0)
+			return index;
+
+		irq_domain_set_hwirq_and_chip(domain, irq + i,
+					      hwirq + i,
+					      &meson_irq_chip,
+					      pc);
+
+		gic_data = pc->gic_irqs[index];
+		ret = irq_domain_alloc_irqs_parent(domain, irq + i, nr_irqs,
+						   &gic_data);
+	}
+
+	return 0;
+}
+
+static void meson_irq_domain_free(struct irq_domain *domain, unsigned int irq,
+				  unsigned int nr_irqs)
+{
+	struct meson_pinctrl *pc = domain->host_data;
+	struct irq_data *irq_data;
+	int index, i;
+
+	spin_lock(&pc->lock);
+	for (i = 0; i < nr_irqs; i++) {
+		irq_data = irq_domain_get_irq_data(domain, irq + i);
+		index = meson_get_gic_irq(pc, irq_data->hwirq);
+		if (index < 0)
+			continue;
+		pc->irq_map[index] = IRQ_FREE;
+	}
+	spin_unlock(&pc->lock);
+
+	irq_domain_free_irqs_parent(domain, irq, nr_irqs);
+}
+
+static int meson_irq_domain_translate(struct irq_domain *d,
+				      struct irq_fwspec *fwspec,
+				      unsigned long *hwirq,
+				      unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static struct irq_domain_ops meson_irq_domain_ops = {
+	.alloc		= meson_irq_domain_alloc,
+	.free		= meson_irq_domain_free,
+	.translate	= meson_irq_domain_translate,
+};
+
+static int meson_gpio_irq_init(struct platform_device *pdev,
+			       struct meson_pinctrl *pc)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *parent_node;
+	struct irq_domain *parent_domain;
+	int i;
+
+	parent_node = of_irq_find_parent(node);
+	if (!parent_node) {
+		dev_err(pc->dev, "can't find parent interrupt controller\n");
+		return -EINVAL;
+	}
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain) {
+		dev_err(pc->dev, "can't find parent IRQ domain\n");
+		return -EINVAL;
+	}
+
+	pc->reg_irq = meson_map_resource(pc, node, "irq");
+	if (!pc->reg_irq) {
+		dev_err(pc->dev, "can't find irq registers\n");
+		return -EINVAL;
+	}
+
+	pc->num_gic_irqs = of_irq_count(node);
+	if (!pc->num_gic_irqs) {
+		dev_err(pc->dev, "no parent interrupts specified\n");
+		return -EINVAL;
+	}
+
+	pc->irq_map = devm_kmalloc(pc->dev, sizeof(int) * pc->num_gic_irqs,
+				   GFP_KERNEL);
+	if (!pc->irq_map)
+		return -ENOMEM;
+
+	pc->gic_irqs = devm_kzalloc(pc->dev, sizeof(struct irq_fwspec) *
+				    pc->num_gic_irqs, GFP_KERNEL);
+	if (!pc->gic_irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < pc->num_gic_irqs; i++) {
+		struct of_phandle_args oirq;
+
+		of_irq_parse_one(node, i, &oirq);
+		irq_of_phandle_args_to_fwspec(&oirq, &pc->gic_irqs[i]);
+
+		pc->irq_map[i] = IRQ_FREE;
+	}
+
+	pc->irq_domain = irq_domain_add_hierarchy(parent_domain, 0,
+						  pc->data->last_pin,
+						  node, &meson_irq_domain_ops,
+						  pc);
+	if (!pc->irq_domain)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int meson_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
@@ -749,6 +1048,10 @@ static int meson_pinctrl_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = meson_gpio_irq_init(pdev, pc);
+	if (ret)
+		dev_err(pc->dev, "can't setup gpio interrupts\n");
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 0fe7d53..c2f64b6 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -16,6 +16,8 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
+struct meson_pinctrl;
+
 /**
  * struct meson_pmx_group - a pinmux group
  *
@@ -83,6 +85,7 @@ enum meson_reg_type {
  * @first:	first pin of the bank
  * @last:	last pin of the bank
  * @regs:	array of register descriptors
+ * @irq:	input mux location for IRQs
  *
  * A bank represents a set of pins controlled by a contiguous set of
  * bits in the domain registers. The structure specifies which bits in
@@ -94,6 +97,7 @@ struct meson_bank {
 	unsigned int first;
 	unsigned int last;
 	struct meson_reg_desc regs[NUM_REG];
+	unsigned int irq;
 };
 
 /**
@@ -109,6 +113,7 @@ struct meson_domain_data {
 	unsigned int num_banks;
 	unsigned int pin_base;
 	unsigned int num_pins;
+	struct meson_pinctrl *pinctrl;
 };
 
 /**
@@ -121,6 +126,7 @@ struct meson_domain_data {
  * @chip:	gpio chip associated with the domain
  * @data;	platform data for the domain
  * @node:	device tree node for the domain
+ * @pinctrl:	pinctrl struct associated with the domain
  *
  * A domain represents a set of banks controlled by the same set of
  * registers.
@@ -134,6 +140,7 @@ struct meson_domain {
 	struct gpio_chip chip;
 	struct meson_domain_data *data;
 	struct device_node *of_node;
+	struct meson_pinctrl *pinctrl;
 };
 
 struct meson_pinctrl_data {
@@ -145,6 +152,7 @@ struct meson_pinctrl_data {
 	unsigned int num_groups;
 	unsigned int num_funcs;
 	unsigned int num_domains;
+	unsigned int last_pin;
 };
 
 struct meson_pinctrl {
@@ -153,6 +161,13 @@ struct meson_pinctrl {
 	struct pinctrl_desc desc;
 	struct meson_pinctrl_data *data;
 	struct meson_domain *domains;
+
+	struct irq_fwspec *gic_irqs;
+	struct irq_domain *irq_domain;
+	unsigned int num_gic_irqs;
+	unsigned int *irq_map;
+	struct regmap *reg_irq;
+	spinlock_t lock;
 };
 
 #define PIN(x, b)	(b + x)
@@ -192,11 +207,12 @@ struct meson_pinctrl {
 		.num_groups = ARRAY_SIZE(fn ## _groups),		\
 	}
 
-#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib)		\
+#define BANK(n, f, l, per, peb, pr, pb, dr, db, or, ob, ir, ib, i)	\
 	{								\
 		.name	= n,						\
 		.first	= f,						\
 		.last	= l,						\
+		.irq	= i,						\
 		.regs	= {						\
 			[REG_PULLEN]	= { per, peb },			\
 			[REG_PULL]	= { pr, pb },			\
diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 7b1cc91..d941568 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -14,7 +14,12 @@
 #include <dt-bindings/gpio/meson8-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFF	120
+#define EE_BASE		0
+#define EE_NPINS	120
+#define AO_BASE		120
+#define AO_NPINS	16
+
+#define AO_OFF		AO_BASE
 
 static const struct pinctrl_pin_desc meson8_pins[] = {
 	MESON_PIN(GPIOX_0, 0),
@@ -907,19 +912,19 @@ static struct meson_pmx_func meson8_functions[] = {
 };
 
 static struct meson_bank meson8_banks[] = {
-	/*   name    first             last                 pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    1,  0,  1,  0,  3, 17,  4, 17,  5, 17),
-	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
+	/*   name    first             last                 pullen  pull    dir     out     in     irq */
+	BANK("X",    PIN(GPIOX_0, 0),  PIN(GPIOX_21, 0),    4,  0,  4,  0,  0,  0,  1,  0,  2,  0, 112),
+	BANK("Y",    PIN(GPIOY_0, 0),  PIN(GPIOY_16, 0),    3,  0,  3,  0,  3,  0,  4,  0,  5,  0,  95),
+	BANK("DV",   PIN(GPIODV_0, 0), PIN(GPIODV_29, 0),   0,  0,  0,  0,  7,  0,  8,  0,  9,  0,  65),
+	BANK("H",    PIN(GPIOH_0, 0),  PIN(GPIOH_9, 0),     1, 16,  1, 16,  9, 19, 10, 19, 11, 19,  29),
+	BANK("Z",    PIN(GPIOZ_0, 0),  PIN(GPIOZ_14, 0),    1,  0,  1,  0,  3, 17,  4, 17,  5, 17,  14),
+	BANK("CARD", PIN(CARD_0, 0),   PIN(CARD_6, 0),      2, 20,  2, 20,  0, 22,  1, 22,  2, 22,  58),
+	BANK("BOOT", PIN(BOOT_0, 0),   PIN(BOOT_18, 0),     2,  0,  2,  0,  9,  0, 10,  0, 11,  0,  39),
 };
 
 static struct meson_bank meson8_ao_banks[] = {
-	/*   name    first                  last                      pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      pullen  pull    dir     out     in     irq */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0,  0),
 };
 
 static struct meson_domain_data meson8_domain_data[] = {
@@ -927,15 +932,15 @@ static struct meson_domain_data meson8_domain_data[] = {
 		.name		= "banks",
 		.banks		= meson8_banks,
 		.num_banks	= ARRAY_SIZE(meson8_banks),
-		.pin_base	= 0,
-		.num_pins	= 120,
+		.pin_base	= EE_BASE,
+		.num_pins	= EE_NPINS,
 	},
 	{
 		.name		= "ao-bank",
 		.banks		= meson8_ao_banks,
 		.num_banks	= ARRAY_SIZE(meson8_ao_banks),
-		.pin_base	= 120,
-		.num_pins	= 16,
+		.pin_base	= AO_BASE,
+		.num_pins	= AO_NPINS,
 	},
 };
 
@@ -948,4 +953,5 @@ struct meson_pinctrl_data meson8_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson8_groups),
 	.num_funcs	= ARRAY_SIZE(meson8_functions),
 	.num_domains	= ARRAY_SIZE(meson8_domain_data),
+	.last_pin	= EE_NPINS + AO_NPINS,
 };
diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 9677807..c921ae3 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -15,7 +15,12 @@
 #include <dt-bindings/gpio/meson8b-gpio.h>
 #include "pinctrl-meson.h"
 
-#define AO_OFF	130
+#define EE_BASE		0
+#define EE_NPINS	130
+#define AO_BASE		130
+#define AO_NPINS	16
+
+#define AO_OFF		AO_BASE
 
 static const struct pinctrl_pin_desc meson8b_pins[] = {
 	MESON_PIN(GPIOX_0, 0),
@@ -855,19 +860,19 @@ static struct meson_pmx_func meson8b_functions[] = {
 };
 
 static struct meson_bank meson8b_banks[] = {
-	/*   name    first                      last                   pullen  pull    dir     out     in  */
-	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0),
-	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0),
-	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),     0,  0,  0,  0,  7,  0,  8,  0,  9,  0),
-	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),       1, 16,  1, 16,  9, 19, 10, 19, 11, 19),
-	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),        2, 20,  2, 20,  0, 22,  1, 22,  2, 22),
-	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),       2,  0,  2,  0,  9,  0, 10,  0, 11,  0),
-	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),       5,  8,  5,  8, 12, 12, 13, 12, 14, 12),
+	/*   name    first                      last                   pullen  pull    dir     out     in     irq */
+	BANK("X",    PIN(GPIOX_0, 0),		PIN(GPIOX_21, 0),      4,  0,  4,  0,  0,  0,  1,  0,  2,  0,  97),
+	BANK("Y",    PIN(GPIOY_0, 0),		PIN(GPIOY_14, 0),      3,  0,  3,  0,  3,  0,  4,  0,  5,  0,  80),
+	BANK("DV",   PIN(GPIODV_9, 0),		PIN(GPIODV_29, 0),     0,  0,  0,  0,  7,  0,  8,  0,  9,  0,  59),
+	BANK("H",    PIN(GPIOH_0, 0),		PIN(GPIOH_9, 0),       1, 16,  1, 16,  9, 19, 10, 19, 11, 19,  14),
+	BANK("CARD", PIN(CARD_0, 0),		PIN(CARD_6, 0),        2, 20,  2, 20,  0, 22,  1, 22,  2, 22,  43),
+	BANK("BOOT", PIN(BOOT_0, 0),		PIN(BOOT_18, 0),       2,  0,  2,  0,  9,  0, 10,  0, 11,  0,  24),
+	BANK("DIF",  PIN(DIF_0_P, 0),		PIN(DIF_4_N, 0),       5,  8,  5,  8, 12, 12, 13, 12, 14, 12, 119),
 };
 
 static struct meson_bank meson8b_ao_banks[] = {
-	/*   name    first                  last                      pullen  pull    dir     out     in  */
-	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	/*   name    first                  last                      pullen  pull    dir     out     in    irq */
+	BANK("AO",   PIN(GPIOAO_0, AO_OFF), PIN(GPIO_TEST_N, AO_OFF), 0,  0,  0, 16,  0,  0,  0, 16,  1,  0,  0),
 };
 
 static struct meson_domain_data meson8b_domain_data[] = {
@@ -875,15 +880,15 @@ static struct meson_domain_data meson8b_domain_data[] = {
 		.name		= "banks",
 		.banks		= meson8b_banks,
 		.num_banks	= ARRAY_SIZE(meson8b_banks),
-		.pin_base	= 0,
-		.num_pins	= 130,
+		.pin_base	= EE_BASE,
+		.num_pins	= EE_NPINS,
 	},
 	{
 		.name		= "ao-bank",
 		.banks		= meson8b_ao_banks,
 		.num_banks	= ARRAY_SIZE(meson8b_ao_banks),
-		.pin_base	= 130,
-		.num_pins	= 16,
+		.pin_base	= AO_BASE,
+		.num_pins	= AO_NPINS,
 	},
 };
 
@@ -896,4 +901,5 @@ struct meson_pinctrl_data meson8b_pinctrl_data = {
 	.num_groups	= ARRAY_SIZE(meson8b_groups),
 	.num_funcs	= ARRAY_SIZE(meson8b_functions),
 	.num_domains	= ARRAY_SIZE(meson8b_domain_data),
+	.last_pin	= EE_NPINS + AO_NPINS,
 };
-- 
2.5.0
