From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu,  3 May 2012 09:24:06 +0100
Subject: [PATCH] gpio: Add simple poweroff-gpio driver
In-Reply-To: <20120501195603.GW25584@lunn.ch>
References: <20120501195603.GW25584@lunn.ch>
Message-ID: <1336033446-18949-1-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given appropriate devicetree bindings, this driver registers a
pm_power_off function to set a GPIO line high/low and power down
your board.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
Here's an attempt at doing this. All works fine, I've not submitted a
patch to use it since GPIO patches for kirkwood aren't finalised, but
you can see it being used here:-

https://github.com/lentinj/linux.git v3.4-rc4-clk-next-orion-dnskw-gpio

The main issue is where to put it. I'm not convinced that drivers/gpio
is an appropriate home, however drivers/power and drivers/hwmon (where
drivers with similar purpose live) contain frameworks this is not part
of. drivers/mfd has some modules that can power off, but this is hardly
multifunction :) Could also give in and use drivers/misc.

Feedback appreciated.

 .../devicetree/bindings/gpio/poweroff-gpio.txt     |   15 ++++
 drivers/gpio/Kconfig                               |   10 +++
 drivers/gpio/Makefile                              |    2 +
 drivers/gpio/poweroff-gpio.c                       |   95 ++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/poweroff-gpio.txt
 create mode 100644 drivers/gpio/poweroff-gpio.c

diff --git a/Documentation/devicetree/bindings/gpio/poweroff-gpio.txt b/Documentation/devicetree/bindings/gpio/poweroff-gpio.txt
new file mode 100644
index 0000000..be52486
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/poweroff-gpio.txt
@@ -0,0 +1,15 @@
+GPIO line that should be set high/low to power off a device
+
+Required properties:
+- compatible : should be "gpio-poweroff".
+- gpios : The GPIO to set high/low, see "gpios property" in
+  Documentation/devicetree/bindings/gpio/gpio.txt. If the pin should be
+  low to power down the board set it to "Active Low", otherwise set
+  gpio to "Active High".
+
+Examples:
+
+gpio-poweroff {
+	compatible = "gpio-poweroff";
+	gpios = <&gpio 4 0>; /* GPIO 4 Active High */
+};
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e03653d..48a531b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -63,6 +63,16 @@ config GPIO_SYSFS
 	  Kernel drivers may also request that a particular GPIO be
 	  exported to userspace; this can be useful when debugging.
 
+config GPIO_POWEROFF
+	tristate "GPIO power-off driver"
+	depends on OF_GPIO
+	help
+	  This driver supports turning off your device via. a GPIO call.
+	  If your device needs a GPIO high/low to power down, say Y and
+	  create a binding in your devicetree.
+
+	  If unsure, say N
+
 config GPIO_GENERIC
 	tristate
 
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 007f54b..54adeb8 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -4,6 +4,8 @@ ccflags-$(CONFIG_DEBUG_GPIO)	+= -DDEBUG
 
 obj-$(CONFIG_GPIOLIB)		+= gpiolib.o devres.o
 
+obj-$(CONFIG_GPIO_POWEROFF)	+= poweroff-gpio.o
+
 # Device drivers. Generally keep list sorted alphabetically
 obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 
diff --git a/drivers/gpio/poweroff-gpio.c b/drivers/gpio/poweroff-gpio.c
new file mode 100644
index 0000000..3d216aa
--- /dev/null
+++ b/drivers/gpio/poweroff-gpio.c
@@ -0,0 +1,95 @@
+/*
+ * Toggles a GPIO pin to power down a device
+ *
+ * Jamie Lentin <jm@lentin.co.uk>
+ * Copyright (C) 2012 Jamie Lentin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
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
+static int gpio_num;
+static int gpio_active_low;
+
+static void gpio_poweroff_do_poweroff(void)
+{
+	gpio_set_value(gpio_num, !gpio_active_low);
+}
+
+static int __devinit gpio_poweroff_probe(struct platform_device *pdev)
+{
+	enum of_gpio_flags flags;
+
+	gpio_num = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
+	if (gpio_num < 0) {
+		pr_err("%s: Could not get GPIO configuration: %d",
+		       __func__, gpio_num);
+		return -ENODEV;
+	}
+	gpio_active_low = flags & OF_GPIO_ACTIVE_LOW;
+
+	/* If a pm_power_off function has already been added, leave it alone */
+	if (pm_power_off != NULL) {
+		pr_err("%s: pm_power_off function already registered",
+		       __func__);
+		return -EBUSY;
+	}
+
+	if (gpio_request(gpio_num, "poweroff-gpio")) {
+		pr_err("%s: Could not get GPIO %d", __func__, gpio_num);
+		return -ENODEV;
+	}
+	if (gpio_direction_output(gpio_num, gpio_active_low)) {
+		pr_err("%s: Could not set direction of GPIO %d",
+		       __func__, gpio_num);
+		return -ENODEV;
+	}
+
+	pm_power_off = &gpio_poweroff_do_poweroff;
+	return 0;
+}
+
+static int __devexit gpio_poweroff_remove(struct platform_device *pdev)
+{
+	if (gpio_num)
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
1.7.10
