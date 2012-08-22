From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 10:44:02 +0200
Subject: [PATCH 3/7] gpio/ab8500: MASK_ON_SUSPEND
Message-ID: <1345625042-5678-1-git-send-email-linus.walleij@stericsson.com>
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

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Etienne Carriere <etienne.carriere@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-ab8500.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-ab8500.c b/drivers/gpio/gpio-ab8500.c
index 050c05d..3d2cd66 100644
--- a/drivers/gpio/gpio-ab8500.c
+++ b/drivers/gpio/gpio-ab8500.c
@@ -203,6 +203,7 @@ static struct gpio_chip ab8500gpio_chip = {
 	.direction_output	= ab8500_gpio_direction_output,
 	.set			= ab8500_gpio_set,
 	.to_irq			= ab8500_gpio_to_irq,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static unsigned int irq_to_rising(unsigned int irq)
-- 
1.7.11.3
