From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 30 Nov 2014 01:02:04 +0300
Subject: [PATCH v2 2/3] usb: phy: add lubbock phy driver
In-Reply-To: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract lubbock-specific code from pxa25x_udc driver. As a bonus, phy
driver determines connector/VBUS status by reading CPLD register. Also
it uses a work to call into udc stack, instead of pinging vbus session
right from irq handler.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/phy/Kconfig       |  10 ++
 drivers/usb/phy/Makefile      |   1 +
 drivers/usb/phy/phy-lubbock.c | 220 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 drivers/usb/phy/phy-lubbock.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 0cd1f44..98b1682 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -137,6 +137,16 @@ config USB_ISP1301
 	  To compile this driver as a module, choose M here: the
 	  module will be called phy-isp1301.
 
+config USB_LUBBOCK
+	tristate "USB VBUS PHY Driver for DBPXA250 Lubbock platform"
+	depends on ARCH_LUBBOCK
+	help
+	  Say Y here to add support for the USB Gadget VBUS tranceiver driver
+	  for DBPXA250 (Lubbock) platform.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called phy-lubbock.
+
 config USB_MSM_OTG
 	tristate "Qualcomm on-chip USB OTG controller support"
 	depends on (USB || USB_GADGET) && (ARCH_MSM || ARCH_QCOM || COMPILE_TEST)
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index 75f2bba..0fe461c 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_TWL6030_USB)		+= phy-twl6030-usb.o
 obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
 obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
 obj-$(CONFIG_USB_ISP1301)		+= phy-isp1301.o
+obj-$(CONFIG_USB_LUBBOCK)		+= phy-lubbock.o
 obj-$(CONFIG_USB_MSM_OTG)		+= phy-msm-usb.o
 obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
 obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
