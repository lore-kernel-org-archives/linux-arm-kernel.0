From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sat, 15 Nov 2014 14:53:52 +0300
Subject: [PATCH 6/6] ARM: sa1100: switch to hwirq usage
In-Reply-To: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
References: <1416052432-26192-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416052432-26192-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch internally to using hardware irq numbers (hwirq). In case of GPIO
interrupts, hwirq is equal to GPIO number. In case of system interrupts,
hwirq is equal to interrupt number in the interrupt controller.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 36dd45e..c88d9c3 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -35,20 +35,11 @@ static int GPIO_IRQ_rising_edge;
 static int GPIO_IRQ_falling_edge;
 static int GPIO_IRQ_mask = (1 << 11) - 1;
 
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
@@ -76,25 +67,25 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
  */
 static void sa1100_low_gpio_ack(struct irq_data *d)
 {
-	GEDR = (1 << d->irq);
+	GEDR = BIT(d->hwirq);
 }
 
 static void sa1100_low_gpio_mask(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	ICMR &= ~BIT(d->hwirq);
 }
 
 static void sa1100_low_gpio_unmask(struct irq_data *d)
 {
-	ICMR |= 1 << d->irq;
+	ICMR |= BIT(d->hwirq);
 }
 
 static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= 1 << d->irq;
+		PWER |= BIT(d->hwirq);
 	else
-		PWER &= ~(1 << d->irq);
+		PWER &= ~BIT(d->hwirq);
 	return 0;
 }
 
@@ -162,14 +153,14 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
  */
 static void sa1100_high_gpio_ack(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	GEDR = mask;
 }
 
 static void sa1100_high_gpio_mask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	GPIO_IRQ_mask &= ~mask;
 
@@ -179,7 +170,7 @@ static void sa1100_high_gpio_mask(struct irq_data *d)
 
 static void sa1100_high_gpio_unmask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	GPIO_IRQ_mask |= mask;
 
@@ -190,9 +181,9 @@ static void sa1100_high_gpio_unmask(struct irq_data *d)
 static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= GPIO11_27_MASK(d->irq);
+		PWER |= BIT(d->hwirq);
 	else
-		PWER &= ~GPIO11_27_MASK(d->irq);
+		PWER &= ~BIT(d->hwirq);
 	return 0;
 }
 
@@ -228,12 +219,12 @@ static struct irq_domain *sa1100_high_gpio_irqdomain;
  */
 static void sa1100_mask_irq(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	ICMR &= ~BIT(d->hwirq);
 }
 
 static void sa1100_unmask_irq(struct irq_data *d)
 {
-	ICMR |= (1 << d->irq);
+	ICMR |= BIT(d->hwirq);
 }
 
 /*
@@ -241,7 +232,7 @@ static void sa1100_unmask_irq(struct irq_data *d)
  */
 static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 {
-	if (d->irq == IRQ_RTCAlrm) {
+	if (d->hwirq == IRQ_RTCAlrm) {
 		if (on)
 			PWER |= PWER_RTC;
 		else
-- 
2.1.1
