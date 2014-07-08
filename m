From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:34 +0100
Subject: [PATCH 11/15] irqchip: sun4i: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-sun4i.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 6fcef4a..64155b6 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -136,7 +136,7 @@ IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-	u32 irq, hwirq;
+	u32 hwirq;
 
 	/*
 	 * hwirq == 0 can mean one of 3 things:
@@ -154,8 +154,7 @@ static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 		return;
 
 	do {
-		irq = irq_find_mapping(sun4i_irq_domain, hwirq);
-		handle_IRQ(irq, regs);
+		handle_domain_irq(sun4i_irq_domain, hwirq, regs);
 		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
 	} while (hwirq != 0);
 }
-- 
2.0.0
