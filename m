From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Aug 2012 10:44:23 +0200
Subject: [PATCH 6/7] mfd/stmpe: MASK_ON_SUSPEND
Message-ID: <1345625063-5784-1-git-send-email-linus.walleij@stericsson.com>
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
 drivers/gpio/gpio-stmpe.c | 1 +
 drivers/mfd/stmpe.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index dce3472..2195abc 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -223,6 +223,7 @@ static struct irq_chip stmpe_gpio_irq_chip = {
 	.irq_mask		= stmpe_gpio_irq_mask,
 	.irq_unmask		= stmpe_gpio_irq_unmask,
 	.irq_set_type		= stmpe_gpio_irq_set_type,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static irqreturn_t stmpe_gpio_irq(int irq, void *dev)
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 2dd8d49..846b9c8 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -851,6 +851,7 @@ static struct irq_chip stmpe_irq_chip = {
 	.irq_bus_sync_unlock	= stmpe_irq_sync_unlock,
 	.irq_mask		= stmpe_irq_mask,
 	.irq_unmask		= stmpe_irq_unmask,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static int __devinit stmpe_irq_init(struct stmpe *stmpe)
-- 
1.7.11.3
