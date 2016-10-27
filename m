From: eric@anholt.net (Eric Anholt)
Date: Thu, 27 Oct 2016 11:20:38 -0700
Subject: [PATCH v2] irqchip/bcm2836: Prevent spurious interrupts
Message-ID: <20161027182038.11312-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Elwell <phil@raspberrypi.org>

The old arch-specific IRQ macros included a dsb to ensure the
write to clear the mailbox interrupt completed before returning
from the interrupt. The BCM2836 irqchip driver needs the same
precaution to avoid spurious interrupts.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2836.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index d96b2c947e74..93e3f7660c42 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -175,6 +175,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 		u32 ipi = ffs(mbox_val) - 1;
 
 		writel(1 << ipi, mailbox0);
+		dsb(sy);
 		handle_IPI(ipi, regs);
 #endif
 	} else if (stat) {
-- 
2.9.3
