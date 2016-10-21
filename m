From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 Oct 2016 15:11:38 +0200
Subject: [PATCH 2/2] gpio: mxs: fix duplicate level interrupts
In-Reply-To: <20161021131138.10467-1-s.hauer@pengutronix.de>
References: <20161021131138.10467-1-s.hauer@pengutronix.de>
Message-ID: <20161021131138.10467-3-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the reference manual level interrupts can't be acked
using the IRQSTAT registers. The effect is that when a level interrupt
triggers the following ack is a no-op and the same interrupt triggers
again right after it has been unmasked after running the interrupt
handler.

The reference manual says:

Status bits for pins configured as level sensitive interrupts cannot be
cleared unless either the actual pin is in the non-interrupting state, or
the pin has been disabled as an interrupt source by clearing its bit in
HW_PINCTRL_PIN2IRQ.

To work around the duplicated interrupts we can use the PIN2IRQ
rather than the IRQEN registers to mask the interrupts. This
probably does not work for the edge interrupts, so we have to split up
the irq chip into two chip types, one for the level interrupts and
one for the edge interrupts. We now make use of two different enable
registers, so we have to take care to always enable the right one,
especially during switching of the interrupt type. An easy way
to accomplish this is to use the IRQCHIP_SET_TYPE_MASKED which
makes sure that set_irq_type is called with masked interrupts. With this
the flow to change the irq type is like:

- core masks interrupt (using the current chip type)
- mxs_gpio_set_irq_type() changes chip type if necessary
- mxs_gpio_set_irq_type() unconditionally sets the enable bit in the
  now unused enable register
- core eventually unmasks the interrupt (using the new chip type)

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/gpio/gpio-mxs.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 1cf579f..62061f7 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -87,10 +87,15 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	u32 val;
 	u32 pin_mask = 1 << d->hwirq;
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mxs_gpio_port *port = gc->private;
 	void __iomem *pin_addr;
 	int edge;
 
+	if (!(ct->type & type))
+		if (irq_setup_alt_chip(d, type))
+			return -EINVAL;
+
 	port->both_edges &= ~pin_mask;
 	switch (type) {
 	case IRQ_TYPE_EDGE_BOTH:
@@ -119,10 +124,13 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 
 	/* set level or edge */
 	pin_addr = port->base + PINCTRL_IRQLEV(port);
-	if (edge & GPIO_INT_LEV_MASK)
+	if (edge & GPIO_INT_LEV_MASK) {
 		writel(pin_mask, pin_addr + MXS_SET);
-	else
+		writel(pin_mask, port->base + PINCTRL_IRQEN(port) + MXS_SET);
+	} else {
 		writel(pin_mask, pin_addr + MXS_CLR);
+		writel(pin_mask, port->base + PINCTRL_PIN2IRQ(port) + MXS_SET);
+	}
 
 	/* set polarity */
 	pin_addr = port->base + PINCTRL_IRQPOL(port);
@@ -202,22 +210,37 @@ static int __init mxs_gpio_init_gc(struct mxs_gpio_port *port, int irq_base)
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_alloc_generic_chip("gpio-mxs", 1, irq_base,
+	gc = irq_alloc_generic_chip("gpio-mxs", 2, irq_base,
 				    port->base, handle_level_irq);
 	if (!gc)
 		return -ENOMEM;
 
 	gc->private = port;
 
-	ct = gc->chip_types;
+	ct = &gc->chip_types[0];
+	ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
+	ct->chip.irq_ack = irq_gc_ack_set_bit;
+	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+	ct->chip.irq_set_type = mxs_gpio_set_irq_type;
+	ct->chip.irq_set_wake = mxs_gpio_set_wake_irq;
+	ct->chip.flags = IRQCHIP_SET_TYPE_MASKED;
+	ct->regs.ack = PINCTRL_IRQSTAT(port) + MXS_CLR;
+	ct->regs.enable = PINCTRL_PIN2IRQ(port) + MXS_SET;
+	ct->regs.disable = PINCTRL_PIN2IRQ(port) + MXS_CLR;
+
+	ct = &gc->chip_types[1];
+	ct->type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 	ct->chip.irq_set_type = mxs_gpio_set_irq_type;
 	ct->chip.irq_set_wake = mxs_gpio_set_wake_irq;
+	ct->chip.flags = IRQCHIP_SET_TYPE_MASKED;
 	ct->regs.ack = PINCTRL_IRQSTAT(port) + MXS_CLR;
 	ct->regs.enable = PINCTRL_IRQEN(port) + MXS_SET;
 	ct->regs.disable = PINCTRL_IRQEN(port) + MXS_CLR;
+	ct->handler = handle_level_irq;
 
 	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_NESTED_LOCK,
 			       IRQ_NOREQUEST, 0);
@@ -298,11 +321,8 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 	}
 	port->base = base;
 
-	/*
-	 * select the pin interrupt functionality but initially
-	 * disable the interrupts
-	 */
-	writel(~0U, port->base + PINCTRL_PIN2IRQ(port));
+	/* initially disable the interrupts */
+	writel(0, port->base + PINCTRL_PIN2IRQ(port));
 	writel(0, port->base + PINCTRL_IRQEN(port));
 
 	/* clear address has to be used to clear IRQSTAT bits */
-- 
2.9.3
