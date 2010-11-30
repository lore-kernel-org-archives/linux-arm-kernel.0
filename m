From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:24 +0100
Subject: [PATCH 52/54] ARM: plat-orion: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134124.GA15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-orion/gpio.c |   37 ++++++++++++++++++-------------------
 arch/arm/plat-orion/irq.c  |   18 +++++++++---------
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index e814803..5f35223 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -232,20 +232,19 @@ EXPORT_SYMBOL(orion_gpio_set_blink);
  *        polarity    LEVEL          mask
  *
  ****************************************************************************/
-
-static void gpio_irq_ack(u32 irq)
+static void gpio_irq_ack(struct irq_data *d)
 {
-	int type = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
+	int type = irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK;
 	if (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
-		int pin = irq_to_gpio(irq);
+		int pin = irq_to_gpio(d->irq);
 		writel(~(1 << (pin & 31)), GPIO_EDGE_CAUSE(pin));
 	}
 }
 
-static void gpio_irq_mask(u32 irq)
+static void gpio_irq_mask(struct irq_data *d)
 {
-	int pin = irq_to_gpio(irq);
-	int type = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
+	int pin = irq_to_gpio(d->irq);
+	int type = irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK;
 	u32 reg = (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) ?
 		GPIO_EDGE_MASK(pin) : GPIO_LEVEL_MASK(pin);
 	u32 u = readl(reg);
@@ -253,10 +252,10 @@ static void gpio_irq_mask(u32 irq)
 	writel(u, reg);
 }
 
-static void gpio_irq_unmask(u32 irq)
+static void gpio_irq_unmask(struct irq_data *d)
 {
-	int pin = irq_to_gpio(irq);
-	int type = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
+	int pin = irq_to_gpio(d->irq);
+	int type = irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK;
 	u32 reg = (type & (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) ?
 		GPIO_EDGE_MASK(pin) : GPIO_LEVEL_MASK(pin);
 	u32 u = readl(reg);
@@ -264,20 +263,20 @@ static void gpio_irq_unmask(u32 irq)
 	writel(u, reg);
 }
 
-static int gpio_irq_set_type(u32 irq, u32 type)
+static int gpio_irq_set_type(struct irq_data *d, u32 type)
 {
-	int pin = irq_to_gpio(irq);
+	int pin = irq_to_gpio(d->irq);
 	struct irq_desc *desc;
 	u32 u;
 
 	u = readl(GPIO_IO_CONF(pin)) & (1 << (pin & 31));
 	if (!u) {
 		printk(KERN_ERR "orion gpio_irq_set_type failed "
-				"(irq %d, pin %d).\n", irq, pin);
+				"(irq %d, pin %d).\n", d->irq, pin);
 		return -EINVAL;
 	}
 
-	desc = irq_desc + irq;
+	desc = irq_desc + d->irq;
 
 	/*
 	 * Set edge/level type.
@@ -287,7 +286,7 @@ static int gpio_irq_set_type(u32 irq, u32 type)
 	} else if (type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
 		desc->handle_irq = handle_level_irq;
 	} else {
-		printk(KERN_ERR "failed to set irq=%d (type=%d)\n", irq, type);
+		printk(KERN_ERR "failed to set irq=%d (type=%d)\n", d->irq, type);
 		return -EINVAL;
 	}
 
@@ -325,10 +324,10 @@ static int gpio_irq_set_type(u32 irq, u32 type)
 
 struct irq_chip orion_gpio_irq_chip = {
 	.name		= "orion_gpio_irq",
-	.ack		= gpio_irq_ack,
-	.mask		= gpio_irq_mask,
-	.unmask		= gpio_irq_unmask,
-	.set_type	= gpio_irq_set_type,
+	.irq_ack	= gpio_irq_ack,
+	.irq_mask	= gpio_irq_mask,
+	.irq_unmask	= gpio_irq_unmask,
+	.irq_set_type	= gpio_irq_set_type,
 };
 
 void orion_gpio_irq_handler(int pinoff)
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 3f9d34f..7d0c7eb 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -14,31 +14,31 @@
 #include <linux/io.h>
 #include <plat/irq.h>
 
-static void orion_irq_mask(u32 irq)
+static void orion_irq_mask(struct irq_data *d)
 {
-	void __iomem *maskaddr = get_irq_chip_data(irq);
+	void __iomem *maskaddr = irq_data_get_irq_chip_data(d);
 	u32 mask;
 
 	mask = readl(maskaddr);
-	mask &= ~(1 << (irq & 31));
+	mask &= ~(1 << (d->irq & 31));
 	writel(mask, maskaddr);
 }
 
-static void orion_irq_unmask(u32 irq)
+static void orion_irq_unmask(struct irq_data *d)
 {
-	void __iomem *maskaddr = get_irq_chip_data(irq);
+	void __iomem *maskaddr = irq_data_get_irq_chip_data(d);
 	u32 mask;
 
 	mask = readl(maskaddr);
-	mask |= 1 << (irq & 31);
+	mask |= 1 << (d->irq & 31);
 	writel(mask, maskaddr);
 }
 
 static struct irq_chip orion_irq_chip = {
 	.name		= "orion_irq",
-	.mask		= orion_irq_mask,
-	.mask_ack	= orion_irq_mask,
-	.unmask		= orion_irq_unmask,
+	.irq_mask	= orion_irq_mask,
+	.irq_mask_ack	= orion_irq_mask,
+	.irq_unmask	= orion_irq_unmask,
 };
 
 void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
-- 
1.7.1
