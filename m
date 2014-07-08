From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:32 +0100
Subject: [PATCH 09/15] irqchip: s3c24xx: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-s3c24xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 78a6acc..c8d373f 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -339,7 +339,6 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 {
 	int pnd;
 	int offset;
-	int irq;
 
 	pnd = __raw_readl(intc->reg_intpnd);
 	if (!pnd)
@@ -365,8 +364,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 	if (!(pnd & (1 << offset)))
 		offset =  __ffs(pnd);
 
-	irq = irq_find_mapping(intc->domain, intc_offset + offset);
-	handle_IRQ(irq, regs);
+	handle_domain_irq(intc->domain, intc_offset + offset, regs);
 	return true;
 }
 
-- 
2.0.0
