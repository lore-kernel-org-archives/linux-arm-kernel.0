From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Apr 2011 15:49:50 +0100
Subject: [PATCH 1/3] Framework for exporting System-on-Chip information via
	sysfs
In-Reply-To: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
References: <1302792592-17484-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1302792592-17484-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/base/Kconfig    |    3 +
 drivers/base/Makefile   |    1 +
 drivers/base/soc.c      |  127 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sys_soc.h |   29 +++++++++++
 4 files changed, 160 insertions(+), 0 deletions(-)
 create mode 100644 drivers/base/soc.c
 create mode 100644 include/linux/sys_soc.h

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index e9e5238..f381fcc 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -168,6 +168,9 @@ config SYS_HYPERVISOR
 	bool
 	default n
 
+config SYS_SOC
+	bool
+
 config ARCH_NO_SYSDEV_OPS
 	bool
 	---help---
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
index 0000000..5e4d6ef
--- /dev/null
+++ b/drivers/base/soc.c
@@ -0,0 +1,127 @@
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
+struct device *parent_soc;
+struct device *soc[MAX_SOCS];
+
+static void soc_device_remove_files(struct device *soc,
+                                    struct device_attribute soc_attrs[])
+{
+	int i = 0;
+
+	while (soc_attrs[i++].attr.name != NULL)
+		device_remove_file(soc, &soc_attrs[i]);
+}
+
+static int __init soc_device_create_files(struct device *soc,
+                                          struct device_attribute soc_attrs[])
+{
+	int ret = 0;
+	int i = 0;
+
+	while (soc_attrs[i].attr.name != NULL) {
+		ret = device_create_file(soc, &soc_attrs[i++]);
+		if (ret)
+			goto out;
+	}
+	return ret;
+
+out:
+	soc_device_remove_files(soc, soc_attrs);
+	return ret;
+}
+
+void soc_device_release(struct device *soc)
+{
+	kfree(soc);
+}
+
+int __init soc_device_register(struct device_attribute *soc_attrs[],
+                               int soc_count)
+{
+	int ret, i;
+
+	if (!soc_attrs || soc_count > MAX_SOCS)
+		return -EINVAL;
+
+	/* Register top-level SoC device '/sys/devices/soc'. */
+	parent_soc = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!parent_soc)
+		return -ENOMEM;
+
+	ret = dev_set_name(parent_soc, "soc");
+	if (ret)
+		goto soc_parent_free;
+
+	parent_soc->release = soc_device_release;
+
+	ret = device_register(parent_soc);
+	if (ret)
+		goto soc_parent_free;
+
+	/* Register each SoC and populate sysfs with requested attributes. */
+	for (i = 0; i < soc_count - 1; i++) {
+		soc[i] = kzalloc(sizeof(struct device), GFP_KERNEL);
+		if (!soc[i]) {
+			ret = -ENOMEM;
+			goto soc_out_of_memory;
+		}
+
+		ret = dev_set_name(soc[i], "soc%d", i);
+		if (ret)
+			goto soc_free_unreg;
+
+		soc[i]->parent = parent_soc;
+		soc[i]->release = soc_device_release;
+
+		ret = device_register(soc[i]);
+		if (ret)
+			goto soc_free_unreg;
+
+		ret = soc_device_create_files(soc[i], soc_attrs[i]);
+		if (ret)
+			goto soc_free_unreg;
+	}
+	return ret;
+
+soc_free_unreg:
+	kfree(soc[i]);
+soc_out_of_memory:
+	/* Unregister only previously registered SoCs. */
+	soc_device_unregister(soc_attrs, i);
+	return ret;
+
+soc_parent_free:
+	/* Free unregisterable parent SoC device. */
+	kfree(parent_soc);
+	return ret;
+}
+
+void soc_device_unregister(struct device_attribute *soc_attrs[],
+                           int soc_count)
+{
+	int i;
+
+	if (!soc_attrs || soc_count > MAX_SOCS)
+		return;
+
+	/* Unregister and free all SoC from sysfs. */
+	for (i = 0; i < soc_count - 1; i++) {
+		soc_device_remove_files(soc[i], soc_attrs[i]);
+		device_unregister(soc[i]);
+	}
+
+	/* Unregister top-level SoC device '/sys/devices/soc'. */
+	device_unregister(parent_soc);
+}
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
new file mode 100644
index 0000000..988cf6f
--- /dev/null
+++ b/include/linux/sys_soc.h
@@ -0,0 +1,29 @@
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
+
+#define MAX_SOCS 8
+
+/**
+ * soc_device_register - register SoC as a device
+ * @soc_attrs: Multiple arrays of sysfs file attributes
+ * @num_socs: Amount of SoCs we're attempting to register
+ */
+int soc_device_register(struct device_attribute *soc_attrs[],
+                        int num_socs);
+/**
+ * soc_device_unregister - unregister SoC as a device
+ * @soc_attrs: Multiple arrays of sysfs file attributes
+ * @num_socs: Amount of SoCs we're attempting to register
+ */
+void soc_device_unregister(struct device_attribute *soc_attrs[],
+                           int num_socs);
+
+#endif /* __SYS_SOC_H */
-- 
1.7.4.1
