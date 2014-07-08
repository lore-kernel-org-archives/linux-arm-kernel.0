From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:45:41 +0100
Subject: [PATCH v2 04/15] irqchip: armada-370-xp: convert to handle_domain_irq
In-Reply-To: <1404827141-30381-1-git-send-email-marc.zyngier@arm.com>
References: <1404827141-30381-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404827141-30381-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
Sending the right patch this time...

 drivers/irqchip/irq-armada-370-xp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 574aba0..fa75a29 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -393,13 +393,15 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 		if (!(msimask & BIT(msinr)))
 			continue;
 
-		irq = irq_find_mapping(armada_370_xp_msi_domain,
-				       msinr - 16);
-
-		if (is_chained)
+		if (is_chained) {
+			irq = irq_find_mapping(armada_370_xp_msi_domain,
+					       msinr - 16);
 			generic_handle_irq(irq);
-		else
-			handle_IRQ(irq, regs);
+		} else {
+			irq = msinr - 16;
+			handle_domain_irq(armada_370_xp_msi_domain,
+					  irq, regs);
+		}
 	}
 }
 #else
@@ -444,9 +446,8 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			break;
 
 		if (irqnr > 1) {
-			irqnr =	irq_find_mapping(armada_370_xp_mpic_domain,
-					irqnr);
-			handle_IRQ(irqnr, regs);
+			handle_domain_irq(armada_370_xp_mpic_domain,
+					  irqnr, regs);
 			continue;
 		}
 
-- 
2.0.0
