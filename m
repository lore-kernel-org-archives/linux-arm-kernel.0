From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:36 +0100
Subject: [PATCH 12/54] ARM: davinci: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133636.GM15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-davinci/cp_intc.c |   30 ++++++++++++------------
 arch/arm/mach-davinci/gpio.c    |   46 +++++++++++++++++++-------------------
 arch/arm/mach-davinci/irq.c     |   26 +++++++++++-----------
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index bb4c40e..9abc80a 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -26,30 +26,30 @@ static inline void cp_intc_write(unsigned long value, unsigned offset)
 	__raw_writel(value, davinci_intc_base + offset);
 }
 
-static void cp_intc_ack_irq(unsigned int irq)
+static void cp_intc_ack_irq(struct irq_data *d)
 {
-	cp_intc_write(irq, CP_INTC_SYS_STAT_IDX_CLR);
+	cp_intc_write(d->irq, CP_INTC_SYS_STAT_IDX_CLR);
 }
 
 /* Disable interrupt */
-static void cp_intc_mask_irq(unsigned int irq)
+static void cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
 	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_CLR);
-	cp_intc_write(irq, CP_INTC_SYS_ENABLE_IDX_CLR);
+	cp_intc_write(d->irq, CP_INTC_SYS_ENABLE_IDX_CLR);
 	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
 /* Enable interrupt */
-static void cp_intc_unmask_irq(unsigned int irq)
+static void cp_intc_unmask_irq(struct irq_data *d)
 {
-	cp_intc_write(irq, CP_INTC_SYS_ENABLE_IDX_SET);
+	cp_intc_write(d->irq, CP_INTC_SYS_ENABLE_IDX_SET);
 }
 
