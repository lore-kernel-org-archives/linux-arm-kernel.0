From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 22 Dec 2014 13:05:39 +0300
Subject: [PATCH 4/5] ARM: sa1100: move GPIO-related IRQ code to gpio driver
In-Reply-To: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
References: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1419242740-20219-4-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a part of driver consolidation, move GPIO-related IRQ code to
drivers/gpio/gpio-sa1100.c. The code does not use GPIOLIB_IRQCHIP (yet),
because sa1100 does not have a device for gpios, which is a requirement
for GPIOLIB_IRQCHIP. This will be the next step.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 174 ---------------------------------------
 drivers/gpio/gpio-sa1100.c | 197 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+), 174 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index a9dfe8e..a7d116a 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -80,138 +80,6 @@ static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
 
 static struct irq_domain *sa1100_normal_irqdomain;
 
-/*
- * SA1100 GPIO edge detection for IRQs:
- * IRQs are generated on Falling-Edge, Rising-Edge, or both.
- * Use this instead of directly setting GRER/GFER.
- */
-static int GPIO_IRQ_rising_edge;
-static int GPIO_IRQ_falling_edge;
-static int GPIO_IRQ_mask;
-
-static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
-{
-	unsigned int mask;
-
-	mask = BIT(d->hwirq);
-
-	if (type == IRQ_TYPE_PROBE) {
-		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
-			return 0;
-		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
-	}
-
-	if (type & IRQ_TYPE_EDGE_RISING) {
-		GPIO_IRQ_rising_edge |= mask;
-	} else
-		GPIO_IRQ_rising_edge &= ~mask;
-	if (type & IRQ_TYPE_EDGE_FALLING) {
-		GPIO_IRQ_falling_edge |= mask;
-	} else
-		GPIO_IRQ_falling_edge &= ~mask;
-
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-
-	return 0;
-}
-
-/*
- * GPIO IRQs must be acknowledged.
- */
-static void sa1100_gpio_ack(struct irq_data *d)
-{
-	GEDR = BIT(d->hwirq);
-}
-
-static void sa1100_gpio_mask(struct irq_data *d)
-{
-	unsigned int mask = BIT(d->hwirq);
-
-	GPIO_IRQ_mask &= ~mask;
-
-	GRER &= ~mask;
-	GFER &= ~mask;
-}
-
-static void sa1100_gpio_unmask(struct irq_data *d)
-{
-	unsigned int mask = BIT(d->hwirq);
-
-	GPIO_IRQ_mask |= mask;
-
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-}
-
-static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
-{
-	if (on)
-		PWER |= BIT(d->hwirq);
-	else
-		PWER &= ~BIT(d->hwirq);
-	return 0;
-}
-
-/*
- * This is for GPIO IRQs
- */
-static struct irq_chip sa1100_gpio_chip = {
-	.name		= "GPIO",
-	.irq_ack	= sa1100_gpio_ack,
-	.irq_mask	= sa1100_gpio_mask,
-	.irq_unmask	= sa1100_gpio_unmask,
-	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_gpio_wake,
-};
-
-static int sa1100_gpio_irqdomain_map(struct irq_domain *d,
-		unsigned int irq, irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &sa1100_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-
-	return 0;
-}
-
-static struct irq_domain_ops sa1100_gpio_irqdomain_ops = {
-	.map = sa1100_gpio_irqdomain_map,
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
-static struct irq_domain *sa1100_gpio_irqdomain;
-
-/*
- * IRQ 0-11 (GPIO) handler.  We enter here with the
- * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
- * and call the handler.
- */
-static void
-sa1100_gpio_handler(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned int mask;
-
-	mask = GEDR;
-	do {
-		/*
-		 * clear down all currently active IRQ sources.
-		 * We will be processing them all.
-		 */
-		GEDR = mask;
-
-		irq = IRQ_GPIO0;
-		do {
-			if (mask & 1)
-				generic_handle_irq(irq);
-			mask >>= 1;
-			irq++;
-		} while (mask);
-
-		mask = GEDR;
-	} while (mask);
-}
-
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
@@ -238,17 +106,6 @@ static int sa1100irq_suspend(void)
 		  IC_GPIO6|IC_GPIO5|IC_GPIO4|IC_GPIO3|IC_GPIO2|
 		  IC_GPIO1|IC_GPIO0);
 
-	/*
-	 * Set the appropriate edges for wakeup.
-	 */
-	GRER = PWER & GPIO_IRQ_rising_edge;
-	GFER = PWER & GPIO_IRQ_falling_edge;
-	
-	/*
-	 * Clear any pending GPIO interrupts.
-	 */
-	GEDR = GEDR;
-
 	return 0;
 }
 
@@ -260,9 +117,6 @@ static void sa1100irq_resume(void)
 		ICCR = st->iccr;
 		ICLR = st->iclr;
 
-		GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-		GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
-
 		ICMR = st->icmr;
 	}
 }
@@ -307,11 +161,6 @@ void __init sa1100_init_irq(void)
 	/* all IRQs are IRQ, not FIQ */
 	ICLR = 0;
 
