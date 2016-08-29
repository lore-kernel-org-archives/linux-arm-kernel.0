From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:20 +0100
Subject: [PATCH 03/33] gpio: sa1100: convert to use IO accessors
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJjo-0000ly-NT@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/gpio/gpio-sa1100.c | 199 ++++++++++++++++++++++++++++-----------------
 1 file changed, 124 insertions(+), 75 deletions(-)

diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index fb9d52a57d78..bad0169524c9 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -16,54 +16,85 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
+struct sa1100_gpio_chip {
+	struct gpio_chip chip;
+	void __iomem *membase;
+	int irqbase;
+	u32 irqmask;
+	u32 irqrising;
+	u32 irqfalling;
+	u32 irqwake;
+};
+
+#define sa1100_gpio_chip(x) container_of(x, struct sa1100_gpio_chip, chip)
+
+enum {
+	R_GPLR = 0x00,
+	R_GPDR = 0x04,
+	R_GPSR = 0x08,
+	R_GPCR = 0x0c,
+	R_GRER = 0x10,
+	R_GFER = 0x14,
+	R_GEDR = 0x18,
+	R_GAFR = 0x1c,
+};
+
 static int sa1100_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return !!(GPLR & GPIO_GPIO(offset));
+	return readl_relaxed(sa1100_gpio_chip(chip)->membase + R_GPLR) &
+		BIT(offset);
 }
 
 static void sa1100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	if (value)
-		GPSR = GPIO_GPIO(offset);
-	else
-		GPCR = GPIO_GPIO(offset);
+	int reg = value ? R_GPSR : R_GPCR;
+
+	writel_relaxed(BIT(offset), sa1100_gpio_chip(chip)->membase + reg);
 }
 
 static int sa1100_direction_input(struct gpio_chip *chip, unsigned offset)
 {
+	void __iomem *gpdr = sa1100_gpio_chip(chip)->membase + R_GPDR;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	GPDR &= ~GPIO_GPIO(offset);
+	writel_relaxed(readl_relaxed(gpdr) & ~BIT(offset), gpdr);
 	local_irq_restore(flags);
+
 	return 0;
 }
 
 static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int value)
 {
+	void __iomem *gpdr = sa1100_gpio_chip(chip)->membase + R_GPDR;
 	unsigned long flags;
 
 	local_irq_save(flags);
 	sa1100_gpio_set(chip, offset, value);
-	GPDR |= GPIO_GPIO(offset);
+	writel_relaxed(readl_relaxed(gpdr) | BIT(offset), gpdr);
 	local_irq_restore(flags);
+
 	return 0;
 }
 
 static int sa1100_to_irq(struct gpio_chip *chip, unsigned offset)
 {
-	return IRQ_GPIO0 + offset;
+	return sa1100_gpio_chip(chip)->irqbase + offset;
 }
 