-static int cp_intc_set_irq_type(unsigned int irq, unsigned int flow_type)
+static int cp_intc_set_irq_type(struct irq_data *d, unsigned int flow_type)
 {
-	unsigned reg		= BIT_WORD(irq);
-	unsigned mask		= BIT_MASK(irq);
+	unsigned reg		= BIT_WORD(d->irq);
+	unsigned mask		= BIT_MASK(d->irq);
 	unsigned polarity	= cp_intc_read(CP_INTC_SYS_POLARITY(reg));
 	unsigned type		= cp_intc_read(CP_INTC_SYS_TYPE(reg));
 
@@ -85,18 +85,18 @@ static int cp_intc_set_irq_type(unsigned int irq, unsigned int flow_type)
  * generic drivers which call {enable|disable}_irq_wake for
  * wake up interrupt sources (eg RTC on DA850).
  */
-static int cp_intc_set_wake(unsigned int irq, unsigned int on)
+static int cp_intc_set_wake(struct irq_data *d, unsigned int on)
 {
 	return 0;
 }
 
 static struct irq_chip cp_intc_irq_chip = {
 	.name		= "cp_intc",
-	.ack		= cp_intc_ack_irq,
-	.mask		= cp_intc_mask_irq,
-	.unmask		= cp_intc_unmask_irq,
-	.set_type	= cp_intc_set_irq_type,
-	.set_wake	= cp_intc_set_wake,
+	.irq_ack	= cp_intc_ack_irq,
+	.irq_mask	= cp_intc_mask_irq,
+	.irq_unmask	= cp_intc_unmask_irq,
+	.irq_set_type	= cp_intc_set_irq_type,
+	.irq_set_wake	= cp_intc_set_wake,
 };
 
 void __init cp_intc_init(void)
diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index bf0ff58..20d66e5 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -205,20 +205,20 @@ pure_initcall(davinci_gpio_setup);
  * serve as EDMA event triggers.
  */
 
-static void gpio_irq_disable(unsigned irq)
+static void gpio_irq_disable(struct irq_data *d)
 {
-	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
-	u32 mask = (u32) get_irq_data(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(d->irq);
+	u32 mask = (u32) irq_data_get_irq_data(d);
 
 	__raw_writel(mask, &g->clr_falling);
 	__raw_writel(mask, &g->clr_rising);
 }
 
-static void gpio_irq_enable(unsigned irq)
+static void gpio_irq_enable(struct irq_data *d)
 {
-	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
-	u32 mask = (u32) get_irq_data(irq);
-	unsigned status = irq_desc[irq].status;
+	struct davinci_gpio_regs __iomem *g = irq2regs(d->irq);
+	u32 mask = (u32) irq_data_get_irq_data(d);
+	unsigned status = irq_desc[d->irq].status;
 
 	status &= IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING;
 	if (!status)
@@ -230,19 +230,19 @@ static void gpio_irq_enable(unsigned irq)
 		__raw_writel(mask, &g->set_rising);
 }
 
-static int gpio_irq_type(unsigned irq, unsigned trigger)
+static int gpio_irq_type(struct irq_data *d, unsigned trigger)
 {
-	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
-	u32 mask = (u32) get_irq_data(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(d->irq);
+	u32 mask = (u32) irq_data_get_irq_data(d);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		return -EINVAL;
 
-	irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
-	irq_desc[irq].status |= trigger;
+	irq_desc[d->irq].status &= ~IRQ_TYPE_SENSE_MASK;
+	irq_desc[d->irq].status |= trigger;
 
 	/* don't enable the IRQ if it's currently disabled */
-	if (irq_desc[irq].depth == 0) {
+	if (irq_desc[d->irq].depth == 0) {
 		__raw_writel(mask, (trigger & IRQ_TYPE_EDGE_FALLING)
 			     ? &g->set_falling : &g->clr_falling);
 		__raw_writel(mask, (trigger & IRQ_TYPE_EDGE_RISING)
@@ -253,9 +253,9 @@ static int gpio_irq_type(unsigned irq, unsigned trigger)
 
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
-	.enable		= gpio_irq_enable,
-	.disable	= gpio_irq_disable,
-	.set_type	= gpio_irq_type,
+	.irq_enable	= gpio_irq_enable,
+	.irq_disable	= gpio_irq_disable,
+	.irq_set_type	= gpio_irq_type,
 };
 
 static void
@@ -269,8 +269,8 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		mask <<= 16;
 
 	/* temporarily mask (level sensitive) parent IRQ */
-	desc->chip->mask(irq);
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_mask(&desc->irq_data);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 	while (1) {
 		u32		status;
 		int		n;
@@ -293,7 +293,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			status >>= res;
 		}
 	}
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 	/* now it may re-trigger */
 }
 
@@ -320,10 +320,10 @@ static int gpio_to_irq_unbanked(struct gpio_chip *chip, unsigned offset)
 		return -ENODEV;
 }
 
-static int gpio_irq_type_unbanked(unsigned irq, unsigned trigger)
+static int gpio_irq_type_unbanked(struct irq_data *d, unsigned trigger)
 {
-	struct davinci_gpio_regs __iomem *g = irq2regs(irq);
-	u32 mask = (u32) get_irq_data(irq);
+	struct davinci_gpio_regs __iomem *g = irq2regs(d->irq);
+	u32 mask = (u32) irq_data_get_irq_data(d);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		return -EINVAL;
@@ -397,7 +397,7 @@ static int __init davinci_gpio_irq_setup(void)
 		irq = bank_irq;
 		gpio_irqchip_unbanked = *get_irq_desc_chip(irq_to_desc(irq));
 		gpio_irqchip_unbanked.name = "GPIO-AINTC";
-		gpio_irqchip_unbanked.set_type = gpio_irq_type_unbanked;
+		gpio_irqchip_unbanked.irq_set_type = gpio_irq_type_unbanked;
 
 		/* default trigger: both edges */
 		g = gpio2regs(0);
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 784ddf3..f5f417e 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -53,14 +53,14 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
 }
 
 /* Disable interrupt */
-static void davinci_mask_irq(unsigned int irq)
+static void davinci_mask_irq(struct irq_data *d)
 {
 	unsigned int mask;
 	u32 l;
 
-	mask = 1 << IRQ_BIT(irq);
+	mask = 1 << IRQ_BIT(d->irq);
 
-	if (irq > 31) {
+	if (d->irq > 31) {
 		l = davinci_irq_readl(IRQ_ENT_REG1_OFFSET);
 		l &= ~mask;
 		davinci_irq_writel(l, IRQ_ENT_REG1_OFFSET);
@@ -72,14 +72,14 @@ static void davinci_mask_irq(unsigned int irq)
 }
 
 /* Enable interrupt */
-static void davinci_unmask_irq(unsigned int irq)
+static void davinci_unmask_irq(struct irq_data *d)
 {
 	unsigned int mask;
 	u32 l;
 
-	mask = 1 << IRQ_BIT(irq);
+	mask = 1 << IRQ_BIT(d->irq);
 
-	if (irq > 31) {
+	if (d->irq > 31) {
 		l = davinci_irq_readl(IRQ_ENT_REG1_OFFSET);
 		l |= mask;
 		davinci_irq_writel(l, IRQ_ENT_REG1_OFFSET);
@@ -91,23 +91,23 @@ static void davinci_unmask_irq(unsigned int irq)
 }
 
 /* EOI interrupt */
-static void davinci_ack_irq(unsigned int irq)
+static void davinci_ack_irq(struct irq_data *d)
 {
 	unsigned int mask;
 
-	mask = 1 << IRQ_BIT(irq);
+	mask = 1 << IRQ_BIT(d->irq);
 
-	if (irq > 31)
+	if (d->irq > 31)
 		davinci_irq_writel(mask, IRQ_REG1_OFFSET);
 	else
 		davinci_irq_writel(mask, IRQ_REG0_OFFSET);
 }
 
 static struct irq_chip davinci_irq_chip_0 = {
-	.name	= "AINTC",
-	.ack	= davinci_ack_irq,
-	.mask	= davinci_mask_irq,
-	.unmask = davinci_unmask_irq,
+	.name		= "AINTC",
+	.irq_ack	= davinci_ack_irq,
+	.irq_mask	= davinci_mask_irq,
+	.irq_unmask = davinci_unmask_irq,
 };
 
 /* ARM Interrupt Controller Initialization */
-- 
1.7.1
