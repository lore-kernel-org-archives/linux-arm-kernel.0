From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 23 Oct 2015 06:36:21 -0700
Subject: [PATCH] gpio: zynq: Implement irq_(request|release)_resources
Message-ID: <1445607381-7794-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver uses runtime PM to leverage low power techniques. For
use-cases using GPIO as interrupt the device needs to be in an
appropriate state.

Reported-by: John Linn <linnj@xilinx.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: John Linn <linnj@xilinx.com>
---
 drivers/gpio/gpio-zynq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 8abeacac5885..0d1669416112 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -471,6 +471,22 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+int zynq_gpio_irq_request_resources(struct irq_data *data)
+{
+	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct device *dev = gpio->chip.dev;
+
+	return pm_runtime_get_sync(dev);
+}
+
+void zynq_gpio_irq_release_resources(struct irq_data *data)
+{
+	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct device *dev = gpio->chip.dev;
+
+	pm_runtime_put(dev);
+}
+
 /* irq chip descriptor */
 static struct irq_chip zynq_gpio_level_irqchip = {
 	.name		= DRIVER_NAME,
@@ -480,6 +496,8 @@ static struct irq_chip zynq_gpio_level_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources	= zynq_gpio_irq_request_resources,
+	.irq_release_resources	= zynq_gpio_irq_release_resources,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND,
 };
@@ -492,6 +510,8 @@ static struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_request_resources	= zynq_gpio_irq_request_resources,
+	.irq_release_resources	= zynq_gpio_irq_release_resources,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
-- 
2.6.2.3.ga463a5b
