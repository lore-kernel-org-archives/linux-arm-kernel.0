From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:23 +0100
Subject: [PATCH 03/11] misc: Versatile Express reset driver
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-4-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a simple vexpress config driver providing platform restart and
power off functions.

By writing to the "active" attribute of the reboot or reset device,
user can decide what if the platform is supposed to execute full power
cycle (reboot, default) or simply assert system level reset signal.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/misc/vexpress/Makefile |    1 +
 drivers/misc/vexpress/reset.c  |  110 ++++++++++++++++++++++++++++++++++++++++
 include/linux/vexpress.h       |    4 ++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/misc/vexpress/reset.c

diff --git a/drivers/misc/vexpress/Makefile b/drivers/misc/vexpress/Makefile
index 5b1e8fc..af11749 100644
--- a/drivers/misc/vexpress/Makefile
+++ b/drivers/misc/vexpress/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += config_bus.o
+obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += reset.o
diff --git a/drivers/misc/vexpress/reset.c b/drivers/misc/vexpress/reset.c
new file mode 100644
index 0000000..1be7cba
--- /dev/null
+++ b/drivers/misc/vexpress/reset.c
@@ -0,0 +1,110 @@
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
+#include <linux/jiffies.h>
+#include <linux/stat.h>
+#include <linux/vexpress.h>
+
+static void vexpress_reset_do(struct vexpress_config_device *vecdev,
+		const char *what)
+{
+	int err = -ENOENT;
+
+	if (vecdev) {
+		unsigned long timeout;
+
+		err = vexpress_config_write(vecdev, 0, 0);
+
+		timeout = jiffies + HZ;
+		while (time_before(jiffies, timeout))
+			cpu_relax();
+	}
+
+	dev_emerg(&vecdev->dev, "Unable to %s (%d)\n", what, err);
+}
+
+static struct vexpress_config_device *vexpress_power_off_device;
+
+void vexpress_power_off(void)
+{
+	vexpress_reset_do(vexpress_power_off_device, "power off");
+}
+
+static struct vexpress_config_device *vexpress_restart_device;
+
+void vexpress_restart(char str, const char *cmd)
+{
+	vexpress_reset_do(vexpress_restart_device, "restart");
+}
+
+static ssize_t vexpress_reset_active_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", vexpress_restart_device ==
+			to_vexpress_config_device(dev));
+}
+
+static ssize_t vexpress_reset_active_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	long value;
+	int err = kstrtol(buf, 0, &value);
+
+	if (!err && value)
+		vexpress_restart_device = to_vexpress_config_device(dev);
+
+	return err ? err : count;
+}
+
+DEVICE_ATTR(active, S_IRUGO | S_IWUSR, vexpress_reset_active_show,
+		vexpress_reset_active_store);
+
+
+static int vexpress_reset_probe(struct vexpress_config_device *vecdev)
+{
+	switch (vecdev->func) {
+	case VEXPRESS_CONFIG_FUNC_SHUTDOWN:
+		vexpress_power_off_device = vecdev;
+		break;
+	case VEXPRESS_CONFIG_FUNC_RESET:
+		if (!vexpress_restart_device)
+			vexpress_restart_device = vecdev;
+		device_create_file(&vecdev->dev, &dev_attr_active);
+		break;
+	case VEXPRESS_CONFIG_FUNC_REBOOT:
+		vexpress_restart_device = vecdev;
+		device_create_file(&vecdev->dev, &dev_attr_active);
+		break;
+	};
+
+	return 0;
+}
+
+static const unsigned vexpress_reset_funcs[] = {
+	VEXPRESS_CONFIG_FUNC_RESET,
+	VEXPRESS_CONFIG_FUNC_SHUTDOWN,
+	VEXPRESS_CONFIG_FUNC_REBOOT,
+	0,
+};
+
+static struct vexpress_config_driver vexpress_reset_driver = {
+	.funcs = vexpress_reset_funcs,
+	.probe = vexpress_reset_probe,
+	.driver.name = "vexpress-reset",
+};
+
+static int __init vexpress_reset_init(void)
+{
+	return vexpress_config_driver_register(&vexpress_reset_driver);
+}
+device_initcall(vexpress_reset_init);
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index f1ed744..7b02341 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -117,4 +117,8 @@ int vexpress_config_read(struct vexpress_config_device *vecdev, int offset,
 int vexpress_config_write(struct vexpress_config_device *vecdev, int offset,
 		u32 data);
 
+/* Reset control */
+void vexpress_power_off(void);
+void vexpress_restart(char str, const char *cmd);
+
 #endif
-- 
1.7.9.5
