From: jaghu@google.com (Jaghathiswari Rankappagounder Natarajan)
Date: Tue, 13 Dec 2016 23:55:02 -0800
Subject: [PATCH linux v1 2/4] drivers: misc: Character device driver for seven
 segment display
In-Reply-To: <1481702104-8617-1-git-send-email-jaghu@google.com>
References: <1481702104-8617-1-git-send-email-jaghu@google.com>
Message-ID: <1481702104-8617-3-git-send-email-jaghu@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Character device driver which implements the user-space
API for letting a user write to two 7-segment displays including
any conversion methods necessary to map the user input
to two 7-segment displays.

Signed-off-by: Jaghathiswari Rankappagounder Natarajan <jaghu@google.com>
---
 drivers/misc/Kconfig          |   8 ++
 drivers/misc/Makefile         |   1 +
 drivers/misc/seven_seg_disp.c | 197 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/seven_seg_disp.h |  34 ++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/misc/seven_seg_disp.c
 create mode 100644 drivers/misc/seven_seg_disp.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a216b46..a21aec1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -791,6 +791,14 @@ config PANEL_CHANGE_MESSAGE
 	  If you say 'Y' here, you'll be able to choose a message yourself. Otherwise,
 	  say 'N' and keep the default message with the version.

+config SEVEN_SEGMENT_DISPLAY
+	tristate "Character driver for seven segment display support"
+	help
+	  Character device driver which implements the user-space
+	  API for letting a user write to two 7-segment displays including
+	  any conversion methods necessary to map the user input
+	  to two 7-segment displays.
+
 config PANEL_BOOT_MESSAGE
 	depends on PANEL && PANEL_CHANGE_MESSAGE="y"
 	string "New initialization message"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b2fb6dbf..c2defbd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,4 +56,5 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_SEVEN_SEGMENT_DISPLAY)	+= seven_seg_disp.o
 obj-$(CONFIG_PANEL)             += panel.o
