From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 16 Nov 2017 07:53:02 +0100
Subject: [PATCH RFC] irq-bcm2836: Avoid "Invalid trigger warning"
Message-ID: <1510815182-4889-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Phil Elwell <phil@raspberrypi.org>

Initialise the level for each IRQ to avoid a warning from the
arm arch timer code:

    arch_timer: WARNING: Invalid trigger for IRQ19, assuming level low
    arch_timer: WARNING: Please fix your firmware
    arch_timer: cp15 timer(s) running at 19.20MHz (virt).

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/irqchip/irq-bcm2836.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 667b9e1..abc9b40 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -104,7 +104,7 @@ static void bcm2836_arm_irqchip_register_irq(int hwirq, struct irq_chip *chip)
 
 	irq_set_percpu_devid(irq);
 	irq_set_chip_and_handler(irq, chip, handle_percpu_devid_irq);
-	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	irq_set_status_flags(irq, IRQ_NOAUTOEN | IRQ_TYPE_LEVEL_LOW);
 }
 
 static void
-- 
2.7.4
