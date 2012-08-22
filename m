From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 10:43:56 +0200
Subject: [PATCH 2/7] mfd/ab8500: MASK_ON_SUSPEND
Message-ID: <1345625036-5643-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Etienne Carriere <etienne.carriere@stericsson.com>

ux500 machines performs pins (GPIO) reconfiguration when entering
in the suspended mode. This reconfiguration aims at reaching an ultra
low power HW configuration.

Due to this HW reconfiguration, some HW devices can change of HW state
and have their output signals at level that could generate IRQs.

If the non-wakeup IRQs are disabled but not yet masked (delayed interrupt
disable feature from the generic irq layer), effective interrupts reach
the system only because the system attempt to enter the suspended mode.

To prevent such IRQs to trig, all irq chips embedded in ux500 platform
should enable their IRQCHIP_MASK_ON_SUSPEND flag.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Etienne Carriere <etienne.carriere@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab8500-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 626b4ec..b25a0b0 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -386,6 +386,7 @@ static struct irq_chip ab8500_irq_chip = {
 	.irq_mask		= ab8500_irq_mask,
 	.irq_disable		= ab8500_irq_mask,
 	.irq_unmask		= ab8500_irq_unmask,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static int ab8500_handle_hierarchical_line(struct ab8500 *ab8500,
-- 
1.7.11.3
