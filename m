From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Tue, 29 Jan 2013 09:16:33 +0100
Subject: [PATCH v2] ARM: mxs: gpio-mxs: Add IRQ_TYPE_EDGE_BOTH support
Message-ID: <1359447393-2570-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for IRQ_TYPE_EDGE_BOTH needed for some driver
(gpio-keys).
Inspired from gpio-mxc.c

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 Changes since v1 (as advised by Shawn Guo):
 * fix some typos
 * use GPIO_INT_xxx_EDGE instead of GPIO_INT_xxx_LEV
 * suppress useless variables

 drivers/gpio/gpio-mxs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index fa2a63c..859b6fa 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -65,6 +65,7 @@ struct mxs_gpio_port {
 	struct irq_domain *domain;
 	struct bgpio_chip bgc;
 	enum mxs_gpio_id devid;
+	u32 both_edges;
 };
 
 static inline int is_imx23_gpio(struct mxs_gpio_port *port)
@@ -81,13 +82,23 @@ static inline int is_imx28_gpio(struct mxs_gpio_port *port)
 
 static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 {
+	u32 val;
 	u32 pin_mask = 1 << d->hwirq;
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxs_gpio_port *port = gc->private;
 	void __iomem *pin_addr;
 	int edge;
 
+	port->both_edges &= ~pin_mask;
 	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+		val = gpio_get_value(port->bgc.gc.base + d->hwirq);
+		if (val)
+			edge = GPIO_INT_FALL_EDGE;
+		else
+			edge = GPIO_INT_RISE_EDGE;
+		port->both_edges |= pin_mask;
+		break;
 	case IRQ_TYPE_EDGE_RISING:
 		edge = GPIO_INT_RISE_EDGE;
 		break;
@@ -124,6 +135,23 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static void mxs_flip_edge(struct mxs_gpio_port *port, u32 gpio)
+{
+	u32 bit, val, edge;
+	void __iomem *pin_addr;
+
+	bit = 1 << gpio;
+
+	pin_addr = port->base + PINCTRL_IRQPOL(port);
+	val = readl(pin_addr);
+	edge = val & bit;
+
+	if (edge)
+		writel(bit, pin_addr + MXS_CLR);
+	else
+		writel(bit, pin_addr + MXS_SET);
+}
+
 /* MXS has one interrupt *per* gpio port */
 static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 {
@@ -137,6 +165,9 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
 
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
+		if (port->both_edges & (1 << irqoffset))
+			mxs_flip_edge(port, irqoffset);
+
 		generic_handle_irq(irq_find_mapping(port->domain, irqoffset));
 		irq_stat &= ~(1 << irqoffset);
 	}
-- 
1.7.12.4
