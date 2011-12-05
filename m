From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Dec 2011 12:15:48 +0800
Subject: [PATCH 5/6] gpio/mxc: adopt irq_domain in gpio driver
In-Reply-To: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1323058550-13368-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adopts irq_domain for gpio interrupt controller in gpio-mxc driver,
and fixes the translation between irq and gpio number for DT users.

As the results, macro MXC_GPIO_IRQ_START is not referenced any more
by gpio-mxc driver, and the irq_domain initilization for gpio ports
in platform code is removed.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |   12 --------
 arch/arm/mach-mx5/imx51-dt.c   |   11 -------
 arch/arm/mach-mx5/imx53-dt.c   |   11 -------
 drivers/gpio/Kconfig           |    1 +
 drivers/gpio/gpio-mxc.c        |   57 +++++++++++++++++++++------------------
 5 files changed, 32 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 9cd860a..94f2a07 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -12,7 +12,6 @@
 
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -37,19 +36,8 @@ static void __init imx6q_map_io(void)
 	imx6q_clock_map_io();
 }
 
-static void __init imx6q_gpio_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
-				   32 * 7; /* imx6q gets 7 gpio ports */
-
-	irq_domain_add_simple(np, gpio_irq_base);
-	gpio_irq_base += 32;
-}
-
 static const struct of_device_id imx6q_irq_match[] __initconst = {
 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
-	{ .compatible = "fsl,imx6q-gpio", .data = imx6q_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
index ccc6158..9995777 100644
--- a/arch/arm/mach-mx5/imx51-dt.c
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -50,19 +50,8 @@ static void __init imx51_tzic_add_irq_domain(struct device_node *np,
 	irq_domain_add_simple(np, 0);
 }
 
-static void __init imx51_gpio_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
-				   32 * 4; /* imx51 gets 4 gpio ports */
-
-	irq_domain_add_simple(np, gpio_irq_base);
-	gpio_irq_base += 32;
-}
-
 static const struct of_device_id imx51_irq_match[] __initconst = {
 	{ .compatible = "fsl,imx51-tzic", .data = imx51_tzic_add_irq_domain, },
-	{ .compatible = "fsl,imx51-gpio", .data = imx51_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
index ccaa0b8..b662adf 100644
--- a/arch/arm/mach-mx5/imx53-dt.c
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -54,19 +54,8 @@ static void __init imx53_tzic_add_irq_domain(struct device_node *np,
 	irq_domain_add_simple(np, 0);
 }
 
-static void __init imx53_gpio_add_irq_domain(struct device_node *np,
-				struct device_node *interrupt_parent)
-{
-	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
-				   32 * 7; /* imx53 gets 7 gpio ports */
-
-	irq_domain_add_simple(np, gpio_irq_base);
-	gpio_irq_base += 32;
-}
-
 static const struct of_device_id imx53_irq_match[] __initconst = {
 	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_add_irq_domain, },
-	{ .compatible = "fsl,imx53-gpio", .data = imx53_gpio_add_irq_domain, },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8482a23..112ea93 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -128,6 +128,7 @@ config GPIO_MXC
 	depends on ARCH_MXC
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
 
 config GPIO_MXS
 	def_bool y
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index e791476..545733f 100644
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
@@ -61,8 +60,8 @@ struct mxc_gpio_port {
 	void __iomem *base;
 	int irq;
 	int irq_high;
-	int virtual_irq_start;
 	struct bgpio_chip bgc;
+	struct irq_domain domain;
 	u32 both_edges;
 };
 
@@ -144,14 +143,15 @@ static LIST_HEAD(mxc_gpio_ports);
 
 static int gpio_set_irq_type(struct irq_data *d, u32 type)
 {
-	u32 gpio = irq_to_gpio(d->irq);
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxc_gpio_port *port = gc->private;
+	u32 gpio_idx = d->irq - gc->irq_base;
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
@@ -217,15 +217,13 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
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
+		generic_handle_irq(irq_domain_to_irq(&port->domain, irqoffset));
 
 		irq_stat &= ~(1 << irqoffset);
 	}
@@ -276,10 +274,9 @@ static void mx2_gpio_irq_handler(u32 irq, struct irq_desc *desc)
  */
 static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 {
-	u32 gpio = irq_to_gpio(d->irq);
-	u32 gpio_idx = gpio & 0x1F;
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxc_gpio_port *port = gc->private;
+	u32 gpio_idx = d->irq - gc->irq_base;
 
 	if (enable) {
 		if (port->irq_high && (gpio_idx >= 16))
@@ -296,12 +293,28 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 	return 0;
 }
 
-static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
+static void __devinit mxc_gpio_init_gc(struct mxc_gpio_port *port,
+				       struct platform_device *pdev)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	int ret;
 
-	gc = irq_alloc_generic_chip("gpio-mxc", 1, port->virtual_irq_start,
+	ret = irq_alloc_descs(-1, 0, 32, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"%s: failed to allocate irq numbers, errno %d\n",
+			__func__, ret);
+		return;
+	}
+
+	port->domain.irq_base = ret;
+	port->domain.nr_irq = 32;
+	port->domain.of_node = pdev->dev.of_node;
+	port->domain.ops = &irq_domain_simple_ops;
+	irq_domain_add(&port->domain);
+
+	gc = irq_alloc_generic_chip("gpio-mxc", 1, port->domain.irq_base,
 				    port->base, handle_level_irq);
 	gc->private = port;
 
@@ -352,12 +365,11 @@ static int mxc_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	struct mxc_gpio_port *port =
 		container_of(bgc, struct mxc_gpio_port, bgc);
 
-	return port->virtual_irq_start + offset;
+	return irq_domain_to_irq(&port->domain, offset);
 }
 
 static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
 	struct resource *iores;
 	int err;
@@ -430,15 +442,8 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
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
+	mxc_gpio_init_gc(port, pdev);
 
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
-- 
1.7.4.1
