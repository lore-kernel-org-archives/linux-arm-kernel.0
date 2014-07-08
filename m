From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:28 +0100
Subject: [PATCH 05/15] irqchip: clps711x: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-clps711x.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 33340dc..33127f1 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -76,24 +76,20 @@ static struct {
 
 static asmlinkage void __exception_irq_entry clps711x_irqh(struct pt_regs *regs)
 {
-	u32 irqnr, irqstat;
+	u32 irqstat;
 
 	do {
 		irqstat = readw_relaxed(clps711x_intc->intmr[0]) &
 			  readw_relaxed(clps711x_intc->intsr[0]);
-		if (irqstat) {
-			irqnr =	irq_find_mapping(clps711x_intc->domain,
-						 fls(irqstat) - 1);
-			handle_IRQ(irqnr, regs);
-		}
+		if (irqstat)
+			handle_domain_irq(clps711x_intc->domain,
+					  fls(irqstat) - 1, regs);
 
 		irqstat = readw_relaxed(clps711x_intc->intmr[1]) &
 			  readw_relaxed(clps711x_intc->intsr[1]);
-		if (irqstat) {
-			irqnr =	irq_find_mapping(clps711x_intc->domain,
-						 fls(irqstat) - 1 + 16);
-			handle_IRQ(irqnr, regs);
-		}
+		if (irqstat)
+			handle_domain_irq(clps711x_intc->domain,
+					  fls(irqstat) - 1 + 16, regs);
 	} while (irqstat);
 }
 
-- 
2.0.0
