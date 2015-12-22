From: andy.yan@rock-chips.com (Andy Yan)
Date: Tue, 22 Dec 2015 17:10:46 +0800
Subject: [PATCH v1 3/6] misc: add reboot mode driver
In-Reply-To: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1450775446-24077-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the vendor specific write interfae
to store the boot mode in some place like special register
or sram , which can be read by the bootloader after system
reboot, then the bootloader can take different action according
to the mode stored.

This is commonly used on Android based devices, in order to
reboot the device into fastboot or recovery mode.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

Changes in v1: None

 drivers/misc/Kconfig       |  7 ++++
 drivers/misc/Makefile      |  1 +
 drivers/misc/reboot_mode.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/reboot.h     |  4 +-
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/reboot_mode.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 22892c7..0cceb74 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -525,6 +525,13 @@ config VEXPRESS_SYSCFG
 	  bus. System Configuration interface is one of the possible means
 	  of generating transactions on this bus.
 
+config REBOOT_MODE
+	tristate
+	depends on OF
+	help
+	 This driver will help to pass the system reboot mode
+	 to bootloader
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 537d7f3..6ada5de 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_REBOOT_MODE)       += reboot_mode.o
diff --git a/drivers/misc/reboot_mode.c b/drivers/misc/reboot_mode.c
new file mode 100644
index 0000000..16bbaab
--- /dev/null
+++ b/drivers/misc/reboot_mode.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (c) 2015, Fuzhou Rockchip Electronics Co., Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reboot.h>
+
+struct mode_info {
+	const char *mode;
+	int magic;
+	struct list_head list;
+};
+
+struct reboot_mode_driver {
+	struct list_head head;
+	int (*write)(int magic);
+	struct notifier_block reboot_notifier;
+};
+
+static int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
+				 const char *cmd)
+{
+	int magic = 0;
+	struct mode_info *info;
+
+	if (cmd) {
+		list_for_each_entry(info, &reboot->head, list) {
+			if (!strcmp(info->mode, cmd)) {
+				magic = info->magic;
+				break;
+			}
+		}
+	}
+
+	return magic;
+}
+
+static int reboot_mode_notify(struct notifier_block *this,
+			      unsigned long mode, void *cmd)
+{
+	struct reboot_mode_driver *reboot;
+	int magic;
+
+	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
+	magic = get_reboot_mode_magic(reboot, cmd);
+	reboot->write(magic);
+
+	return NOTIFY_DONE;
+}
+
+int reboot_mode_register(struct device *dev, int (*write)(int))
+{
+	struct reboot_mode_driver *reboot;
+	struct mode_info *info;
+	struct device_node *child;
+	int ret;
+
+	reboot = devm_kzalloc(dev, sizeof(*reboot), GFP_KERNEL);
+	if (!reboot)
+		return -ENOMEM;
+
+	reboot->write = write;
+	INIT_LIST_HEAD(&reboot->head);
+	for_each_child_of_node(dev->of_node, child) {
+		info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+		info->mode = of_get_property(child, "linux,mode", NULL);
+		if (of_property_read_u32(child, "linux,magic", &info->magic)) {
+			dev_err(dev, "reboot mode %s without magic number\n",
+				info->mode);
+			devm_kfree(dev, info);
+			continue;
+		}
+		list_add_tail(&info->list, &reboot->head);
+	}
+	reboot->reboot_notifier.notifier_call = reboot_mode_notify;
+	ret = register_reboot_notifier(&reboot->reboot_notifier);
+	if (ret)
+		dev_err(dev, "can't register reboot notifier\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(reboot_mode_register);
+
+MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
+MODULE_DESCRIPTION("System reboot mode driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index a7ff409..f523c32 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -1,7 +1,7 @@
 #ifndef _LINUX_REBOOT_H
 #define _LINUX_REBOOT_H
 
-
+#include <linux/device.h>
 #include <linux/notifier.h>
 #include <uapi/linux/reboot.h>
 
@@ -42,6 +42,8 @@ extern int register_restart_handler(struct notifier_block *);
 extern int unregister_restart_handler(struct notifier_block *);
 extern void do_kernel_restart(char *cmd);
 
+extern int reboot_mode_register(struct device *dev, int (*write)(int));
+
 /*
  * Architecture-specific implementations of sys_reboot commands.
  */
-- 
1.9.1
