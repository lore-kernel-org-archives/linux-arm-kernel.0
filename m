From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 21 May 2012 17:23:50 +0800
Subject: [PATCH v2 05/12] usb: chipidea: add imx driver binding
In-Reply-To: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337592237-5090-6-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just add host support.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Peter Chen <peter.chen@freescale.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |   20 ++
 drivers/usb/chipidea/Makefile                      |    8 +
 drivers/usb/chipidea/ci13xxx_imx.c                 |  191 ++++++++++++++++++++
 3 files changed, 219 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
new file mode 100644
index 0000000..beb75d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -0,0 +1,20 @@
+* Freescale i.MX ci13xxx usb controllers
+
+Required properties:
+- compatible: Should be "fsl,imx31-usb"
+- reg: Should contain registers location and length
+- interrupts: Should contain controller interrupt
+
+Optional properties:
+- fsl,usbphy: phandler of usb phy that connects to the only one port
+- fsl,hub-reset-gpios: gpio used to reset on-board usb hub
+- fsl,vbus-power-gpios: gpio used to set vbus power of the only one port
+
+Examples:
+usb at 02184000 { /* USB OTG */
+	compatible = "fsl,imx6q-usb", "fsl,imx31-usb";
+	reg = <0x02184000 0x200>;
+	interrupts = <0 43 0x04>;
+	fsl,usbphy = <&usbphy1>;
+	fsl,vbus-power-gpios = <&gpio3 22 0>;
+};
diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index cc34937..ffa2f63 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -12,3 +12,11 @@ endif
 ifneq ($(CONFIG_ARCH_MSM),)
 	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
 endif
+
+ifneq ($(CONFIG_ARCH_MXC),)
+	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
+else
+  ifneq ($(CONFIG_ARCH_MXS),)
+	  obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o
+  endif
+endif
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
new file mode 100644
index 0000000..9f64b3c
--- /dev/null
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
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
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/chipidea.h>
+#include <linux/usb/ehci_def.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/chipidea.h>
+#include <linux/usb/otg.h>
+#include <linux/dma-mapping.h>
+#include <linux/clk.h>
+#include <linux/string.h>
+
+#include "ci.h"
+
+#define PORT0_STATUS	0x184
+
+#define pdev_to_phy(pdev) \
+	((struct usb_phy *)platform_get_drvdata(pdev))
+
+struct ci13xxx_imx_data {
+	struct device_node *phy_np;
+	struct usb_phy *phy;
+	struct platform_device *ci_pdev;
+	struct clk *clk;
+	int gpio_hub_rst, gpio_vbus_pwr;
+};
+
+static struct ci13xxx_udc_driver ci13xxx_imx_udc_driver __devinitdata  = {
+	.name			= "ci13xxx_imx",
+	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
+				  CI13XXX_PULLUP_ON_VBUS |
+				  CI13XXX_DISABLE_STREAMING,
+	.capoffset		= DEF_CAPOFFSET,
+};
+
+static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
+{
+	struct ci13xxx_imx_data *data;
+	struct platform_device *plat_ci, *phy_pdev;
+	struct platform_device_info ci_pdevinfo;
+	struct device_node *phy_np;
+	struct resource *res;
+	int vbus_pwr;
+	int ret;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX data!\n");
+		return -ENOMEM;
+	}
+	data->gpio_hub_rst = -1;
+	data->gpio_vbus_pwr = -1;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "can't get device resources!\n");
+		return -ENOENT;
+	}
+
+	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk)) {
+		dev_err(&pdev->dev, "Failed to get clock!\n");
+		return PTR_ERR(data->clk);
+	}
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to prepare or enable clock!\n");
+		return ret;
+	}
+
+	phy_np = of_parse_phandle(pdev->dev.of_node, "fsl,usbphy", 0);
+	if (phy_np) {
+		data->phy_np = phy_np;
+		phy_pdev = of_find_device_by_node(phy_np);
+		if (phy_pdev) {
+			struct usb_phy *phy;
+			phy = pdev_to_phy(phy_pdev);
+			if (phy &&
+			    try_module_get(phy_pdev->dev.driver->owner)) {
+				usb_phy_init(phy);
+				data->phy = phy;
+			}
+		}
+	}
+
+	/* we only support host now, so enable vbus here */
+	vbus_pwr = of_get_named_gpio(pdev->dev.of_node,
+					"fsl,vbus-power-gpios", 0);
+	if (gpio_is_valid(vbus_pwr) &&
+	    !devm_gpio_request(&pdev->dev, vbus_pwr, "vbus-pwr")) {
+		gpio_direction_output(vbus_pwr, 1);
+		data->gpio_hub_rst = vbus_pwr;
+	}
+
+	ci13xxx_imx_udc_driver.phy = data->phy;
+	memset(&ci_pdevinfo, 0, sizeof(ci_pdevinfo));
+	ci_pdevinfo.parent = &pdev->dev;
+	ci_pdevinfo.name = "ci_hdrc";
+	ci_pdevinfo.id = (int)res->start;
+	ci_pdevinfo.res = pdev->resource;
+	ci_pdevinfo.num_res = pdev->num_resources;
+	ci_pdevinfo.data = &ci13xxx_imx_udc_driver;
+	ci_pdevinfo.size_data = sizeof(ci13xxx_imx_udc_driver);
+	ci_pdevinfo.dma_mask = DMA_BIT_MASK(32);
+
+	plat_ci = platform_device_register_full(&ci_pdevinfo);
+	if (IS_ERR(plat_ci)) {
+		dev_err(&pdev->dev, "can't register ci_hdrc platform device\n");
+		ret = PTR_ERR(plat_ci);
+		goto put_np;
+	}
+
+	data->ci_pdev = plat_ci;
+	platform_set_drvdata(pdev, data);
+
+	pm_runtime_no_callbacks(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+put_np:
+	if (phy_np)
+		of_node_put(phy_np);
+	return ret;
+}
+
+static int __devexit ci13xxx_imx_remove(struct platform_device *pdev)
+{
+	struct ci13xxx_imx_data *data = platform_get_drvdata(pdev);
+
+	kfree(data->ci_pdev->dev.dma_mask);
+	data->ci_pdev->dev.dma_mask = NULL;
+	platform_device_unregister(data->ci_pdev);
+
+	if (data->gpio_vbus_pwr != -1)
+		gpio_direction_output(data->gpio_vbus_pwr, 0);
+	if (data->gpio_hub_rst != -1)
+		gpio_direction_output(data->gpio_hub_rst, 0);
+
+	if (data->phy) {
+		usb_phy_shutdown(data->phy);
+		module_put(data->phy->dev->driver->owner);
+	}
+
+	of_node_put(data->phy_np);
+
+	clk_disable_unprepare(data->clk);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id ci13xxx_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx31-usb", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ci13xxx_imx_driver = {
+	.probe = ci13xxx_imx_probe,
+	.remove = __devexit_p(ci13xxx_imx_remove),
+	.driver = {
+		.name = "imx_usb",
+		.owner = THIS_MODULE,
+		.of_match_table = ci13xxx_imx_dt_ids,
+	 },
+};
+
+module_platform_driver(ci13xxx_imx_driver);
+
+MODULE_ALIAS("platform:imx-usb");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("CI13xxx i.MX USB binding");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
-- 
1.7.5.4
