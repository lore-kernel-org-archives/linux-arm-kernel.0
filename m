From: jolly.shah@xilinx.com (Jolly Shah)
Date: Tue, 20 Feb 2018 11:21:06 -0800
Subject: [PATCH v5 3/4] drivers: firmware: xilinx: Add sysfs interface
In-Reply-To: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
Message-ID: <1519154467-2896-4-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Firmware-ggs sysfs interface which provides read/write
interface to global storage registers.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../ABI/stable/sysfs-driver-zynqmp-firmware        |  50 ++++
 drivers/firmware/xilinx/zynqmp/Makefile            |   2 +-
 drivers/firmware/xilinx/zynqmp/firmware-ggs.c      | 297 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp/firmware.c          |  13 +
 include/linux/firmware/xilinx/zynqmp/firmware.h    |   2 +
 5 files changed, 363 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c

diff --git a/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
new file mode 100644
index 0000000..b04727a
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
@@ -0,0 +1,50 @@
+What:		/sys/devices/platform/zynqmp-firmware/ggs*
+Date:		January 2018
+KernelVersion:	4.15.0
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU global general storage register value,
+		GLOBAL_GEN_STORAGE{0:3}.
+		Global general storage register that can be used
+		by system to pass information between masters.
+
+		The register is reset during system or power-on
+		resets. Three registers are used by the FSBL and
+		other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
+
+		Usage:
+		# cat /sys/.../zynqmp-firmware/ggs0
+		# echo <mask> <value> > /sys/.../zynqmp-firmware/ggs0
+
+		Example:
+		# cat /sys/.../zynqmp-firmware/ggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/.../zynqmp-firmware/ggs0
+
+Users:		Xilinx
+
+What:		/sys/devices/platform/zynqmp-firmware/pggs*
+Date:		January 2018
+KernelVersion:	4.15.0
+Contact:	"Jolly Shah" <jollys@xilinx.com>
+Description:
+		Read/Write PMU persistent global general storage register
+		value, PERS_GLOB_GEN_STORAGE{0:3}.
+		Persistent global general storage register that
+		can be used by system to pass information between
+		masters.
+
+		This register is only reset by the power-on reset
+		and maintains its value through a system reset.
+		Four registers are used by the FSBL and other Xilinx
+		software products: PERS_GLOB_GEN_STORAGE{4:7}.
+		Register is reset only by a POR reset.
+
+		Usage:
+		# cat /sys/.../zynqmp-firmware/pggs0
+		# echo <mask> <value> > /sys/.../zynqmp-firmware/pggs0
+
+		Example:
+		# cat /sys/.../zynqmp-firmware/pggs0
+		# echo 0xFFFFFFFF 0x1234ABCD > /sys/.../zynqmp-firmware/pggs0
+
+Users:		Xilinx
diff --git a/drivers/firmware/xilinx/zynqmp/Makefile b/drivers/firmware/xilinx/zynqmp/Makefile
index c3ec669..6629781 100644
--- a/drivers/firmware/xilinx/zynqmp/Makefile
+++ b/drivers/firmware/xilinx/zynqmp/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Makefile for Xilinx firmwares
 
-obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o
+obj-$(CONFIG_ZYNQMP_FIRMWARE) += firmware.o firmware-ggs.o
diff --git a/drivers/firmware/xilinx/zynqmp/firmware-ggs.c b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
new file mode 100644
index 0000000..e08f6a6
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ *  Jolly Shah <jollys@xilinx.com>
+ *  Rajan Vaja <rajanv@xilinx.com>
+ */
+
+#include <linux/compiler.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return -EFAULT;
+
+	ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", ret_payload[1]);
+}
+
+static ssize_t write_register(const char *buf, size_t count, u32 read_ioctl,
+			      u32 write_ioctl, u32 reg)
+{
+	char *kern_buff, *inbuf, *tok;
+	long mask, value;
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return -EFAULT;
+
+	kern_buff = kzalloc(count, GFP_KERNEL);
+	if (!kern_buff)
+		return -ENOMEM;
+
+	ret = strlcpy(kern_buff, buf, count);
+	if (ret < 0) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	inbuf = kern_buff;
+
+	/* Read the write mask */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtol(tok, 16, &mask);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	/* Read the write value */
+	tok = strsep(&inbuf, " ");
+	if (!tok) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = kstrtol(tok, 16, &value);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
+	if (ret) {
+		ret = -EFAULT;
+		goto err;
+	}
+	ret_payload[1] &= ~mask;
+	value &= mask;
+	value |= ret_payload[1];
+
+	ret = eemi_ops->ioctl(0, write_ioctl, reg, value, NULL);
+	if (ret)
+		ret = -EFAULT;
+
+err:
+	kfree(kern_buff);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+/**
+ * ggs_show - Show global general storage (ggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a ggs register value.
+ *
+ * User-space interface for viewing the content of the ggs0 register.
+ * cat /sys/firmware/zynqmp/ggs0
+ */
+static ssize_t ggs_show(struct kobject *kobj,
+			struct kobj_attribute *attr,
+			char *buf,
+			u32 reg)
+{
+	return read_register(buf, IOCTL_READ_GGS, reg);
+}
+
+/**
+ * ggs_store - Store global general storage (ggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a ggs register value.
+ *
+ * For example, the user-space interface for storing a value to the
+ * ggs0 register:
+ * echo 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/ggs0
+ */
+static ssize_t ggs_store(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 const char *buf,
+			 size_t count,
+			 u32 reg)
+{
+	if (!kobj || !attr || !buf || !count || reg >= GSS_NUM_REGS)
+		return -EINVAL;
+
+	return write_register(buf, count, IOCTL_READ_GGS, IOCTL_WRITE_GGS, reg);
+}
+
+/* GGS register show functions */
+#define GGS0_SHOW(N)						\
+	ssize_t ggs##N##_show(struct kobject *kobj,		\
+				struct kobj_attribute *attr,	\
+				char *buf)			\
+	{							\
+		return ggs_show(kobj, attr, buf, N);		\
+	}
+
+static GGS0_SHOW(0);
+static GGS0_SHOW(1);
+static GGS0_SHOW(2);
+static GGS0_SHOW(3);
+
+/* GGS register store function */
+#define GGS0_STORE(N)						\
+	ssize_t ggs##N##_store(struct kobject *kobj,		\
+				struct kobj_attribute *attr,	\
+				const char *buf,		\
+				size_t count)			\
+	{							\
+		return ggs_store(kobj, attr, buf, count, N);	\
+	}
+
+static GGS0_STORE(0);
+static GGS0_STORE(1);
+static GGS0_STORE(2);
+static GGS0_STORE(3);
+
+/**
+ * pggs_show - Show persistent global general storage (pggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a pggs register value.
+ */
+static ssize_t pggs_show(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 char *buf,
+			 u32 reg)
+{
+	return read_register(buf, IOCTL_READ_PGGS, reg);
+}
+
+/**
+ * pggs_store - Store persistent global general storage (pggs) sysfs attribute
+ * @kobj: Kobject structure
+ * @attr: Kobject attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a pggs register value.
+ */
+static ssize_t pggs_store(struct kobject *kobj,
+			  struct kobj_attribute *attr,
+			  const char *buf,
+			  size_t count,
+			  u32 reg)
+{
+	return write_register(buf, count, IOCTL_READ_PGGS,
+			      IOCTL_WRITE_PGGS, reg);
+}
+
+#define PGGS0_SHOW(N)						\
+	ssize_t pggs##N##_show(struct kobject *kobj,		\
+				struct kobj_attribute *attr,	\
+				char *buf)			\
+	{							\
+		return pggs_show(kobj, attr, buf, N);		\
+	}
+
+#define PGGS0_STORE(N)						\
+	ssize_t pggs##N##_store(struct kobject *kobj,		\
+				   struct kobj_attribute *attr,	\
+				   const char *buf,		\
+				   size_t count)		\
+	{							\
+		return pggs_store(kobj, attr, buf, count, N);	\
+	}
+
+/* PGGS register show functions */
+static PGGS0_SHOW(0);
+static PGGS0_SHOW(1);
+static PGGS0_SHOW(2);
+static PGGS0_SHOW(3);
+
+/* PGGS register store functions */
+static PGGS0_STORE(0);
+static PGGS0_STORE(1);
+static PGGS0_STORE(2);
+static PGGS0_STORE(3);
+
+/* GGS register attributes */
+static struct kobj_attribute zynqmp_attr_ggs0 = __ATTR_RW(ggs0);
+static struct kobj_attribute zynqmp_attr_ggs1 = __ATTR_RW(ggs1);
+static struct kobj_attribute zynqmp_attr_ggs2 = __ATTR_RW(ggs2);
+static struct kobj_attribute zynqmp_attr_ggs3 = __ATTR_RW(ggs3);
+
+/* PGGS register attributes */
+static struct kobj_attribute zynqmp_attr_pggs0 = __ATTR_RW(pggs0);
+static struct kobj_attribute zynqmp_attr_pggs1 = __ATTR_RW(pggs1);
+static struct kobj_attribute zynqmp_attr_pggs2 = __ATTR_RW(pggs2);
+static struct kobj_attribute zynqmp_attr_pggs3 = __ATTR_RW(pggs3);
+
+static struct attribute *attrs[] = {
+	&zynqmp_attr_ggs0.attr,
+	&zynqmp_attr_ggs1.attr,
+	&zynqmp_attr_ggs2.attr,
+	&zynqmp_attr_ggs3.attr,
+	&zynqmp_attr_pggs0.attr,
+	&zynqmp_attr_pggs1.attr,
+	&zynqmp_attr_pggs2.attr,
+	&zynqmp_attr_pggs3.attr,
+	NULL,
+};
+
+static const struct attribute_group attr_group = {
+	.attrs = attrs,
+	NULL,
+};
+
+int zynqmp_pm_ggs_init(void)
+{
+	struct kobject *zynqmp_kobj;
+
+	zynqmp_kobj = kobject_create_and_add("zynqmp", firmware_kobj);
+	if (!zynqmp_kobj) {
+		pr_err("zynqmp: Firmware kobj add failed.\n");
+		return -ENOMEM;
+	}
+
+	return sysfs_create_group(zynqmp_kobj, &attr_group);
+}
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
index 6979f4b..02266d9 100644
--- a/drivers/firmware/xilinx/zynqmp/firmware.c
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -1049,3 +1049,16 @@ static int __init zynqmp_plat_init(void)
 	return ret;
 }
 early_initcall(zynqmp_plat_init);
+
+static int zynqmp_firmware_init(void)
+{
+	int ret;
+
+	ret = zynqmp_pm_ggs_init();
+	if (ret)
+		pr_err("%s() GGS init fail with error %d\n",
+		       __func__, ret);
+
+	return ret;
+}
+device_initcall(zynqmp_firmware_init);
diff --git a/include/linux/firmware/xilinx/zynqmp/firmware.h b/include/linux/firmware/xilinx/zynqmp/firmware.h
index 859d809..94b5a43 100644
--- a/include/linux/firmware/xilinx/zynqmp/firmware.h
+++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
@@ -578,6 +578,8 @@ struct zynqmp_eemi_ops {
 int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 			u32 arg2, u32 arg3, u32 *ret_payload);
 
+int zynqmp_pm_ggs_init(void);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4