-	/* clear all GPIO edge detects */
-	GFER = 0;
-	GRER = 0;
-	GEDR = -1;
-
 	/*
 	 * Whatever the doc says, this has to be set for the wait-on-irq
 	 * instruction to work... on a SA1100 rev 9 at least.
@@ -322,29 +171,6 @@ void __init sa1100_init_irq(void)
 			32, IRQ_GPIO0_SC,
 			&sa1100_normal_irqdomain_ops, NULL);
 
-	sa1100_gpio_irqdomain = irq_domain_add_simple(NULL,
-			28, IRQ_GPIO0,
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
-
 	set_handle_irq(sa1100_handle_irq);
 
 	sa1100_init_gpio();
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 5b5d3c7..bec397a 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/syscore_ops.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
@@ -64,7 +65,203 @@ static struct gpio_chip sa1100_gpio_chip = {
 	.ngpio			= GPIO_MAX + 1,
 };
 
+/*
+ * SA1100 GPIO edge detection for IRQs:
+ * IRQs are generated on Falling-Edge, Rising-Edge, or both.
+ * Use this instead of directly setting GRER/GFER.
+ */
+static int GPIO_IRQ_rising_edge;
+static int GPIO_IRQ_falling_edge;
+static int GPIO_IRQ_mask;
+
+static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int mask;
+
+	mask = BIT(d->hwirq);
+
+	if (type == IRQ_TYPE_PROBE) {
+		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
+			return 0;
+		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	}
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		GPIO_IRQ_rising_edge |= mask;
+	else
+		GPIO_IRQ_rising_edge &= ~mask;
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		GPIO_IRQ_falling_edge |= mask;
+	else
+		GPIO_IRQ_falling_edge &= ~mask;
+
+	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
+	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+
+	return 0;
+}
+
+/*
+ * GPIO IRQs must be acknowledged.
+ */
+static void sa1100_gpio_ack(struct irq_data *d)
+{
+	GEDR = BIT(d->hwirq);
+}
+
+static void sa1100_gpio_mask(struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq);
+
+	GPIO_IRQ_mask &= ~mask;
+
+	GRER &= ~mask;
+	GFER &= ~mask;
+}
+
+static void sa1100_gpio_unmask(struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq);
+
+	GPIO_IRQ_mask |= mask;
+
+	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
+	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+}
+
+static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
+{
+	if (on)
+		PWER |= BIT(d->hwirq);
+	else
+		PWER &= ~BIT(d->hwirq);
+	return 0;
+}
+
+/*
+ * This is for GPIO IRQs
+ */
+static struct irq_chip sa1100_gpio_irq_chip = {
+	.name		= "GPIO",
+	.irq_ack	= sa1100_gpio_ack,
+	.irq_mask	= sa1100_gpio_mask,
+	.irq_unmask	= sa1100_gpio_unmask,
+	.irq_set_type	= sa1100_gpio_type,
+	.irq_set_wake	= sa1100_gpio_wake,
+};
+
+static int sa1100_gpio_irqdomain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sa1100_gpio_irq_chip,
+				 handle_edge_irq);
+	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_gpio_irqdomain_ops = {
+	.map = sa1100_gpio_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irq_domain *sa1100_gpio_irqdomain;
+
+/*
+ * IRQ 0-11 (GPIO) handler.  We enter here with the
+ * irq_controller_lock held, and IRQs disabled.  Decode the IRQ
+ * and call the handler.
+ */
+static void
+sa1100_gpio_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned int mask;
+
+	mask = GEDR;
+	do {
+		/*
+		 * clear down all currently active IRQ sources.
+		 * We will be processing them all.
+		 */
+		GEDR = mask;
+
+		irq = IRQ_GPIO0;
+		do {
+			if (mask & 1)
+				generic_handle_irq(irq);
+			mask >>= 1;
+			irq++;
+		} while (mask);
+
+		mask = GEDR;
+	} while (mask);
+}
+
+static int sa1100_gpio_suspend(void)
+{
+	/*
+	 * Set the appropriate edges for wakeup.
+	 */
+	GRER = PWER & GPIO_IRQ_rising_edge;
+	GFER = PWER & GPIO_IRQ_falling_edge;
+
+	/*
+	 * Clear any pending GPIO interrupts.
+	 */
+	GEDR = GEDR;
+
+	return 0;
+}
+
+static void sa1100_gpio_resume(void)
+{
+	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
+	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+}
+
+static struct syscore_ops sa1100_gpio_syscore_ops = {
+	.suspend	= sa1100_gpio_suspend,
+	.resume		= sa1100_gpio_resume,
+};
+
+static int __init sa1100_gpio_init_devicefs(void)
+{
+	register_syscore_ops(&sa1100_gpio_syscore_ops);
+	return 0;
+}
+
+device_initcall(sa1100_gpio_init_devicefs);
+
 void __init sa1100_init_gpio(void)
 {
+	/* clear all GPIO edge detects */
+	GFER = 0;
+	GRER = 0;
+	GEDR = -1;
+
 	gpiochip_add(&sa1100_gpio_chip);
+
+	sa1100_gpio_irqdomain = irq_domain_add_simple(NULL,
+			28, IRQ_GPIO0,
+			&sa1100_gpio_irqdomain_ops, NULL);
+
+	/*
+	 * Install handlers for GPIO 0-10 edge detect interrupts
+	 */
+	irq_set_chained_handler(IRQ_GPIO0_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO1_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO2_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO3_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO4_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO5_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO6_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO7_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO8_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO9_SC, sa1100_gpio_handler);
+	irq_set_chained_handler(IRQ_GPIO10_SC, sa1100_gpio_handler);
+	/*
+	 * Install handler for GPIO 11-27 edge detect interrupts
+	 */
+	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_gpio_handler);
+
 }
-- 
2.1.3
