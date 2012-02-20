From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Mon, 20 Feb 2012 14:52:05 +0100
Subject: [PATCH] gpio/mxs: support irqs triggered by both edges
Message-ID: <1329745925-7868-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

iMX28 silicon does not support irqs triggered by both gpio edges. Patch
emulates this behavior by configuring such irqs as level triggered and
by switching polarity in the interrupt handler.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
---
 drivers/gpio/gpio-mxs.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 385c58e..ab973be 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -57,6 +57,7 @@ struct mxs_gpio_port {
 	int id;
 	int irq;
 	int virtual_irq_start;
+	unsigned long both_edge;
 	struct bgpio_chip bgc;
 };
 
@@ -68,9 +69,12 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	u32 pin_mask = 1 << (gpio & 31);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxs_gpio_port *port = gc->private;
+	int lvl;
 	void __iomem *pin_addr;
 	int edge;
 
+	clear_bit(gpio & 31, &port->both_edge);
+
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		edge = GPIO_INT_RISE_EDGE;
@@ -84,6 +88,14 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_LEVEL_HIGH:
 		edge = GPIO_INT_HIGH_LEV;
 		break;
+	case IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING:
+		/* mx28 does not support triggering irq by both edges; emulate
+		 * behavior by configuring irq as level triggered and update
+		 * irq polarity in the irq handler */
+		set_bit(gpio & 31, &port->both_edge);
+		lvl  = readl(port->base + PINCTRL_DIN(port->id));
+		edge = (lvl & pin_mask) ? GPIO_INT_LOW_LEV : GPIO_INT_HIGH_LEV;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -114,11 +126,26 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 	u32 irq_stat;
 	struct mxs_gpio_port *port = irq_get_handler_data(irq);
 	u32 gpio_irq_no_base = port->virtual_irq_start;
+	void __iomem *base = port->base;
+	u32 pol_msk;
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
-	irq_stat = readl(port->base + PINCTRL_IRQSTAT(port->id)) &
-			readl(port->base + PINCTRL_IRQEN(port->id));
+	irq_stat = readl(base + PINCTRL_IRQSTAT(port->id)) &
+			readl(base + PINCTRL_IRQEN(port->id));
+
+	/* handle irqs triggered by both edges */
+	pol_msk = irq_stat & port->both_edge;
+	if (pol_msk) {
+		void __iomem *reg = base + PINCTRL_IRQPOL(port->id);
+		u32 port_lvl = readl(base + PINCTRL_DIN(port->id));
+
+		/* \todo write into the TOGGLE register (without reading port
+		 * level register); this requires a special unmask operation
+		 * which updates the IRQPOL register */
+		writel(pol_msk & port_lvl, reg + MXS_CLR);
+		writel(pol_msk & ~port_lvl, reg + MXS_SET);
+	}
 
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
-- 
1.7.7.6
