From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  1 Sep 2011 13:27:19 +0100
Subject: [PATCH 1/5] Framework for exporting System-on-Chip information via
	sysfs
Message-ID: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a new driver to drivers/base. The
driver provides a means to export vital SoC data out to
userspace via sysfs. Standard information applicable to all
SoCs are exported to:

/sys/devices/soc/[1|2|3|...]/[family|machine|revision|soc_id].

It is possible to create SoC specific items via the
soc device, which is returned post-registration, although
this should be discouraged.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/base/Kconfig    |    3 +
 drivers/base/Makefile   |    1 +
 drivers/base/soc.c      |  103 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |   27 ++++++++++++
 4 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 drivers/base/soc.c
 create mode 100644 include/linux/sys_soc.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 21cf46f..95f10c5 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -172,6 +172,9 @@ config SYS_HYPERVISOR
 	bool
 	default n
 
+config SYS_SOC
+	bool
+
 source "drivers/base/regmap/Kconfig"
 
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 99a375a..a67a1e7 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_MODULES)	+= module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
+obj-$(CONFIG_SYS_SOC) += soc.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
new file mode 100644
index 0000000..e9d908b
--- /dev/null
+++ b/drivers/base/soc.c
@@ -0,0 +1,103 @@
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
+#include <linux/sys_soc.h>
+
+static DEFINE_SPINLOCK(register_lock);
+static int soc_count = 0;
+
+static struct device soc_grandparent = {
+	.init_name = "soc",
+};
+
+static ssize_t soc_info_get(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+
+	if (!strcmp(attr->attr.name, "machine"))
+		return sprintf(buf, "%s\n", soc_dev->machine);
+	if (!strcmp(attr->attr.name, "family"))
+		return sprintf(buf, "%s\n", soc_dev->family);
+	if (!strcmp(attr->attr.name, "revision"))
+		return sprintf(buf, "%s\n", soc_dev->revision);
+	if (!strcmp(attr->attr.name, "soc_id")) {
+		if (soc_dev->pfn_soc_id)
+			return sprintf(buf, "%s\n", soc_dev->pfn_soc_id());
+		else return sprintf(buf, "N/A \n");
+	}
+
+	return -EINVAL;
+}
+
+struct device_attribute soc_attrs[] = {
+	__ATTR(machine,  S_IRUGO, soc_info_get,  NULL),
+	__ATTR(family,   S_IRUGO, soc_info_get,  NULL),
+	__ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL),
+	__ATTR(revision, S_IRUGO, soc_info_get,  NULL),
+	__ATTR_NULL,
+};
+
+static void soc_device_remove_files(struct device *soc, int i)
+{
+	while (i > 0)
+		device_remove_file(soc, &soc_attrs[--i]);
+}
+
+static int __init soc_device_create_files(struct device *dev)
+{
+	int ret = 0;
+	int i   = 0;
+
+	while (soc_attrs[i].attr.name != NULL) {
+		ret = device_create_file(dev, &soc_attrs[i++]);
+		if (ret)
+			goto out;
+	}
+	return ret;
+
+out:
+	soc_device_remove_files(dev, --i);
+	return ret;
+}
+
+int __init soc_device_register(struct device *dev)
+{
+	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
+	int ret;
+
+	spin_lock_irq(&register_lock);
+
+	if (!soc_count) {
+		/* Register top-level SoC device '/sys/devices/soc' */
+		ret = device_register(&soc_grandparent);
+		if (ret) {
+			spin_unlock_irq(&register_lock);
+			return ret;
+		}
+	}
+
+	soc_count++;
+	dev->parent = &soc_grandparent;
+	dev_set_name(dev, "%i_%s", soc_count, soc_dev->machine);
+
+	spin_unlock_irq(&register_lock);
+
+	ret = device_register(dev);
+	if (ret)
+		return ret;
+
+	soc_device_create_files(dev);
+
+	return ret;
+}
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
new file mode 100644
index 0000000..811d7fe
--- /dev/null
+++ b/include/linux/sys_soc.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ * Author: Lee Jones <lee.jones@linaro.org> for ST-Ericsson.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#ifndef __SYS_SOC_H
+#define __SYS_SOC_H
+
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+
+struct soc_device {
+	struct device dev;
+	const char *machine;
+	const char *family;
+	const char *revision;
+	const char *(*pfn_soc_id)(void);
+};
+
+/**
+ * soc_device_register - register SoC as a device
+ * @dev: Parent node '/sys/devices/soc/X'
+ */
+int soc_device_register(struct device *dev);
+
+#endif /* __SYS_SOC_H */
-- 
1.7.4.1
