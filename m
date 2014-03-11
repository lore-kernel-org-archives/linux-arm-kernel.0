From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Mar 2014 16:51:00 +0100
Subject: [PATCH] irqchip: sun4i: Fix irq 0 not working
Message-ID: <1394553060-30298-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SUN4I_IRQ_VECTOR_REG containing 0 can mean one of 2 things:
1) irq 0 pending
2) no more irqs pending

So we must loop always atleast once to make irq 0 work, otherwise irq 0
will never get serviced and we end up with a hard hang because
sun4i_handle_irq gets re-entered constantly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/irqchip/irq-sun4i.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index a5438d8..3761bf1 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -140,10 +140,16 @@ static asmlinkage void __exception_irq_entry sun4i_handle_irq(struct pt_regs *re
 {
 	u32 irq, hwirq;
 
+	/*
+	 * hwirq == 0 can mean one of 2 things:
+	 * 1) irq 0 pending
+	 * 2) no more irqs pending
+	 * So loop always atleast once to make irq 0 work.
+	 */
 	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
-	while (hwirq != 0) {
+	do {
 		irq = irq_find_mapping(sun4i_irq_domain, hwirq);
 		handle_IRQ(irq, regs);
 		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
-	}
+	} while (hwirq != 0);
 }
-- 
1.9.0
