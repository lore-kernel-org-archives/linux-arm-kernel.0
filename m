From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri,  2 Aug 2013 12:38:21 +0200
Subject: [PATCH 1/7] gpio: mxc: Support initialization as subdevice
In-Reply-To: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1375439907-10462-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx27 and imx21, there is no clear seperation between iomux control
registers and GPIO data registers. For easier pingroup definitions, the
gpio drivers will be initialized as subnodes of the iomux controller. It
is necessary to share the registers between iomux and gpio.

This patch adds support to pass a register memory region via platform
data.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpio-mxc.c                | 18 ++++++++++++++----
 include/linux/platform_data/gpio-mxc.h | 17 +++++++++++++++++
 2 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/platform_data/gpio-mxc.h

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 875a7c5..41922e8 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -27,6 +27,7 @@
 #include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/gpio-mxc.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/basic_mmio_gpio.h>
@@ -401,6 +402,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mxc_gpio_port *port;
 	struct resource *iores;
+	struct mxc_gpio_platform_data *pdata = pdev->dev.platform_data;
 	int irq_base;
 	int err;
 
@@ -410,10 +412,18 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	port->base = devm_ioremap_resource(&pdev->dev, iores);
-	if (IS_ERR(port->base))
-		return PTR_ERR(port->base);
+	if (pdata) {
+		port->base = pdata->base;
+		if (!pdata->base) {
+			dev_err(&pdev->dev, "No mapped memory in platform_data\n");
+			return -EINVAL;
+		}
+	} else {
+		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		port->base = devm_ioremap_resource(&pdev->dev, iores);
+		if (IS_ERR(port->base))
+			return PTR_ERR(port->base);
+	}
 
 	port->irq_high = platform_get_irq(pdev, 1);
 	port->irq = platform_get_irq(pdev, 0);
diff --git a/include/linux/platform_data/gpio-mxc.h b/include/linux/platform_data/gpio-mxc.h
new file mode 100644
index 0000000..fb3e06b
--- /dev/null
+++ b/include/linux/platform_data/gpio-mxc.h
@@ -0,0 +1,17 @@
+#ifndef _LINUX_GPIO_MXC_H
+#define _LINUX_GPIO_MXC_H
+
+#include <linux/types.h>
+
+/*
+ * MXC GPIO driver platform data. If this platform data is passed to the
+ * driver, it will use the memory base defined in the struct. This is used for
+ * iomuxc drivers on imx1/imx21/imx27, where the GPIO data register is embedded
+ * between iomuxc registers.
+ */
+
+struct mxc_gpio_platform_data {
+	void __iomem *base;
+};
+
+#endif /* _LINUX_GPIO_MXC_H */
-- 
1.8.3.2
