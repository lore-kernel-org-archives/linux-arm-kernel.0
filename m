From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 22 Dec 2014 13:05:37 +0300
Subject: [PATCH 2/5] ARM: sa1100: merge both GPIO irqdomains
In-Reply-To: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
References: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1419242740-20219-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now there is no difference between low and high GPIO irqdomains. Merge
them into single irqdomain handling all GPIOs.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 57 +++++++++-------------------------------------
 1 file changed, 11 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 2dc6a2a..5589b23 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -154,10 +154,10 @@ static int sa1100_gpio_wake(struct irq_data *d, unsigned int on)
 }
 
 /*
- * This is for IRQs from 0 to 10.
+ * This is for GPIO IRQs
  */
-static struct irq_chip sa1100_low_gpio_chip = {
-	.name		= "GPIO-l",
+static struct irq_chip sa1100_gpio_chip = {
+	.name		= "GPIO",
 	.irq_ack	= sa1100_gpio_ack,
 	.irq_mask	= sa1100_gpio_mask,
 	.irq_unmask	= sa1100_gpio_unmask,
@@ -165,22 +165,22 @@ static struct irq_chip sa1100_low_gpio_chip = {
 	.irq_set_wake	= sa1100_gpio_wake,
 };
 
-static int sa1100_low_gpio_irqdomain_map(struct irq_domain *d,
+static int sa1100_gpio_irqdomain_map(struct irq_domain *d,
 		unsigned int irq, irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
+	irq_set_chip_and_handler(irq, &sa1100_gpio_chip,
 				 handle_edge_irq);
 	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 
 	return 0;
 }
 
-static struct irq_domain_ops sa1100_low_gpio_irqdomain_ops = {
-	.map = sa1100_low_gpio_irqdomain_map,
+static struct irq_domain_ops sa1100_gpio_irqdomain_ops = {
+	.map = sa1100_gpio_irqdomain_map,
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static struct irq_domain *sa1100_low_gpio_irqdomain;
+static struct irq_domain *sa1100_gpio_irqdomain;
 
 /*
  * IRQ 0-11 (GPIO) handler.  We enter here with the
@@ -212,37 +212,6 @@ sa1100_gpio_handler(unsigned int irq, struct irq_desc *desc)
 	} while (mask);
 }
 
-/*
- * Like GPIO0 to 10, GPIO11-27 IRQs need to be handled specially.
- * In addition, the IRQs are all collected up into one bit in the
- * interrupt controller registers.
- */
-static struct irq_chip sa1100_high_gpio_chip = {
-	.name		= "GPIO-h",
-	.irq_ack	= sa1100_gpio_ack,
-	.irq_mask	= sa1100_gpio_mask,
-	.irq_unmask	= sa1100_gpio_unmask,
-	.irq_set_type	= sa1100_gpio_type,
-	.irq_set_wake	= sa1100_gpio_wake,
-};
-
-static int sa1100_high_gpio_irqdomain_map(struct irq_domain *d,
-		unsigned int irq, irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &sa1100_high_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-
-	return 0;
-}
-
-static struct irq_domain_ops sa1100_high_gpio_irqdomain_ops = {
-	.map = sa1100_high_gpio_irqdomain_map,
-	.xlate = irq_domain_xlate_onetwocell,
-};
-
-static struct irq_domain *sa1100_high_gpio_irqdomain;
-
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
@@ -353,13 +322,9 @@ void __init sa1100_init_irq(void)
 			32, IRQ_GPIO0_SC, 0,
 			&sa1100_normal_irqdomain_ops, NULL);
 
-	sa1100_low_gpio_irqdomain = irq_domain_add_legacy(NULL,
-			11, IRQ_GPIO0, 0,
-			&sa1100_low_gpio_irqdomain_ops, NULL);
-
-	sa1100_high_gpio_irqdomain = irq_domain_add_legacy(NULL,
-			17, IRQ_GPIO11, 11,
-			&sa1100_high_gpio_irqdomain_ops, NULL);
+	sa1100_gpio_irqdomain = irq_domain_add_legacy(NULL,
+			28, IRQ_GPIO0, 0,
+			&sa1100_gpio_irqdomain_ops, NULL);
 
 	/*
 	 * Install handlers for GPIO 0-10 edge detect interrupts
-- 
2.1.3
