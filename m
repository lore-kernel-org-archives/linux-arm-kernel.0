From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 22:09:52 +0300
Subject: [PATCH v2 8/8] ARM: sa1100: reorder IRQ handling code
In-Reply-To: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
References: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1416942592-23059-9-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch just reorders functions/data inside sa1100 irq driver to be
able to merge functions that have the same code after converting to
irqdomains and hwirq. No real code changes.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 155 +++++++++++++++++++--------------------------
 1 file changed, 66 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 981db98..63e2901 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -27,6 +27,60 @@
 
 
 /*
+ * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
+ * this is for internal IRQs i.e. from IRQ LCD to RTCAlrm.
+ */
+static void sa1100_mask_irq(struct irq_data *d)
+{
+	ICMR &= ~BIT(d->hwirq);
+}
+
+static void sa1100_unmask_irq(struct irq_data *d)
+{
+	ICMR |= BIT(d->hwirq);
+}
+
+/*
+ * Apart form GPIOs, only the RTC alarm can be a wakeup event.
+ */
+static int sa1100_set_wake(struct irq_data *d, unsigned int on)
+{
+	if (BIT(d->hwirq) == IC_RTCAlrm) {
+		if (on)
+			PWER |= PWER_RTC;
+		else
+			PWER &= ~PWER_RTC;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static struct irq_chip sa1100_normal_chip = {
+	.name		= "SC",
+	.irq_ack	= sa1100_mask_irq,
+	.irq_mask	= sa1100_mask_irq,
+	.irq_unmask	= sa1100_unmask_irq,
+	.irq_set_wake	= sa1100_set_wake,
+};
+
+static int sa1100_normal_irqdomain_map(struct irq_domain *d,
+		unsigned int irq, irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &sa1100_normal_chip,
+				 handle_level_irq);
+	set_irq_flags(irq, IRQF_VALID);
+
+	return 0;
+}
+
+static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
+	.map = sa1100_normal_irqdomain_map,
+	.xlate = irq_domain_xlate_onetwocell,
+};
+
+static struct irq_domain *sa1100_normal_irqdomain;
+
+/*
  * SA1100 GPIO edge detection for IRQs:
  * IRQs are generated on Falling-Edge, Rising-Edge, or both.
  * Use this instead of directly setting GRER/GFER.
@@ -63,24 +117,14 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 }
 
 /*
- * GPIO IRQs must be acknowledged.  This is for IRQs from GPIO0 to 10.
+ * GPIO IRQs must be acknowledged.
  */
-static void sa1100_low_gpio_ack(struct irq_data *d)
+static void sa1100_gpio_ack(struct irq_data *d)
 {
 	GEDR = BIT(d->hwirq);
 }
 
-static void sa1100_low_gpio_mask(struct irq_data *d)
-{
-	ICMR &= ~BIT(d->hwirq);
-}
-
-static void sa1100_low_gpio_unmask(struct irq_data *d)
-{
-	ICMR |= BIT(d->hwirq);
-}
-
-static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
+static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
 		PWER |= BIT(d->hwirq);
@@ -89,13 +133,16 @@ static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+/*
+ * This is for IRQs from 0 to 10.
+ */
 static struct irq_chip sa1100_low_gpio_chip = {
 	.name		= "GPIO-l",
-	.irq_ack	= sa1100_low_gpio_ack,
-	.irq_mask	= sa1100_low_gpio_mask,
-	.irq_unmask	= sa1100_low_gpio_unmask,
+	.irq_ack	= sa1100_gpio_ack,
+	.irq_mask	= sa1100_mask_irq,
+	.irq_unmask	= sa1100_unmask_irq,
 	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_low_gpio_wake,
+	.irq_set_wake	= sa1100_gpio_wake,
 };
 
 static int sa1100_low_gpio_irqdomain_map(struct irq_domain *d,
@@ -151,13 +198,6 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
  * In addition, the IRQs are all collected up into one bit in the
  * interrupt controller registers.
  */
-static void sa1100_high_gpio_ack(struct irq_data *d)
-{
-	unsigned int mask = BIT(d->hwirq);
-
-	GEDR = mask;
-}
-
 static void sa1100_high_gpio_mask(struct irq_data *d)
 {
 	unsigned int mask = BIT(d->hwirq);
@@ -178,22 +218,13 @@ static void sa1100_high_gpio_unmask(struct irq_data *d)
 	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
 }
 
-static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
-{
-	if (on)
-		PWER |= BIT(d->hwirq);
-	else
-		PWER &= ~BIT(d->hwirq);
-	return 0;
-}
-
 static struct irq_chip sa1100_high_gpio_chip = {
 	.name		= "GPIO-h",
-	.irq_ack	= sa1100_high_gpio_ack,
+	.irq_ack	= sa1100_gpio_ack,
 	.irq_mask	= sa1100_high_gpio_mask,
 	.irq_unmask	= sa1100_high_gpio_unmask,
 	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_high_gpio_wake,
+	.irq_set_wake	= sa1100_gpio_wake,
 };
 
 static int sa1100_high_gpio_irqdomain_map(struct irq_domain *d,
@@ -213,60 +244,6 @@ static struct irq_domain_ops sa1100_high_gpio_irqdomain_ops = {
 
 static struct irq_domain *sa1100_high_gpio_irqdomain;
 
-/*
- * We don't need to ACK IRQs on the SA1100 unless they're GPIOs
- * this is for internal IRQs i.e. from IRQ LCD to RTCAlrm.
- */
-static void sa1100_mask_irq(struct irq_data *d)
-{
-	ICMR &= ~BIT(d->hwirq);
-}
-
-static void sa1100_unmask_irq(struct irq_data *d)
-{
-	ICMR |= BIT(d->hwirq);
-}
-
-/*
- * Apart form GPIOs, only the RTC alarm can be a wakeup event.
- */
-static int sa1100_set_wake(struct irq_data *d, unsigned int on)
-{
-	if (BIT(d->hwirq) == IC_RTCAlrm) {
-		if (on)
-			PWER |= PWER_RTC;
-		else
-			PWER &= ~PWER_RTC;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-static struct irq_chip sa1100_normal_chip = {
-	.name		= "SC",
-	.irq_ack	= sa1100_mask_irq,
-	.irq_mask	= sa1100_mask_irq,
-	.irq_unmask	= sa1100_unmask_irq,
-	.irq_set_wake	= sa1100_set_wake,
-};
-
-static int sa1100_normal_irqdomain_map(struct irq_domain *d,
-		unsigned int irq, irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &sa1100_normal_chip,
-				 handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID);
-
-	return 0;
-}
-
-static struct irq_domain_ops sa1100_normal_irqdomain_ops = {
-	.map = sa1100_normal_irqdomain_map,
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
-static struct irq_domain *sa1100_normal_irqdomain;
-
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
-- 
2.1.3
