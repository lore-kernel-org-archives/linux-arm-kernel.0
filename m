From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:20 +0800
Subject: [PATCH v1 4/7] usb: chipidea: add imx driver binding
In-Reply-To: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337090303-16046-5-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/usb/chipidea/Makefile      |    2 +-
 drivers/usb/chipidea/ci13xxx_imx.c |  177 ++++++++++++++++++++++++++++++++++++
 2 files changed, 178 insertions(+), 1 deletions(-)
 create mode 100644 drivers/usb/chipidea/ci13xxx_imx.c

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 0f34c0c..6821385 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -14,5 +14,5 @@ ifneq ($(CONFIG_ARCH_MSM),)
 endif
 
 ifneq ($(CONFIG_ARCH_MXC),)
-	obj-$(CONFIG_USB_CHIPIDEA)	+= phy-imx-utmi.o
+	obj-$(CONFIG_USB_CHIPIDEA)	+= phy-imx-utmi.o ci13xxx_imx.o
 endif
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
new file mode 100644
index 0000000..5f36f07
--- /dev/null
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -0,0 +1,177 @@
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
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/ulpi.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/chipidea.h>
+#include <linux/usb/otg.h>
+#include <linux/dma-mapping.h>
+
+#include "ci.h"
+
+#define pdev_to_phy(pdev) \
+	((struct usb_phy *)platform_get_drvdata(pdev))
+
+static void ci13xxx_imx_notify_event(struct ci13xxx *udc, unsigned event)
+{
+#if 0
+	struct device *dev = udc->gadget.dev.parent;
+	int val;
+
+	switch (event) {
+	case CI13XXX_CONTROLLER_RESET_EVENT:
+		dev_dbg(dev, "CI13XXX_CONTROLLER_RESET_EVENT received\n");
+		writel(0, USB_AHBBURST);
+		writel(0, USB_AHBMODE);
+		break;
+	case CI13XXX_CONTROLLER_STOPPED_EVENT:
+		dev_dbg(dev, "CI13XXX_CONTROLLER_STOPPED_EVENT received\n");
+		/*
+		 * Put the transceiver in non-driving mode. Otherwise host
+		 * may not detect soft-disconnection.
+		 */
+		val = usb_phy_io_read(udc->transceiver, ULPI_FUNC_CTRL);
+		val &= ~ULPI_FUNC_CTRL_OPMODE_MASK;
+		val |= ULPI_FUNC_CTRL_OPMODE_NONDRIVING;
+		usb_phy_io_write(udc->transceiver, val, ULPI_FUNC_CTRL);
+		break;
+	default:
+		dev_dbg(dev, "unknown ci13xxx_udc event\n");
+		break;
+	}
+#endif
+}
+
+static struct ci13xxx_udc_driver ci13xxx_imx_udc_driver = {
+	.name			= "ci13xxx_imx",
+	.flags			= CI13XXX_REGS_SHARED |
+				  CI13XXX_PULLUP_ON_VBUS |
+				  CI13XXX_DISABLE_STREAMING,
+	.capoffset		= 0x100,
+
+	.notify_event		= ci13xxx_imx_notify_event,
+};
+
+static int ci13xxx_imx_probe(struct platform_device *pdev)
+{
+	struct platform_device *plat_ci, *phy_pdev;
+	struct device_node *phy_np;
+	struct resource *res;
+	int hub_reset, vbus_pwr;
+	int ret;
+
+	dev_dbg(&pdev->dev, "ci13xxx_imx_probe\n");
+
+	phy_np = of_parse_phandle(pdev->dev.of_node, "fsl,usbphy", 0);
+	if (phy_np) {
+		phy_pdev = of_find_device_by_node(phy_np);
+		if (phy_pdev) {
+			struct usb_phy *phy;
+			phy = pdev_to_phy(phy_pdev);
+			if (phy)
+				usb_phy_init(phy);
+		}
+		of_node_put(phy_np);
+	}
+
+	hub_reset = of_get_named_gpio(pdev->dev.of_node, "fsl,hub-reset", 0);
+	if (hub_reset > 0 &&
+	    devm_gpio_request(&pdev->dev, hub_reset, "hub-reset")) {
+		gpio_direction_output(hub_reset, 0);
+		udelay(10);
+		gpio_direction_output(hub_reset, 1);
+	}
+
+	/* we only support host now, so enable vbus here */
+	vbus_pwr = of_get_named_gpio(pdev->dev.of_node, "fsl,vbus-power", 0);
+	if (vbus_pwr > 0 &&
+	    devm_gpio_request(&pdev->dev, vbus_pwr, "vbus-pwr")) {
+		gpio_direction_output(vbus_pwr, 1);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "can't get device resources\n");
+		return -ENOENT;
+	}
+
+	plat_ci = platform_device_alloc("ci_hdrc", (int)res->start);
+	if (!plat_ci) {
+		dev_err(&pdev->dev, "can't allocate ci_hdrc platform device\n");
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add_resources(plat_ci, pdev->resource,
+					    pdev->num_resources);
+	if (ret) {
+		dev_err(&pdev->dev, "can't add resources to platform device\n");
+		goto put_platform;
+	}
+
+	ret = platform_device_add_data(plat_ci, &ci13xxx_imx_udc_driver,
+				       sizeof(ci13xxx_imx_udc_driver));
+	if (ret)
+		goto put_platform;
+
+	plat_ci->dev.dma_mask =
+		kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+	if (!plat_ci->dev.dma_mask) {
+		ret = -ENOMEM;
+		goto put_platform;
+	}
+	*plat_ci->dev.dma_mask = DMA_BIT_MASK(32);
+	plat_ci->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+
+	ret = platform_device_add(plat_ci);
+	if (ret)
+		goto free_dma_mask;
+
+	pm_runtime_no_callbacks(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+free_dma_mask:
+	kfree(plat_ci->dev.dma_mask);
+	plat_ci->dev.dma_mask = NULL;
+put_platform:
+	platform_device_put(plat_ci);
+
+	return ret;
+}
+
+static const struct of_device_id ci13xxx_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-usboh3", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver ci13xxx_imx_driver = {
+	.probe = ci13xxx_imx_probe,
+	.driver = {
+		.name = "imx_usboh3",
+		.of_match_table = ci13xxx_imx_dt_ids,
+	 },
+};
+
+MODULE_ALIAS("platform:imx_usboh3");
+
+static int __init ci13xxx_imx_init(void)
+{
+	return platform_driver_register(&ci13xxx_imx_driver);
+}
+module_init(ci13xxx_imx_init);
+
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
