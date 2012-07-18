From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 18 Jul 2012 18:29:06 +0800
Subject: [PATCH v2 1/2] USB: chipidea: add imx usbmisc support
In-Reply-To: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1342607348-8587-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX usb controllers shares non-core registers, which may include
SoC specific controls. We take it as a usbmisc device and usbmisc
driver set operations needed by ci13xxx_imx driver.

For example, Sabrelite board has bad over-current design, we can
usbmisc to disable over-current detect.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
 .../devicetree/bindings/usb/usbmisc-imx.txt        |   12 ++
 drivers/usb/chipidea/Makefile                      |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c                 |   23 +++
 drivers/usb/chipidea/usbmisc_imx6q.c               |  161 ++++++++++++++++++++
 5 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
 create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index 2c29041..06105ce 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -8,6 +8,7 @@ Required properties:
 Optional properties:
 - fsl,usbphy: phandler of usb phy that connects to the only one port
 - vbus-supply: regulator for vbus
+- disable-over-current: disable over current detect
 
 Examples:
 usb at 02184000 { /* USB OTG */
@@ -15,4 +16,5 @@ usb at 02184000 { /* USB OTG */
 	reg = <0x02184000 0x200>;
 	interrupts = <0 43 0x04>;
 	fsl,usbphy = <&usbphy1>;
+	disable-over-current;
 };
diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
new file mode 100644
index 0000000..4fa500d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
@@ -0,0 +1,12 @@
+* Freescale i.MX non-core registers
+
+Required properties:
+- compatible: Should be one of below:
+	"fsl,imx6q-usbmisc" for imx6q
+- reg: Should contain registers location and length
+
+Examples:
+usbmisc at 02184800 {
+	compatible = "fsl,imx6q-usbmisc";
+	reg = <0x02184800 0x200>;
+};
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 5c66d9c..57e510f 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -15,5 +15,5 @@ ifneq ($(CONFIG_PCI),)
 endif
 
 ifneq ($(CONFIG_OF_DEVICE),)
-	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
+	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx6q.o
 endif
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index ef60d06..e790c0e 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 
 #include "ci.h"
+#include "ci13xxx_imx.h"
 
 #define pdev_to_phy(pdev) \
 	((struct usb_phy *)platform_get_drvdata(pdev))
@@ -34,6 +35,25 @@ struct ci13xxx_imx_data {
 	struct regulator *reg_vbus;
 };
 
+static const struct usbmisc_ops *usbmisc_ops;
+
+int usbmisc_set_ops(const struct usbmisc_ops *ops)
+{
+	if (usbmisc_ops)
+		return -EBUSY;
+
+	usbmisc_ops = ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usbmisc_set_ops);
+
+void usbmisc_unset_ops(const struct usbmisc_ops *ops)
+{
+	usbmisc_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(usbmisc_unset_ops);
+
 static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
 	.name			= "ci13xxx_imx",
 	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
@@ -120,6 +140,9 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
 	}
+
+	usbmisc_ops->init(&pdev->dev);
+
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				&ci13xxx_imx_platdata);
diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx6q.c
new file mode 100644
index 0000000..9f69a8c
--- /dev/null
+++ b/drivers/usb/chipidea/usbmisc_imx6q.c
@@ -0,0 +1,161 @@
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
+#include <linux/io.h>
+
+#include "ci13xxx_imx.h"
+
+#define USB_DEV_MAX 4
+
+#define BM_OVER_CUR_DIS		BIT(7)
+
+struct imx6q_usbmisc {
+	void __iomem *base;
+	struct clk *clk;
+	struct device *usb_dev[USB_DEV_MAX];
+	spinlock_t lock;
+
+	int disable_oc:USB_DEV_MAX;
+};
+
+static struct imx6q_usbmisc *usbmisc;
+
+static int get_index(struct device *dev)
+{
+	int i, id = -1;
+
+	for (i = 0; i < USB_DEV_MAX; i ++) {
+		if (usbmisc->usb_dev[i] == dev) {
+			id = i;
+			break;
+		}
+	}
+
+	if (id != -1)
+		return id;
+
+	id = of_alias_get_id(dev->of_node, "usb");
+	if (id < 0)
+		dev_err(dev, "failed to get alias id, errno %d\n", id);
+	return id;
+}
+
+static int usbmisc_imx6q_init(struct device *usb_dev)
+{
+
+	int id;
+	u32 reg;
+	struct device_node *usb_np;
+	unsigned long flags;
+
+	id = get_index(usb_dev);
+	if (id < 0)
+		return id;
+
+	usb_np = usb_dev->of_node;
+	if (of_find_property(usb_np, "disable-over-current", NULL)) {
+		spin_lock_irqsave(&usbmisc->lock, flags);
+		usbmisc->disable_oc |= BIT(id);
+		reg = readl(usbmisc->base + id * 4);
+		writel(reg | BM_OVER_CUR_DIS, usbmisc->base + id * 4);
+		spin_unlock_irqrestore(&usbmisc->lock, flags);
+	}
+
+	return 0;
+}
+
+static const struct usbmisc_ops imx6q_usbmisc_ops = {
+	.init = usbmisc_imx6q_init,
+};
+
+static const struct of_device_id usbmisc_imx6q_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-usbmisc"},
+	{ /* sentinel */ }
+};
+
+static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
+{
+	struct resource	*res;
+	struct imx6q_usbmisc *data;
+	int ret;
+
+	if (usbmisc)
+		return -EBUSY;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	spin_lock_init(&data->lock);
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
+	if (ret) {
+		dev_err(&pdev->dev,
+			"clk_prepare_enable failed, err=%d\n", ret);
+		return ret;
+	}
+
+	ret = usbmisc_set_ops(&imx6q_usbmisc_ops);
+	if (ret)
+		return ret;
+
+	usbmisc = data;
+
+	return 0;
+}
+
+static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
+{
+	usbmisc_unset_ops(&imx6q_usbmisc_ops);
+	clk_disable_unprepare(usbmisc->clk);
+	return 0;
+}
+
+static struct platform_driver usbmisc_imx6q_driver = {
+	.probe = usbmisc_imx6q_probe,
+	.remove = __devexit_p(usbmisc_imx6q_remove),
+	.driver = {
+		.name = "usbmisc_imx6q",
+		.owner = THIS_MODULE,
+		.of_match_table = usbmisc_imx6q_dt_ids,
+	 },
+};
+
+static int __init usbmisc_imx6q_drv_init(void)
+{
+	return platform_driver_register(&usbmisc_imx6q_driver);
+}
+subsys_initcall(usbmisc_imx6q_drv_init);
+
+static void __exit usbmisc_imx6q_drv_exit(void)
+{
+	platform_driver_unregister(&usbmisc_imx6q_driver);
+}
+module_exit(usbmisc_imx6q_drv_exit);
+MODULE_ALIAS("platform:usbmisc-imx6q"); MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("i.MX6Q non-core usb register handling");
+MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
-- 
1.7.9.5
