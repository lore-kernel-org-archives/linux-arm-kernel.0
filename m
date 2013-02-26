From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 26 Feb 2013 23:58:29 +0100
Subject: [PATCH 2/5] ARM: S3C24XX: fix irq parent check
In-Reply-To: <201302262357.24544.heiko@sntech.de>
References: <201302262357.24544.heiko@sntech.de>
Message-ID: <201302262358.29291.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current parent_irq check checks for a value != 0. This does of course
not work when the parent irq sits in the bit 0 of the parent register.
This only affects the eint0 interrupt of the s3c2412.

To fix this behaviour, check for the presence of a parent_intc in the
structure. In an s3c24xx interrupt controller either all interrupts have
parent interrupts or none have, so if a parent controller is available
the parent_irq value always points to a parent_irq.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq.c |   22 ++++++++--------------
 1 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 5257c9f..a6a7554 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -81,7 +81,7 @@ static void s3c_irq_mask(struct irq_data *data)
 	mask |= (1UL << data->hwirq);
 	__raw_writel(mask, intc->reg_mask);
 
-	if (parent_intc && irq_data->parent_irq) {
+	if (parent_intc) {
 		parent_data = &parent_intc->irqs[irq_data->parent_irq];
 
 		/* check to see if we need to mask the parent IRQ */
@@ -105,7 +105,7 @@ static void s3c_irq_unmask(struct irq_data *data)
 	mask &= ~(1UL << data->hwirq);
 	__raw_writel(mask, intc->reg_mask);
 
-	if (parent_intc && irq_data->parent_irq) {
+	if (parent_intc) {
 		irqno = irq_find_mapping(parent_intc->domain,
 					 irq_data->parent_irq);
 		s3c_irq_unmask(irq_get_irq_data(irqno));
@@ -327,6 +327,8 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 	/* attach controller pointer to irq_data */
 	irq_data->intc = intc;
 
+	parent_intc = intc->parent;
+
 	/* set handler and flags */
 	switch (irq_data->type) {
 	case S3C_IRQTYPE_NONE:
@@ -335,7 +337,7 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 		/* On the S3C2412, the EINT0to3 have a parent irq
 		 * but need the s3c_irq_eint0t4 chip
 		 */
-		if (irq_data->parent_irq && (!soc_is_s3c2412() || hw >= 4))
+		if (parent_intc && (!soc_is_s3c2412() || hw >= 4))
 			irq_set_chip_and_handler(virq, &s3c_irqext_chip,
 						 handle_edge_irq);
 		else
@@ -343,8 +345,7 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 						 handle_edge_irq);
 		break;
 	case S3C_IRQTYPE_EDGE:
-		if (irq_data->parent_irq ||
-		    intc->reg_pending == S3C2416_SRCPND2)
+		if (parent_intc || intc->reg_pending == S3C2416_SRCPND2)
 			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
 						 handle_edge_irq);
 		else
@@ -352,7 +353,7 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 						 handle_edge_irq);
 		break;
 	case S3C_IRQTYPE_LEVEL:
-		if (irq_data->parent_irq)
+		if (parent_intc)
 			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
 						 handle_level_irq);
 		else
@@ -365,14 +366,7 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 	}
 	set_irq_flags(virq, IRQF_VALID);
 
-	if (irq_data->parent_irq) {
-		parent_intc = intc->parent;
-		if (!parent_intc) {
-			pr_err("irq-s3c24xx: no parent controller found for hwirq %lu\n",
-			       hw);
-			goto err;
-		}
-
+	if (parent_intc && irq_data->type != S3C_IRQTYPE_NONE) {
 		if (irq_data->parent_irq > 31) {
 			pr_err("irq-s3c24xx: parent irq %lu is out of range\n",
 			       irq_data->parent_irq);
-- 
1.7.2.3
