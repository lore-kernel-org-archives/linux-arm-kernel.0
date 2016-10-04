From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:19 +0200
Subject: [RFC 01/10] irqchip: meson: add support for gpio interrupt controller
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-2-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the intterrupt gpio controller found on Amlogic's meson
SoC family.

Unlike what the IP name suggest, it is not directly linked to the gpio
subsystem. It is actually an indepedent IP that is able to spy on the
SoC pad. For that purpose, it can mux and filter (edge or level and
polarity) any single SoC pad to one of the 8 GIC's interrupts it owns.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/irqchip/Kconfig          |   9 +
 drivers/irqchip/Makefile         |   1 +
 drivers/irqchip/irq-meson-gpio.c | 398 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 drivers/irqchip/irq-meson-gpio.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 82b0b5daf3f5..168837263e80 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -279,3 +279,12 @@ config EZNPS_GIC
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
+
+config MESON_GPIO_IRQ
+       bool "Meson GPIO Interrupt Multiplexer"
+       depends on ARCH_MESON || COMPILE_TEST
+       select IRQ_DOMAIN
+       select IRQ_DOMAIN_HIERARCHY
+       help
+         Support Meson SoC Family GPIO Interrupt Multiplexer
+
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e4dbfc85abdb..33f913d037d0 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -74,3 +74,4 @@ obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
+obj-$(CONFIG_MESON_GPIO_IRQ)		+= irq-meson-gpio.o
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
new file mode 100644
index 000000000000..184025a9cdaf
--- /dev/null
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -0,0 +1,398 @@
+/*
+ * Copyright (C) 2015 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * The full GNU General Public License is included in this distribution
+ * in the file called COPYING.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+
+#define IRQ_FREE (-1)
+
+#define REG_EDGE_POL	0x00
+#define REG_PIN_03_SEL	0x04
+#define REG_PIN_47_SEL	0x08
+#define REG_FILTER_SEL	0x0c
+
+#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
+#define REG_EDGE_POL_EDGE(x)	BIT(x)
+#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
+#define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
+#define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
+
+struct meson_gpio_irq_params {
+	unsigned int nr_hwirqs;
+};
+
+struct meson_gpio_irq_domain {
+	struct irq_fwspec *parent_irqs;
+	void __iomem *base;
+	int nr_parent_irqs;
+	int *irq_map;
+};
+
+struct meson_gpio_irq_chip {
+	void __iomem *base;
+	int index;
+};
+
+static const struct meson_gpio_irq_params meson8_params = {
+	.nr_hwirqs = 134,
+};
+
+static const struct meson_gpio_irq_params meson8b_params = {
+	.nr_hwirqs = 119,
+};
+
+static const struct meson_gpio_irq_params gxbb_params = {
+	.nr_hwirqs = 133,
+};
+
+static const struct of_device_id meson_irq_gpio_matches[] = {
+	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
+	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
+	{ .compatible = "amlogic,gxbb-gpio-intc", .data = &gxbb_params },
+	{ }
+};
+
+static void meson_gpio_irq_update_bits(void __iomem *base, unsigned int reg,
+				       u32 mask, u32 val)
+{
+	u32 tmp;
+
+	tmp = readl(base + reg);
+	tmp &= ~mask;
+	tmp |= val;
+
+	writel(tmp, base + reg);
+}
+
+static int meson_gpio_irq_get_index(struct meson_gpio_irq_domain *domain_data,
+				    int hwirq)
+{
+	int i;
+
+	for (i = 0; i < domain_data->nr_parent_irqs; i++) {
+		if (domain_data->irq_map[i] == hwirq)
+			return i;
+	}
+
+	return -1;
+}
+
+static int meson_gpio_irq_map_pirq(struct meson_gpio_irq_domain *domain_data,
+				   irq_hw_number_t hwirq)
+{
+	int index;
+	unsigned int reg;
+
+	index = meson_gpio_irq_get_index(domain_data, IRQ_FREE);
+	if (index < 0) {
+		pr_err("No irq available\n");
+		return -ENOSPC;
+	}
+
+	domain_data->irq_map[index] = hwirq;
+
+	reg = (index < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
+	meson_gpio_irq_update_bits(domain_data->base, reg,
+				   0xff << REG_PIN_SEL_SHIFT(index),
+				   hwirq << REG_PIN_SEL_SHIFT(index));
+
+	pr_debug("hwirq %d assigned to channel %d\n", (int)hwirq, index);
+
+	return index;
+}
+
+static int meson_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct meson_gpio_irq_chip *cd = irq_data_get_irq_chip_data(data);
+	u32 val = 0;
+
+	pr_debug("set type of hwirq %lu to %u\n", data->hwirq, type);
+
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		return -EINVAL;
+
+	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
+		val |= REG_EDGE_POL_EDGE(cd->index);
+
+	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
+		val |= REG_EDGE_POL_LOW(cd->index);
+
+		/*
+		 * According to the datasheet, the polarity block invert the
+		 * signal on the path to parent interrupt
+		 */
+		if (type & IRQ_TYPE_LEVEL_LOW)
+			type = (type & ~IRQ_TYPE_LEVEL_LOW)
+				| IRQ_TYPE_LEVEL_HIGH;
+		else
+			type = (type & ~IRQ_TYPE_EDGE_FALLING)
+				| IRQ_TYPE_EDGE_RISING;
+	}
+
+	meson_gpio_irq_update_bits(cd->base, REG_EDGE_POL,
+				   REG_EDGE_POL_MASK(cd->index), val);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip meson_gpio_irq_chip = {
+	.name			= "meson-gpio-irqchip",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= meson_gpio_irq_set_type,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+};
+
+static int meson_gpio_irq_domain_translate(struct irq_domain *domain,
+					   struct irq_fwspec *fwspec,
+					   unsigned long *hwirq,
+					   unsigned int *type)
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
+static int meson_gpio_irq_domain_alloc(struct irq_domain *domain,
+				       unsigned int virq,
+				       unsigned int nr_irqs,
+				       void *data)
+{
+	struct irq_fwspec *fwspec_parent, *fwspec = data;
+	struct meson_gpio_irq_domain *domain_data = domain->host_data;
+	struct meson_gpio_irq_chip *cd;
+	unsigned long hwirq;
+	unsigned int type;
+	int i, index, ret;
+
+	ret = meson_gpio_irq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	pr_debug("irq %d, nr_irqs %d, hwirqs %lu\n", virq, nr_irqs, hwirq);
+
+	for (i = 0; i < nr_irqs; i++) {
+		index = meson_gpio_irq_map_pirq(domain_data, hwirq + i);
+		if (index < 0)
+			return index;
+
+		cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+		if (!cd)
+			return -ENOMEM;
+
+		cd->base = domain_data->base;
+		cd->index = index;
+		fwspec_parent = &domain_data->parent_irqs[index];
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &meson_gpio_irq_chip,
+					      cd);
+
+		ret = irq_domain_alloc_irqs_parent(domain, virq + i, 1,
+						   fwspec_parent);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void meson_gpio_irq_domain_free(struct irq_domain *domain,
+				       unsigned int virq,
+				       unsigned int nr_irqs)
+{
+	struct meson_gpio_irq_domain *domain_data = domain->host_data;
+	struct meson_gpio_irq_chip *cd;
+	struct irq_data *irq_data;
+	int i;
+
+	for (i = 0; i < nr_irqs; i++) {
+		irq_data = irq_domain_get_irq_data(domain, virq + i);
+		cd = irq_data_get_irq_chip_data(irq_data);
+
+		domain_data->irq_map[cd->index] = IRQ_FREE;
+		kfree(cd);
+	}
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+
+static const struct irq_domain_ops meson_gpio_irq_domain_ops = {
+	.alloc		= meson_gpio_irq_domain_alloc,
+	.free		= meson_gpio_irq_domain_free,
+	.translate	= meson_gpio_irq_domain_translate,
+};
+
+
+static int __init meson_gpio_irq_get_one_pirq(struct device_node *node,
+					      int index,
+					      struct irq_fwspec *pirq)
+{
+	int ret, i;
+	struct of_phandle_args oirq;
+
+	ret = of_irq_parse_one(node, index, &oirq);
+	if (ret < 0)
+		return ret;
+
+	pirq->fwnode = of_node_to_fwnode(oirq.np);
+
+	if (!pirq->fwnode) {
+		pr_err("can't get interrupt fwnode\n");
+		return -ENODEV;
+	}
+
+	pirq->param_count = oirq.args_count;
+	for (i = 0; i < oirq.args_count; i++)
+		pirq->param[i] = oirq.args[i];
+
+	return 0;
+}
+
+
+static int __init
+meson_gpio_irq_init_domain(struct device_node *node,
+			   struct meson_gpio_irq_domain *domain_data)
+{
+	int ret, i, n_pirqs;
+	int *map;
+	struct irq_fwspec *pirqs;
+
+	n_pirqs = of_irq_count(node);
+	if (n_pirqs == 0) {
+		pr_err("missing parent interrupts\n");
+		return -ENODEV;
+	}
+
+	pirqs = kcalloc(n_pirqs, sizeof(*pirqs), GFP_KERNEL);
+	if (!pirqs)
+		return -ENOMEM;
+
+	map = kcalloc(n_pirqs, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	for (i = 0; i < n_pirqs; i++) {
+		map[i] = IRQ_FREE;
+		ret = meson_gpio_irq_get_one_pirq(node, i, &pirqs[i]);
+		if (ret < 0)
+			return ret;
+	}
+
+	domain_data->nr_parent_irqs = n_pirqs;
+	domain_data->parent_irqs = pirqs;
+	domain_data->irq_map = map;
+
+	return 0;
+}
+
+static int __init meson_gpio_irq_of_init(struct device_node *node,
+					 struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	const struct of_device_id *match;
+	const struct meson_gpio_irq_params *params;
+	struct meson_gpio_irq_domain *domain_data;
+	int ret;
+
+	match = of_match_node(meson_irq_gpio_matches, node);
+	if (!match)
+		return -ENODEV;
+	params = match->data;
+
+	if (!parent) {
+		pr_err("missing parent interrupt node\n");
+		return -ENODEV;
+	}
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("unable to obtain parent domain\n");
+		return -ENXIO;
+	}
+
+	domain_data = kzalloc(sizeof(*domain_data), GFP_KERNEL);
+	if (!domain_data)
+		return -ENOMEM;
+
+	domain_data->base = of_iomap(node, 0);
+	if (!domain_data->base) {
+		ret = -ENOMEM;
+		goto out_free_dev;
+	}
+
+	ret = meson_gpio_irq_init_domain(node, domain_data);
+	if (ret < 0)
+		goto out_free_dev_content;
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, params->nr_hwirqs,
+					  node, &meson_gpio_irq_domain_ops,
+					  domain_data);
+
+	if (!domain) {
+		pr_err("failed to allocated domain\n");
+		ret = -ENOMEM;
+		goto out_free_dev_content;
+	}
+
+	pr_info("%d to %d gpio interrupt mux initialized\n",
+		params->nr_hwirqs, domain_data->nr_parent_irqs);
+
+	return 0;
+
+out_free_dev_content:
+	kfree(domain_data->parent_irqs);
+	kfree(domain_data->irq_map);
+	iounmap(domain_data->base);
+
+out_free_dev:
+	kfree(domain_data);
+
+	return ret;
+}
+IRQCHIP_DECLARE(meson8_gpio_intc, "amlogic,meson8-gpio-intc",
+		meson_gpio_irq_of_init);
+IRQCHIP_DECLARE(meson8b_gpio_intc, "amlogic,meson8b-gpio-intc",
+		meson_gpio_irq_of_init);
+IRQCHIP_DECLARE(gxbb_gpio_intc, "amlogic,gxbb-gpio-intc",
+		meson_gpio_irq_of_init);
-- 
2.7.4
