From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:39 +0100
Subject: [PATCH 15/54] ARM: ep93xx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133639.GP15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ep93xx/gpio.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-ep93xx/gpio.c b/arch/arm/mach-ep93xx/gpio.c
index cf547ad..f3dc76f 100644
--- a/arch/arm/mach-ep93xx/gpio.c
+++ b/arch/arm/mach-ep93xx/gpio.c
@@ -112,13 +112,13 @@ static void ep93xx_gpio_f_irq_handler(unsigned int irq, struct irq_desc *desc)
 	generic_handle_irq(gpio_irq);
 }
 
-static void ep93xx_gpio_irq_ack(unsigned int irq)
+static void ep93xx_gpio_irq_ack(struct irq_data *d)
 {
-	int line = irq_to_gpio(irq);
+	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
-	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
+	if ((irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH) {
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
 		ep93xx_gpio_update_int_params(port);
 	}
@@ -126,13 +126,13 @@ static void ep93xx_gpio_irq_ack(unsigned int irq)
 	__raw_writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
 }
 
-static void ep93xx_gpio_irq_mask_ack(unsigned int irq)
+static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
 {
-	int line = irq_to_gpio(irq);
+	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 	int port_mask = 1 << (line & 7);
 
-	if ((irq_desc[irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
+	if ((irq_desc[d->irq].status & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 		gpio_int_type2[port] ^= port_mask; /* switch edge direction */
 
 	gpio_int_unmasked[port] &= ~port_mask;
@@ -141,18 +141,18 @@ static void ep93xx_gpio_irq_mask_ack(unsigned int irq)
 	__raw_writeb(port_mask, EP93XX_GPIO_REG(eoi_register_offset[port]));
 }
 
-static void ep93xx_gpio_irq_mask(unsigned int irq)
+static void ep93xx_gpio_irq_mask(struct irq_data *d)
 {
-	int line = irq_to_gpio(irq);
+	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] &= ~(1 << (line & 7));
 	ep93xx_gpio_update_int_params(port);
 }
 
-static void ep93xx_gpio_irq_unmask(unsigned int irq)
+static void ep93xx_gpio_irq_unmask(struct irq_data *d)
 {
-	int line = irq_to_gpio(irq);
+	int line = irq_to_gpio(d->irq);
 	int port = line >> 3;
 
 	gpio_int_unmasked[port] |= 1 << (line & 7);
@@ -164,10 +164,10 @@ static void ep93xx_gpio_irq_unmask(unsigned int irq)
  * edge (1) triggered, while gpio_int_type2 controls whether it
  * triggers on low/falling (0) or high/rising (1).
  */
-static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
+static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
-	struct irq_desc *desc = irq_desc + irq;
-	const int gpio = irq_to_gpio(irq);
+	struct irq_desc *desc = irq_desc + d->irq;
+	const int gpio = irq_to_gpio(d->irq);
 	const int port = gpio >> 3;
 	const int port_mask = 1 << (gpio & 7);
 
@@ -220,11 +220,11 @@ static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
 
 static struct irq_chip ep93xx_gpio_irq_chip = {
 	.name		= "GPIO",
-	.ack		= ep93xx_gpio_irq_ack,
-	.mask_ack	= ep93xx_gpio_irq_mask_ack,
-	.mask		= ep93xx_gpio_irq_mask,
-	.unmask		= ep93xx_gpio_irq_unmask,
-	.set_type	= ep93xx_gpio_irq_type,
+	.irq_ack	= ep93xx_gpio_irq_ack,
+	.irq_mask_ack	= ep93xx_gpio_irq_mask_ack,
+	.irq_mask	= ep93xx_gpio_irq_mask,
+	.irq_unmask	= ep93xx_gpio_irq_unmask,
+	.irq_set_type	= ep93xx_gpio_irq_type,
 };
 
 void __init ep93xx_gpio_init_irq(void)
-- 
1.7.1
