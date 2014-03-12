From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 12 Mar 2014 18:17:05 +0100
Subject: [PATCH v2 2/4] irqchip: sun4i: Fix irq 0 not working
In-Reply-To: <1394644627-12315-1-git-send-email-hdegoede@redhat.com>
References: <1394644627-12315-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1394644627-12315-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SUN4I_IRQ_VECTOR_REG containing 0 can mean one of 3 things:
1) no more irqs pending
2) irq 0 pending
3) spurious irq

So if we immediately get a reading of 0, check the irq-pending reg
to differentiate between 2 and 3. We only do this once to avoid
the extra check in the common case of 1) hapening after having
read the vector-reg once.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/irqchip/irq-sun4i.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index a5438d8..5c25048 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -140,10 +140,24 @@ static asmlinkage void __exception_irq_entry sun4i_handle_irq(struct pt_regs *re
 {
 	u32 irq, hwirq;
 
+	/*
+	 * hwirq == 0 can mean one of 3 things:
+	 * 1) no more irqs pending
+	 * 2) irq 0 pending
+	 * 3) spurious irq
+	 * So if we immediately get a reading of 0, check the irq-pending reg
+	 * to differentiate between 2 and 3. We only do this once to avoid
+	 * the extra check in the common case of 1 hapening after having
+	 * read the vector-reg once.
+	 */
 	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
-	while (hwirq != 0) {
+	if (hwirq == 0 &&
+		  !(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
+		return;
+
+	do {
 		irq = irq_find_mapping(sun4i_irq_domain, hwirq);
 		handle_IRQ(irq, regs);
 		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
-	}
+	} while (hwirq != 0);
 }
-- 
1.9.0