diff --git a/drivers/misc/seven_seg_disp.c b/drivers/misc/seven_seg_disp.c
new file mode 100644
index 0000000..4daeac5
--- /dev/null
+++ b/drivers/misc/seven_seg_disp.c
@@ -0,0 +1,197 @@
+/*
+ * Copyright (c) 2016 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or later as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/kdev_t.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/ctype.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include "seven_seg_disp.h"
+
+#define LED_DOT 0x01
+
+/*
+ * 0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
+ *  _       _   _       _   _   _   _   _   _       _       _   _
+ * | |   |  _|  _| |_| |_  |_    | |_| |_| |_| |_  |    _| |_  |_
+ * |_|   | |_   _|   |  _| |_|   | |_|   | | | |_| |_  |_| |_  |
+ *
+ * data[7:1] = led[a:g]
+ */
+const u8 seven_seg_bits[] = {
+	0xFC, 0x60, 0xDA, 0xF2, 0x66, 0xB6, 0xBE, 0xE0,
+	0xFE, 0xF6, 0xEE, 0x3E, 0x9C, 0x7A, 0x9E, 0x8E
+	};
+
+/*
+ * 0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
+ *      _       _   _                              _            _
+ *     |   |_  |_| |_  _   _   _   _   _   _   _  |_    _|  _| | |
+ *     |_  |_  |   |                               _|  |_| |_| | |
+ *
+ * data[7:1] = led[a:g]
+ */
+const u8 special_seven_seg_bits[] = {
+	0x00, 0x9C, 0x1E, 0xCE, 0x8E, 0x02, 0x02, 0x02,
+	0x02, 0x02, 0x02, 0x02, 0xB6, 0x7A, 0x7A, 0xEC
+	};
+
+static dev_t seven_seg_devno;
+static struct class *seven_seg_disp_class;
+
+static int seven_seg_disp_open(struct inode *inode, struct file *filp)
+{
+	struct seven_seg_disp_dev *disp_dev;
+
+	disp_dev = container_of(inode->i_cdev,
+				 struct seven_seg_disp_dev, cdev);
+	filp->private_data = disp_dev;
+	return 0;
+}
+
+static int seven_seg_disp_close(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static ssize_t seven_seg_disp_read(struct file *filp, char __user *buf, size_t
+				len, loff_t *off)
+{
+	struct seven_seg_disp_dev *disp_dev = filp->private_data;
+
+	if (disp_dev->disp_data_valid)
+		return -EINVAL;
+
+	if (copy_to_user(buf, disp_dev->seven_seg_disp_data_array,
+				MAX_DISP_CHAR_SIZE) != 0) {
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static u16 convert_to_disp_data(char *buf)
+{
+	u8 low_display;
+	u8 high_display;
+	u16 led_value;
+
+	low_display = seven_seg_bits[hex_to_bin(buf[2])];
+
+	high_display = (buf[0] == '1') ?
+	special_seven_seg_bits[hex_to_bin(buf[1])] :
+	seven_seg_bits[hex_to_bin(buf[1])];
+
+	led_value = low_display | (high_display << 8);
+	if (buf[0] == '1')
+		led_value |= LED_DOT | (LED_DOT << 8);
+
+	return led_value;
+}
+
+static ssize_t seven_seg_disp_write(struct file *filp, const char __user *buf,
+				size_t len, loff_t *off)
+{
+	int length = len - 1;
+	int i;
+
+	struct seven_seg_disp_dev *disp_dev = filp->private_data;
+
+	if (length != MAX_DISP_CHAR_SIZE)
+		return -EINVAL;
+
+	if (copy_from_user(disp_dev->seven_seg_disp_data_array,
+				buf, length) != 0) {
+		return -EFAULT;
+	}
+
+	for (i = 0; i < MAX_DISP_CHAR_SIZE; i++) {
+		if (!isxdigit(disp_dev->seven_seg_disp_data_array[i]))
+			return -EINVAL;
+	}
+
+	disp_dev->current_seven_seg_disp_data = convert_to_disp_data(
+			disp_dev->seven_seg_disp_data_array);
+	disp_dev->disp_data_valid = true;
+	disp_dev->update_seven_seg_data(&disp_dev->parent,
+			disp_dev->current_seven_seg_disp_data);
+
+	return len;
+}
+
+static const struct file_operations seven_seg_disp_fops = {
+
+	.owner = THIS_MODULE,
+	.open = seven_seg_disp_open,
+	.release = seven_seg_disp_close,
+	.read = seven_seg_disp_read,
+	.write = seven_seg_disp_write
+};
+
+void seven_seg_rem_cdev(struct seven_seg_disp_dev *disp_dev)
+{
+	cdev_del(&disp_dev->cdev);
+	device_destroy(seven_seg_disp_class, seven_seg_devno);
+}
+
+int seven_seg_setup_cdev(struct seven_seg_disp_dev *disp_dev,
+	void (*update_disp_data)(struct device *, u16 data))
+{
+	struct device *dev;
+	int err;
+
+	dev = device_create(seven_seg_disp_class, &disp_dev->parent,
+			seven_seg_devno,
+			NULL, "seven_seg_disp_val");
+	if (dev == NULL)
+		return -1;
+	disp_dev->dev = dev;
+	disp_dev->update_seven_seg_data = update_disp_data;
+	disp_dev->disp_data_valid = false;
+
+	cdev_init(&disp_dev->cdev, &seven_seg_disp_fops);
+	err = cdev_add(&disp_dev->cdev, seven_seg_devno, 1);
+	if (err)
+		device_destroy(seven_seg_disp_class, seven_seg_devno);
+	return err;
+}
+
+static int __init seven_seg_disp_init(void)
+{
+	if (alloc_chrdev_region(&seven_seg_devno, 0, 1, "disp_state") < 0)
+		return -1;
+
+	seven_seg_disp_class = class_create(THIS_MODULE, "disp_state");
+	if (seven_seg_disp_class == NULL)
+		goto unreg_chrdev;
+
+unreg_chrdev:
+	unregister_chrdev_region(seven_seg_devno, 1);
+	return -1;
+}
+
+static void __exit seven_seg_disp_exit(void)
+{
+	class_destroy(seven_seg_disp_class);
+	unregister_chrdev_region(seven_seg_devno, 1);
+}
+
+module_init(seven_seg_disp_init);
+module_exit(seven_seg_disp_exit);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jaghathiswari Rankappagounder Natarajan <jaghu@google.com>");
+MODULE_DESCRIPTION("Seven segment display character driver");
diff --git a/drivers/misc/seven_seg_disp.h b/drivers/misc/seven_seg_disp.h
new file mode 100644
index 0000000..b0f93c5
--- /dev/null
+++ b/drivers/misc/seven_seg_disp.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2016 Google, Inc
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or later as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef SEVEN_SEG_DISP_H
+#define SEVEN_SEG_DISP_H
+
+#include <linux/device.h>
+#include <linux/cdev.h>
+
+#define MAX_DISP_CHAR_SIZE 3
+
+#define DEFAULT_REFRESH_INTERVAL_MS 1000
+
+struct seven_seg_disp_dev {
+	bool disp_data_valid;
+	u16 current_seven_seg_disp_data;
+	char seven_seg_disp_data_array[MAX_DISP_CHAR_SIZE];
+	struct device parent;
+	struct device *dev;
+	struct cdev cdev;
+	void (*update_seven_seg_data)(struct device *, u16 data);
+};
+
+int seven_seg_setup_cdev(struct seven_seg_disp_dev *disp_dev,
+	void (*update_disp_data)(struct device *, u16 data));
+
+void seven_seg_rem_cdev(struct seven_seg_disp_dev *disp_dev);
+
+#endif
--
2.8.0.rc3.226.g39d4020
