From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:16 +0400
Subject: [PATCH v3 09/10] arm: sa1100: switch to hwirq usage
In-Reply-To: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1387081697-21841-10-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch internally to using hardware irq numbers (hwirq). In case of GPIO
interrupts, hwirq is equal to GPIO number. In case of system interrupts,
hwirq is equal to interrupt number in the interrupt controller.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 5c72062..43287a5 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -49,20 +49,11 @@ static int GPIO_IRQ_falling_edge;
 static int GPIO_IRQ_mask = (1 << 11) - 1;
 static int GPIO_IRQ_wake_mask;
 
-/*
- * To get the GPIO number from an IRQ number
- */
-#define GPIO_11_27_IRQ(i)	((i) - 21)
-#define GPIO11_27_MASK(irq)	(1 << GPIO_11_27_IRQ(irq))
-
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
 	unsigned int mask;
 
-	if (d->irq <= 10)
-		mask = 1 << d->irq;
-	else
-		mask = GPIO11_27_MASK(d->irq);
+	mask = BIT(d->hwirq);
 
 	if (type == IRQ_TYPE_PROBE) {
 		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
@@ -92,31 +83,31 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
  */
 static void sa1100_low_gpio_ack(struct irq_data *d)
 {
-	writel_relaxed((1 << d->irq), gpio_regbase + GEDR_OFFSET);
+	writel_relaxed(BIT(d->hwirq), gpio_regbase + GEDR_OFFSET);
 }
 
 static void sa1100_low_gpio_mask(struct irq_data *d)
 {
 	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
-	r &= ~BIT(d->irq);
+	r &= ~BIT(d->hwirq);
 	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 static void sa1100_low_gpio_unmask(struct irq_data *d)
 {
 	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
-	r |= BIT(d->irq);
+	r |= BIT(d->hwirq);
 	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		GPIO_IRQ_wake_mask |= BIT(d->irq);
+		GPIO_IRQ_wake_mask |= BIT(d->hwirq);
 	else
-		GPIO_IRQ_wake_mask &= ~BIT(d->irq);
+		GPIO_IRQ_wake_mask &= ~BIT(d->hwirq);
 
-	return sa11x0_gpio_set_wake(d->irq, on);
+	return sa11x0_gpio_set_wake(d->hwirq, on);
 }
 
 static struct irq_chip sa1100_low_gpio_chip = {
@@ -183,14 +174,14 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
  */
 static void sa1100_high_gpio_ack(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	writel_relaxed(mask, gpio_regbase + GEDR_OFFSET);
 }
 
 static void sa1100_high_gpio_mask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 	unsigned int r;
 
 	GPIO_IRQ_mask &= ~mask;
@@ -205,7 +196,7 @@ static void sa1100_high_gpio_mask(struct irq_data *d)
 
 static void sa1100_high_gpio_unmask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	GPIO_IRQ_mask |= mask;
 
@@ -218,11 +209,11 @@ static void sa1100_high_gpio_unmask(struct irq_data *d)
 static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		GPIO_IRQ_wake_mask |= GPIO11_27_MASK(d->irq);
+		GPIO_IRQ_wake_mask |= BIT(d->hwirq);
 	else
-		GPIO_IRQ_wake_mask &= ~GPIO11_27_MASK(d->irq);
+		GPIO_IRQ_wake_mask &= ~BIT(d->hwirq);
 
-	return sa11x0_gpio_set_wake(GPIO_11_27_IRQ(d->irq), on);
+	return sa11x0_gpio_set_wake(d->hwirq, on);
 }
 
 static struct irq_chip sa1100_high_gpio_chip = {
@@ -258,14 +249,14 @@ static struct irq_domain *sa1100_high_gpio_irqdomain;
 static void sa1100_mask_irq(struct irq_data *d)
 {
 	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
-	r &= ~BIT(d->irq);
+	r &= ~BIT(d->hwirq);
 	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 static void sa1100_unmask_irq(struct irq_data *d)
 {
 	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
-	r |= BIT(d->irq);
+	r |= BIT(d->hwirq);
 	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
@@ -274,7 +265,7 @@ static void sa1100_unmask_irq(struct irq_data *d)
  */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	return sa11x0_sc_set_wake(d->irq, on);
+	return sa11x0_sc_set_wake(d->hwirq, on);
 }
 
 static struct irq_chip sa1100_normal_chip = {
-- 
1.8.5.1
