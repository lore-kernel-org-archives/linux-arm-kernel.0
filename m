From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Mon, 13 Apr 2015 13:05:20 +0200
Subject: [PATCH 2/2] gpio: add driver to export DT configured GPIOs to
 userspace
In-Reply-To: <20150413110515.9681.58848.stgit@localhost>
References: <20150413110515.9681.58848.stgit@localhost>
Message-ID: <20150413110519.9681.95469.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selected GPIOs (defined as child nodes in DT) may be exported as
symlinks to user space (using gpiod_export_link())

The advantages of this are:
* Userspace no longer needs to know the GPIO number (which may
vary with other hardware and with kernel version due to dynamic
allocation)
* Userspace can be prevented from changing the direction if that
does not make sense from a hardware perspective.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/gpio/Kconfig         |    9 ++
 drivers/gpio/Makefile        |    1 
 drivers/gpio/gpio-exporter.c |  171 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)
 create mode 100644 drivers/gpio/gpio-exporter.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 633ec21..682fce2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -110,6 +110,15 @@ config GPIO_DA9055
 config GPIO_MAX730X
 	tristate
 
+config GPIO_EXPORTER
+	tristate "Userspace exporter driver"
+	depends on OF_GPIO && GPIO_SYSFS
+	help
+	  This enables a GPIO consumer which exports some GPIOs to userspace.
+	  The GPIOs to be exported are defined in the device tree.
+	  The exported GPIOs are represented as symbolic links in sysfs,
+	  relieving usespace of the burden of knowing the GPIO number to export
+
 comment "Memory mapped GPIO drivers:"
 
 config GPIO_74XX_MMIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 81755f1..bb665c5 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GPIO_SYSFS)	+= gpiolib-sysfs.o
 obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
 
 # Device drivers. Generally keep list sorted alphabetically
+obj-$(CONFIG_GPIO_EXPORTER)	+= gpio-exporter.o
 obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 
 obj-$(CONFIG_GPIO_74X164)	+= gpio-74x164.o
diff --git a/drivers/gpio/gpio-exporter.c b/drivers/gpio/gpio-exporter.c
new file mode 100644
index 0000000..72cdcf0
--- /dev/null
+++ b/drivers/gpio/gpio-exporter.c
@@ -0,0 +1,171 @@
+/*
+ * A driver that allows some gpios to be exported to userspace
+ * using friendly names.
+ *
+ * This allows the gpios to be exported to be configured in the device tree
+ * and frees userspace from having to know unstable gpio numbers.
+ *
+ * Copyright 2015 Parkeon
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+
+struct gpio_exporter_gpio {
+	const char *name;
+	struct gpio_desc *desc;
+};
+
+struct gpio_exporter_data {
+	struct device *dev;
+	int num_gpios;
+	struct gpio_exporter_gpio *gpios;
+};
+
+static int gpio_exporter_do_one(struct gpio_exporter_data *data,
+				struct fwnode_handle *child)
+{
+	struct device_node *np = of_node(child);
+	const char *name = np->name;
+	const char *config;
+	struct gpio_desc *desc;
+	int ret;
+
+	desc = devm_get_gpiod_from_child(data->dev, child);
+	if (IS_ERR(desc)) {
+		ret = PTR_ERR(desc);
+		goto failed_get;
+	}
+
+	if (of_property_read_bool(np, "output")) {
+		u32 state = 0;
+
+		of_property_read_u32(np, "initial-state", &state);
+		ret = gpiod_direction_output(desc, state);
+	} else {
+		ret = gpiod_direction_input(desc);
+	}
+	if (ret)
+		goto failed_setdir;
+
+	ret = gpiod_export(desc,
+			of_property_read_bool(np, "allow-direction-change"));
+	if (ret)
+		goto failed_export;
+
+	ret = gpiod_export_link(data->dev, name, desc);
+	if (ret)
+		goto failed_link;
+
+	data->gpios[data->num_gpios].name = name;
+	data->gpios[data->num_gpios].desc = desc;
+	data->num_gpios++;
+
+	dev_info(data->dev,
+		"Exported gpio%d as '%s'\n", desc_to_gpio(desc), name);
+
+	return 0;
+
+failed_link:
+	gpiod_unexport(desc);
+
+failed_export:
+failed_setdir:
+failed_get:
+	dev_err(data->dev, "Failed to export gpio '%s': %d\n", name, ret);
+
+	return ret;
+}
+
+static void gpio_exporter_cleanup(struct gpio_exporter_data *data)
+{
+	int i;
+
+	for (i = 0; i < data->num_gpios; i++) {
+		sysfs_remove_link(&data->dev->kobj, data->gpios[i].name);
+		gpiod_unexport(data->gpios[i].desc);
+	}
+}
+
+static int gpio_exporter_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fwnode_handle *child;
+	int num_gpios;
+	int ret;
+	struct gpio_exporter_data *data;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->dev = dev;
+	dev_set_drvdata(dev, data);
+
+	num_gpios = device_get_child_node_count(dev);
+	data->gpios = devm_kzalloc(dev, num_gpios * sizeof(*data->gpios),
+					GFP_KERNEL);
+	if (!data->gpios)
+		return -ENOMEM;
+
+	device_for_each_child_node(dev, child) {
+		ret = gpio_exporter_do_one(data, child);
+		if (ret)
+			goto out_cleanup;
+	}
+
+	dev_info(dev, "exported %d gpios\n", data->num_gpios);
+
+	return 0;
+
+out_cleanup:
+	gpio_exporter_cleanup(data);
+
+	return ret;
+}
+
+static int gpio_exporter_remove(struct platform_device *pdev)
+{
+	struct gpio_exporter_data *data = platform_get_drvdata(pdev);
+
+	gpio_exporter_cleanup(data);
+
+	return 0;
+}
+
+static const struct of_device_id gpio_exporter_dt_ids[] = {
+	 { .compatible = "linux,gpio-exporter", },
+	 { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, gpio_exporter_dt_ids);
+
+static struct platform_driver gpio_exporter_driver = {
+	.driver	= {
+		.name	= "gpio-exporter",
+		.of_match_table	= gpio_exporter_dt_ids,
+	},
+	.probe	= gpio_exporter_probe,
+	.remove = gpio_exporter_remove,
+};
+
+module_platform_driver(gpio_exporter_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Martin Fuzzey <mfuzzey@parkeon.com>");
+MODULE_DESCRIPTION("Userspace GPIO exporter");
+MODULE_ALIAS("platform:gpio-exporter");
