From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Wed, 22 Jan 2014 13:39:00 +0100
Subject: [PATCH 1/2] at91: gpio: use gpiolib API to mark a GPIO used as an IRQ
Message-ID: <1390394341-12548-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
the gpiolib so we can keep track of the usage centrally.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/gpio.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index a5afcf7..6176b4b 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -577,8 +577,32 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
 	return 0;
 }
 
+static unsigned int gpio_irq_startup(struct irq_data *d)
+{
+	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
+	unsigned	pin = d->hwirq;
+	int ret;
+
+	ret = gpio_lock_as_irq(&at91_gpio->chip, pin);
+	if (ret) {
+		dev_err(at91_gpio->chip.dev, "unable to lock pind %lu IRQ\n",
+			d->hwirq);
+		return ret;
+	}
+	return 0;
+}
+static void gpio_irq_shutdown(struct irq_data *d)
+{
+	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
+	unsigned	pin = d->hwirq;
+
+	gpio_unlock_as_irq(&at91_gpio->chip, pin);
+}
+
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
+	.irq_shutdown	= gpio_irq_shutdown,
+	.irq_startup	= gpio_irq_startup,
 	.irq_disable	= gpio_irq_mask,
 	.irq_mask	= gpio_irq_mask,
 	.irq_unmask	= gpio_irq_unmask,
-- 
1.8.5.2
