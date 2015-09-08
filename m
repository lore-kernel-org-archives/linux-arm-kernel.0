From: emilio.lopez@collabora.co.uk (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue,  8 Sep 2015 09:07:45 -0300
Subject: [PATCH 2/3] platform/chrome: Support reading/writing the vboot context
In-Reply-To: <1441714066-5599-1-git-send-email-emilio.lopez@collabora.co.uk>
References: <1441714066-5599-1-git-send-email-emilio.lopez@collabora.co.uk>
Message-ID: <1441714066-5599-3-git-send-email-emilio.lopez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some EC implementations include a small nvram space used to store
verified boot context data. This patch offers a way to expose this
data to userspace.

Signed-off-by: Emilio L?pez <emilio.lopez@collabora.co.uk>
---
 Documentation/devicetree/bindings/mfd/cros-ec.txt |   4 +
 drivers/platform/chrome/Makefile                  |   5 +-
 drivers/platform/chrome/cros_ec_dev.c             |   1 +
 drivers/platform/chrome/cros_ec_vbc.c             | 137 ++++++++++++++++++++++
 include/linux/mfd/cros_ec.h                       |   1 +
 5 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/cros_ec_vbc.c

diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
index 1777916..136e0c2 100644
--- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
+++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
@@ -34,6 +34,10 @@ Required properties (LPC):
 - compatible: "google,cros-ec-lpc"
 - reg: List of (IO address, size) pairs defining the interface uses
 
+Optional properties (all):
+- google,has-vbc-nvram: Some implementations of the EC include a small
+  nvram space used to store verified boot context data. This boolean flag
+  is used to specify whether this nvram is present or not.
 
 Example for I2C:
 
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 4a11b01..787be61 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -1,7 +1,10 @@
 
 obj-$(CONFIG_CHROMEOS_LAPTOP)	+= chromeos_laptop.o
 obj-$(CONFIG_CHROMEOS_PSTORE)	+= chromeos_pstore.o
-cros_ec_devs-objs               := cros_ec_dev.o cros_ec_sysfs.o cros_ec_lightbar.o
+cros_ec_devs-objs               := cros_ec_dev.o
+cros_ec_devs-objs               += cros_ec_lightbar.o
+cros_ec_devs-objs               += cros_ec_sysfs.o
+cros_ec_devs-objs               += cros_ec_vbc.o
 obj-$(CONFIG_CROS_EC_CHARDEV)   += cros_ec_devs.o
 obj-$(CONFIG_CROS_EC_LPC)       += cros_ec_lpc.o
 obj-$(CONFIG_CROS_EC_PROTO)	+= cros_ec_proto.o
diff --git a/drivers/platform/chrome/cros_ec_dev.c b/drivers/platform/chrome/cros_ec_dev.c
index e8fcdc2..d19263f 100644
--- a/drivers/platform/chrome/cros_ec_dev.c
+++ b/drivers/platform/chrome/cros_ec_dev.c
@@ -32,6 +32,7 @@ static int ec_major;
 static const struct attribute_group *cros_ec_groups[] = {
 	&cros_ec_attr_group,
 	&cros_ec_lightbar_attr_group,
+	&cros_ec_vbc_attr_group,
 	NULL,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
new file mode 100644
index 0000000..f6ca8b6
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -0,0 +1,137 @@
+/*
+ * cros_ec_vbc - Expose the vboot context nvram to userspace
+ *
+ * Copyright (C) 2015 Collabora Ltd.
+ *
+ * based on vendor driver,
+ *
+ * Copyright (C) 2012 The Chromium OS Authors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/slab.h>
+
+static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
+				  struct bin_attribute *att, char *buf,
+				  loff_t pos, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
+					      class_dev);
+	struct cros_ec_device *ecdev = ec->ec_dev;
+	struct ec_params_vbnvcontext *params;
+	struct cros_ec_command *msg;
+	int err;
+	const size_t para_sz = sizeof(struct ec_params_vbnvcontext);
+	const size_t resp_sz = sizeof(struct ec_response_vbnvcontext);
+	const size_t payload = max(para_sz, resp_sz);
+
+	msg = kmalloc(sizeof(*msg) + payload, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	params = (struct ec_params_vbnvcontext *)msg->data;
+	params->op = EC_VBNV_CONTEXT_OP_READ;
+
+	msg->version = EC_VER_VBNV_CONTEXT;
+	msg->command = EC_CMD_VBNV_CONTEXT;
+	msg->outsize = sizeof(params->op);
+	msg->insize = resp_sz;
+
+	err = cros_ec_cmd_xfer(ecdev, msg);
+	if (err < 0) {
+		dev_err(dev, "Error sending read request: %d\n", err);
+		kfree(msg);
+		return err;
+	}
+
+	BUILD_BUG_ON(resp_sz > PAGE_SIZE);
+	memcpy(buf, msg->data, resp_sz);
+
+	kfree(msg);
+	return resp_sz;
+}
+
+static ssize_t vboot_context_write(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr, char *buf,
+				   loff_t pos, size_t count)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
+					      class_dev);
+	struct cros_ec_device *ecdev = ec->ec_dev;
+	struct ec_params_vbnvcontext *params;
+	struct cros_ec_command *msg;
+	int err;
+	const size_t para_sz = sizeof(*params);
+	const size_t data_sz = sizeof(params->block);
+
+	/* Only write full values */
+	if (count != data_sz)
+		return -EINVAL;
+
+	msg = kmalloc(sizeof(*msg) + para_sz, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	params = (struct ec_params_vbnvcontext *)msg->data;
+	params->op = EC_VBNV_CONTEXT_OP_WRITE;
+	memcpy(params->block, buf, data_sz);
+
+	msg->version = EC_VER_VBNV_CONTEXT;
+	msg->command = EC_CMD_VBNV_CONTEXT;
+	msg->outsize = para_sz;
+	msg->insize = 0;
+
+	err = cros_ec_cmd_xfer(ecdev, msg);
+	if (err < 0) {
+		dev_err(dev, "Error sending write request: %d\n", err);
+		kfree(msg);
+		return err;
+	}
+
+	kfree(msg);
+	return data_sz;
+}
+
+static umode_t cros_ec_vbc_is_visible(struct kobject *kobj,
+				      struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cros_ec_dev *ec = container_of(dev, struct cros_ec_dev,
+					      class_dev);
+	struct device_node *np = ec->ec_dev->dev->of_node;
+
+	if (IS_ENABLED(CONFIG_OF) && np) {
+		if (of_property_read_bool(np, "google,has-vbc-nvram"))
+			return a->mode;
+	}
+
+	return 0;
+}
+
+static BIN_ATTR_RW(vboot_context, 16);
+
+static struct bin_attribute *cros_ec_vbc_bin_attrs[] = {
+	&bin_attr_vboot_context,
+	NULL
+};
+
+struct attribute_group cros_ec_vbc_attr_group = {
+	.name = "vbc",
+	.bin_attrs = cros_ec_vbc_bin_attrs,
+	.is_visible = cros_ec_vbc_is_visible,
+};
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index da72671..494682c 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -255,5 +255,6 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev);
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 extern struct attribute_group cros_ec_lightbar_attr_group;
+extern struct attribute_group cros_ec_vbc_attr_group;
 
 #endif /* __LINUX_MFD_CROS_EC_H */
-- 
2.1.4