-static struct gpio_chip sa1100_gpio_chip = {
-	.label			= "gpio",
-	.direction_input	= sa1100_direction_input,
-	.direction_output	= sa1100_direction_output,
-	.set			= sa1100_gpio_set,
-	.get			= sa1100_gpio_get,
-	.to_irq			= sa1100_to_irq,
-	.base			= 0,
-	.ngpio			= GPIO_MAX + 1,
+static struct sa1100_gpio_chip sa1100_gpio_chip = {
+	.chip = {
+		.label			= "gpio",
+		.direction_input	= sa1100_direction_input,
+		.direction_output	= sa1100_direction_output,
+		.set			= sa1100_gpio_set,
+		.get			= sa1100_gpio_get,
+		.to_irq			= sa1100_to_irq,
+		.base			= 0,
+		.ngpio			= GPIO_MAX + 1,
+	},
+	.membase = (void *)&GPLR,
+	.irqbase = IRQ_GPIO0,
 };
 
 /*
@@ -71,34 +102,39 @@ static struct gpio_chip sa1100_gpio_chip = {
  * IRQs are generated on Falling-Edge, Rising-Edge, or both.
  * Use this instead of directly setting GRER/GFER.
  */
-static int GPIO_IRQ_rising_edge;
-static int GPIO_IRQ_falling_edge;
-static int GPIO_IRQ_mask;
-static int GPIO_IRQ_wake;
+static void sa1100_update_edge_regs(struct sa1100_gpio_chip *sgc)
+{
+	void *base = sgc->membase;
+	u32 grer, gfer;
+
+	grer = sgc->irqrising & sgc->irqmask;
+	gfer = sgc->irqfalling & sgc->irqmask;
+
+	writel_relaxed(grer, base + R_GRER);
+	writel_relaxed(gfer, base + R_GFER);
+}
 
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int mask;
-
-	mask = BIT(d->hwirq);
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
+	unsigned int mask = BIT(d->hwirq);
 
 	if (type == IRQ_TYPE_PROBE) {
-		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
+		if ((sgc->irqrising | sgc->irqfalling) & mask)
 			return 0;
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	}
 
 	if (type & IRQ_TYPE_EDGE_RISING)
-		GPIO_IRQ_rising_edge |= mask;
+		sgc->irqrising |= mask;
 	else
-		GPIO_IRQ_rising_edge &= ~mask;
+		sgc->irqrising &= ~mask;
 	if (type & IRQ_TYPE_EDGE_FALLING)
-		GPIO_IRQ_falling_edge |= mask;
+		sgc->irqfalling |= mask;
 	else
-		GPIO_IRQ_falling_edge &= ~mask;
+		sgc->irqfalling &= ~mask;
 
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	sa1100_update_edge_regs(sgc);
 
 	return 0;
 }
@@ -108,37 +144,40 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
  */
 static void sa1100_gpio_ack(struct irq_data *d)
 {
-	GEDR = BIT(d->hwirq);
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
+
+	writel_relaxed(BIT(d->hwirq), sgc->membase + R_GEDR);
 }
 
 static void sa1100_gpio_mask(struct irq_data *d)
 {
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
 	unsigned int mask = BIT(d->hwirq);
 
-	GPIO_IRQ_mask &= ~mask;
+	sgc->irqmask &= ~mask;
 
-	GRER &= ~mask;
-	GFER &= ~mask;
+	sa1100_update_edge_regs(sgc);
 }
 
 static void sa1100_gpio_unmask(struct irq_data *d)
 {
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
 	unsigned int mask = BIT(d->hwirq);
 
-	GPIO_IRQ_mask |= mask;
+	sgc->irqmask |= mask;
 
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	sa1100_update_edge_regs(sgc);
 }
 
 static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
 {
+	struct sa1100_gpio_chip *sgc = irq_data_get_irq_chip_data(d);
 	int ret = sa11x0_gpio_set_wake(d->hwirq, on);
 	if (!ret) {
 		if (on)
-			GPIO_IRQ_wake |= BIT(d->hwirq);
+			sgc->irqwake |= BIT(d->hwirq);
 		else
-			GPIO_IRQ_wake &= ~BIT(d->hwirq);
+			sgc->irqwake &= ~BIT(d->hwirq);
 	}
 	return ret;
 }
