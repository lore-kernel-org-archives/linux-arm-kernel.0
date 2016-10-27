From: eric@anholt.net (Eric Anholt)
Date: Thu, 27 Oct 2016 09:40:51 -0700
Subject: [PATCH] irq-bcm2836: Prevent spurious interrupts, and trap them early
In-Reply-To: <20161027164051.22493-1-eric@anholt.net>
References: <20161027164051.22493-1-eric@anholt.net>
Message-ID: <20161027164051.22493-2-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Elwell <phil@raspberrypi.org>

The old arch-specific IRQ macros included a dsb to ensure the
write to clear the mailbox interrupt completed before returning
from the interrupt. The BCM2836 irqchip driver needs the same
precaution to avoid spurious interrupts.

Spurious interrupts are still possible for other reasons,
though, so trap them early.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Eric Anholt <eric@anholt.net>
---

Phil, your patch didn't apply because it looks like you pasted into
gmail (tabs got converted to spaces).  git-send-email can avoid that.
I've pulled it out of the rpi tree and applied the s-o-b from your
email.

Also, patches to lkml need to be sent to the relevant maintainers or
they won't get picked up.  ./scripts/get_maintainer.pl <patch> can
give you the list of who to send to/cc.

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
