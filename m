From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 11 Jan 2016 16:38:55 +0800
Subject: [PATCH 1/1] USB: core: let USB device know device node
Message-ID: <1452501535-8580-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although most of USB devices are hot-plug's, there are still some devices
are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
If these kinds of USB devices are multiple functions, and they can supply
other interfaces like i2c, gpios for other devices, we may need to
descirbe these at device tree.

In this commit, it uses "reg" in dts as port number to match the port
number decided by USB core, if they are the same, then the device node
is for the device we are creating for USB core.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
Changes from RFC:
- Fix the error address for binding doc, and add compatible for binding doc
- Change get child node API from "usb_of_find_node" to
  "usb_of_get_child_node"
- Delete unecessary header files
- One typo

 .../devicetree/bindings/usb/usb-device.txt         | 17 ++++++++
 drivers/usb/core/Makefile                          |  2 +-
 drivers/usb/core/of.c                              | 47 ++++++++++++++++++++++
 drivers/usb/core/usb.c                             |  8 +++-
 include/linux/usb.h                                |  2 +
 include/linux/usb/of.h                             |  7 ++++
 6 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
 create mode 100644 drivers/usb/core/of.c

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
new file mode 100644
index 0000000..0468834
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -0,0 +1,17 @@
+Generic USB Device Properties
+
+Usually, we only use device tree for hard wired USB device.
+The reference binding doc is from:
+http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
+
+Required properties:
+- compatible: usbVID,PID
+- reg: the port number which this device is connecting to.
+
+
+Example:
+
+hub: genesys at 01 {
+	compatible = "usb05e3,0608";
+	reg = <0x01>;
+};
diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 2f6f932..9780877 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -5,7 +5,7 @@
 usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
 usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
 usbcore-y += devio.o notify.o generic.o quirks.o devices.o
-usbcore-y += port.o
+usbcore-y += port.o of.o
 
 usbcore-$(CONFIG_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
new file mode 100644
index 0000000..2289700
--- /dev/null
+++ b/drivers/usb/core/of.c
@@ -0,0 +1,47 @@
+/*
+ * of.c		The helpers for hcd device tree support
+ *
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Author: Peter Chen <peter.chen@freescale.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/of.h>
+
+/**
+ * usb_of_get_child_node - Find the device node match port number
+ * @parent: the parent device node
+ * @portnum: the port number which device is connecting
+ *
+ * Find the node from device tree according to its port number.
+ *
+ * Return: On success, a pointer to the device node, %NULL on failure.
+ */
+struct device_node *usb_of_get_child_node(struct device_node *parent,
+					int portnum)
+{
+	struct device_node *node;
+	u32 port;
+
+	for_each_child_of_node(parent, node) {
+		if (!of_property_read_u32(node, "reg", &port)) {
+			if (port == portnum)
+				return node;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(usb_of_get_child_node);
+
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 77e4c9b..64c094e 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -36,6 +36,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
+#include <linux/usb/of.h>
 
 #include <asm/io.h>
 #include <linux/scatterlist.h>
@@ -502,11 +503,14 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 	dev->connect_time = jiffies;
 	dev->active_duration = -jiffies;
 #endif
-	if (root_hub)	/* Root hub always ok [and always wired] */
+	if (root_hub) {	/* Root hub always ok [and always wired] */
 		dev->authorized = 1;
-	else {
+		dev->of_node = bus->controller->of_node;
+	} else {
 		dev->authorized = !!HCD_DEV_AUTHORIZED(usb_hcd);
 		dev->wusb = usb_bus_is_wusb(bus) ? 1 : 0;
+		dev->dev.of_node = usb_of_get_child_node
+			(parent->of_node, dev->portnum);
 	}
 	return dev;
 }
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 89533ba..101b943 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -25,6 +25,7 @@
 struct usb_device;
 struct usb_driver;
 struct wusb_dev;
+struct devcie_node;
 
 /*-------------------------------------------------------------------------*/
 
@@ -616,6 +617,7 @@ struct usb_device {
 	struct usb3_lpm_parameters u1_params;
 	struct usb3_lpm_parameters u2_params;
 	unsigned lpm_disable_count;
+	struct device_node	*of_node; /* associated device tree node */
 };
 #define	to_usb_device(d) container_of(d, struct usb_device, dev)
 
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index 974bce9..99d0377 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -16,6 +16,8 @@ enum usb_dr_mode of_usb_get_dr_mode_by_phy(struct device_node *phy_np);
 bool of_usb_host_tpl_support(struct device_node *np);
 int of_usb_update_otg_caps(struct device_node *np,
 			struct usb_otg_caps *otg_caps);
+struct device_node *usb_of_get_child_node(struct device_node *parent,
+			int portnum);
 #else
 static inline enum usb_dr_mode
 of_usb_get_dr_mode_by_phy(struct device_node *phy_np)
@@ -31,6 +33,11 @@ static inline int of_usb_update_otg_caps(struct device_node *np,
 {
 	return 0;
 }
+struct inline device_node * usb_of_get_child_node(struct device_node *parent,
+				int portnum)
+{
+	return NULL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
-- 
1.9.1
