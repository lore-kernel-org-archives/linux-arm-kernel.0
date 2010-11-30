From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:22 +0100
Subject: [PATCH 50/54] ARM: plat-nomadik: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134122.GY15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-nomadik/gpio.c |   56 +++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 85e6fd2..2edc841 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -318,13 +318,13 @@ static inline int nmk_gpio_get_bitmask(int gpio)
 	return 1 << (gpio % 32);
 }
 
-static void nmk_gpio_irq_ack(unsigned int irq)
+static void nmk_gpio_irq_ack(struct irq_data *d)
 {
 	int gpio;
 	struct nmk_gpio_chip *nmk_chip;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(irq);
-	nmk_chip = get_irq_chip_data(irq);
+	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
+	nmk_chip = irq_data_get_irq_chip_data(d);
 	if (!nmk_chip)
 		return;
 	writel(nmk_gpio_get_bitmask(gpio), nmk_chip->addr + NMK_GPIO_IC);
@@ -363,7 +363,7 @@ static void __nmk_gpio_irq_modify(struct nmk_gpio_chip *nmk_chip,
 	}
 }
 
-static int nmk_gpio_irq_modify(unsigned int irq, enum nmk_gpio_irq_type which,
+static int nmk_gpio_irq_modify(struct irq_data *d, enum nmk_gpio_irq_type which,
 			       bool enable)
 {
 	int gpio;
@@ -371,8 +371,8 @@ static int nmk_gpio_irq_modify(unsigned int irq, enum nmk_gpio_irq_type which,
 	unsigned long flags;
 	u32 bitmask;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(irq);
-	nmk_chip = get_irq_chip_data(irq);
+	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
+	nmk_chip = irq_data_get_irq_chip_data(d);
 	bitmask = nmk_gpio_get_bitmask(gpio);
 	if (!nmk_chip)
 		return -EINVAL;
@@ -384,24 +384,24 @@ static int nmk_gpio_irq_modify(unsigned int irq, enum nmk_gpio_irq_type which,
 	return 0;
 }
 
-static void nmk_gpio_irq_mask(unsigned int irq)
+static void nmk_gpio_irq_mask(struct irq_data *d)
 {
-	nmk_gpio_irq_modify(irq, NORMAL, false);
+	nmk_gpio_irq_modify(d, NORMAL, false);
 }
 
-static void nmk_gpio_irq_unmask(unsigned int irq)
+static void nmk_gpio_irq_unmask(struct irq_data *d)
 {
-	nmk_gpio_irq_modify(irq, NORMAL, true);
+	nmk_gpio_irq_modify(d, NORMAL, true);
 }
 
-static int nmk_gpio_irq_set_wake(unsigned int irq, unsigned int on)
+static int nmk_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct nmk_gpio_chip *nmk_chip;
 	unsigned long flags;
 	int gpio;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(irq);
-	nmk_chip = get_irq_chip_data(irq);
+	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
+	nmk_chip = irq_data_get_irq_chip_data(d);
 	if (!nmk_chip)
 		return -EINVAL;
 
@@ -419,9 +419,9 @@ static int nmk_gpio_irq_set_wake(unsigned int irq, unsigned int on)
 	return 0;
 }
 
-static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
+static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	bool enabled = !(desc->status & IRQ_DISABLED);
 	bool wake = desc->wake_depth;
 	int gpio;
@@ -429,8 +429,8 @@ static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 	unsigned long flags;
 	u32 bitmask;
 
-	gpio = NOMADIK_IRQ_TO_GPIO(irq);
-	nmk_chip = get_irq_chip_data(irq);
+	gpio = NOMADIK_IRQ_TO_GPIO(d->irq);
+	nmk_chip = irq_data_get_irq_chip_data(d);
 	bitmask = nmk_gpio_get_bitmask(gpio);
 	if (!nmk_chip)
 		return -EINVAL;
@@ -469,11 +469,11 @@ static int nmk_gpio_irq_set_type(unsigned int irq, unsigned int type)
 
 static struct irq_chip nmk_gpio_irq_chip = {
 	.name		= "Nomadik-GPIO",
-	.ack		= nmk_gpio_irq_ack,
-	.mask		= nmk_gpio_irq_mask,
-	.unmask		= nmk_gpio_irq_unmask,
-	.set_type	= nmk_gpio_irq_set_type,
-	.set_wake	= nmk_gpio_irq_set_wake,
+	.irq_ack	= nmk_gpio_irq_ack,
+	.irq_mask	= nmk_gpio_irq_mask,
+	.irq_unmask	= nmk_gpio_irq_unmask,
+	.irq_set_type	= nmk_gpio_irq_set_type,
+	.irq_set_wake	= nmk_gpio_irq_set_wake,
 };
 
 static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
@@ -484,12 +484,12 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 pending;
 	unsigned int first_irq;
 
-	if (host_chip->mask_ack)
-		host_chip->mask_ack(irq);
+	if (host_chip->irq_mask_ack)
+		host_chip->irq_mask_ack(&desc->irq_data);
 	else {
-		host_chip->mask(irq);
-		if (host_chip->ack)
-			host_chip->ack(irq);
+		host_chip->irq_mask(&desc->irq_data);
+		if (host_chip->irq_ack)
+			host_chip->irq_ack(&desc->irq_data);
 	}
 
 	nmk_chip = get_irq_data(irq);
@@ -499,7 +499,7 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(gpio_irq);
 	}
 
-	host_chip->unmask(irq);
+	host_chip->irq_unmask(&desc->irq_data);
 }
 
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
-- 
1.7.1
