From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 15 Feb 2012 10:47:47 -0800
Subject: [PATCH v2 6/7] gpio/mxc: adopt irq_domain for gpio interrupt support
In-Reply-To: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
References: <1329331668-30325-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1329331668-30325-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adopts irq_domain for imx gpio interrupt support, and fixes the
translation between irq and gpio number for DT users.

As the results, macro MXC_GPIO_IRQ_START is referenced nowhere in
gpio-mxc driver, and the gpio irq_domain initilization in DT platform
code is removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |   14 ---------
 arch/arm/mach-mx5/imx51-dt.c   |   12 --------
 arch/arm/mach-mx5/imx53-dt.c   |   12 --------
 drivers/gpio/gpio-mxc.c        |   59 ++++++++++++++++-----------------------
 4 files changed, 24 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 6075d4d..8268471 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -14,7 +14,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
@@ -91,21 +90,8 @@ static void __init imx6q_map_io(void)
 	imx6q_clock_map_io();
 }
 
-static int __init imx6q_gpio_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
-
-	gpio_irq_base -= 32;
-	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops,
-			      NULL);
-
-	return 0;
-}
-
 static const struct of_device_id imx6q_irq_match[] __initconst = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ .compatible = "fsl,imx6q-gpio", .data = imx6q_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
index 636ef34..035a147 100644
--- a/arch/arm/mach-mx5/imx51-dt.c
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -56,20 +56,8 @@ static int __init imx51_tzic_init_cb(struct device_node *np,
 	return 0;
 }
 
-static int __init imx51_gpio_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
-
-	gpio_irq_base -= 32;
-	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops, NULL);
-
-	return 0;
-}
-
 static const struct of_device_id imx51_irq_match[] __initconst = {
 	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_init_cb, },
-	{ .compatible = "fsl,imx51-gpio", .data = imx51_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
index ce2b700..d59f4db 100644
--- a/arch/arm/mach-mx5/imx53-dt.c
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -60,20 +60,8 @@ static int __init imx53_tzic_init_cb(struct device_node *np,
 	return 0;
 }
 
-static int __init imx53_gpio_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS;
-
-	gpio_irq_base -= 32;
-	irq_domain_add_legacy(np, 32, gpio_irq_base, 0, &irq_domain_simple_ops, NULL);
-
-	return 0;
-}
-
 static const struct of_device_id imx53_irq_match[] __initconst = {
 	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_init_cb, },
-	{ .compatible = "fsl,imx53-gpio", .data = imx53_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index e791476..0b15787 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -23,6 +23,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -33,8 +34,6 @@
 #include <asm-generic/bug.h>
 #include <asm/mach/irq.h>
 
-#define irq_to_gpio(irq)	((irq) - MXC_GPIO_IRQ_START)
-
 enum mxc_gpio_hwtype {
 	IMX1_GPIO,	/* runs on i.mx1 */
 	IMX21_GPIO,	/* runs on i.mx21 and i.mx27 */
@@ -61,7 +60,7 @@ struct mxc_gpio_port {
 	void __iomem *base;
 	int irq;
 	int irq_high;
-	int virtual_irq_start;
+	struct irq_chip_generic *irq_gc;
 	struct bgpio_chip bgc;
 	u32 both_edges;
 };
@@ -144,14 +143,15 @@ static LIST_HEAD(mxc_gpio_ports);
 
 static int gpio_set_irq_type(struct irq_data *d, u32 type)
 {
-	u32 gpio = irq_to_gpio(d->irq);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxc_gpio_port *port = gc->private;
+	u32 gpio_idx = d->hwirq;
+	u32 gpio = port->bgc.gc.base + gpio_idx;
 	u32 bit, val;
 	int edge;
 	void __iomem *reg = port->base;
 
-	port->both_edges &= ~(1 << (gpio & 31));
+	port->both_edges &= ~(1 << gpio_idx);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		edge = GPIO_INT_RISE_EDGE;
@@ -168,7 +168,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 			edge = GPIO_INT_HIGH_LEV;
 			pr_debug("mxc: set GPIO %d to high trigger\n", gpio);
 		}
-		port->both_edges |= 1 << (gpio & 31);
+		port->both_edges |= 1 << gpio_idx;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		edge = GPIO_INT_LOW_LEV;
@@ -180,11 +180,11 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 		return -EINVAL;
 	}
 
-	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
-	bit = gpio & 0xf;
+	reg += GPIO_ICR1 + ((gpio_idx & 0x10) >> 2); /* ICR1 or ICR2 */
+	bit = gpio_idx & 0xf;
 	val = readl(reg) & ~(0x3 << (bit << 1));
 	writel(val | (edge << (bit << 1)), reg);
-	writel(1 << (gpio & 0x1f), port->base + GPIO_ISR);
+	writel(1 << gpio_idx, port->base + GPIO_ISR);
 
 	return 0;
 }
