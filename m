From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  3 Jul 2011 16:16:57 +0800
Subject: [PATCH 2/2] gpio/mxc: add device tree probe support
In-Reply-To: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
References: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1309681017-22970-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds device tree probe support for gpio-mxc driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |   22 ++++++++++
 drivers/gpio/gpio-mxc.c                            |   42 +++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
new file mode 100644
index 0000000..4363ae4
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
@@ -0,0 +1,22 @@
+* Freescale i.MX/MXC GPIO controller
+
+Required properties:
+- compatible : Should be "fsl,<soc>-gpio"
+- reg : Address and length of the register set for the device
+- interrupts : Should be the port interrupt shared by all 32 pins, if
+  one number.  If two numbers, the first one is the interrupt shared
+  by low 16 pins and the second one is for high 16 pins.
+- gpio-controller : Marks the device node as a gpio controller.
+- #gpio-cells : Should be two.  The first cell is the pin number and
+  the second cell is used to specify optional parameters (currently
+  unused).
+
+Example:
+
+gpio0: gpio at 73f84000 {
+	compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+	reg = <0x73f84000 0x4000>;
+	interrupts = <50 51>;
+	gpio-controller;
+	#gpio-cells = <2>;
+};
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 7ae71d6..b42204f 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -27,6 +27,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/basic_mmio_gpio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <asm-generic/bug.h>
 
 enum mxc_gpio_type {
@@ -141,6 +143,13 @@ static struct platform_device_id mxc_gpio_devtype[] = {
 	}
 };
 
+static const struct of_device_id mxc_gpio_dt_ids[] = {
+	{ .compatible = "fsl,imx1-gpio", .data = &mxc_gpio_devdata[IMX1_GPIO], },
+	{ .compatible = "fsl,imx2-gpio", .data = &mxc_gpio_devdata[IMX2_GPIO], },
+	{ .compatible = "fsl,imx31-gpio", .data = &mxc_gpio_devdata[IMX_GPIO], },
+	{ /* sentinel */ },
+};
+
 /*
  * MX2 has one interrupt *for all* gpio ports. The list is used
  * to save the references to all ports, so that mx2_gpio_irq_handler
@@ -321,6 +330,33 @@ static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
 			       IRQ_NOREQUEST, 0);
 }
 
+#ifdef CONFIG_OF
+static int mxc_gpio_probe_dt(struct mxc_gpio_port *port,
+			     struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+			of_match_device(mxc_gpio_dt_ids, &pdev->dev);
+
+	if (!np)
+		return -ENODEV;
+
+	pdev->id = of_alias_get_id(np, "gpio");
+	if (pdev->id < 0)
+		return -ENODEV;
+
+	port->devdata = of_id->data;
+
+	return 0;
+}
+#else
+static inline int mxc_gpio_probe_dt(struct mxc_gpio_port *port,
+				    struct platform_device *pdev)
+{
+	return -ENODEV;
+}
+#endif
+
 static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct mxc_gpio_port *port;
@@ -331,7 +367,10 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 	if (!port)
 		return -ENOMEM;
 
-	port->devdata = &mxc_gpio_devdata[pdev->id_entry->driver_data];
+	err = mxc_gpio_probe_dt(port, pdev);
+	if (err == -ENODEV)
+		port->devdata = &mxc_gpio_devdata[pdev->id_entry->driver_data];
+
 	port->virtual_irq_start = MXC_GPIO_IRQ_START + pdev->id * 32;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -416,6 +455,7 @@ static struct platform_driver mxc_gpio_driver = {
 	.driver		= {
 		.name	= "gpio-mxc",
 		.owner	= THIS_MODULE,
+		.of_match_table = mxc_gpio_dt_ids,
 	},
 	.probe		= mxc_gpio_probe,
 	.id_table	= mxc_gpio_devtype,
-- 
1.7.4.1
