From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:29 +0100
Subject: [PATCH 06/15] irqchip: mmp: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-mmp.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 1c3e2c9..c0da57b 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -196,26 +196,24 @@ static struct mmp_intc_conf mmp2_conf = {
 
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
 {
-	int irq, hwirq;
+	int hwirq;
 
 	hwirq = readl_relaxed(mmp_icu_base + PJ1_INT_SEL);
 	if (!(hwirq & SEL_INT_PENDING))
 		return;
 	hwirq &= SEL_INT_NUM_MASK;
-	irq = irq_find_mapping(icu_data[0].domain, hwirq);
-	handle_IRQ(irq, regs);
+	handle_domain_irq(icu_data[0].domain, hwirq, regs);
 }
 
 static void __exception_irq_entry mmp2_handle_irq(struct pt_regs *regs)
 {
-	int irq, hwirq;
+	int hwirq;
 
 	hwirq = readl_relaxed(mmp_icu_base + PJ4_INT_SEL);
 	if (!(hwirq & SEL_INT_PENDING))
 		return;
 	hwirq &= SEL_INT_NUM_MASK;
-	irq = irq_find_mapping(icu_data[0].domain, hwirq);
-	handle_IRQ(irq, regs);
+	handle_domain_irq(icu_data[0].domain, hwirq, regs);
 }
 
 /* MMP (ARMv5) */
-- 
2.0.0
