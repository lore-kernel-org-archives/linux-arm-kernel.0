From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 15:01:52 +0800
Subject: [PATCH 12/12] USB: chipidea: add imx usbmisc support
In-Reply-To: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX usb controllers shares non-core registers, which may include
SoC specific controls. We take it as a usbmisc device and usbmisc
driver export functions needed by ci13xxx_imx driver.

For example, Sabrelite board has bad over-current design, we can
usbmisc to disable over-current detect.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 .../devicetree/bindings/usb/imx-usbmisc.txt        |   15 ++
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |    4 +
 drivers/usb/chipidea/imx_usbmisc.c                 |  144 ++++++++++++++++++++
 4 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/imx-usbmisc.txt
 create mode 100644 drivers/usb/chipidea/imx_usbmisc.c

diff --git a/Documentation/devicetree/bindings/usb/imx-usbmisc.txt b/Documentation/devicetree/bindings/usb/imx-usbmisc.txt
new file mode 100644
index 0000000..09f01ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/imx-usbmisc.txt
@@ -0,0 +1,15 @@
+* Freescale i.MX non-core registers
+
+Required properties:
+- compatible: Should be "fsl,imx6q-usbmisc"
+- reg: Should contain registers location and length
+
+Optional properties:
+- fsl,disable-over-current: disable over current detect
+
+Examples:
+usbmisc at 02184800 {
+	compatible = "fsl,imx6q-usbmisc";
+	reg = <0x02184800 0x200>;
+	fsl,disable-over-current;
+};
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 3f56b76..46fc31c 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -17,5 +17,5 @@ ifneq ($(CONFIG_PCI),)
 endif
 
 ifneq ($(CONFIG_OF_DEVICE),)
-	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
+	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o imx_usbmisc.o
 endif
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index b3173d8..dd7f3a3 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -24,6 +24,8 @@
 
 #include "ci.h"
 
+int imx_usbmisc_init(struct device *usbdev);
+
 #define pdev_to_phy(pdev) \
 	((struct usb_phy *)platform_get_drvdata(pdev))
 #define ci_to_imx_data(ci) \
@@ -142,6 +144,8 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
 	}
 
+	imx_usbmisc_init(&pdev->dev);
+
 	platform_set_drvdata(pdev, data);
 
 	plat_ci = ci13xxx_add_device(&pdev->dev,
diff --git a/drivers/usb/chipidea/imx_usbmisc.c b/drivers/usb/chipidea/imx_usbmisc.c
new file mode 100644
index 0000000..33a8ec0
--- /dev/null
+++ b/drivers/usb/chipidea/imx_usbmisc.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <asm/io.h>
+
+struct usbmisc;
+
+struct soc_data {
+	int (*init) (struct usbmisc *usbmisc, int id);
+	void (*exit) (struct usbmisc *usbmisc, int id);
+};
+
+struct usbmisc {
+	struct soc_data *soc_data;
+	void __iomem *base;
+	struct clk *clk;
+
+	int dis_oc:1;
+};
+
+/* Since we only have one usbmisc device at runtime, we global variables */
+static struct usbmisc *usbmisc;
+
+static int imx6q_usbmisc_init(struct usbmisc *usbmisc, int id)
+{
+	u32 reg;
+
+	if (usbmisc->dis_oc) {
+		reg = readl_relaxed(usbmisc->base + id * 4);
+		writel_relaxed(reg | (1 << 7), usbmisc->base + id * 4);
+	}
+
+	return 0;
+}
+
+static struct soc_data imx6q_data = {
+	.init = imx6q_usbmisc_init,
+};
+
+
+static const struct of_device_id imx_usbmisc_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-usbmisc", .data = &imx6q_data },
+	{ /* sentinel */ }
+};
+
+static int __devinit imx_usbmisc_probe(struct platform_device *pdev)
+{
+	struct resource	*res;
+	struct usbmisc *data;
+	const struct of_device_id *of_id =
+			of_match_device(imx_usbmisc_dt_ids, &pdev->dev);
+
+	int ret;
+
+	if (usbmisc)
+		return -EBUSY;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!data->base)
+		return -EADDRNOTAVAIL;
+
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk)) {
+		dev_err(&pdev->dev,
+			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
+		return PTR_ERR(data->clk);
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (!ret) {
+		if (of_find_property(pdev->dev.of_node,
+			"fsl,disable-over-current", NULL))
+			data->dis_oc = 1;
+		data->soc_data = of_id->data;
+		usbmisc = data;
+	}
+
+	return ret;
+}
+
+static int __devexit imx_usbmisc_remove(struct platform_device *pdev)
+{
+	clk_disable_unprepare(usbmisc->clk);
+	return 0;
+}
+
+static struct platform_driver imx_usbmisc_driver = {
+	.probe = imx_usbmisc_probe,
+	.remove = __devexit_p(imx_usbmisc_remove),
+	.driver = {
+		.name = "imx_usbmisc",
+		.owner = THIS_MODULE,
+		.of_match_table = imx_usbmisc_dt_ids,
+	 },
+};
+
+int imx_usbmisc_init(struct device *usbdev)
+{
+	struct device_node *np = usbdev->of_node;
+	int ret;
+
+	if (!usbmisc)
+		return 0;
+
+	ret = of_alias_get_id(np, "usb");
+	if (ret < 0) {
+		dev_err(usbdev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+
+	return usbmisc->soc_data->init(usbmisc, ret);
+}
+EXPORT_SYMBOL_GPL(imx_usbmisc_init);
+
+static int __init imx_usbmisc_drv_init(void)
+{
+	return platform_driver_register(&imx_usbmisc_driver);
+}
+subsys_initcall(imx_usbmisc_drv_init);
+
+static void __exit imx_usbmisc_drv_exit(void)
+{
+	platform_driver_unregister(&imx_usbmisc_driver);
+}
+module_exit(imx_usbmisc_drv_exit);
+
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5
