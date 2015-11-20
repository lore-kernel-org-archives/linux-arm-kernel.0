From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:44 +0200
Subject: [PATCH 09/10] irqchip: lpc32xx: add option to wakeup from an interrupt
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-10-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change allows to set wakeup interrupts on client side.

Now all LPC32xx irq chips have assigned irq_set_wake callback, which
is rerouted to some platform specific wakeup controller.

Mapping between particular interrupts and wakeup sources is taken from
interrupt controller device tree node.

It is worth to mention that during initialization wakeup controller
driver may appear after initialization of interrupt controller driver,
this situation is correctly handled.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/irqchip/irq-lpc32xx.c | 103 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index fcf281b..e0f50da 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -19,6 +19,7 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <asm/exception.h>
+#include <mach/wakeup.h>
 
 #define LPC32XX_INTC_MASK		0x00
 #define LPC32XX_INTC_RAW		0x04
@@ -27,16 +28,53 @@
 #define LPC32XX_INTC_TYPE		0x10
 #define LPC32XX_INTC_FIQ		0x14
 
+struct irq_to_wakeup {
+	/*
+	 * wakeup controller driver initialization may be deferred,
+	 * get its platform driver in runtime by device node
+	 */
+	struct wakeup_controller *wakeup;
+	struct device_node *wakeup_node;
+	u32 bit;
+};
+
 #define IRQS_PER_CONTROLLER		32
 
 struct lpc32xx_irq_chip {
 	void __iomem *base;
 	struct irq_domain *domain;
 	struct irq_chip chip;
+	struct irq_to_wakeup i2w[IRQS_PER_CONTROLLER];
 };
 
 static struct lpc32xx_irq_chip *lpc32xx_mic_data;
 
+static struct wakeup_controller *get_wakeup_bit(struct irq_data *d, u32 *bit)
+{
+	struct irq_domain *id = d->domain;
+	struct lpc32xx_irq_chip *ic = (struct lpc32xx_irq_chip *)id->host_data;
+	struct irq_to_wakeup *i2w = &ic->i2w[d->hwirq];
+	struct platform_device *wakeup;
+
+	if (!i2w->wakeup_node)
+		return NULL;
+
+	if (!i2w->wakeup) {
+		pr_debug("searching wakeup device for interrupt %u\n",
+				 irq_find_mapping(id, d->hwirq));
+		wakeup = of_find_device_by_node(i2w->wakeup_node);
+		if (wakeup) {
+			i2w->wakeup = platform_get_drvdata(wakeup);
+			of_node_put(i2w->wakeup_node);
+		}
+	}
+
+	if (i2w->wakeup)
+		*bit = i2w->bit;
+
+	return i2w->wakeup;
+}
+
 static inline u32 lpc32xx_ic_read(struct irq_domain *id, u32 reg)
 {
 	struct lpc32xx_irq_chip *ic = (struct lpc32xx_irq_chip *)id->host_data;
@@ -77,8 +115,9 @@ static void lpc32xx_irq_ack(struct irq_data *d)
 static int lpc32xx_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct irq_domain *domain = d->domain;
-	u32 val, mask = BIT(d->hwirq);
+	u32 bit, val, mask = BIT(d->hwirq);
 	bool high, edge;
+	struct wakeup_controller *wuc;
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -121,6 +160,24 @@ static int lpc32xx_irq_set_type(struct irq_data *d, unsigned int type)
 	}
 	lpc32xx_ic_write(domain, LPC32XX_INTC_TYPE, val);
 
+	wuc = get_wakeup_bit(d, &bit);
+	if (wuc)
+		lpc32xx_wakeup_set_edge(wuc, bit, high);
+
+	return 0;
+}
+
+static int lpc32xx_irq_set_wake(struct irq_data *d, unsigned int state)
+{
+	struct wakeup_controller *wuc;
+	u32 bit;
+
+	wuc = get_wakeup_bit(d, &bit);
+	if (wuc)
+		lpc32xx_wakeup_enable(wuc, bit, state);
+	else
+		return -ENODEV;
+
 	return 0;
 }
 
@@ -174,11 +231,42 @@ static const struct irq_domain_ops lpc32xx_irq_domain_ops = {
 	.xlate  = irq_domain_xlate_twocell,
 };
 
+static void __init of_node_to_wakeup(struct irq_to_wakeup *i2w,
+				     struct of_phandle_args *args)
+{
+	struct platform_device *wakeup;
+	int wakeup_cells = 0;
+	u32 hwirq;
+
+	if (!of_device_is_available(args->np))
+		return;
+
+	of_property_read_u32(args->np, "#wakeup-cells", &wakeup_cells);
+	if (wakeup_cells != 2) {
+		pr_info("%s: unsupported format of wakeup data, got %d\n",
+			args->np->full_name, wakeup_cells);
+		return;
+	}
+
+	hwirq = args->args[1];
+
+	wakeup = of_find_device_by_node(args->np);
+	if (wakeup) {
+		i2w[hwirq].wakeup = platform_get_drvdata(wakeup);
+	} else {
+		i2w[hwirq].wakeup_node = args->np;
+		of_node_get(i2w[hwirq].wakeup_node);
+	}
+
+	i2w[hwirq].bit = args->args[0];
+}
+
 static int __init lpc32xx_of_ic_init(struct device_node *node,
 				     struct device_node *parent)
 {
-	int parent_irq, i;
+	int parent_irq, i, ret;
 	struct lpc32xx_irq_chip *irqc;
+	struct of_phandle_args args;
 
 	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
 	if (!irqc)
@@ -188,9 +276,20 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
 	irqc->chip.irq_mask = lpc32xx_irq_mask;
 	irqc->chip.irq_unmask = lpc32xx_irq_unmask;
 	irqc->chip.irq_set_type = lpc32xx_irq_set_type;
+	irqc->chip.irq_set_wake = lpc32xx_irq_set_wake;
 	irqc->chip.name = of_get_property(node, "interrupt-controller-name",
 					  NULL);
 
+	for (i = 0; ; i++) {
+		ret = of_parse_phandle_with_args(node, "wakeup-sources",
+						 "#wakeup-cells", i, &args);
+		if (ret)
+			break;
+
+		of_node_to_wakeup(irqc->i2w, &args);
+		of_node_put(args.np);
+	}
+
 	irqc->base = of_iomap(node, 0);
 	if (!irqc->base) {
 		pr_err("%s: unable to map registers\n", node->full_name);
-- 
2.1.4
