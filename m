From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 29 Jun 2012 11:21:16 +0200
Subject: [RFC PATCH] gpio: Add a generic GPIO handling driver
Message-ID: <1340961676-25432-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver provides an interface for device drivers that need to
control some external hardware (e.g. reset or enable signals) for the
devices they serve.

Features:
 - supports sharing a single GPIO between multiple devices.
 - optionally sets the controlled GPIOs to a predefined state upon
   suspend/resume.
 - handles output polarity

Client API:
	cookie = request_gpio_switch(dev, id);
	gpio_switch_set(cookie, on|off);
	free_gpio_switch(cookie);

	gpio_switch_set_suspend_state(cookie, on|off)
	gpio_switch_set_resume_state(cookie, on|off)

request_gpio_switch() always returns a valid cookie (that may be NULL
if the requested pin is not registered on the current platform), so
that client drivers do not need to check whether the current platform
provides a certain pin or not.

The client drivers only cope with the logical pin states
(active/inactive, on/off) while the gpio-switch driver takes care of
the output polarity handling.

The typical use of this driver in a client driver (e.g. flexcan
transceiver switch) would be like (with DT):

in the .dts file:
	flexcan_transceiver: gpio-switch at 0 {
		compatible = "linux,gpio-switch";
		gpio = <&gpio4 21 1>; /* GPIO is active low */
		label = "Flexcan Transceiver Enable";
		gpio-shared;
		init-state = <0>; /* Transceiver will be initially inactive */
	};

in flexcan_probe()
	struct gpio_sw *xcvr_switch = NULL;
	struct device_node *np = pdev->dev.of_node;

	if (np) {
		ph = of_get_property(np, "transceiver-switch", NULL);
		if (ph) {
			xcvr_switch = request_gpio_switch(&pdev->dev,
					be32_to_cpu(*ph));
		}
	}
...
static void flexcan_transceiver_switch(const struct flexcan_priv *priv, int on)
{
	if (priv->pdata && priv->pdata->transceiver_switch)
		priv->pdata->transceiver_switch(on);
	else
		gpio_switch_set(priv->xcvr_switch, on);
}
...
flexcan_remove()
    free_gpio_switch(xcvr_switch);

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 .../devicetree/bindings/gpio/gpio-switch.txt       |   36 ++
 drivers/gpio/Kconfig                               |    9 +
 drivers/gpio/Makefile                              |    3 +
 drivers/gpio/gpio-switch.c                         |  389 ++++++++++++++++++++
 include/linux/gpio-switch.h                        |   47 +++
 5 files changed, 484 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-switch.txt
 create mode 100644 drivers/gpio/gpio-switch.c
 create mode 100644 include/linux/gpio-switch.h

diff --git a/Documentation/devicetree/bindings/gpio/gpio-switch.txt b/Documentation/devicetree/bindings/gpio/gpio-switch.txt
new file mode 100644
index 0000000..d91c628
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-switch.txt
@@ -0,0 +1,36 @@
+Device-Tree bindings for gpio/gpio-switch.c driver
+
+Required properties:
+	- compatible = "linux,gpio-switch";
+	- gpios: OF device-tree gpio specification
+
+Optional properties:
+	- label: Human readable name for the gpio function
+	- init-state: specifies whether the gpio should be switched
+	  active or inactive on startup.
+	  If not set, pin will be initialized to the inactive state.
+	- suspend-state: specifies the state that the GPIO should be
+	  set to when suspending.
+	  If not set, pin state will not be changed upon suspend.
+	- resume-state: specifies the state that the GPIO should be
+	  set to when resuming.
+	  If not set, pin state will not be changed upon resume.
+	- gpio-shared: Boolean, Enable refcounted
+	  assertion/deassertion of the GPIO for a pin that is shared
+	  between multiple devices.
+
+Pin states are logical states. The actual pin output state is
+determined by the active low flag of the referenced gpio.
+
+Example nodes:
+
+	gpio-switch {
+		compatible = "linux,gpio-switch";
+		flexcan_transceiver: gpio-switch at 0 {
+			label = "Flexcan transceiver";
+			gpios = <&gpio1 0 1>;
+			init-state = <0>;
+			gpio-shared;
+		};
+	};
+	...
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index e03653d..17f2f4f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -514,4 +514,13 @@ config GPIO_TPS65910
 	help
 	  Select this option to enable GPIO driver for the TPS65910
 	  chip family.
+
+comment "Generic GPIO switch"
+
+config GENERIC_GPIO_SWITCH
+       tristate "Generic GPIO switch"
+       help
+         Provide a generic GPIO interface for drivers that require some
+	 external logic for the device they serve to operate.
+
 endif
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 007f54b..b31f41a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -64,3 +64,6 @@ obj-$(CONFIG_GPIO_WM831X)	+= gpio-wm831x.o
 obj-$(CONFIG_GPIO_WM8350)	+= gpio-wm8350.o
 obj-$(CONFIG_GPIO_WM8994)	+= gpio-wm8994.o
 obj-$(CONFIG_GPIO_XILINX)	+= gpio-xilinx.o
