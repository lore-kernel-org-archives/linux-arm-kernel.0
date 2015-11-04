From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 4 Nov 2015 12:16:00 -0800
Subject: [PATCH v2 2/2] gpio: zynq: Implement irq_pm_(get|put)
In-Reply-To: <1446668160-17522-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446668160-17522-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446668160-17522-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver uses runtime PM to leverage low power techniques. For
use-cases using GPIO as interrupt the device needs to be in an
appropriate state.

Reported-by: John Linn <linnj@xilinx.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - declare callbacks static
---
 drivers/gpio/gpio-zynq.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 8abeacac5885..98197f778694 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -471,6 +471,22 @@ static int zynq_gpio_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static int zynq_gpio_irq_pm_get(struct irq_data *data)
+{
+	struct zynq_gpio *gpio = irq_data_get_irq_chip_data(data);
+	struct device *dev = gpio->chip.dev;
+
+	return pm_runtime_get_sync(dev);
+}
+
+static void zynq_gpio_irq_pm_put(struct irq_data *data)
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
+	.irq_pm_get	= zynq_gpio_irq_pm_get,
+	.irq_pm_put	= zynq_gpio_irq_pm_put,
 	.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
 			  IRQCHIP_MASK_ON_SUSPEND,
 };
@@ -492,6 +510,8 @@ static struct irq_chip zynq_gpio_edge_irqchip = {
 	.irq_unmask	= zynq_gpio_irq_unmask,
 	.irq_set_type	= zynq_gpio_set_irq_type,
 	.irq_set_wake	= zynq_gpio_set_wake,
+	.irq_pm_get	= zynq_gpio_irq_pm_get,
+	.irq_pm_put	= zynq_gpio_irq_pm_put,
 	.flags		= IRQCHIP_MASK_ON_SUSPEND,
 };
 
-- 
2.6.2.3.ga463a5b