@@ -158,8 +197,10 @@ static struct irq_chip sa1100_gpio_irq_chip = {
 static int sa1100_gpio_irqdomain_map(struct irq_domain *d,
 		unsigned int irq, irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &sa1100_gpio_irq_chip,
-				 handle_edge_irq);
+	struct sa1100_gpio_chip *sgc = d->host_data;
+
+	irq_set_chip_data(irq, sgc);
+	irq_set_chip_and_handler(irq, &sa1100_gpio_irq_chip, handle_edge_irq);
 	irq_set_probe(irq);
 
 	return 0;
@@ -179,17 +220,19 @@ static struct irq_domain *sa1100_gpio_irqdomain;
  */
 static void sa1100_gpio_handler(struct irq_desc *desc)
 {
+	struct sa1100_gpio_chip *sgc = irq_desc_get_handler_data(desc);
 	unsigned int irq, mask;
+	void __iomem *gedr = sgc->membase + R_GEDR;
 
-	mask = GEDR;
+	mask = readl_relaxed(gedr);
 	do {
 		/*
 		 * clear down all currently active IRQ sources.
 		 * We will be processing them all.
 		 */
-		GEDR = mask;
+		writel_relaxed(mask, gedr);
 
-		irq = IRQ_GPIO0;
+		irq = sgc->irqbase;
 		do {
 			if (mask & 1)
 				generic_handle_irq(irq);
@@ -197,30 +240,32 @@ static void sa1100_gpio_handler(struct irq_desc *desc)
 			irq++;
 		} while (mask);
 
-		mask = GEDR;
+		mask = readl_relaxed(gedr);
 	} while (mask);
 }
 
 static int sa1100_gpio_suspend(void)
 {
+	struct sa1100_gpio_chip *sgc = &sa1100_gpio_chip;
+
 	/*
 	 * Set the appropriate edges for wakeup.
 	 */
-	GRER = GPIO_IRQ_wake & GPIO_IRQ_rising_edge;
-	GFER = GPIO_IRQ_wake & GPIO_IRQ_falling_edge;
+	writel_relaxed(sgc->irqwake & sgc->irqrising, sgc->membase + R_GRER);
+	writel_relaxed(sgc->irqwake & sgc->irqfalling, sgc->membase + R_GFER);
 
 	/*
 	 * Clear any pending GPIO interrupts.
 	 */
-	GEDR = GEDR;
+	writel_relaxed(readl_relaxed(sgc->membase + R_GEDR),
+		       sgc->membase + R_GEDR);
 
 	return 0;
 }
 
 static void sa1100_gpio_resume(void)
 {
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	sa1100_update_edge_regs(&sa1100_gpio_chip);
 }
 
 static struct syscore_ops sa1100_gpio_syscore_ops = {
@@ -236,36 +281,40 @@ static int __init sa1100_gpio_init_devicefs(void)
 
 device_initcall(sa1100_gpio_init_devicefs);
 
+static const int sa1100_gpio_irqs[] __initconst = {
+	/* Install handlers for GPIO 0-10 edge detect interrupts */
+	IRQ_GPIO0_SC,
+	IRQ_GPIO1_SC,
+	IRQ_GPIO2_SC,
+	IRQ_GPIO3_SC,
+	IRQ_GPIO4_SC,
+	IRQ_GPIO5_SC,
+	IRQ_GPIO6_SC,
+	IRQ_GPIO7_SC,
+	IRQ_GPIO8_SC,
+	IRQ_GPIO9_SC,
+	IRQ_GPIO10_SC,
+	/* Install handler for GPIO 11-27 edge detect interrupts */
+	IRQ_GPIO11_27,
+};
+
 void __init sa1100_init_gpio(void)
 {
+	struct sa1100_gpio_chip *sgc = &sa1100_gpio_chip;
+	int i;
+
 	/* clear all GPIO edge detects */
-	GFER = 0;
-	GRER = 0;
-	GEDR = -1;
+	writel_relaxed(0, sgc->membase + R_GFER);
+	writel_relaxed(0, sgc->membase + R_GRER);
+	writel_relaxed(-1, sgc->membase + R_GEDR);
 
-	gpiochip_add_data(&sa1100_gpio_chip, NULL);
+	gpiochip_add_data(&sa1100_gpio_chip.chip, NULL);
 
 	sa1100_gpio_irqdomain = irq_domain_add_simple(NULL,
 			28, IRQ_GPIO0,
-			&sa1100_gpio_irqdomain_ops, NULL);
-
-	/*
-	 * Install handlers for GPIO 0-10 edge detect interrupts
-	 */
-	irq_set_chained_handler(IRQ_GPIO0_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO1_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO2_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO3_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO4_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO5_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO6_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO7_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO8_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO9_SC, sa1100_gpio_handler);
-	irq_set_chained_handler(IRQ_GPIO10_SC, sa1100_gpio_handler);
-	/*
-	 * Install handler for GPIO 11-27 edge detect interrupts
-	 */
-	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_gpio_handler);
+			&sa1100_gpio_irqdomain_ops, sgc);
 
+	for (i = 0; i < ARRAY_SIZE(sa1100_gpio_irqs); i++)
+		irq_set_chained_handler_and_data(sa1100_gpio_irqs[i],
+						 sa1100_gpio_handler, sgc);
 }
-- 
2.1.0
