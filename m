From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Fri, 21 Jan 2011 12:02:19 +0100
Subject: [PATCH] ARM: msm: gpio-v2 irq_data conversion.
Message-ID: <20110121110219.GD23596@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert gpio-v2.c to the new irq_data methods.  This was overlooked
in the first pass as there is currently no defconfig in the tree that
builds this file.

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

diff --git a/arch/arm/mach-msm/gpio-v2.c b/arch/arm/mach-msm/gpio-v2.c
index 0de19ec..b2a0113 100644
--- a/arch/arm/mach-msm/gpio-v2.c
+++ b/arch/arm/mach-msm/gpio-v2.c
@@ -230,18 +230,18 @@ static void msm_gpio_update_dual_edge_pos(unsigned gpio)
 	       val, val2);
 }
 
-static void msm_gpio_irq_ack(unsigned int irq)
+static void msm_gpio_irq_ack(struct irq_data *d)
 {
-	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, irq);
+	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, d->irq);
 
 	writel(BIT(INTR_STATUS), GPIO_INTR_STATUS(gpio));
 	if (test_bit(gpio, msm_gpio.dual_edge_irqs))
 		msm_gpio_update_dual_edge_pos(gpio);
 }
 
-static void msm_gpio_irq_mask(unsigned int irq)
+static void msm_gpio_irq_mask(struct irq_data *d)
 {
-	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, irq);
+	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, d->irq);
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&tlmm_lock, irq_flags);
@@ -251,9 +251,9 @@ static void msm_gpio_irq_mask(unsigned int irq)
 	spin_unlock_irqrestore(&tlmm_lock, irq_flags);
 }
 
-static void msm_gpio_irq_unmask(unsigned int irq)
+static void msm_gpio_irq_unmask(struct irq_data *d)
 {
-	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, irq);
+	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, d->irq);
 	unsigned long irq_flags;
 
 	spin_lock_irqsave(&tlmm_lock, irq_flags);
@@ -263,9 +263,9 @@ static void msm_gpio_irq_unmask(unsigned int irq)
 	spin_unlock_irqrestore(&tlmm_lock, irq_flags);
 }
 
-static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
+static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int flow_type)
 {
-	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, irq);
+	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, d->irq);
 	unsigned long irq_flags;
 	uint32_t bits;
 
@@ -275,14 +275,14 @@ static int msm_gpio_irq_set_type(unsigned int irq, unsigned int flow_type)
 
 	if (flow_type & IRQ_TYPE_EDGE_BOTH) {
 		bits |= BIT(INTR_DECT_CTL);
-		irq_desc[irq].handle_irq = handle_edge_irq;
+		irq_desc[d->irq].handle_irq = handle_edge_irq;
 		if ((flow_type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
 			__set_bit(gpio, msm_gpio.dual_edge_irqs);
 		else
 			__clear_bit(gpio, msm_gpio.dual_edge_irqs);
 	} else {
 		bits &= ~BIT(INTR_DECT_CTL);
-		irq_desc[irq].handle_irq = handle_level_irq;
+		irq_desc[d->irq].handle_irq = handle_level_irq;
 		__clear_bit(gpio, msm_gpio.dual_edge_irqs);
 	}
 
@@ -321,9 +321,9 @@ static void msm_summary_irq_handler(unsigned int irq, struct irq_desc *desc)
 	desc->chip->ack(irq);
 }
 
-static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, irq);
+	int gpio = msm_irq_to_gpio(&msm_gpio.gpio_chip, d->irq);
 
 	if (on) {
 		if (bitmap_empty(msm_gpio.wake_irqs, NR_GPIO_IRQS))
@@ -340,11 +340,11 @@ static int msm_gpio_irq_set_wake(unsigned int irq, unsigned int on)
 
 static struct irq_chip msm_gpio_irq_chip = {
 	.name		= "msmgpio",
-	.mask		= msm_gpio_irq_mask,
-	.unmask		= msm_gpio_irq_unmask,
-	.ack		= msm_gpio_irq_ack,
-	.set_type	= msm_gpio_irq_set_type,
-	.set_wake	= msm_gpio_irq_set_wake,
+	.irq_mask	= msm_gpio_irq_mask,
+	.irq_unmask	= msm_gpio_irq_unmask,
+	.irq_ack	= msm_gpio_irq_ack,
+	.irq_set_type	= msm_gpio_irq_set_type,
+	.irq_set_wake	= msm_gpio_irq_set_wake,
 };
 
 static int __devinit msm_gpio_probe(struct platform_device *dev)
