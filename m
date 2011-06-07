From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  7 Jun 2011 22:00:54 +0800
Subject: [PATCH 2/2] gpio/mxs: convert gpio-mxs to use generic irq chip
In-Reply-To: <1307455254-7604-1-git-send-email-shawn.guo@linaro.org>
References: <1307455254-7604-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1307455254-7604-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts gpio-mxs driver to use generic irq chip.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/Kconfig    |    1 +
 drivers/gpio/gpio-mxs.c |   95 +++++++++++++++++------------------------------
 2 files changed, 35 insertions(+), 61 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0b858e5..59003bf 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -96,6 +96,7 @@ config GPIO_EXYNOS4
 config GPIO_MXS
 	def_bool y
 	depends on ARCH_MXS
+	select GENERIC_IRQ_CHIP
 	select GPIO_BASIC_MMIO_CORE
 
 config GPIO_PLAT_SAMSUNG
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index ddde0f4..d8cafba 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -59,51 +59,12 @@ struct mxs_gpio_port {
 
 /* Note: This driver assumes 32 GPIOs are handled in one register */
 
-static void clear_gpio_irqstatus(struct mxs_gpio_port *port, u32 index)
-{
-	writel(1 << index, port->base + PINCTRL_IRQSTAT(port->id) + MXS_CLR);
-}
-
-static void set_gpio_irqenable(struct mxs_gpio_port *port, u32 index,
-				int enable)
-{
-	if (enable) {
-		writel(1 << index,
-			port->base + PINCTRL_IRQEN(port->id) + MXS_SET);
-		writel(1 << index,
-			port->base + PINCTRL_PIN2IRQ(port->id) + MXS_SET);
-	} else {
-		writel(1 << index,
-			port->base + PINCTRL_IRQEN(port->id) + MXS_CLR);
-	}
-}
-
-static void mxs_gpio_ack_irq(struct irq_data *d)
-{
-	struct mxs_gpio_port *port = irq_data_get_irq_chip_data(d);
-	u32 gpio = irq_to_gpio(d->irq);
-	clear_gpio_irqstatus(port, gpio & 0x1f);
-}
-
-static void mxs_gpio_mask_irq(struct irq_data *d)
-{
-	struct mxs_gpio_port *port = irq_data_get_irq_chip_data(d);
-	u32 gpio = irq_to_gpio(d->irq);
-	set_gpio_irqenable(port, gpio & 0x1f, 0);
-}
-
-static void mxs_gpio_unmask_irq(struct irq_data *d)
-{
-	struct mxs_gpio_port *port = irq_data_get_irq_chip_data(d);
-	u32 gpio = irq_to_gpio(d->irq);
-	set_gpio_irqenable(port, gpio & 0x1f, 1);
-}
-
 static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	u32 gpio = irq_to_gpio(d->irq);
 	u32 pin_mask = 1 << (gpio & 31);
-	struct mxs_gpio_port *port = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mxs_gpio_port *port = gc->private;
 	void __iomem *pin_addr;
 	int edge;
 
@@ -138,7 +99,8 @@ static int mxs_gpio_set_irq_type(struct irq_data *d, unsigned int type)
 	else
 		writel(pin_mask, pin_addr + MXS_CLR);
 
-	clear_gpio_irqstatus(port, gpio & 0x1f);
+	writel(1 << (gpio & 0x1f),
+	       port->base + PINCTRL_IRQSTAT(port->id) + MXS_CLR);
 
 	return 0;
 }
@@ -173,7 +135,8 @@ static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
  */
 static int mxs_gpio_set_wake_irq(struct irq_data *d, unsigned int enable)
 {
-	struct mxs_gpio_port *port = irq_data_get_irq_chip_data(d);
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct mxs_gpio_port *port = gc->private;
 
 	if (enable)
 		enable_irq_wake(port->irq);
@@ -183,14 +146,26 @@ static int mxs_gpio_set_wake_irq(struct irq_data *d, unsigned int enable)
 	return 0;
 }
 
-static struct irq_chip gpio_irq_chip = {
-	.name = "mxs gpio",
-	.irq_ack = mxs_gpio_ack_irq,
-	.irq_mask = mxs_gpio_mask_irq,
-	.irq_unmask = mxs_gpio_unmask_irq,
-	.irq_set_type = mxs_gpio_set_irq_type,
-	.irq_set_wake = mxs_gpio_set_wake_irq,
-};
+static void __init mxs_gpio_init_gc(struct mxs_gpio_port *port)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	gc = irq_alloc_generic_chip("gpio-mxs", 1, port->virtual_irq_start,
+				    port->base, handle_level_irq);
+	gc->private = port;
+
+	ct = gc->chip_types;
+	ct->chip.irq_ack = irq_gc_ack,
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->chip.irq_set_type = mxs_gpio_set_irq_type;
+	ct->chip.irq_set_wake = mxs_gpio_set_wake_irq,
+	ct->regs.ack = PINCTRL_IRQSTAT(port->id) + MXS_CLR;
+	ct->regs.mask = PINCTRL_IRQEN(port->id);
+
+	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
+}
 
 static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
@@ -206,7 +181,7 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 	static void __iomem *base;
 	struct mxs_gpio_port *port;
 	struct resource *iores = NULL;
-	int err, i;
+	int err;
 
 	port = kzalloc(sizeof(struct mxs_gpio_port), GFP_KERNEL);
 	if (!port)
@@ -246,20 +221,18 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	/* disable the interrupt and clear the status */
-	writel(0, port->base + PINCTRL_PIN2IRQ(port->id));
+	/*
+	 * select the pin interrupt functionality but initially
+	 * disable the interrupts
+	 */
+	writel(~0U, port->base + PINCTRL_PIN2IRQ(port->id));
 	writel(0, port->base + PINCTRL_IRQEN(port->id));
 
 	/* clear address has to be used to clear IRQSTAT bits */
 	writel(~0U, port->base + PINCTRL_IRQSTAT(port->id) + MXS_CLR);
 
-	for (i = port->virtual_irq_start;
-		i < port->virtual_irq_start + 32; i++) {
-		irq_set_chip_and_handler(i, &gpio_irq_chip,
-					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-		irq_set_chip_data(i, port);
-	}
+	/* gpio-mxs can be a generic irq chip */
+	mxs_gpio_init_gc(port);
 
 	/* setup one handler for each entry */
 	irq_set_chained_handler(port->irq, mxs_gpio_irq_handler);
-- 
1.7.4.1
