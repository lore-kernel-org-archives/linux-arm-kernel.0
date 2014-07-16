From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Wed, 16 Jul 2014 15:51:04 +0200
Subject: [[RFC PATCH]] gpio: gpio-mxc: make sure gpio is input when request IRQ
Message-ID: <1405518664-31313-1-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tq-group.com>

When requesting an GPIO irq for imx Soc two things are missing:
- there is no check, if the GPIO is already requested
- there is no check, if the GPIO is configured as input

The first case can lead to reconfiguring the GPIO pin from third
party while it is used as IRQ pin, second case will (eventually)
prevent IRQ from being seen by SOC becaus the pin is driven by
Soc

This patch tries to implement (logic taken roughly from gpio-omap)
- basic check if gpio already requested
- if needed requests the gpio and configures as IN.
- if gpio is already requested it is only verified if pin is IN
- gpio is locked as irq

Tested on a not mainlined i.MX6 based hardware with pin configured
by bootloader as OUT HIGH and expecting a low active IRQ.

Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
---
 drivers/gpio/gpio-mxc.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index db83b3c..4316a38 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -175,6 +175,31 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 	u32 gpio = port->bgc.gc.base + gpio_idx;
 	int edge;
 	void __iomem *reg = port->base;
+	int ret = 0;
+
+	if (!gpiochip_is_requested(&port->bgc.gc, gpio_idx)) {
+		char label[32];
+
+		snprintf(label, 32, "gpio%u-irq", gpio);
+		ret = gpio_request_one(gpio, GPIOF_DIR_IN, label);
+	} else {
+		val = readl(port->base + GPIO_GDIR);
+		if (val & BIT(gpio_idx))
+			ret = -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(port->bgc.gc.dev, "unable to set gpio_idx %u as IN\n",
+			gpio_idx);
+		return ret;
+	}
+
+	ret = gpio_lock_as_irq(&port->bgc.gc, gpio_idx);
+	if (ret) {
+		dev_err(port->bgc.gc.dev, "unable to lock gpio_idx %u for IRQ\n",
+			gpio_idx);
+		return ret;
+	}
 
 	port->both_edges &= ~(1 << gpio_idx);
 	switch (type) {
@@ -231,6 +256,15 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 	return 0;
 }
 
+static void gpio_irq_shutdown(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mxc_gpio_port *port = gc->private;
+	u32 gpio_idx = d->hwirq;
+
+	gpio_unlock_as_irq(&port->bgc.gc, gpio_idx);
+}
+
 static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
 {
 	void __iomem *reg = port->base;
@@ -353,6 +387,7 @@ static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port, int irq_base)
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 	ct->chip.irq_set_type = gpio_set_irq_type;
+	ct->chip.irq_shutdown = gpio_irq_shutdown;
 	ct->chip.irq_set_wake = gpio_set_wake_irq;
 	ct->regs.ack = GPIO_ISR;
 	ct->regs.mask = GPIO_IMR;
-- 
1.7.9.5