diff --git a/drivers/usb/phy/phy-lubbock.c b/drivers/usb/phy/phy-lubbock.c
new file mode 100644
index 0000000..f73c1a6
--- /dev/null
+++ b/drivers/usb/phy/phy-lubbock.c
@@ -0,0 +1,220 @@
+/*
+ * gpio-lubbock.c - VBUS handling code for DBPXA250 platform (lubbock)
+ *
+ * Based on lubbock-vbus.c:
+ * Copyright (c) 2008 Philipp Zabel <philipp.zabel@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/usb.h>
+
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+
+#include <mach/hardware.h>
+#include <mach/lubbock.h>
+
+struct lubbock_vbus_data {
+	struct usb_phy		phy;
+	struct device          *dev;
+	int			vbus;
+};
+
+static int is_vbus_powered(void)
+{
+	return !(LUB_MISC_RD && BIT(9));
+}
+
+static void lubbock_vbus_handle(struct lubbock_vbus_data *lubbock_vbus)
+{
+	int status, vbus;
+
+	if (!lubbock_vbus->phy.otg->gadget)
+		return;
+
+	vbus = is_vbus_powered();
+	if ((vbus ^ lubbock_vbus->vbus) == 0)
+		return;
+	lubbock_vbus->vbus = vbus;
+
+	if (vbus) {
+		status = USB_EVENT_VBUS;
+		lubbock_vbus->phy.state = OTG_STATE_B_PERIPHERAL;
+		lubbock_vbus->phy.last_event = status;
+		usb_gadget_vbus_connect(lubbock_vbus->phy.otg->gadget);
+
+		atomic_notifier_call_chain(&lubbock_vbus->phy.notifier,
+				   status, lubbock_vbus->phy.otg->gadget);
+	} else {
+		usb_gadget_vbus_disconnect(lubbock_vbus->phy.otg->gadget);
+		status = USB_EVENT_NONE;
+		lubbock_vbus->phy.state = OTG_STATE_B_IDLE;
+		lubbock_vbus->phy.last_event = status;
+
+		atomic_notifier_call_chain(&lubbock_vbus->phy.notifier,
+				   status, lubbock_vbus->phy.otg->gadget);
+	}
+}
+
+/* VBUS change IRQ handler */
+static irqreturn_t lubbock_vbus_irq(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	struct lubbock_vbus_data *lubbock_vbus = platform_get_drvdata(pdev);
+	struct usb_otg *otg = lubbock_vbus->phy.otg;
+
+	dev_dbg(&pdev->dev, "VBUS %s (gadget: %s)\n",
+		is_vbus_powered() ? "supplied" : "inactive",
+		otg->gadget ? otg->gadget->name : "none");
+
+	switch (irq) {
+	case LUBBOCK_USB_IRQ:
+		disable_irq(LUBBOCK_USB_IRQ);
+		enable_irq(LUBBOCK_USB_DISC_IRQ);
+		break;
+	case LUBBOCK_USB_DISC_IRQ:
+		disable_irq(LUBBOCK_USB_DISC_IRQ);
+		enable_irq(LUBBOCK_USB_IRQ);
+		break;
+	default:
+		return IRQ_NONE;
+	}
+
+	/*
+	 * No need to use workqueue here - we are in a threded handler,
+	 * so we can sleep.
+	 */
+	if (otg->gadget)
+		lubbock_vbus_handle(lubbock_vbus);
+
+	return IRQ_HANDLED;
+}
+
+/* OTG transceiver interface */
+
+/* bind/unbind the peripheral controller */
+static int lubbock_vbus_set_peripheral(struct usb_otg *otg,
+					struct usb_gadget *gadget)
+{
+	struct lubbock_vbus_data *lubbock_vbus;
+	struct platform_device *pdev;
+
+	lubbock_vbus = container_of(otg->phy, struct lubbock_vbus_data, phy);
+	pdev = to_platform_device(lubbock_vbus->dev);
+
+	if (!gadget) {
+		dev_dbg(&pdev->dev, "unregistering gadget '%s'\n",
+			otg->gadget->name);
+
+		usb_gadget_vbus_disconnect(otg->gadget);
+		otg->phy->state = OTG_STATE_UNDEFINED;
+
+		otg->gadget = NULL;
+		return 0;
+	}
+
+	otg->gadget = gadget;
+	dev_dbg(&pdev->dev, "registered gadget '%s'\n", gadget->name);
+
+	/* initialize connection state */
+	lubbock_vbus->vbus = 0; /* start with disconnected */
+	lubbock_vbus_irq(LUBBOCK_USB_DISC_IRQ, pdev);
+
+	return 0;
+}
+
+/* for non-OTG B devices: set/clear transceiver suspend mode */
+static int lubbock_vbus_set_suspend(struct usb_phy *phy, int suspend)
+{
+	return 0;
+}
+
+/* platform driver interface */
+
+static int lubbock_vbus_probe(struct platform_device *pdev)
+{
+	struct lubbock_vbus_data *lubbock_vbus;
+	int err;
+
+	lubbock_vbus = devm_kzalloc(&pdev->dev,
+			sizeof(struct lubbock_vbus_data),
+			GFP_KERNEL);
+	if (!lubbock_vbus)
+		return -ENOMEM;
+
+	lubbock_vbus->phy.otg = devm_kzalloc(&pdev->dev,
+			sizeof(struct usb_otg),
+			GFP_KERNEL);
+	if (!lubbock_vbus->phy.otg)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, lubbock_vbus);
+	lubbock_vbus->dev = &pdev->dev;
+	lubbock_vbus->phy.label = "lubbock-vbus";
+	lubbock_vbus->phy.dev = lubbock_vbus->dev;
+	lubbock_vbus->phy.set_suspend = lubbock_vbus_set_suspend;
+	lubbock_vbus->phy.state = OTG_STATE_UNDEFINED;
+
+	lubbock_vbus->phy.otg->phy = &lubbock_vbus->phy;
+	lubbock_vbus->phy.otg->set_peripheral = lubbock_vbus_set_peripheral;
+
+	err = devm_request_threaded_irq(&pdev->dev, LUBBOCK_USB_DISC_IRQ,
+			NULL, lubbock_vbus_irq, 0, "vbus disconnect", pdev);
+	if (err) {
+		dev_err(&pdev->dev, "can't request irq %i, err: %d\n",
+			LUBBOCK_USB_DISC_IRQ, err);
+		return err;
+	}
+
+	err = devm_request_threaded_irq(&pdev->dev, LUBBOCK_USB_IRQ,
+			NULL, lubbock_vbus_irq, 0, "vbus connect", pdev);
+	if (err) {
+		dev_err(&pdev->dev, "can't request irq %i, err: %d\n",
+			LUBBOCK_USB_IRQ, err);
+		return err;
+	}
+
+	/* only active when a gadget is registered */
+	err = usb_add_phy(&lubbock_vbus->phy, USB_PHY_TYPE_USB2);
+	if (err) {
+		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int lubbock_vbus_remove(struct platform_device *pdev)
+{
+	struct lubbock_vbus_data *lubbock_vbus = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&lubbock_vbus->phy);
+
+	return 0;
+}
+
+MODULE_ALIAS("platform:lubbock-vbus");
+
+static struct platform_driver lubbock_vbus_driver = {
+	.driver = {
+		.name  = "lubbock-vbus",
+		.owner = THIS_MODULE,
+	},
+	.probe		= lubbock_vbus_probe,
+	.remove		= lubbock_vbus_remove,
+};
+
+module_platform_driver(lubbock_vbus_driver);
+
+MODULE_DESCRIPTION("OTG transceiver driver for DBPXA250 Lubbock platform");
+MODULE_AUTHOR("Dmitry Eremin-Solenikov");
+MODULE_LICENSE("GPL v2");
-- 
2.1.3
