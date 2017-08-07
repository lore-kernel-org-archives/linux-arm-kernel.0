From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  7 Aug 2017 13:01:55 +0200
Subject: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as IRQ
 controller
In-Reply-To: <cover.1502103715.git.michal.simek@xilinx.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
Message-ID: <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Borsodi Petr <Petr.Borsodi@i.cz>

There is a problem with GPIO driver when used as IRQ controller.
It is not working because the module is sleeping (clock is disabled).
The patch enables clocks when IP is used as IRQ controller.

Signed-off-by: Borsodi Petr <Petr.Borsodi@i.cz>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 064033803449..5198fa6e016a 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -11,6 +11,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -20,6 +21,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 
+#include "gpiolib.h"
+
 #define DRIVER_NAME "zynq-gpio"
 
 /* Maximum banks */
@@ -498,6 +501,38 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static int zynq_gpio_irq_request_resources(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	int ret;
+
+	if (!try_module_get(chip->gpiodev->owner))
+		return -ENODEV;
+
+	ret = pm_runtime_get_sync(chip->parent);
+	if (ret < 0) {
+		module_put(chip->gpiodev->owner);
+		return ret;
+	}
+
+	if (gpiochip_lock_as_irq(chip, d->hwirq)) {
+		chip_err(chip, "unable to lock HW IRQ %lu for IRQ\n", d->hwirq);
+		pm_runtime_put(chip->parent);
+		module_put(chip->gpiodev->owner);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void zynq_gpio_irq_release_resources(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+
+	gpiochip_unlock_as_irq(chip, d->hwirq);
+	pm_runtime_put(chip->parent);
+	module_put(chip->gpiodev->owner);
+}
+
 /* irq chip descriptor */
 static struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
@@ -507,6 +542,8 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_request_resources,
+	.irq_release_resources = zynq_gpio_irq_release_resources,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND,
 };
@@ -519,6 +556,8 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources = zynq_gpio_irq_request_resources,
+	.irq_release_resources = zynq_gpio_irq_release_resources,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
-- 
1.9.1
