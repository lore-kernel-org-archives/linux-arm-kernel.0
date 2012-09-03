From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:28 +0100
Subject: [PATCH 08/11] hwmon: Versatile Express hwmon driver
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-9-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hwmon framework driver for Versatile Express sensors, providing
information about board level voltage (only when regulator driver
is not configured), currents, temperature and power/energy usage.
Labels for the values can be defined as DT properties.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/hwmon/Kconfig    |    8 ++
 drivers/hwmon/Makefile   |    1 +
 drivers/hwmon/vexpress.c |  275 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 284 insertions(+)
 create mode 100644 drivers/hwmon/vexpress.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b0a2e4c..3915794 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1187,6 +1187,14 @@ config SENSORS_TWL4030_MADC
 	This driver can also be built as a module. If so it will be called
 	twl4030-madc-hwmon.
 
+config SENSORS_VEXPRESS
+	tristate "Versatile Express"
+	depends on VEXPRESS_CONFIG_BUS
+	help
+	  This driver provides support for hardware sensors available on
+	  the ARM Ltd's Versatile Express platform. It can provide wide
+	  range of information like temperature, power, energy.
+
 config SENSORS_VIA_CPUTEMP
 	tristate "VIA CPU temperature sensor"
 	depends on X86
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 7aa9811..e719a7d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_SENSORS_TMP102)	+= tmp102.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
+obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress.c
new file mode 100644
index 0000000..7ada171
--- /dev/null
+++ b/drivers/hwmon/vexpress.c
@@ -0,0 +1,275 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#define DRVNAME "vexpress-hwmon"
+#define pr_fmt(fmt) DRVNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/vexpress.h>
+
+static struct device *vexpress_hwmon_dev;
+static int vexpress_hwmon_dev_refcount;
+static DEFINE_SPINLOCK(vexpress_hwmon_dev_lock);
+
+static ssize_t vexpress_hwmon_name_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	return sprintf(buffer, "%s\n", DRVNAME);
+}
+
+static struct device_attribute vexpress_hwmon_name_attr =
+		__ATTR(name, 0444, vexpress_hwmon_name_show, NULL);
+
+struct vexpress_hwmon_attrs {
+	struct vexpress_config_device *vecdev;
+	const char *label;
+	struct device_attribute label_attr;
+	char label_name[16];
+	struct device_attribute input_attr;
+	char input_name[16];
+	u32 divisor;
+};
+
+static ssize_t vexpress_hwmon_label_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attrs *attrs = container_of(dev_attr,
+			struct vexpress_hwmon_attrs, label_attr);
+
+	return snprintf(buffer, PAGE_SIZE, "%s\n", attrs->label);
+}
+
+static ssize_t vexpress_hwmon_u32_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attrs *attrs = container_of(dev_attr,
+			struct vexpress_hwmon_attrs, input_attr);
+	int err;
+	u32 value;
+
+	err = vexpress_config_read(attrs->vecdev, 0, &value);
+	if (err)
+		return err;
+
+	return snprintf(buffer, PAGE_SIZE, "%u\n", value / attrs->divisor);
+}
+
+static ssize_t vexpress_hwmon_u64_show(struct device *dev,
+		struct device_attribute *dev_attr, char *buffer)
+{
+	struct vexpress_hwmon_attrs *attrs = container_of(dev_attr,
+			struct vexpress_hwmon_attrs, input_attr);
+	int err;
+	u32 value_hi, value_lo;
+
+	err = vexpress_config_read(attrs->vecdev, 0, &value_lo);
+	if (err)
+		return err;
+
+	err = vexpress_config_read(attrs->vecdev, 1, &value_hi);
+	if (err)
+		return err;
+
+	return snprintf(buffer, PAGE_SIZE, "%llu\n",
+			div_u64(((u64)value_hi << 32) | value_lo,
+			attrs->divisor));
+}
+
+static struct device *vexpress_hwmon_dev_get(void)
+{
+	struct device *result;
+
+	spin_lock(&vexpress_hwmon_dev_lock);
+
+	if (vexpress_hwmon_dev) {
+		result = vexpress_hwmon_dev;
+	} else {
+		int err;
+
+		result = hwmon_device_register(NULL);
+		if (IS_ERR(result))
+			goto out;
+
+		err = device_create_file(result, &vexpress_hwmon_name_attr);
+		if (err) {
+			result = ERR_PTR(err);
+			hwmon_device_unregister(result);
+			goto out;
+		}
+
+		vexpress_hwmon_dev = result;
+	}
+
+	vexpress_hwmon_dev_refcount++;
+
+out:
+	spin_unlock(&vexpress_hwmon_dev_lock);
+
+	return result;
+}
+
+static void vexpress_hwmon_dev_put(void)
+{
+	spin_lock(&vexpress_hwmon_dev_lock);
+
+	if (--vexpress_hwmon_dev_refcount == 0) {
+		vexpress_hwmon_dev = NULL;
+		hwmon_device_unregister(vexpress_hwmon_dev);
+	}
+
+	WARN_ON(vexpress_hwmon_dev_refcount < 0);
+
+	spin_unlock(&vexpress_hwmon_dev_lock);
+}
+
+static struct {
+	const char *name;
+	u32 divisor;
+	atomic_t index;
+} vexpress_hwmon_func_list[] = {
+	[VEXPRESS_CONFIG_FUNC_VOLT] = { .name = "in", .divisor = 1000, },
+	[VEXPRESS_CONFIG_FUNC_AMP] = { .name = "curr", .divisor = 1000, },
+	[VEXPRESS_CONFIG_FUNC_TEMP] = { .name = "temp", .divisor = 1000, },
+	[VEXPRESS_CONFIG_FUNC_POWER] = { .name = "power", .divisor = 1, },
+	[VEXPRESS_CONFIG_FUNC_ENERGY] = { .name = "energy", .divisor = 1, },
+};
+
+static int vexpress_hwmon_probe(struct vexpress_config_device *vecdev)
+{
+	int err;
+	struct device *hwmon_dev;
+	unsigned func = vecdev->func;
+	struct vexpress_hwmon_attrs *attrs;
+	const char *attr_name;
+	int attr_index;
+
+	hwmon_dev = vexpress_hwmon_dev_get();
+	if (IS_ERR(hwmon_dev)) {
+		err = PTR_ERR(hwmon_dev);
+		goto error_hwmon_dev_get;
+	}
+
+	attrs = devm_kzalloc(&vecdev->dev, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs) {
+		err = -ENOMEM;
+		goto error_kzalloc;
+	}
+	attrs->vecdev = vecdev;
+
+	err = sysfs_create_link(&vecdev->dev.kobj, &hwmon_dev->kobj, "hwmon");
+	if (err)
+		goto error_create_link;
+
+	attr_index = atomic_inc_return(&vexpress_hwmon_func_list[func].index);
+	attr_name = vexpress_hwmon_func_list[func].name;
+
+	snprintf(attrs->input_name, sizeof(attrs->input_name),
+			"%s%d_input", attr_name, attr_index);
+	attrs->input_attr.attr.name = attrs->input_name;
+	attrs->input_attr.attr.mode = 0444;
+	if (func == VEXPRESS_CONFIG_FUNC_ENERGY)
+		attrs->input_attr.show = vexpress_hwmon_u64_show;
+	else
+		attrs->input_attr.show = vexpress_hwmon_u32_show;
+	sysfs_attr_init(&attrs->input_attr.attr);
+	err = device_create_file(hwmon_dev, &attrs->input_attr);
+	if (err)
+		goto error_create_input;
+
+	attrs->label = of_get_property(vecdev->dev.of_node, "label", NULL);
+	if (attrs->label) {
+		snprintf(attrs->label_name, sizeof(attrs->label_name),
+				"%s%d_label", attr_name, attr_index);
+		attrs->label_attr.attr.name = attrs->label_name;
+		attrs->label_attr.attr.mode = 0444;
+		attrs->label_attr.show = vexpress_hwmon_label_show;
+		sysfs_attr_init(&attrs->label_attr.attr);
+		err = device_create_file(hwmon_dev, &attrs->label_attr);
+		if (err)
+			goto error_create_label;
+	}
+
+	attrs->divisor = vexpress_hwmon_func_list[func].divisor;
+
+	vexpress_config_set_drvdata(vecdev, attrs);
+
+	return 0;
+
+error_create_label:
+	device_remove_file(hwmon_dev, &attrs->input_attr);
+error_create_input:
+	sysfs_remove_link(&vecdev->dev.kobj, "hwmon");
+error_create_link:
+error_kzalloc:
+	vexpress_hwmon_dev_put();
+error_hwmon_dev_get:
+	return err;
+}
+
+static int __devexit vexpress_hwmon_remove(struct vexpress_config_device
+		*vecdev)
+{
+	struct vexpress_hwmon_attrs *attrs =
+			vexpress_config_get_drvdata(vecdev);
+
+	if (attrs->label)
+		device_remove_file(vexpress_hwmon_dev, &attrs->label_attr);
+	device_remove_file(vexpress_hwmon_dev, &attrs->input_attr);
+	atomic_dec(&vexpress_hwmon_func_list[vecdev->func].index);
+	sysfs_remove_link(&vecdev->dev.kobj, "hwmon");
+	vexpress_hwmon_dev_put();
+
+	return 0;
+}
+
+static const unsigned vexpress_hwmon_funcs[] = {
+#if !defined(CONFIG_REGULATOR_VEXPRESS)
+	VEXPRESS_CONFIG_FUNC_VOLT,
+#endif
+	VEXPRESS_CONFIG_FUNC_AMP,
+	VEXPRESS_CONFIG_FUNC_TEMP,
+	VEXPRESS_CONFIG_FUNC_POWER,
+	VEXPRESS_CONFIG_FUNC_ENERGY,
+	0,
+};
+
+static struct vexpress_config_driver vexpress_hwmon_driver = {
+	.funcs = vexpress_hwmon_funcs,
+	.probe = vexpress_hwmon_probe,
+	.remove = __devexit_p(vexpress_hwmon_remove),
+	.driver	= {
+		.name = DRVNAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init vexpress_hwmon_init(void)
+{
+	return vexpress_config_driver_register(&vexpress_hwmon_driver);
+}
+
+static void __exit vexpress_hwmon_exit(void)
+{
+	vexpress_config_driver_unregister(&vexpress_hwmon_driver);
+}
+
+MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
+MODULE_DESCRIPTION("Versatile Express hwmon");
+MODULE_LICENSE("GPL");
+
+module_init(vexpress_hwmon_init);
+module_exit(vexpress_hwmon_exit);
-- 
1.7.9.5
