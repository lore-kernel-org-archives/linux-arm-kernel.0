From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 10:44:30 +0200
Subject: [PATCH 7/7] mfd/tc3589x: MASK_ON_SUSPEND
Message-ID: <1345625070-5820-1-git-send-email-linus.walleij@stericsson.com>
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
 drivers/gpio/gpio-tc3589x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index 2a82e89..6e48c50 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -199,6 +199,7 @@ static struct irq_chip tc3589x_gpio_irq_chip = {
 	.irq_mask		= tc3589x_gpio_irq_mask,
 	.irq_unmask		= tc3589x_gpio_irq_unmask,
 	.irq_set_type		= tc3589x_gpio_irq_set_type,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static irqreturn_t tc3589x_gpio_irq(int irq, void *dev)
-- 
1.7.11.3
