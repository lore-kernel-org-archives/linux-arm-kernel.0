From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jul 2011 14:08:08 +0100
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information via
	sysfs
Message-ID: <1310476090-9807-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/base/Kconfig    |   10 +++++
 drivers/base/Makefile   |    1 +
 drivers/base/soc.c      |   98 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |   45 +++++++++++++++++++++
 4 files changed, 154 insertions(+), 0 deletions(-)
 create mode 100644 drivers/base/soc.c
 create mode 100644 include/linux/sys_soc.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index d57e8d0..2feab2b 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -168,4 +168,14 @@ config SYS_HYPERVISOR
 	bool
 	default n
 
+config ARCH_NO_SYSDEV_OPS
+	bool
+	---help---
+	  To be selected by architectures that don't use sysdev class or
+	  sysdev driver power management (suspend/resume) and shutdown
+	  operations.
+
+config SYS_SOC
+	bool
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 4c5701c..a0d246d 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -18,6 +18,7 @@ ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_MODULES)	+= module.o
 endif
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
+obj-$(CONFIG_SYS_SOC) += soc.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
new file mode 100644
index 0000000..30659f4
--- /dev/null
+++ b/drivers/base/soc.c
@@ -0,0 +1,98 @@
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
+struct device_attribute soc_attrs[] = {
+	__ATTR(machine,  S_IRUGO, NULL, NULL),
+	__ATTR(family,   S_IRUGO, NULL, NULL),
+	__ATTR(soc_id,   S_IRUGO, NULL, NULL),
+	__ATTR(revision, S_IRUGO, NULL, NULL),
+	__ATTR_NULL,
+};
+
+const char *soc_names[] = { "1", "2", "3", "4", "5", "6", "7", "8" };
+static int soc_count = 0;
+
+static struct device soc_grandparent = {
+	.init_name = "soc",
+};
+
+static int soc_device_create_files(struct device *soc);
+static void soc_device_remove_files(struct device *soc);
+
+static int __init soc_device_create_files(struct device *soc)
+{
+	int ret = 0;
+	int i   = 0;
+
+	while (soc_attrs[i].attr.name != NULL) {
+		ret = device_create_file(soc, &soc_attrs[i++]);
+		if (ret)
+			goto out;
+	}
+	return ret;
+
+out:
+	soc_device_remove_files(soc);
+	return ret;
+}
+
+static void __exit soc_device_remove_files(struct device *soc)
+{
+	int i = 0;
+
+	while (soc_attrs[i++].attr.name != NULL)
+		device_remove_file(soc, &soc_attrs[i]);
+}
+
+int __init soc_device_register(struct device *soc_parent,
+			struct soc_callback_functions *soc_callbacks)
+{
+	int ret;
+
+	soc_attrs[MACHINE].show = soc_callbacks->get_machine_fn;
+	soc_attrs[FAMILY].show = soc_callbacks->get_family_fn;
+	soc_attrs[SOCID].show = soc_callbacks->get_soc_id_fn;
+	soc_attrs[REVISION].show = soc_callbacks->get_revision_fn;
+
+	if (!soc_count) {
+		/* Register top-level SoC device '/sys/devices/soc' */
+		ret = device_register(&soc_grandparent);
+		if (ret)
+			return ret;
+	}
+
+	soc_parent->init_name = soc_names[soc_count];
+	soc_parent->parent = &soc_grandparent;
+
+	ret = device_register(soc_parent);
+	if (ret)
+		return ret;
+
+	soc_device_create_files(soc_parent);
+
+	soc_count++;
+
+	return ret;
+}
+
+void __exit soc_device_unregister(struct device *soc_parent)
+{
+	/* Unregister and free SoC from sysfs */
+	soc_device_remove_files(soc_parent);
+	device_unregister(soc_parent);
+
+	if (--soc_count == 0)
+		/* Unregister top-level SoC device '/sys/devices/soc' */
+	device_unregister(&soc_grandparent);
+}
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
new file mode 100644
index 0000000..94d5707
--- /dev/null
+++ b/include/linux/sys_soc.h
@@ -0,0 +1,45 @@
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
+#define MAX_SOCS 8
+#define MACHINE  0
+#define FAMILY   1
+#define SOCID    2
+#define REVISION 3
+
+struct soc_callback_functions {
+	ssize_t (*get_machine_fn)(struct device *dev,
+				struct device_attribute *attr, char *buf);
+	ssize_t (*get_family_fn)(struct device *dev,
+				struct device_attribute *attr, char *buf);
+	ssize_t (*get_soc_id_fn)(struct device *dev,
+				struct device_attribute *attr, char *buf);
+	ssize_t (*get_revision_fn)(struct device *dev,
+				struct device_attribute *attr, char *buf);
+};
+
+/**
+ * soc_device_register - register SoC as a device
+ * @soc_attr: Array of sysfs file attributes
+ * @soc: Parent node '/sys/devices/soc'
+ */
+int soc_device_register(struct device *soc_parent,
+			struct soc_callback_functions *soc_callbacks);
+
+/**
+ *  soc_device_unregister - unregister SoC as a device
+ * @soc_attr: Array of sysfs file attributes
+ * @soc: Parent node '/sys/devices/soc'
+ */
+void soc_device_unregister(struct device *soc_parent);
+
+#endif /* __SYS_SOC_H */
-- 
1.7.4.1
