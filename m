From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Feb 2012 11:22:22 -0800
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
References: <1328556146-3730-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1328556146-3730-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Traditionally, any System-on-Chip based platform creates a flat list
of platform_devices directly under /sys/devices/platform.

In order to give these some better structure, this introduces a new
bus type for soc_devices that are registered with the new
soc_device_register() function.  All devices that are on the same
chip should then be registered as child devices of the soc device.

The soc bus also exports a few standardised device attributes which
allow user space to query the specific type of soc.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/base/Kconfig    |    3 +
 drivers/base/Makefile   |    1 +
 drivers/base/soc.c      |  183 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |   37 ++++++++++
 4 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 drivers/base/soc.c
 create mode 100644 include/linux/sys_soc.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 7be9f79..9aa618a 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -176,6 +176,9 @@ config GENERIC_CPU_DEVICES
 	bool
 	default n
 
+config SOC_BUS
+	bool
+
 source "drivers/base/regmap/Kconfig"
 
 config DMA_SHARED_BUFFER
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 2c8272d..4f302a6 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MODULES)	+= module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
+obj-$(CONFIG_SOC_BUS) += soc.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
new file mode 100644
index 0000000..05f1503
--- /dev/null
+++ b/drivers/base/soc.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/sysfs.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+#include <linux/sys_soc.h>
+#include <linux/err.h>
+
+static DEFINE_IDR(soc_ida);
+static DEFINE_SPINLOCK(soc_lock);
+
+static ssize_t soc_info_get(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf);
+
+struct soc_device {
+	struct device dev;
+	struct soc_device_attribute *attr;
+	int soc_dev_num;
+};
+
+static struct bus_type soc_bus_type = {
+	.name  = "soc",
+};
+
+static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
+
+struct device *soc_device_to_device(struct soc_device *soc_dev)
+{
+	return &soc_dev->dev;
+}
+
+static mode_t soc_attribute_mode(struct kobject *kobj,
+                                 struct attribute *attr,
+                                 int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+
+	if ((attr == &dev_attr_machine.attr)
+	    && (soc_dev->attr->machine != NULL))
+		return attr->mode;
+	if ((attr == &dev_attr_family.attr)
+	    && (soc_dev->attr->family != NULL))
+		return attr->mode;
+	if ((attr == &dev_attr_revision.attr)
+	    && (soc_dev->attr->revision != NULL))
+		return attr->mode;
+	if ((attr == &dev_attr_soc_id.attr)
+	    && (soc_dev->attr->soc_id != NULL))
+	        return attr->mode;
+
+	/* Unknown or unfilled attribute. */
+	return 0;
+}
+
+static ssize_t soc_info_get(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+
+	if (attr == &dev_attr_machine)
+		return sprintf(buf, "%s\n", soc_dev->attr->machine);
+	if (attr == &dev_attr_family)
+		return sprintf(buf, "%s\n", soc_dev->attr->family);
+	if (attr == &dev_attr_revision)
+		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+	if (attr == &dev_attr_soc_id)
+		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
+
+	return -EINVAL;
+
+}
+
+static struct attribute *soc_attr[] = {
+	&dev_attr_machine.attr,
+	&dev_attr_family.attr,
+	&dev_attr_soc_id.attr,
+	&dev_attr_revision.attr,
+	NULL,
+};
+
+static const struct attribute_group soc_attr_group = {
+	.attrs = soc_attr,
+	.is_visible = soc_attribute_mode,
+};
+
+static const struct attribute_group *soc_attr_groups[] = {
+	&soc_attr_group,
+	NULL,
+};
+
+static void soc_release(struct device *dev)
+{
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+
+	kfree(soc_dev);
+}
+
+struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr)
+{
+	struct soc_device *soc_dev;
+	int ret;
+
+	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
+	if (!soc_dev) {
+	        ret = -ENOMEM;
+		goto out1;
+	}
+
+	/* Fetch a unique (reclaimable) SOC ID. */
+	do {
+		if (!ida_pre_get(&soc_ida, GFP_KERNEL)) {
+			ret = -ENOMEM;
+			goto out2;
+		}
+
+		spin_lock(&soc_lock);
+		ret = ida_get_new(&soc_ida, &soc_dev->soc_dev_num);
+		spin_unlock(&soc_lock);
+
+	} while (ret == -EAGAIN);
+
+	if (ret)
+	         goto out2;
+
+	soc_dev->attr = soc_dev_attr;
+	soc_dev->dev.bus = &soc_bus_type;
+	soc_dev->dev.groups = soc_attr_groups;
+	soc_dev->dev.release = soc_release;
+
+	dev_set_name(&soc_dev->dev, "soc%d", soc_dev->soc_dev_num);
+
+	ret = device_register(&soc_dev->dev);
+	if (ret)
+		goto out3;
+
+	return soc_dev;
+
+out3:
+	ida_remove(&soc_ida, soc_dev->soc_dev_num);
+out2:
+	kfree(soc_dev);
+out1:
+	return ERR_PTR(ret);
+}
+
+/* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
+void soc_device_unregister(struct soc_device *soc_dev)
+{
+	ida_remove(&soc_ida, soc_dev->soc_dev_num);
+
+	device_unregister(&soc_dev->dev);
+}
+
+static int __init soc_bus_register(void)
+{
+	spin_lock_init(&soc_lock);
+
+	return bus_register(&soc_bus_type);
+}
+core_initcall(soc_bus_register);
+
+static void __exit soc_bus_unregister(void)
+{
+	ida_destroy(&soc_ida);
+
+	bus_unregister(&soc_bus_type);
+}
+module_exit(soc_bus_unregister);
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
new file mode 100644
index 0000000..2739ccb
--- /dev/null
+++ b/include/linux/sys_soc.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#ifndef __SOC_BUS_H
+#define __SOC_BUS_H
+
+#include <linux/device.h>
+
+struct soc_device_attribute {
+	const char *machine;
+	const char *family;
+	const char *revision;
+	const char *soc_id;
+};
+
+/**
+ * soc_device_register - register SoC as a device
+ * @soc_plat_dev_attr: Attributes passed from platform to be attributed to a SoC
+ */
+struct soc_device *soc_device_register(
+	struct soc_device_attribute *soc_plat_dev_attr);
+
+/**
+ * soc_device_unregister - unregister SoC device
+ * @dev: SoC device to be unregistered
+ */
+void soc_device_unregister(struct soc_device *soc_dev);
+
+/**
+ * soc_device_to_device - helper function to fetch struct device
+ * @soc: Previously registered SoC device container
+ */
+struct device *soc_device_to_device(struct soc_device *soc);
+
+#endif /* __SOC_BUS_H */
-- 
1.7.5.4
