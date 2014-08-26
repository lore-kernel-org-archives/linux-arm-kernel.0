From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Aug 2014 11:03:34 +0100
Subject: [PATCH v2 19/26] irqchip: atmel-aic: convert to handle_domain_irq
In-Reply-To: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
References: <1409047421-27649-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1409047421-27649-20-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-atmel-aic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index a82869e..9a2cf3c 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -68,12 +68,10 @@ aic_handle(struct pt_regs *regs)
 	irqnr = irq_reg_readl(gc->reg_base + AT91_AIC_IVR);
 	irqstat = irq_reg_readl(gc->reg_base + AT91_AIC_ISR);
 
-	irqnr = irq_find_mapping(aic_domain, irqnr);
-
 	if (!irqstat)
 		irq_reg_writel(0, gc->reg_base + AT91_AIC_EOICR);
 	else
-		handle_IRQ(irqnr, regs);
+		handle_domain_irq(aic_domain, irqnr, regs);
 }
 
 static int aic_retrigger(struct irq_data *d)
-- 
2.0.4
