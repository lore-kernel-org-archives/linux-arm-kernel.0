From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 11 Nov 2012 17:21:29 +0100
Subject: [PATCH 1/3] gpio: Add simple poweroff-gpio driver
In-Reply-To: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
References: <1352650891-18356-1-git-send-email-andrew@lunn.ch>
Message-ID: <1352650891-18356-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jamie Lentin <jm@lentin.co.uk>

Given appropriate devicetree bindings, this driver registers a
pm_power_off function to set a GPIO line high/low to power down
your board.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/gpio/gpio-poweroff.txt     |   22 ++++
 drivers/gpio/Kconfig                               |   10 ++
 drivers/gpio/Makefile                              |    2 +
 drivers/gpio/gpio-poweroff.c                       |  129 ++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
 create mode 100644 drivers/gpio/gpio-poweroff.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
new file mode 100644
index 0000000..558cdf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-poweroff.txt
@@ -0,0 +1,22 @@
+GPIO line that should be set high/low to power off a device
+
+Required properties:
+- compatible : should be "gpio-poweroff".
+- gpios : The GPIO to set high/low, see "gpios property" in
+  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
+  low to power down the board set it to "Active Low", otherwise set
+  gpio to "Active High".
+
+Optional properties:
+- input : Initially configure the GPIO line as an input. Only reconfigure
+  it to an output when the pm_power_off function is called. If this optional
+  property is not specified, the GPIO is initialized as an output in its
+  inactive state.
+
+
+Examples:
+
+gpio-poweroff {
+	compatible = "gpio-poweroff";
+	gpios = <&gpio 4 0>; /* GPIO 4 Active Low */
+};
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d055cee..5ec1714 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -75,6 +75,16 @@ config GPIO_SYSFS
 	  Kernel drivers may also request that a particular GPIO be
 	  exported to userspace; this can be useful when debugging.
 
+config GPIO_POWEROFF
+	tristate "GPIO power-off driver"
+	depends on OF_GPIO
+	help
+	  This driver supports turning off your device via a GPIO line.
+	  If your device needs a GPIO high/low to power down, say Y and
+	  create a binding in your devicetree.
+
+	  If unsure, say N
+
 config GPIO_GENERIC
 	tristate
 
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9aeed67..a8efda3 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -5,6 +5,8 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 obj-$(CONFIG_GPIOLIB)		+= gpiolib.o devres.o
 obj-$(CONFIG_OF_GPIO)		+= gpiolib-of.o
 
+obj-$(CONFIG_GPIO_POWEROFF)	+= gpio-poweroff.o
+
 # Device drivers. Generally keep list sorted alphabetically
 obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 
diff --git a/drivers/gpio/gpio-poweroff.c b/drivers/gpio/gpio-poweroff.c
new file mode 100644
index 0000000..101ad57
--- /dev/null
+++ b/drivers/gpio/gpio-poweroff.c
@@ -0,0 +1,129 @@
+/*
+ * Toggles a GPIO pin to power down a device
+ *
+ * Jamie Lentin <jm@lentin.co.uk>
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * Copyright (C) 2012 Jamie Lentin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
+#include <linux/module.h>
+
+/*
+ * Hold configuration here, cannot be more than one instance of the driver
+ * since pm_power_off itself is global.
+ */
+static int gpio_num = -1;
+static int gpio_active_low;
+
+static void gpio_poweroff_do_poweroff(void)
+{
+	BUG_ON(gpio_num == -1);
+
+	/* drive it active */
+	gpio_direction_output(gpio_num, !gpio_active_low);
+	mdelay(100);
+	/* rising edge or drive inactive */
+	gpio_set_value(gpio_num, gpio_active_low);
+	mdelay(100);
+	/* falling edge */
+	gpio_set_value(gpio_num, !gpio_active_low);
+
+	/* give it some time */
+	mdelay(100);
+
+	WARN_ON(1);
+}
+
+static int __devinit gpio_poweroff_probe(struct platform_device *pdev)
+{
+	enum of_gpio_flags flags;
+	bool input = false;
+	int ret;
+
+	/* If a pm_power_off function has already been added, leave it alone */
+	if (pm_power_off != NULL) {
+		pr_err("%s: pm_power_off function already registered",
+		       __func__);
+		return -EBUSY;
+	}
+
+	gpio_num = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
+	if (gpio_num < 0) {
+		pr_err("%s: Could not get GPIO configuration: %d",
+		       __func__, gpio_num);
+		return -ENODEV;
+	}
+	gpio_active_low = flags & OF_GPIO_ACTIVE_LOW;
+
+	if (of_get_property(pdev->dev.of_node, "input", NULL))
+		input = true;
+
+	ret = gpio_request(gpio_num, "poweroff-gpio");
+	if (ret) {
+		pr_err("%s: Could not get GPIO %d", __func__, gpio_num);
+		return ret;
+	}
+	if (input) {
+		if (gpio_direction_input(gpio_num)) {
+			pr_err("Could not set direction of GPIO %d to input",
+			       gpio_num);
+			goto err;
+		}
+	} else {
+		if (gpio_direction_output(gpio_num, gpio_active_low)) {
+			pr_err("Could not set direction of GPIO %d", gpio_num);
+			goto err;
+		}
+	}
+
+	pm_power_off = &gpio_poweroff_do_poweroff;
+	return 0;
+
+err:
+	gpio_free(gpio_num);
+	return -ENODEV;
+}
+
+static int __devexit gpio_poweroff_remove(struct platform_device *pdev)
+{
+	if (gpio_num != -1)
+		gpio_free(gpio_num);
+	if (pm_power_off == &gpio_poweroff_do_poweroff)
+		pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id of_gpio_poweroff_match[] = {
+	{ .compatible = "gpio-poweroff", },
+	{},
+};
+
+static struct platform_driver gpio_poweroff_driver = {
+	.probe = gpio_poweroff_probe,
+	.remove = __devexit_p(gpio_poweroff_remove),
+	.driver = {
+		   .name = "poweroff-gpio",
+		   .owner = THIS_MODULE,
+		   .of_match_table = of_gpio_poweroff_match,
+		   },
+};
+
+module_platform_driver(gpio_poweroff_driver);
+
+MODULE_AUTHOR("Jamie Lentin <jm@lentin.co.uk>");
+MODULE_DESCRIPTION("GPIO poweroff driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:poweroff-gpio");
-- 
1.7.10.4
