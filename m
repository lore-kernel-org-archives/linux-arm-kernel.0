From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:54 +0100
Subject: [PATCH 09/54] ARM: at91: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132554.GJ15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-at91/gpio.c |   34 +++++++++++++++++-----------------
 arch/arm/mach-at91/irq.c  |   36 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index ae4772e..af818a2 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -274,10 +274,10 @@ EXPORT_SYMBOL(at91_get_gpio_value);
 static u32 wakeups[MAX_GPIO_BANKS];
 static u32 backups[MAX_GPIO_BANKS];
 
-static int gpio_irq_set_wake(unsigned pin, unsigned state)
+static int gpio_irq_set_wake(struct irq_data *d, unsigned state)
 {
-	unsigned	mask = pin_to_mask(pin);
-	unsigned	bank = (pin - PIN_BASE) / 32;
+	unsigned	mask = pin_to_mask(d->irq);
+	unsigned	bank = (d->irq - PIN_BASE) / 32;
 
 	if (unlikely(bank >= MAX_GPIO_BANKS))
 		return -EINVAL;
@@ -344,25 +344,25 @@ void at91_gpio_resume(void)
  * IRQ0..IRQ6 should be configurable, e.g. level vs edge triggering.
  */
 
-static void gpio_irq_mask(unsigned pin)
+static void gpio_irq_mask(struct irq_data *d)
 {
-	void __iomem	*pio = pin_to_controller(pin);
-	unsigned	mask = pin_to_mask(pin);
+	void __iomem	*pio = pin_to_controller(d->irq);
+	unsigned	mask = pin_to_mask(d->irq);
 
 	if (pio)
 		__raw_writel(mask, pio + PIO_IDR);
 }
 
-static void gpio_irq_unmask(unsigned pin)
+static void gpio_irq_unmask(struct irq_data *d)
 {
-	void __iomem	*pio = pin_to_controller(pin);
-	unsigned	mask = pin_to_mask(pin);
+	void __iomem	*pio = pin_to_controller(d->irq);
+	unsigned	mask = pin_to_mask(d->irq);
 
 	if (pio)
 		__raw_writel(mask, pio + PIO_IER);
 }
 
-static int gpio_irq_type(unsigned pin, unsigned type)
+static int gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	switch (type) {
 	case IRQ_TYPE_NONE:
@@ -375,10 +375,10 @@ static int gpio_irq_type(unsigned pin, unsigned type)
 
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
-	.mask		= gpio_irq_mask,
-	.unmask		= gpio_irq_unmask,
-	.set_type	= gpio_irq_type,
-	.set_wake	= gpio_irq_set_wake,
+	.irq_mask	= gpio_irq_mask,
+	.irq_unmask	= gpio_irq_unmask,
+	.irq_set_type	= gpio_irq_type,
+	.irq_set_wake	= gpio_irq_set_wake,
 };
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
@@ -393,7 +393,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	pio = at91_gpio->regbase;
 
 	/* temporarily mask (level sensitive) parent IRQ */
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 	for (;;) {
 		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
 		 * When there none are pending, we're finished unless we need
@@ -419,7 +419,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 					 * another IRQ must be generated before it actually gets
 					 * here to be disabled on the GPIO controller.
 					 */
-					gpio_irq_mask(pin);
+					gpio_irq_mask(irq_get_irq_data(pin));
 				}
 				else
 					generic_handle_irq(pin);
@@ -429,7 +429,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			isr >>= 1;
 		}
 	}
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 	/* now it may re-trigger */
 }
 
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index da3494a..b56d6b3 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -34,23 +34,23 @@
 #include <asm/mach/map.h>
 
 
-static void at91_aic_mask_irq(unsigned int irq)
+static void at91_aic_mask_irq(struct irq_data *d)
 {
 	/* Disable interrupt on AIC */
-	at91_sys_write(AT91_AIC_IDCR, 1 << irq);
+	at91_sys_write(AT91_AIC_IDCR, 1 << d->irq);
 }
 
-static void at91_aic_unmask_irq(unsigned int irq)
+static void at91_aic_unmask_irq(struct irq_data *d)
 {
 	/* Enable interrupt on AIC */
-	at91_sys_write(AT91_AIC_IECR, 1 << irq);
+	at91_sys_write(AT91_AIC_IECR, 1 << d->irq);
 }
 
 unsigned int at91_extern_irq;
 
 #define is_extern_irq(irq) ((1 << (irq)) & at91_extern_irq)
 
-static int at91_aic_set_type(unsigned irq, unsigned type)
+static int at91_aic_set_type(struct irq_data *d, unsigned type)
 {
 	unsigned int smr, srctype;
 
@@ -62,13 +62,13 @@ static int at91_aic_set_type(unsigned irq, unsigned type)
 		srctype = AT91_AIC_SRCTYPE_RISING;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		if ((irq == AT91_ID_FIQ) || is_extern_irq(irq))		/* only supported on external interrupts */
+		if ((d->irq == AT91_ID_FIQ) || is_extern_irq(d->irq))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_LOW;
 		else
 			return -EINVAL;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		if ((irq == AT91_ID_FIQ) || is_extern_irq(irq))		/* only supported on external interrupts */
+		if ((d->irq == AT91_ID_FIQ) || is_extern_irq(d->irq))		/* only supported on external interrupts */
 			srctype = AT91_AIC_SRCTYPE_FALLING;
 		else
 			return -EINVAL;
@@ -77,8 +77,8 @@ static int at91_aic_set_type(unsigned irq, unsigned type)
 		return -EINVAL;
 	}
 
-	smr = at91_sys_read(AT91_AIC_SMR(irq)) & ~AT91_AIC_SRCTYPE;
-	at91_sys_write(AT91_AIC_SMR(irq), smr | srctype);
+	smr = at91_sys_read(AT91_AIC_SMR(d->irq)) & ~AT91_AIC_SRCTYPE;
+	at91_sys_write(AT91_AIC_SMR(d->irq), smr | srctype);
 	return 0;
 }
 
@@ -87,15 +87,15 @@ static int at91_aic_set_type(unsigned irq, unsigned type)
 static u32 wakeups;
 static u32 backups;
 
-static int at91_aic_set_wake(unsigned irq, unsigned value)
+static int at91_aic_set_wake(struct irq_data *d, unsigned value)
 {
-	if (unlikely(irq >= 32))
+	if (unlikely(d->irq >= 32))
 		return -EINVAL;
 
 	if (value)
-		wakeups |= (1 << irq);
+		wakeups |= (1 << d->irq);
 	else
-		wakeups &= ~(1 << irq);
+		wakeups &= ~(1 << d->irq);
 
 	return 0;
 }
@@ -119,11 +119,11 @@ void at91_irq_resume(void)
 
 static struct irq_chip at91_aic_chip = {
 	.name		= "AIC",
-	.ack		= at91_aic_mask_irq,
-	.mask		= at91_aic_mask_irq,
-	.unmask		= at91_aic_unmask_irq,
-	.set_type	= at91_aic_set_type,
-	.set_wake	= at91_aic_set_wake,
+	.irq_ack	= at91_aic_mask_irq,
+	.irq_mask	= at91_aic_mask_irq,
+	.irq_unmask	= at91_aic_unmask_irq,
+	.irq_set_type	= at91_aic_set_type,
+	.irq_set_wake	= at91_aic_set_wake,
 };
 
 /*
-- 
1.7.1
