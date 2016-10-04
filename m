From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue,  4 Oct 2016 17:08:28 +0200
Subject: [RFC 10/10] irqchip: meson: Add support for IRQ_TYPE_EDGE_BOTH
In-Reply-To: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1475593708-10526-11-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IP cannot take IRQ_EDGE_BOTH because the polarity in the filtering
block is just one bit. It can trigger on either edge, but not both with
the same configuration.

This prevents meson based SoC to use some simple generic driver, like
gpio-keys. The proposition is to change edge polarity in the end of
interrupt callback (just toggling the polarity register of the IP).

This works nicely but has 2 limitations:
 1) If the signal is initially high, the first falling edge will not be
    detected, because the chip is initially configured for a rising
    edge.
 2) If the signal changes too quickly for all edges to be properly
    handled, an additional edge might get lost, for the same reason as
    point 1.

There is no drawback for introducing this work around so, knowing the
limitation, it would be nice to have it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/irqchip/irq-meson-gpio.c | 45 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 184025a9cdaf..5bcbefef3e94 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -58,6 +58,7 @@ struct meson_gpio_irq_domain {
 struct meson_gpio_irq_chip {
 	void __iomem *base;
 	int index;
+	unsigned int flow_type;
 };
 
 static const struct meson_gpio_irq_params meson8_params = {
@@ -91,6 +92,19 @@ static void meson_gpio_irq_update_bits(void __iomem *base, unsigned int reg,
 	writel(tmp, base + reg);
 }
 
+static void meson_gpio_irq_flip_bits(void __iomem *base, unsigned int reg,
+				     u32 mask)
+{
+	u32 tmp, val;
+
+	tmp = readl(base + reg);
+	val = tmp ^ mask;
+	tmp = (tmp & val) | val;
+
+	writel(tmp, base + reg);
+}
+
+
 static int meson_gpio_irq_get_index(struct meson_gpio_irq_domain *domain_data,
 				    int hwirq)
 {
@@ -135,11 +149,15 @@ static int meson_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 
 	pr_debug("set type of hwirq %lu to %u\n", data->hwirq, type);
 
-	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
-		return -EINVAL;
+	cd->flow_type = type;
 
 	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
 		val |= REG_EDGE_POL_EDGE(cd->index);
+	/*
+	 * Take care of the dual polarity issue here, starting positive
+	 */
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		type &= ~IRQ_TYPE_EDGE_FALLING;
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
 		val |= REG_EDGE_POL_LOW(cd->index);
@@ -162,11 +180,31 @@ static int meson_gpio_irq_set_type(struct irq_data *data, unsigned int type)
 	return irq_chip_set_type_parent(data, type);
 }
 
+static void meson_gpio_irq_eoi(struct irq_data *data)
+{
+	struct meson_gpio_irq_chip *cd = irq_data_get_irq_chip_data(data);
+
+	/*
+	 * To simulate IRQ_TYPE_EDGE_BOTH, change the polarity of the edge
+	 * after each interrupt.
+	 * Limitation:
+	 * 1) If the signal is initially high, the first falling edge will not
+	 *    be detected
+	 * 2) If the signal changes too quickly to detect all the edges, an
+	 *    additional edge might get lost.
+	 */
+	if ((cd->flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		meson_gpio_irq_flip_bits(cd->base, REG_EDGE_POL,
+					 REG_EDGE_POL_LOW(cd->index));
+
+	irq_chip_eoi_parent(data);
+}
+
 static struct irq_chip meson_gpio_irq_chip = {
 	.name			= "meson-gpio-irqchip",
 	.irq_mask		= irq_chip_mask_parent,
 	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_eoi		= meson_gpio_irq_eoi,
 	.irq_set_type		= meson_gpio_irq_set_type,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 #ifdef CONFIG_SMP
@@ -221,6 +259,7 @@ static int meson_gpio_irq_domain_alloc(struct irq_domain *domain,
 
 		cd->base = domain_data->base;
 		cd->index = index;
+		cd->flow_type = type;
 		fwspec_parent = &domain_data->parent_irqs[index];
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-- 
2.7.4
