From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 27 Dec 2016 18:29:57 +0000
Subject: [PATCH] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Message-ID: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICOLL controller doesn't provide any facility to configure the
wakeup sources. That's the reason why this implementation lacks
the irq_set_wake implementation. But this prevent us from properly
entering power management states like "suspend to idle".

So enable the flags IRQCHIP_SKIP_SET_WAKE and
IRQCHIP_MASK_ON_SUSPEND to let the irqchip core allows and handles
the power management.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/irqchip/irq-mxs.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 1730470..05fa9f7 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -131,12 +131,16 @@ static void asm9260_unmask_irq(struct irq_data *d)
 	.irq_ack = icoll_ack_irq,
 	.irq_mask = icoll_mask_irq,
 	.irq_unmask = icoll_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 static struct irq_chip asm9260_icoll_chip = {
 	.irq_ack = icoll_ack_irq,
 	.irq_mask = asm9260_mask_irq,
 	.irq_unmask = asm9260_unmask_irq,
+	.flags = IRQCHIP_MASK_ON_SUSPEND |
+		 IRQCHIP_SKIP_SET_WAKE,
 };
 
 asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
-- 
1.7.9.5
