From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Dec 2015 15:26:12 +0800
Subject: [PATCH v2 1/3] usb: misc: generic_onboard_hub: add generic onboard
 USB HUB driver
In-Reply-To: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1450077974-22762-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current USB HUB driver lacks of platform interfaces to configure
external signal on HUB chip, eg, the PHY input clock and gpio reset
pin for HUB, these kinds of HUBs are usually soldered at the board,
and they are not hot-plug USB devices.

With this patch, the user can configure the HUB's pins at device tree,
and these configuration will be effective before the USB bus can be used,
it can avoid unexpected signals at USB bus during the USB HUB reset,
so we use subsys_initcall for this driver.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 MAINTAINERS                            |   7 ++
 drivers/usb/misc/Kconfig               |  10 +++
 drivers/usb/misc/Makefile              |   1 +
 drivers/usb/misc/generic_onboard_hub.c | 143 +++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 drivers/usb/misc/generic_onboard_hub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..cc1981e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11121,6 +11121,13 @@ S:	Maintained
 F:	Documentation/usb/ohci.txt
 F:	drivers/usb/host/ohci*
 
+USB Generic Onboard HUB Driver
+M:	Peter Chen <Peter.Chen@freescale.com>
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
+L:	linux-usb at vger.kernel.org
+S:	Maintained
+F:	drivers/usb/misc/generic_onboard_hub.c
+
 USB OTG FSM (Finite State Machine)
 M:	Peter Chen <Peter.Chen@freescale.com>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index f7a7fc2..5ff74ff 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -268,3 +268,13 @@ config USB_CHAOSKEY
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called chaoskey.
+
+config USB_ONBOARD_HUB
+	tristate "Generic USB Onboard HUB"
+	help
+	  depends on OF
+	  Say Y here if your board has an onboard HUB, and this hub needs
+	  to control its PHY clock and reset pin through external signals.
+	  If you are not sure, say N.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
index 45fd4ac..da52e9a 100644
--- a/drivers/usb/misc/Makefile
+++ b/drivers/usb/misc/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_USB_CHAOSKEY)		+= chaoskey.o
 
 obj-$(CONFIG_USB_SISUSBVGA)		+= sisusbvga/
 obj-$(CONFIG_USB_LINK_LAYER_TEST)	+= lvstest.o
+obj-$(CONFIG_USB_ONBOARD_HUB)		+= generic_onboard_hub.o
diff --git a/drivers/usb/misc/generic_onboard_hub.c b/drivers/usb/misc/generic_onboard_hub.c
new file mode 100644
index 0000000..7db5b78
--- /dev/null
+++ b/drivers/usb/misc/generic_onboard_hub.c
@@ -0,0 +1,143 @@
+/*
+ * usb_hub_generic.c	The generic onboard USB HUB driver
+ *
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
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
+/*
+ * This driver is only for the USB HUB devices which need to control
+ * their external pins(clock, reset, etc), and these USB HUB devices
+ * are soldered at the board.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+struct usb_hub_generic_data {
+	struct clk *clk;
+};
+
+static int usb_hub_generic_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct usb_hub_generic_data *hub_data;
+	int ret = -EINVAL;
+	struct gpio_desc *gpiod_reset = NULL;
+	struct device_node *node = dev->of_node;
+	u32 duration_us = 50, clk_rate = 0;
+
+	/* Only support device tree now */
+	if (!node)
+		return ret;
+
+	hub_data = devm_kzalloc(dev, sizeof(*hub_data), GFP_KERNEL);
+	if (!hub_data)
+		return -ENOMEM;
+
+	hub_data->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(hub_data->clk)) {
+		dev_dbg(dev, "Can't get clock: %ld\n",
+			PTR_ERR(hub_data->clk));
+		hub_data->clk = NULL;
+	} else {
+		ret = clk_prepare_enable(hub_data->clk);
+		if (ret) {
+			dev_err(dev,
+				"Can't enable external clock: %d\n",
+				ret);
+			return ret;
+		}
+
+		of_property_read_u32(node, "clock-frequency", &clk_rate);
+		if (clk_rate) {
+			ret = clk_set_rate(hub_data->clk, clk_rate);
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
+		gpiod_set_value(gpiod_reset, 1);
+		usleep_range(duration_us, duration_us + 10);
+		gpiod_set_value(gpiod_reset, 0);
+	}
+
+	dev_set_drvdata(dev, hub_data);
+	return ret;
+
+disable_clk:
+	clk_disable_unprepare(hub_data->clk);
+	return ret;
+}
+
+static int usb_hub_generic_remove(struct platform_device *pdev)
+{
+	struct usb_hub_generic_data *hub_data = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(hub_data->clk);
+
+	return 0;
+}
+
+static const struct of_device_id usb_hub_generic_dt_ids[] = {
+	{.compatible = "generic-onboard-hub"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, usb_hub_generic_dt_ids);
+
+static struct platform_driver usb_hub_generic_driver = {
+	.probe = usb_hub_generic_probe,
+	.remove = usb_hub_generic_remove,
+	.driver = {
+		.name = "usb_hub_generic_onboard",
+		.of_match_table = usb_hub_generic_dt_ids,
+	 },
+};
+
+static int __init usb_hub_generic_init(void)
+{
+	return platform_driver_register(&usb_hub_generic_driver);
+}
+subsys_initcall(usb_hub_generic_init);
+
+static void __exit usb_hub_generic_exit(void)
+{
+	platform_driver_unregister(&usb_hub_generic_driver);
+}
+module_exit(usb_hub_generic_exit);
+
+MODULE_AUTHOR("Peter Chen <peter.chen@freescale.com>");
+MODULE_DESCRIPTION("Generic Onboard USB HUB driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
