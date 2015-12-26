From: eric@anholt.net (Eric Anholt)
Date: Sat, 26 Dec 2015 13:47:23 -0800
Subject: [PATCH 3/4] irqchip: bcm2836: tolerate IRQs while no flag is set in
 ISR
In-Reply-To: <1451166444-11044-1-git-send-email-eric@anholt.net>
References: <1451166444-11044-1-git-send-email-eric@anholt.net>
Message-ID: <1451166444-11044-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrea Merello <andrea.merello@gmail.com>

On my RPi2 I got a lot of:
unexpected IRQ trap at vector 00

This happens because bcm2836_arm_irqchip_handle_irq() is sometimes
invoked even if the ISR is clear, and this case is not handled.

This patch explicitly handle this case, fixing the kernel complaints
about the bad IRQ lookup.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 59ac40c..bb8f234 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -177,7 +177,7 @@ __exception_irq_entry bcm2836_arm_irqchip_handle_irq(struct pt_regs *regs)
 		writel(1 << ipi, mailbox0);
 		handle_IPI(ipi, regs);
 #endif
-	} else {
+	} else if (stat) {
 		u32 hwirq = ffs(stat) - 1;
 
 		handle_IRQ(irq_linear_revmap(intc.domain, hwirq), regs);
-- 
2.6.2
