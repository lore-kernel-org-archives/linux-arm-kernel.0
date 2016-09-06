From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  6 Sep 2016 14:59:03 +0100
Subject: [RFC PATCH] gpio/gpiolib: Forbid irqchip default trigger if probed
 over DT
Message-ID: <1473170343-16853-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a default trigger is a bad idea if using DT to configure
interrupts, as the device's interrupt specifier will always contain
the trigger configuration.

Let's warn about that particular situation, and revert to not
having a default. Hopefully, the couple of drivers still using
this feature will quickly be fixed.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpio/gpiolib.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 53ff25a..e467ad7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1617,6 +1617,15 @@ int _gpiochip_irqchip_add(struct gpio_chip *gpiochip,
 	if (gpiochip->of_node)
 		of_node = gpiochip->of_node;
 #endif
+	/*
+	 * Specifying a default trigger is a terrible idea if DT is
+	 * used to configure the interrupts, as you may end-up with
+	 * conflicting triggers. Tell the user, and reset to NONE.
+	 */
+	if (WARN_ON(of_node && type != IRQ_TYPE_NONE,
+		    "%s: Ignoring %d default trigger\n", of_node->full_name))
+		type = IRQ_TYPE_NONE;
+
 	gpiochip->irqchip = irqchip;
 	gpiochip->irq_handler = handler;
 	gpiochip->irq_default_type = type;
-- 
2.1.4
