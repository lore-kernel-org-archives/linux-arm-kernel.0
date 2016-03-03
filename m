From: peter.chen@nxp.com (Peter Chen)
Date: Thu, 3 Mar 2016 18:01:14 +0800
Subject: [PATCH 1/3] usb: core: add power sequence for USB devices
In-Reply-To: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
References: <1456999276-6315-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1456999276-6315-2-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some hard-wired USB devices need to do power sequence to let the
device work normally, the typical power sequence like: enable USB
PHY clock, toggle reset pin, etc. But current Linux USB driver
lacks of such code to do it, it may cause some hard-wired USB devices
works abnormal or can't be recognized by controller at all.

In this patch, it will do power on sequence at hub's probe for all
devices under this hub (includes root hub) if this device is described
at dts and there is a phandle "usb-pwrseq" for it. At hub_disconnect,
it will do power off sequence.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 .../devicetree/bindings/usb/usb-device.txt         |  41 +++++-
 drivers/usb/core/Makefile                          |   2 +-
 drivers/usb/core/hub.c                             |  32 +++++
 drivers/usb/core/pwrseq.c                          | 149 +++++++++++++++++++++
 include/linux/usb/of.h                             |  10 ++
 5 files changed, 232 insertions(+), 2 deletions(-)
 create mode 100644 drivers/usb/core/pwrseq.c

diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 1c35e7b..c7a298c 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -13,8 +13,37 @@ Required properties:
 - reg: the port number which this device is connecting to, the range
   is 1-31.
 
+Optional properties:
+- usb-pwrseq: the power sequence handler which need to do before this USB
+  device can work.
+- clocks: the input clock for USB device.
+- clock-frequency: the frequency for device's clock.
+- reset-gpios: Should specify the GPIO for reset.
+- reset-duration-us: the duration in microsecond for assert reset signal.
+
 Example:
 
+/ {
+	...
+
+	hub_genesys_1_pwrseq: hub_genesys_1_pwrseq {
+		compatible = "usb-pwrseq";
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
+		reset-duration-us = <10>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+	};
+
+	ethernet_asix_2_pwrseq: ethernet_asix_2_pwrseq {
+		compatible = "usb-pwrseq";
+		reset-gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* ethernet_rst */
+		reset-duration-us = <20>;
+		clock-frequency = <24000000>;
+		clocks = <&clks IMX6QDL_CLK_CKO1>;
+	};
+
+	...
+};
+
 &usb1 {
 	status = "okay";
 
@@ -24,5 +53,15 @@ Example:
 	hub: genesys at 1 {
 		compatible = "usb5e3,608";
 		reg = <1>;
+		usb-pwrseq = <&hub_genesys_1_pwrseq>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethernet: asix at 1 {
+			compatible = "usbb95,1708";
+			reg = <1>;
+			usb-pwrseq = <&ethernet_asix_1_pwrseq>;
+		};
 	};
-}
+};
diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
index 9780877..9cdc548 100644
--- a/drivers/usb/core/Makefile
+++ b/drivers/usb/core/Makefile
@@ -5,7 +5,7 @@
 usbcore-y := usb.o hub.o hcd.o urb.o message.o driver.o
 usbcore-y += config.o file.o buffer.o sysfs.o endpoint.o
 usbcore-y += devio.o notify.o generic.o quirks.o devices.o
-usbcore-y += port.o of.o
+usbcore-y += port.o of.o pwrseq.o
 
 usbcore-$(CONFIG_PCI)		+= hcd-pci.o
 usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0f82db4..0091428 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,8 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/of.h>
+#include <linux/usb/of.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1680,6 +1682,27 @@ static void hub_release(struct kref *kref)
 	kfree(hub);
 }
 
