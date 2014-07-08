From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:31 +0100
Subject: [PATCH 08/15] irqchip: orion: convert to handle_domain_irq
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new handle_domain_irq method to handle interrupts.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-orion.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 34d18b4..ad0c0f6 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -43,9 +43,8 @@ __exception_irq_entry orion_handle_irq(struct pt_regs *regs)
 			gc->mask_cache;
 		while (stat) {
 			u32 hwirq = __fls(stat);
-			u32 irq = irq_find_mapping(orion_irq_domain,
-						   gc->irq_base + hwirq);
-			handle_IRQ(irq, regs);
+			handle_domain_irq(orion_irq_domain,
+					  gc->irq_base + hwirq, regs);
 			stat &= ~(1 << hwirq);
 		}
 	}
-- 
2.0.0
