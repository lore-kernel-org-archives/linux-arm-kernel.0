From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Oct 2014 10:09:36 +0100
Subject: [PATCH] irqchip: hip04: Convert to handle_domain_irq
Message-ID: <1413882576-18922-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HIP04 GIC-like irqchip escaped the conversion to handle_domain_irq.
Let's give it the treatment it deserves.

Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-hip04.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 9c8f8335..29b8f21 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -176,8 +176,7 @@ static void __exception_irq_entry hip04_handle_irq(struct pt_regs *regs)
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
 		if (likely(irqnr > 15 && irqnr <= HIP04_MAX_IRQS)) {
-			irqnr = irq_find_mapping(hip04_data.domain, irqnr);
-			handle_IRQ(irqnr, regs);
+			handle_domain_irq(hip04_data.domain, irqnr, regs);
 			continue;
 		}
 		if (irqnr < 16) {
-- 
2.0.4
