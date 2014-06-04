From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed,  4 Jun 2014 13:37:05 +0100
Subject: [PATCH] irqchip: nvic: Use the generic noop function
Message-ID: <1401885425-12378-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the generic function saves looking up this custom one in a source
navigator.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 drivers/irqchip/irq-nvic.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index 70bdf6e..c935c61 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -49,14 +49,6 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 	handle_IRQ(irq, regs);
 }
 
-static void nvic_eoi(struct irq_data *d)
-{
-	/*
-	 * This is a no-op as end of interrupt is signaled by the exception
-	 * return sequence.
-	 */
-}
-
 static int __init nvic_of_init(struct device_node *node,
 			       struct device_node *parent)
 {
@@ -102,7 +94,7 @@ static int __init nvic_of_init(struct device_node *node,
 		gc->chip_types[0].regs.disable = NVIC_ICER;
 		gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
 		gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
-		gc->chip_types[0].chip.irq_eoi = nvic_eoi;
+		gc->chip_types[0].chip.irq_eoi = irq_gc_noop;
 
 		/* disable interrupts */
 		writel_relaxed(~0, gc->reg_base + NVIC_ICER);
-- 
1.9.0
