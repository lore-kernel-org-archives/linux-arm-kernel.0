From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 17 Mar 2010 08:52:43 -0700
Subject: [PATCH 6/6] davinci: sparse: gpio: void casting
In-Reply-To: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1268841163-5868-7-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup usage of void pointers when using genirq.  genirq API
takes and returns void *, where this GPIO API is using those
as __iomem pointers.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/gpio.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index 3f77062..5476ad1 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -36,6 +36,15 @@ static struct gpio_controller __iomem __init *gpio2controller(unsigned gpio)
 	return __gpio_to_controller(gpio);
 }
 
+static inline struct gpio_controller __iomem *irq2controller(int irq)
+{
+	struct gpio_controller __iomem *g;
+
+	g = (__force struct gpio_controller __iomem *)get_irq_chip_data(irq);
+
+	return g;
+}
+
 static int __init davinci_gpio_irq_setup(void);
 
 /*--------------------------------------------------------------------------*/
@@ -161,7 +170,7 @@ pure_initcall(davinci_gpio_setup);
 
 static void gpio_irq_disable(unsigned irq)
 {
-	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = irq2controller(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	__raw_writel(mask, &g->clr_falling);
@@ -170,7 +179,7 @@ static void gpio_irq_disable(unsigned irq)
 
 static void gpio_irq_enable(unsigned irq)
 {
-	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = irq2controller(irq);
 	u32 mask = (u32) get_irq_data(irq);
 	unsigned status = irq_desc[irq].status;
 
@@ -186,7 +195,7 @@ static void gpio_irq_enable(unsigned irq)
 
 static int gpio_irq_type(unsigned irq, unsigned trigger)
 {
-	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = irq2controller(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -215,7 +224,7 @@ static struct irq_chip gpio_irqchip = {
 static void
 gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = irq2controller(irq);
 	u32 mask = 0xffff;
 
 	/* we only care about one bank */
@@ -276,7 +285,7 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_irq_type_unbanked(unsigned irq, unsigned trigger)
 {
-	struct gpio_controller __iomem *g = get_irq_chip_data(irq);
+	struct gpio_controller __iomem *g = irq2controller(irq);
 	u32 mask = (u32) get_irq_data(irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
@@ -362,7 +371,7 @@ static int __init davinci_gpio_irq_setup(void)
 		for (gpio = 0; gpio < soc_info->gpio_unbanked; gpio++, irq++) {
 			set_irq_chip(irq, &gpio_irqchip_unbanked);
 			set_irq_data(irq, (void *) __gpio_mask(gpio));
-			set_irq_chip_data(irq, g);
+			set_irq_chip_data(irq, (__force void *) g);
 			irq_desc[irq].status |= IRQ_TYPE_EDGE_BOTH;
 		}
 
@@ -385,12 +394,12 @@ static int __init davinci_gpio_irq_setup(void)
 
 		/* set up all irqs in this bank */
 		set_irq_chained_handler(bank_irq, gpio_irq_handler);
-		set_irq_chip_data(bank_irq, g);
-		set_irq_data(bank_irq, (void *)irq);
+		set_irq_chip_data(bank_irq, (__force void *) g);
+		set_irq_data(bank_irq, (void *) irq);
 
 		for (i = 0; i < 16 && gpio < ngpio; i++, irq++, gpio++) {
 			set_irq_chip(irq, &gpio_irqchip);
-			set_irq_chip_data(irq, g);
+			set_irq_chip_data(irq, (__force void *) g);
 			set_irq_data(irq, (void *) __gpio_mask(gpio));
 			set_irq_handler(irq, handle_simple_irq);
 			set_irq_flags(irq, IRQF_VALID);
-- 
1.7.0.2
