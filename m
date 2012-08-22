From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 10:44:09 +0200
Subject: [PATCH 4/7] mfd/db8500-prcmu: MASK_ON_SUSPEND
Message-ID: <1345625049-5714-1-git-send-email-linus.walleij@stericsson.com>
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
 drivers/mfd/db8500-prcmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 7040a00..25d2e9d 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2615,6 +2615,7 @@ static struct irq_chip prcmu_irq_chip = {
 	.irq_ack	= noop,
 	.irq_mask	= prcmu_irq_mask,
 	.irq_unmask	= prcmu_irq_unmask,
+	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static char *fw_project_name(u8 project)
-- 
1.7.11.3
