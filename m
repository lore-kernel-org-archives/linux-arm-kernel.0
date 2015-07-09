From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Jul 2015 14:19:09 +0100
Subject: [PATCH 4/6] irqchip: GIC: Use chip_data instead of handler_data for
 cascaded interrupts
In-Reply-To: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
References: <1436447951-22357-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436447951-22357-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When used as a primary interrupt controller, the GIC driver uses
irq_data->chip_data to extract controller-specific information.

When used as a secondary interrupt controller, it uses handler_data
instead. As this difference is relatively pointless and only creates
confusion, change the secondary path to match what the rest of the
driver does.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e264675..3c7f3a4 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -298,7 +298,7 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 
 static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 {
-	struct gic_chip_data *chip_data = irq_get_handler_data(irq);
+	struct gic_chip_data *chip_data = irq_get_chip_data(irq);
 	struct irq_chip *chip = irq_get_chip(irq);
 	unsigned int cascade_irq, gic_irq;
 	unsigned long status;
@@ -341,7 +341,7 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
 {
 	if (gic_nr >= MAX_GIC_NR)
 		BUG();
-	if (irq_set_handler_data(irq, &gic_data[gic_nr]) != 0)
+	if (irq_set_chip_data(irq, &gic_data[gic_nr]) != 0)
 		BUG();
 	irq_set_chained_handler(irq, gic_handle_cascade_irq);
 }
-- 
2.1.4