@@ -217,15 +217,14 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
 /* handle 32 interrupts in one status register */
 static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 {
-	u32 gpio_irq_no_base = port->virtual_irq_start;
-
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
 
 		if (port->both_edges & (1 << irqoffset))
 			mxc_flip_edge(port, irqoffset);
 
-		generic_handle_irq(gpio_irq_no_base + irqoffset);
+		generic_handle_irq(irq_find_mapping(port->irq_gc->domain,
+						    irqoffset));
 
 		irq_stat &= ~(1 << irqoffset);
 	}
@@ -276,10 +275,9 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
  */
 static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 {
-	u32 gpio = irq_to_gpio(d->irq);
-	u32 gpio_idx = gpio & 0x1F;
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxc_gpio_port *port = gc->private;
+	u32 gpio_idx = d->hwirq;
 
 	if (enable) {
 		if (port->irq_high && (gpio_idx >= 16))
@@ -296,16 +294,13 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 	return 0;
 }
 
-static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
+static void __devinit mxc_gpio_init_gc(struct irq_chip_generic *gc)
 {
-	struct irq_chip_generic *gc;
-	struct irq_chip_type *ct;
+	struct irq_chip_type *ct = gc->chip_types;
+	struct mxc_gpio_port *port = gc->private;
 
-	gc = irq_alloc_generic_chip("gpio-mxc", 1, port->virtual_irq_start,
-				    port->base, handle_level_irq);
-	gc->private = port;
+	port->irq_gc = gc;
 
-	ct = gc->chip_types;
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
@@ -313,9 +308,6 @@ static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
 	ct->chip.irq_set_wake = gpio_set_wake_irq;
 	ct->regs.ack = GPIO_ISR;
 	ct->regs.mask = GPIO_IMR;
-
-	irq_setup_generic_chip(gc, IRQ_MSK(32), IRQ_GC_INIT_NESTED_LOCK,
-			       IRQ_NOREQUEST, 0);
 }
 
 static void __devinit mxc_gpio_get_hw(struct platform_device *pdev)
@@ -352,15 +344,14 @@ static int mxc_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	struct mxc_gpio_port *port =
 		container_of(bgc, struct mxc_gpio_port, bgc);
 
-	return port->virtual_irq_start + offset;
+	return irq_create_mapping(port->irq_gc->domain, offset);
 }
 
 static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
 	struct resource *iores;
-	int err;
+	int err, irq_base;
 
 	mxc_gpio_get_hw(pdev);
 
@@ -430,15 +421,13 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 	if (err)
 		goto out_bgpio_remove;
 
-	/*
-	 * In dt case, we use gpio number range dynamically
-	 * allocated by gpio core.
-	 */
-	port->virtual_irq_start = MXC_GPIO_IRQ_START + (np ? port->bgc.gc.base :
-							     pdev->id * 32);
-
 	/* gpio-mxc can be a generic irq chip */
-	mxc_gpio_init_gc(port);
+	irq_base = pdev->dev.of_node ? -1 : irq_alloc_descs(-1, 0, 32, 0);
+	irq_setup_generic_chip_domain("gpio-mxc",
+				      of_node_get(pdev->dev.of_node),
+				      1, irq_base, port->base, handle_level_irq,
+				      32, IRQ_GC_INIT_NESTED_LOCK,
+				      IRQ_NOREQUEST, 0, mxc_gpio_init_gc, port);
 
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
-- 
1.7.5.4