+static int hub_of_pwrseq(struct usb_device *hdev, bool on)
+{
+	struct device *parent;
+	struct device_node *node;
+	int ret = 0;
+
+	if (hdev->parent)
+		parent = &hdev->dev;
+	else
+		parent = bus_to_hcd(hdev->bus)->self.controller;
+
+	for_each_child_of_node(parent->of_node, node) {
+		ret = on ? usb_child_pwrseq_on(node)
+			: usb_child_pwrseq_off(node);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static unsigned highspeed_hubs;
 
 static void hub_disconnect(struct usb_interface *intf)
@@ -1722,6 +1745,10 @@ static void hub_disconnect(struct usb_interface *intf)
 	kfree(hub->buffer);
 
 	pm_suspend_ignore_children(&intf->dev, false);
+
+	if (hub_of_pwrseq(hdev, false))
+		dev_err(&hdev->dev, "failed to do power operations off\n");
+
 	kref_put(&hub->kref, hub_release);
 }
 
@@ -1731,6 +1758,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1850,6 +1878,10 @@ descriptor_error:
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
+	ret = hub_of_pwrseq(hdev, true);
+	if (ret)
+		dev_err(&hdev->dev, "failed to do power operations on\n");
+
 	if (hub_configure(hub, endpoint) >= 0)
 		return 0;
 
diff --git a/drivers/usb/core/pwrseq.c b/drivers/usb/core/pwrseq.c
new file mode 100644
index 0000000..eeb231d
--- /dev/null
+++ b/drivers/usb/core/pwrseq.c
@@ -0,0 +1,149 @@
+/*
+ * pwrseq.c	USB device power sequence management
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
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+struct usb_pwrseq_data {
+	struct clk *clk;
+};
+
+static int  __usb_child_pwrseq_on(struct device *dev)
+{
+	struct usb_pwrseq_data *pwrseq;
+	int ret = -EINVAL;
+	struct gpio_desc *gpiod_reset = NULL;
+	struct device_node *node = dev->of_node;
+	u32 duration_us = 50, clk_rate = 0;
+
+	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
+	if (!pwrseq)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, pwrseq);
+
+	pwrseq->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pwrseq->clk)) {
+		dev_dbg(dev, "Can't get clock: %ld\n",
+			PTR_ERR(pwrseq->clk));
+		pwrseq->clk = NULL;
+	} else {
+		ret = clk_prepare_enable(pwrseq->clk);
+		if (ret) {
+			dev_err(dev,
+				"Can't enable external clock: %d\n",
+				ret);
+			return ret;
+		}
+
+		of_property_read_u32(node, "clock-frequency", &clk_rate);
+		if (clk_rate) {
+			ret = clk_set_rate(pwrseq->clk, clk_rate);
+			if (ret) {
+				dev_err(dev, "Error setting clock rate\n");
+				goto disable_clk;
+			}
+		}
+	}
+
+	gpiod_reset = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	ret = PTR_ERR_OR_ZERO(gpiod_reset);
+	if (ret) {
+		dev_err(dev, "Failed to get reset gpio, err = %d\n", ret);
+		goto disable_clk;
+	}
+
+	of_property_read_u32(node, "reset-duration-us", &duration_us);
+
+	if (gpiod_reset) {
+		gpiod_direction_output(gpiod_reset, 1);
+
+		gpiod_set_value(gpiod_reset, 1);
+		usleep_range(duration_us, duration_us + 10);
+		gpiod_set_value(gpiod_reset, 0);
+	}
+
+	return ret;
+
+disable_clk:
+	clk_disable_unprepare(pwrseq->clk);
+	return ret;
+}
+
+static struct device *usb_get_pwrseq_device(struct device_node *node)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	int ret;
+
+	np = of_parse_phandle(node, "usb-pwrseq", 0);
+	if (!np)
+		return ERR_PTR(-ENOENT);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	return &pdev->dev;
+err:
+	of_node_put(np);
+	return ERR_PTR(ret);
+}
+
+int usb_child_pwrseq_on(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = usb_get_pwrseq_device(node);
+	if (dev == ERR_PTR(-ENOENT))
+		return 0;
+	else if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	return __usb_child_pwrseq_on(dev);
+}
+
+int usb_child_pwrseq_off(struct device_node *node)
+{
+	struct device *dev;
+	struct usb_pwrseq_data *pwrseq;
+
+	dev = usb_get_pwrseq_device(node);
+	if (dev == ERR_PTR(-ENOENT))
+		return 0;
+	else if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	pwrseq = dev_get_drvdata(dev);
+	clk_disable_unprepare(pwrseq->clk);
+
+	return 0;
+}
diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
index de3237f..1adf065 100644
--- a/include/linux/usb/of.h
+++ b/include/linux/usb/of.h
@@ -18,6 +18,8 @@ int of_usb_update_otg_caps(struct device_node *np,
 			struct usb_otg_caps *otg_caps);
 struct device_node *usb_of_get_child_node(struct device_node *parent,
 			int portnum);
+int usb_child_pwrseq_on(struct device_node *node);
+int usb_child_pwrseq_off(struct device_node *node);
 #else
 static inline enum usb_dr_mode
 of_usb_get_dr_mode_by_phy(struct device_node *phy_np)
@@ -38,6 +40,14 @@ static inline struct device_node *usb_of_get_child_node
 {
 	return NULL;
 }
+static inline int usb_child_pwrseq_on(struct device_node *node)
+{
+	return 0;
+}
+static inline int usb_child_pwrseq_off(struct device_node *node)
+{
+	return 0;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_USB_SUPPORT)
-- 
1.9.1
