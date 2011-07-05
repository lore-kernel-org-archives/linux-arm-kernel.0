From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:34 +0400
Subject: [PATCH 08/15] otg: add gpio_pullup OTG transceiver for devices with
	no VBUS sensing
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-9-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some devices which have D+ pullup GPIO, but no VBUS sensing
support. As such they can't be supported by gpio-vbus transceiver but
would benefit from OTG transceiver interface support. Provide simple
driver that would just handle OTG API for gadgete drivers and provide a
way to toggle D+ pullup.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/otg/Kconfig       |    8 ++
 drivers/usb/otg/Makefile      |    1 +
 drivers/usb/otg/gpio_pullup.c |  159 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/otg/gpio_pullup.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index cf3a245..18b9183 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -140,4 +140,12 @@ config FSL_USB2_OTG
 	help
 	  Enable this to support Freescale USB OTG transceiver.
 
+config USB_GPIO_PULLUP
+	tristate "GPIO based peripheral-only D+ pullup handling"
+	depends on GENERIC_GPIO
+	select USB_OTG_UTILS
+	help
+	  Provides simple GPIO D+ pullup handling for controllers with
+	  internal transceiver via the otg_transceiver interface.
+
 endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index 24d4e63..b482e79 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 obj-$(CONFIG_LUBBOCK_USB)	+= lubbock-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
+obj-$(CONFIG_USB_GPIO_PULLUP)	+= gpio_pullup.o
diff --git a/drivers/usb/otg/gpio_pullup.c b/drivers/usb/otg/gpio_pullup.c
new file mode 100644
index 0000000..075d269
--- /dev/null
+++ b/drivers/usb/otg/gpio_pullup.c
@@ -0,0 +1,159 @@
+/*
+ * gpio_pullup.c - simple GPIO D+ pullup handling for B peripheral devices
+ *
+ * Copyright (c) 2011 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
+ *
+ * Heavily based on gpio_vbus driver:
+ *
+ * Copyright (c) 2008 Philipp Zabel <philipp.zabel@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/usb.h>
+
+#include <linux/usb/gadget.h>
+#include <linux/usb/gpio_vbus.h>
+#include <linux/usb/otg.h>
+
+struct gpio_pullup_data {
+	struct otg_transceiver otg;
+	struct device          *dev;
+};
+
+/* OTG transceiver interface */
+
+/* bind/unbind the peripheral controller */
+static int gpio_pullup_set_peripheral(struct otg_transceiver *otg,
+				struct usb_gadget *gadget)
+{
+	struct gpio_pullup_data *gpio_pullup;
+	struct gpio_vbus_mach_info *pdata;
+	struct platform_device *pdev;
+	int gpio;
+
+	gpio_pullup = container_of(otg, struct gpio_pullup_data, otg);
+	pdev = to_platform_device(gpio_pullup->dev);
+	pdata = gpio_pullup->dev->platform_data;
+	gpio = pdata->gpio_pullup;
+
+	if (!gadget) {
+		dev_dbg(&pdev->dev, "unregistering gadget '%s'\n",
+			otg->gadget->name);
+
+		/* optionally disable D+ pullup */
+		gpio_set_value(pdata->gpio_pullup, pdata->gpio_pullup_inverted);
+
+		usb_gadget_vbus_disconnect(otg->gadget);
+		otg->state = OTG_STATE_UNDEFINED;
+
+		otg->gadget = NULL;
+		return 0;
+	}
+
+	otg->gadget = gadget;
+	dev_dbg(&pdev->dev, "registered gadget '%s'\n", gadget->name);
+
+	/* initialize connection state */
+	gpio_pullup->otg.state = OTG_STATE_B_PERIPHERAL;
+	usb_gadget_vbus_connect(gpio_pullup->otg.gadget);
+
+	gpio_set_value(pdata->gpio_pullup, !pdata->gpio_pullup_inverted);
+
+	return 0;
+}
+
+/* platform driver interface */
+
+static int __devinit gpio_pullup_probe(struct platform_device *pdev)
+{
+	struct gpio_vbus_mach_info *pdata = pdev->dev.platform_data;
+	struct gpio_pullup_data *gpio_pullup;
+	int err, gpio;
+
+	if (!pdata || !gpio_is_valid(pdata->gpio_pullup))
+		return -EINVAL;
+
+	gpio_pullup = kzalloc(sizeof(struct gpio_pullup_data), GFP_KERNEL);
+	if (!gpio_pullup)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, gpio_pullup);
+	gpio_pullup->dev = &pdev->dev;
+	gpio_pullup->otg.label = "gpio-pullup";
+	gpio_pullup->otg.state = OTG_STATE_UNDEFINED;
+	gpio_pullup->otg.set_peripheral = gpio_pullup_set_peripheral;
+
+	/* if data line pullup is in use, initialize it to "not pulling up" */
+	gpio = pdata->gpio_pullup;
+	err = gpio_request(gpio, "udc_pullup");
+	if (err) {
+		dev_err(&pdev->dev,
+			"can't request pullup gpio %d, err: %d\n",
+			gpio, err);
+		gpio_free(pdata->gpio_pullup);
+		goto err_gpio;
+	}
+	gpio_direction_output(gpio, pdata->gpio_pullup_inverted);
+
+	/* only active when a gadget is registered */
+	err = otg_set_transceiver(&gpio_pullup->otg);
+	if (err) {
+		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
+			err);
+		goto err_otg;
+	}
+
+	return 0;
+err_otg:
+	gpio_free(pdata->gpio_pullup);
+err_gpio:
+	platform_set_drvdata(pdev, NULL);
+	kfree(gpio_pullup);
+	return err;
+}
+
+static int __devexit gpio_pullup_remove(struct platform_device *pdev)
+{
+	struct gpio_pullup_data *gpio_pullup = platform_get_drvdata(pdev);
+	struct gpio_vbus_mach_info *pdata = pdev->dev.platform_data;
+
+	otg_set_transceiver(NULL);
+
+	gpio_free(pdata->gpio_pullup);
+	platform_set_drvdata(pdev, NULL);
+	kfree(gpio_pullup);
+
+	return 0;
+}
+
+static struct platform_driver gpio_pullup_driver = {
+	.driver = {
+		.name  = "gpio-pullup",
+		.owner = THIS_MODULE,
+	},
+	.probe		= gpio_pullup_probe,
+	.remove		= __devexit_p(gpio_pullup_remove),
+};
+MODULE_ALIAS("platform:gpio-pullup");
+
+static int __init gpio_pullup_init(void)
+{
+	return platform_driver_register(&gpio_pullup_driver);
+}
+module_init(gpio_pullup_init);
+
+static void __exit gpio_pullup_exit(void)
+{
+	platform_driver_unregister(&gpio_pullup_driver);
+}
+module_exit(gpio_pullup_exit);
+
+MODULE_DESCRIPTION("simple GPIO D+ pulllup OTG transceiver driver");
+MODULE_AUTHOR("Dmitry Eremin-Solenikov");
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
