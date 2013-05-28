From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 28 May 2013 17:00:57 +0200
Subject: [PATCH] ARM: mxs: icoll: Fix interrupts gpio bank 0
Message-ID: <1369753257-11091-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs interrupt controller does not support polling for interrupts,
but the driver still does it, which is a relict from
pre-MULTI_IRQ_HANDLER times.

The existing code assumes that 0x7f means no interrupt, but this value
is an actually valid irq number, namely gpio bank 0's irq. This results
in the driver not detecting when irq 0x7f is active which makes the
machine effectively dead lock.

This patch removes the interrupt poll loop and allows usage of gpio0
interrupt without an infinite loop.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Cc: stable at vger.kernel.org
---
 drivers/irqchip/irq-mxs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 29889bb..63b3d4e 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -76,16 +76,10 @@ asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
-	do {
-		irqnr = __raw_readl(icoll_base + HW_ICOLL_STAT_OFFSET);
-		if (irqnr != 0x7f) {
-			__raw_writel(irqnr, icoll_base + HW_ICOLL_VECTOR);
-			irqnr = irq_find_mapping(icoll_domain, irqnr);
-			handle_IRQ(irqnr, regs);
-			continue;
-		}
-		break;
-	} while (1);
+	irqnr = __raw_readl(icoll_base + HW_ICOLL_STAT_OFFSET);
+	__raw_writel(irqnr, icoll_base + HW_ICOLL_VECTOR);
+	irqnr = irq_find_mapping(icoll_domain, irqnr);
+	handle_IRQ(irqnr, regs);
 }
 
 static int icoll_irq_domain_map(struct irq_domain *d, unsigned int virq,
-- 
1.8.2.rc2