+
+# Not a GPIO HW driver
+obj-$(CONFIG_GENERIC_GPIO_SWITCH)	+= gpio-switch.o
diff --git a/drivers/gpio/gpio-switch.c b/drivers/gpio/gpio-switch.c
new file mode 100644
index 0000000..ea0c390
--- /dev/null
+++ b/drivers/gpio/gpio-switch.c
@@ -0,0 +1,389 @@
+/*
+ * drivers/gpio/gpio-switch.c
+ *
+ * Copyright (C) 2012  Lothar Wassmann <LW@KARO-electronics.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ *
+ * Provide a generic interface for drivers that require to switch some
+ * external hardware such as transceivers, power enable or reset pins
+ * for the device they manage to work.
+ *
+ * Allows multiple devices to share a common switch.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio-switch.h>
+
+static LIST_HEAD(gpio_switch_list);
+static DEFINE_MUTEX(gpio_switch_list_lock);
+static int gpio_switch_index;
+
+struct gpio_sw {
+	struct list_head list;
+	struct device *parent;
+	int id;
+	const char *label;
+	int gpio;
+	unsigned flags;
+	int use_count;
+	int enable_count;
+	unsigned state:1;
+};
+
+/* Helper functions; must be called with 'gpio_switch_list_lock' held */
+static struct gpio_sw *gpio_switch_find_gpio(struct device *parent,
+					int gpio)
+{
+	struct gpio_sw *sw;
+
+	list_for_each_entry(sw, &gpio_switch_list, list) {
+		if (gpio_is_valid(gpio) && sw->gpio != gpio)
+			continue;
+		return sw;
+	}
+	return NULL;
+}
+
+static struct gpio_sw *gpio_switch_find_by_phandle(struct device *parent,
+					phandle ph)
+{
+	struct gpio_sw *sw;
+	struct device_node *dp;
+
+	dp = of_find_node_by_phandle(ph);
+	if (dp == NULL)
+		return NULL;
+
+	list_for_each_entry(sw, &gpio_switch_list, list) {
+		if (sw->parent && sw->parent->of_node == dp)
+			return sw;
+	}
+	return NULL;
+}
+
+static struct gpio_sw *gpio_switch_find_by_id(struct device *parent,
+					int id)
+{
+	struct gpio_sw *sw;
+
+	list_for_each_entry(sw, &gpio_switch_list, list) {
+		if (sw->parent && to_platform_device(sw->parent)->id == id)
+			return sw;
+	}
+	return NULL;
+}
+
+static void gpio_switch_delete(struct gpio_sw *sw)
+{
+	list_del_init(&sw->list);
+	if (!(sw->flags & GPIO_SW_SHARED) ||
+	    !gpio_switch_find_gpio(sw->parent, sw->gpio))
+		gpio_free(sw->gpio);
+}
+
+/* GPIO accessor */
+static void gpio_switch_set_value(struct gpio_sw *sw, int on)
+{
+	gpio_set_value(sw->gpio, !on ^ !(sw->flags & GPIO_SW_ACTIVE_LOW));
+}
+
+/* Provider API */
+int gpio_switch_register(struct device *parent, const char *id, int gpio,
+			 enum gpio_sw_flags flags)
+{
+	int ret;
+	struct platform_device *pdev;
+	struct gpio_sw_platform_data *pdata;
+
+	if (!gpio_is_valid(gpio)) {
+		dev_err(parent, "Invalid GPIO %u\n", gpio);
+		return -EINVAL;
+	}
+
+	pdata = devm_kzalloc(parent, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->gpio = gpio;
+	pdata->flags = flags;
+
+	mutex_lock(&gpio_switch_list_lock);
+	pdev = platform_device_alloc("gpio-switch", gpio_switch_index++);
+	mutex_unlock(&gpio_switch_list_lock);
+	if (pdev == NULL)
+		return -ENOMEM;
+
+	pdev->dev.parent = parent;
+	pdev->dev.platform_data = pdata;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto pdev_free;
+
+	return 0;
+
+ pdev_free:
+	platform_device_put(pdev);
+	return ret;
+}
+EXPORT_SYMBOL(gpio_switch_register);
+
+int gpio_switch_unregister(struct gpio_sw *sw)
+{
+	int ret = -EINVAL;
+	struct gpio_sw *ptr;
+
+	mutex_lock(&gpio_switch_list_lock);
+	list_for_each_entry(ptr, &gpio_switch_list, list) {
+		if (sw == ptr) {
+			gpio_switch_delete(sw);
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&gpio_switch_list_lock);
+	return ret;
+}
+EXPORT_SYMBOL(gpio_switch_unregister);
+
+/* Consumer API */
+struct gpio_sw *request_gpio_switch(struct device *dev, u32 id)
+{
+	struct gpio_sw *sw;
+	struct device_node *np = dev->of_node;
+
+	mutex_lock(&gpio_switch_list_lock);
+	if (np)
+		sw = gpio_switch_find_by_phandle(dev, id);
+	else
+		sw = gpio_switch_find_by_id(dev, id);
+
+	if (sw)
+		sw->use_count++;
+	mutex_unlock(&gpio_switch_list_lock);
+
+	if (sw)
+		dev_dbg(dev, "Found gpio-switch %p\n", sw);
+	else
+		dev_dbg(dev, "No gpio found for ID %08x\n", id);
+
+	return sw;
+}
+EXPORT_SYMBOL(request_gpio_switch);
+
+void free_gpio_switch(struct gpio_sw *sw)
+{
+	if (!sw)
+		return;
+
+	mutex_lock(&gpio_switch_list_lock);
+	sw->use_count--;
+	mutex_unlock(&gpio_switch_list_lock);
+}
+EXPORT_SYMBOL(free_gpio_switch);
+
+void __gpio_switch_set(struct gpio_sw *sw, int on)
+{
+	if (!(sw->flags & GPIO_SW_SHARED))
+		gpio_switch_set_value(sw, on);
+	else
+		if ((on && (sw->enable_count++ == 0)) ||
+			(!on && (--sw->enable_count == 0))) {
+			WARN_ON(sw->enable_count < 0);
+			gpio_switch_set_value(sw, on);
+		}
+}
+EXPORT_SYMBOL(__gpio_switch_set);
+
+void gpio_switch_set_suspend_state(struct gpio_sw *sw, int suspend_state)
+{
+	switch (suspend_state) {
+	case 0:
+		sw->flags |= GPIO_SW_SUSPEND_OFF;
+		break;
+
+	case 1:
+		sw->flags |= GPIO_SW_SUSPEND_ON;
+		break;
+
+	default:
+		sw->flags &= ~(GPIO_SW_SUSPEND_ON | GPIO_SW_SUSPEND_OFF);
+	}
+}
+EXPORT_SYMBOL(gpio_switch_set_suspend_state);
+
+void gpio_switch_set_resume_state(struct gpio_sw *sw, int resume_state)
+{
+	switch (resume_state) {
+	case 0:
+		sw->flags |= GPIO_SW_RESUME_OFF;
+		break;
+
+	case 1:
+		sw->flags |= GPIO_SW_RESUME_ON;
+		break;
+
+	default:
+		sw->flags &= ~(GPIO_SW_RESUME_ON | GPIO_SW_RESUME_OFF);
+	}
+}
+EXPORT_SYMBOL(gpio_switch_set_resume_state);
+
+/* Driver boilerplate */
+static int __devinit gpio_switch_platform_probe(struct platform_device *pdev,
+						struct gpio_sw *sw)
+{
+	struct gpio_sw_platform_data *pdata = pdev->dev.platform_data;
+
+	sw->gpio = pdata->gpio;
+	if (!gpio_is_valid(sw->gpio))
+		return -EINVAL;
+
+	sw->flags = pdata->flags;
+	sw->label = pdata->label;
+	if (pdata->init_state) {
+		if (pdata->init_state == GPIO_SW_INIT_ACTIVE)
+			sw->enable_count++;
+	}
+	return 0;
+}
+
+static int __devinit gpio_switch_dt_probe(struct platform_device *pdev,
+					  struct gpio_sw *sw)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int gpio;
+	enum of_gpio_flags gpio_flags;
+	const u32 *prop;
+
+	of_property_read_string(np, "label", &sw->label);
+
+	gpio = of_get_named_gpio_flags(np, "gpios", 0, &gpio_flags);
+	if (!gpio_is_valid(gpio)) {
+		dev_err(&pdev->dev, "No valid GPIO specified for '%s'\n",
+			sw->label ?: "unknown");
+		return -EINVAL;
+	}
+
+	sw->gpio = gpio;
+	if (gpio_flags & OF_GPIO_ACTIVE_LOW)
+		sw->flags |= GPIO_SW_ACTIVE_LOW;
+
+	if (of_get_property(np, "shared-gpio", NULL))
+		sw->flags |= GPIO_SW_SHARED;
+
+	prop = of_get_property(np, "suspend-state", NULL);
+	if (prop)
+		gpio_switch_set_suspend_state(sw, *prop);
+
+	prop = of_get_property(np, "resume-state", NULL);
+	if (prop)
+		gpio_switch_set_resume_state(sw, *prop);
+
+	prop = of_get_property(np, "init-state", NULL);
+	if (prop) {
+		if (*prop)
+			sw->enable_count++;
+	}
+	return 0;
+}
+
+static int __devinit gpio_switch_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct gpio_sw_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_sw *sw;
+
+	sw = devm_kzalloc(&pdev->dev, sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return -ENOMEM;
+
+	if (pdata)
+		ret = gpio_switch_platform_probe(pdev, sw);
+	else
+		ret = gpio_switch_dt_probe(pdev, sw);
+	if (ret)
+		return ret;
+
+	INIT_LIST_HEAD(&sw->list);
+	sw->parent = &pdev->dev;
+
+	if (!(sw->flags & GPIO_SW_SHARED) ||
+	    !gpio_switch_find_gpio(sw->parent, sw->gpio)) {
+		ret = gpio_request(sw->gpio, sw->label);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request GPIO%d '%s'\n",
+				sw->gpio, sw->label);
+			return ret;
+		}
+		gpio_direction_output(sw->gpio, !!sw->enable_count ^
+				!(sw->flags & GPIO_SW_ACTIVE_LOW));
+	}
+	platform_set_drvdata(pdev, sw);
+
+	mutex_lock(&gpio_switch_list_lock);
+	list_add(&sw->list, &gpio_switch_list);
+	mutex_unlock(&gpio_switch_list_lock);
+
+	dev_info(&pdev->dev, "GPIO%u registered for '%s'\n",
+		sw->gpio, sw->label ?: "unknown");
+	return 0;
+}
+
+static int __devexit gpio_switch_remove(struct platform_device *pdev)
+{
+	struct gpio_sw *sw, *tmp;
+
+	list_for_each_entry_safe(sw, tmp, &gpio_switch_list, list) {
+		gpio_switch_unregister(sw);
+	}
+	return 0;
+}
+
+static struct of_device_id gpio_switch_dt_ids[] = {
+	{ .compatible = "linux,gpio-switch", },
+	{ /* sentinel */ }
+};
+
+struct platform_driver gpio_switch_driver = {
+	.driver = {
+		.name = "gpio-switch",
+		.owner = THIS_MODULE,
+		.of_match_table = gpio_switch_dt_ids,
+	},
+	.probe = gpio_switch_probe,
+	.remove = __devexit_p(gpio_switch_remove),
+};
+
+static int __init gpio_switch_init(void)
+{
+	return platform_driver_register(&gpio_switch_driver);
+}
+arch_initcall(gpio_switch_init);
+
+static void __exit gpio_switch_exit(void)
+{
+	platform_driver_unregister(&gpio_switch_driver);
+}
+module_exit(gpio_switch_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Lother Wa?mann <LW@KARO-electronics.de>");
+MODULE_DESCRIPTION("Generic GPIO switch driver");
+MODULE_ALIAS("platform:gpio_switch");
diff --git a/include/linux/gpio-switch.h b/include/linux/gpio-switch.h
new file mode 100644
index 0000000..23893ab
--- /dev/null
+++ b/include/linux/gpio-switch.h
@@ -0,0 +1,47 @@
+#ifndef LINUX_GPIO_SWITCH_H
+#define LINUX_GPIO_SWITCH_H
+
+enum gpio_sw_flags {
+	GPIO_SW_ACTIVE_LOW	= (1 << 0),
+	GPIO_SW_SHARED		= (1 << 1),
+	GPIO_SW_SUSPEND_ON	= (1 << 2),
+	GPIO_SW_SUSPEND_OFF	= (1 << 3),
+	GPIO_SW_RESUME_ON	= (1 << 4),
+	GPIO_SW_RESUME_OFF	= (1 << 5),
+};
+
+enum gpio_sw_initstate {
+	GPIO_SW_INIT_NONE,
+	GPIO_SW_INIT_ACTIVE,
+	GPIO_SW_INIT_INACTIVE,
+};
+
+struct gpio_sw_platform_data {
+	const char *label;
+	int gpio;
+	enum gpio_sw_flags flags;
+	int init_state;
+};
+
+struct gpio_sw;
+
+extern int gpio_switch_register(struct device *parent, const char *id, int gpio,
+			 enum gpio_sw_flags flags);
+
+extern int gpio_switch_unregister(struct gpio_sw *sw);
+extern struct gpio_sw *request_gpio_switch(struct device *dev, u32 id);
+extern void free_gpio_switch(struct gpio_sw *sw);
+extern void __gpio_switch_set(struct gpio_sw *sw, int on);
+
+static inline void gpio_switch_set(struct gpio_sw *sw, int on)
+{
+	if (!sw)
+		return;
+
+	__gpio_switch_set(sw, on);
+}
+
+extern void gpio_switch_set_suspend_state(struct gpio_sw *sw, int suspend_state);
+extern void gpio_switch_set_resume_state(struct gpio_sw *sw, int resume_state);
+
+#endif
-- 
1.7.2.5
