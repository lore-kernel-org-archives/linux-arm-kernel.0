From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  7 Jun 2011 16:25:37 +0800
Subject: [PATCH] gpio/mxc: convert gpio-mxc to use generic irq chip
Message-ID: <1307435137-31439-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts gpio-mxc driver to use generic irq chip.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/Kconfig    |    1 +
 drivers/gpio/gpio-mxc.c |   90 +++++++++++++++--------------------------------
 2 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d973abd..ee8802f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -97,6 +97,7 @@ config GPIO_MXC
 	def_bool y
 	depends on ARCH_MXC
 	select GPIO_BASIC_MMIO_CORE
+	select GENERIC_IRQ_CHIP
 
 config GPIO_PLAT_SAMSUNG
 	bool "Samsung SoCs GPIO library support"
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index b351952893..950e53a 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -65,46 +65,11 @@ static LIST_HEAD(mxc_gpio_ports);
 
 /* Note: This driver assumes 32 GPIOs are handled in one register */
 
-static void _clear_gpio_irqstatus(struct mxc_gpio_port *port, u32 index)
-{
-	writel(1 << index, port->base + GPIO_ISR);
-}
-
-static void _set_gpio_irqenable(struct mxc_gpio_port *port, u32 index,
-				int enable)
-{
-	u32 l;
-
-	l = readl(port->base + GPIO_IMR);
-	l = (l & (~(1 << index))) | (!!enable << index);
-	writel(l, port->base + GPIO_IMR);
-}
-
-static void gpio_ack_irq(struct irq_data *d)
-{
-	struct mxc_gpio_port *port = irq_data_get_irq_chip_data(d);
-	u32 gpio = irq_to_gpio(d->irq);
-	_clear_gpio_irqstatus(port, gpio & 0x1f);
-}
-
-static void gpio_mask_irq(struct irq_data *d)
-{
-	struct mxc_gpio_port *port = irq_data_get_irq_chip_data(d);
-	u32 gpio = irq_to_gpio(d->irq);
-	_set_gpio_irqenable(port, gpio & 0x1f, 0);
-}
-
-static void gpio_unmask_irq(struct irq_data *d)
-{
-	struct mxc_gpio_port *port = irq_data_get_irq_chip_data(d);
-	u32 gpio = irq_to_gpio(d->irq);
-	_set_gpio_irqenable(port, gpio & 0x1f, 1);
-}
-
 static int gpio_set_irq_type(struct irq_data *d, u32 type)
 {
 	u32 gpio = irq_to_gpio(d->irq);
-	struct mxc_gpio_port *port = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mxc_gpio_port *port = gc->private;
 	u32 bit, val;
 	int edge;
 	void __iomem *reg = port->base;
@@ -142,7 +107,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 	bit = gpio & 0xf;
 	val = readl(reg) & ~(0x3 << (bit << 1));
 	writel(val | (edge << (bit << 1)), reg);
-	_clear_gpio_irqstatus(port, gpio & 0x1f);
+	writel(1 << (gpio & 0x1f), port->base + GPIO_ISR);
 
 	return 0;
 }
@@ -231,7 +196,8 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 {
 	u32 gpio = irq_to_gpio(d->irq);
 	u32 gpio_idx = gpio & 0x1F;
-	struct mxc_gpio_port *port = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mxc_gpio_port *port = gc->private;
 
 	if (enable) {
 		if (port->irq_high && (gpio_idx >= 16))
@@ -248,26 +214,33 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 	return 0;
 }
 
-static struct irq_chip gpio_irq_chip = {
-	.name = "GPIO",
-	.irq_ack = gpio_ack_irq,
-	.irq_mask = gpio_mask_irq,
-	.irq_unmask = gpio_unmask_irq,
-	.irq_set_type = gpio_set_irq_type,
-	.irq_set_wake = gpio_set_wake_irq,
-};
-
-/*
- * This lock class tells lockdep that GPIO irqs are in a different
- * category than their parents, so it won't report false recursion.
- */
-static struct lock_class_key gpio_lock_class;
+static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("gpio-mxc", 1, port->virtual_irq_start,
+				    port->base, handle_level_irq);
+	gc->private = port;
+
+	ct = gc->chip_types;
+	ct->chip.irq_ack = irq_gc_ack,
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->chip.irq_set_type = gpio_set_irq_type;
+	ct->chip.irq_set_wake = gpio_set_wake_irq,
+	ct->regs.ack = GPIO_ISR;
+	ct->regs.mask = GPIO_IMR;
+
+	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_NESTED_LOCK,
+			       IRQ_NOREQUEST, 0);
+}
 
 static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct mxc_gpio_port *port;
 	struct resource *iores;
-	int err, i;
+	int err;
 
 	port = kzalloc(sizeof(struct mxc_gpio_port), GFP_KERNEL);
 	if (!port)
@@ -304,13 +277,8 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 	writel(0, port->base + GPIO_IMR);
 	writel(~0, port->base + GPIO_ISR);
 
-	for (i = port->virtual_irq_start;
-		i < port->virtual_irq_start + 32; i++) {
-		irq_set_lockdep_class(i, &gpio_lock_class);
-		irq_set_chip_and_handler(i, &gpio_irq_chip, handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-		irq_set_chip_data(i, port);
-	}
+	/* gpio-mxc can be a generic irq chip */
+	mxc_gpio_init_gc(port);
 
 	if (cpu_is_mx2()) {
 		/* setup one handler for all GPIO interrupts */
-- 
1.7.4.1
