From: jolly.shah@xilinx.com (Jolly Shah)
Date: Wed, 17 Jan 2018 12:20:33 -0800
Subject: [PATCH v2 3/4] drivers: firmware: xilinx: Add sysfs interface
In-Reply-To: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
References: <1516220434-22204-1-git-send-email-jollys@xilinx.com>
Message-ID: <1516220434-22204-4-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Firmware-ggs sysfs interface which provides read/write
interface to global storage registers.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
---
 .../ABI/stable/sysfs-driver-zynqmp-firmware        |  33 +++
 drivers/firmware/xilinx/zynqmp/Makefile            |   2 +-
 drivers/firmware/xilinx/zynqmp/firmware-ggs.c      | 298 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp/firmware.c          |  26 ++
 include/linux/firmware/xilinx/zynqmp/firmware.h    |   2 +
 5 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c

diff --git a/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
new file mode 100644
index 0000000..2483215
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
@@ -0,0 +1,33 @@
+What:          /sys/devices/platform/zynqmp-firmware/ggs*
+Date:          January 2018
+KernelVersion: 4.15.0
+Contact:       "Jolly Shah" <jollys@xilinx.com>
+Description:
+               Shows PMU global general storage register value,
+               GLOBAL_GEN_STORAGE{0:3}.
+               Global general storage register that can be used
+               by system to pass information between masters.
+
+               The register is reset during system or power-on
+               resets. Three registers are used by the FSBL and
+               other Xilinx software products: GLOBAL_GEN_STORAGE{4:6}.
+
+Users:         Xilinx
+
+What:          /sys/devices/platform/zynqmp-firmware/pggs*
+Date:          January 2018
+KernelVersion: 4.15.0
+Contact:       "Jolly Shah" <jollys@xilinx.com>
+Description:
+               Shows PMU persistent global general storage register
+               value, PERS_GLOB_GEN_STORAGE{0:3}.
+               Persistent global general storage register that
+               can be used by system to pass information between
+               masters.
+
+               This register is only reset by the power-on reset
+               and maintains its value through a system reset.
+               Four registers are used by the FSBL and other Xilinx
+               software products: PERS_GLOB_GEN_STORAGE{4:7}.
+               Register is reset only by a POR reset.
+Users:         Xilinx
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
index 0000000..be47ca2
--- /dev/null
+++ b/drivers/firmware/xilinx/zynqmp/firmware-ggs.c
@@ -0,0 +1,298 @@
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
+#include <linux/platform_device.h>
+
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+static ssize_t read_register(char *buf, u32 ioctl_id, u32 reg)
+{
+       int ret;
+       u32 ret_payload[PAYLOAD_ARG_CNT];
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return 0;
+
+       ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
+       if (ret)
+               return ret;
+
+       return snprintf(buf, PAGE_SIZE, "0x%x\n", ret_payload[1]);
+}
+
+static ssize_t write_register(const char *buf, size_t count,
+                             u32 ioctl_id, u32 reg)
+{
+       char *kern_buff;
+       char *inbuf;
+       char *tok;
+       long mask;
+       long value;
+       int ret;
+       u32 ret_payload[PAYLOAD_ARG_CNT];
+       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return -EFAULT;
+
+       kern_buff = kzalloc(count, GFP_KERNEL);
+       if (!kern_buff)
+               return -ENOMEM;
+
+       ret = strlcpy(kern_buff, buf, count);
+       if (ret < 0) {
+               ret = -EFAULT;
+               goto err;
+       }
+
+       inbuf = kern_buff;
+
+       /* Read the write mask */
+       tok = strsep(&inbuf, " ");
+       if (!tok) {
+               ret = -EFAULT;
+               goto err;
+       }
+
+       ret = kstrtol(tok, 16, &mask);
+       if (ret) {
+               ret = -EFAULT;
+               goto err;
+       }
+
+       /* Read the write value */
+       tok = strsep(&inbuf, " ");
+       if (!tok) {
+               ret = -EFAULT;
+               goto err;
+       }
+
+       ret = kstrtol(tok, 16, &value);
+       if (ret) {
+               ret = -EFAULT;
+               goto err;
+       }
+
+       ret = eemi_ops->ioctl(0, ioctl_id, reg, 0, ret_payload);
+       if (ret) {
+               ret = -EFAULT;
+               goto err;
+       }
+       ret_payload[1] &= ~mask;
+       value &= mask;
+       value |= ret_payload[1];
+
+       ret = eemi_ops->ioctl(0, ioctl_id, reg, value, NULL);
+       if (ret)
+               ret = -EFAULT;
+
+err:
+       kfree(kern_buff);
+       if (ret)
+               return ret;
+
+       return count;
+}
+
+/**
+ * ggs_show - Show global general storage (ggs) sysfs attribute
+ * @dev: Device structure
+ * @attr: Device attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a ggs register value.
+ *
+ * User-space interface for viewing the content of the ggs0 register.
+ * cat /sys/devices/platform/firmware/ggs0
+ */
+static ssize_t ggs_show(struct device *dev,
+                       struct device_attribute *attr,
+                       char *buf,
+                       u32 reg)
+{
+       return read_register(buf, IOCTL_READ_GGS, reg);
+}
+
+/**
+ * ggs_store - Store global general storage (ggs) sysfs attribute
+ * @dev: Device structure
+ * @attr: Device attribute structure
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
+ * echo 0xFFFFFFFF 0x1234ABCD > /sys/devices/platform/firmware/ggs0
+ */
+static ssize_t ggs_store(struct device *dev,
+                        struct device_attribute *attr,
+                        const char *buf,
+                        size_t count,
+                        u32 reg)
+{
+       if (!dev || !attr || !buf || !count || reg >= GSS_NUM_REGS)
+               return -EINVAL;
+
+       return write_register(buf, count, IOCTL_WRITE_GGS, reg);
+}
+
+/* GGS register show functions */
+#define GGS0_SHOW(N) \
+       ssize_t ggs##N##_show(struct device *dev, \
+                        struct device_attribute *attr, \
+                        char *buf) \
+       { \
+               return ggs_show(dev, attr, buf, N); \
+       }
+
+static GGS0_SHOW(0);
+static GGS0_SHOW(1);
+static GGS0_SHOW(2);
+static GGS0_SHOW(3);
+
+/* GGS register store function */
+#define GGS0_STORE(N) \
+       ssize_t ggs##N##_store(struct device *dev, \
+                                  struct device_attribute *attr, \
+                                  const char *buf, \
+                                  size_t count) \
+       { \
+               return ggs_store(dev, attr, buf, count, N); \
+       }
+
+static GGS0_STORE(0);
+static GGS0_STORE(1);
+static GGS0_STORE(2);
+static GGS0_STORE(3);
+
+/* GGS register device attributes */
+static DEVICE_ATTR_RW(ggs0);
+static DEVICE_ATTR_RW(ggs1);
+static DEVICE_ATTR_RW(ggs2);
+static DEVICE_ATTR_RW(ggs3);
+
+#define CREATE_GGS_DEVICE(dev, N) \
+do { \
+       if (device_create_file(dev, &dev_attr_ggs##N)) \
+               dev_err(dev, "unable to create ggs%d attribute\n", N); \
+} while (0)
+
+/**
+ * pggs_show - Show persistent global general storage (pggs) sysfs attribute
+ * @dev: Device structure
+ * @attr: Device attribute structure
+ * @buf: Requested available shutdown_scope attributes string
+ * @reg: Register number
+ *
+ * Return:Number of bytes printed into the buffer.
+ *
+ * Helper function for viewing a pggs register value.
+ */
+static ssize_t pggs_show(struct device *dev,
+                        struct device_attribute *attr,
+                        char *buf,
+                        u32 reg)
+{
+       return read_register(buf, IOCTL_READ_GGS, reg);
+}
+
+/**
+ * pggs_store - Store persistent global general storage (pggs) sysfs attribute
+ * @dev: Device structure
+ * @attr: Device attribute structure
+ * @buf: User entered shutdown_scope attribute string
+ * @count: Size of buf
+ * @reg: Register number
+ *
+ * Return: count argument if request succeeds, the corresponding
+ * error code otherwise
+ *
+ * Helper function for storing a pggs register value.
+ */
+static ssize_t pggs_store(struct device *dev,
+                         struct device_attribute *attr,
+                         const char *buf,
+                         size_t count,
+                         u32 reg)
+{
+       return write_register(buf, count, IOCTL_WRITE_PGGS, reg);
+}
+
+#define PGGS0_SHOW(N) \
+       ssize_t pggs##N##_show(struct device *dev, \
+                        struct device_attribute *attr, \
+                        char *buf) \
+       { \
+               return pggs_show(dev, attr, buf, N); \
+       }
+
+/* PGGS register show functions */
+static PGGS0_SHOW(0);
+static PGGS0_SHOW(1);
+static PGGS0_SHOW(2);
+static PGGS0_SHOW(3);
+
+#define PGGS0_STORE(N) \
+       ssize_t pggs##N##_store(struct device *dev, \
+                                  struct device_attribute *attr, \
+                                  const char *buf, \
+                                  size_t count) \
+       { \
+               return pggs_store(dev, attr, buf, count, N); \
+       }
+
+/* PGGS register store functions */
+static PGGS0_STORE(0);
+static PGGS0_STORE(1);
+static PGGS0_STORE(2);
+static PGGS0_STORE(3);
+
+/* PGGS register device attributes */
+static DEVICE_ATTR_RW(pggs0);
+static DEVICE_ATTR_RW(pggs1);
+static DEVICE_ATTR_RW(pggs2);
+static DEVICE_ATTR_RW(pggs3);
+
+#define CREATE_PGGS_DEVICE(dev, N) \
+do { \
+       if (device_create_file(dev, &dev_attr_pggs##N)) \
+               dev_err(dev, "unable to create pggs%d attribute\n", N); \
+} while (0)
+
+void zynqmp_pm_ggs_init(struct device *dev)
+{
+       /* Create Global General Storage register. */
+       CREATE_GGS_DEVICE(dev, 0);
+       CREATE_GGS_DEVICE(dev, 1);
+       CREATE_GGS_DEVICE(dev, 2);
+       CREATE_GGS_DEVICE(dev, 3);
+
+       /* Create Persistent Global General Storage register. */
+       CREATE_PGGS_DEVICE(dev, 0);
+       CREATE_PGGS_DEVICE(dev, 1);
+       CREATE_PGGS_DEVICE(dev, 2);
+       CREATE_PGGS_DEVICE(dev, 3);
+}
diff --git a/drivers/firmware/xilinx/zynqmp/firmware.c b/drivers/firmware/xilinx/zynqmp/firmware.c
index 8ebacb6..c42cf9f 100644
--- a/drivers/firmware/xilinx/zynqmp/firmware.c
+++ b/drivers/firmware/xilinx/zynqmp/firmware.c
@@ -15,11 +15,14 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>

 #include <linux/firmware/xilinx/zynqmp/firmware.h>

+#define DRIVER_NAME    "zynqmp_firmware"
+
 /**
  * zynqmp_pm_ret_code - Convert PMU-FW error codes to Linux error codes
  * @ret_status:                PMUFW return code
@@ -984,4 +987,27 @@ static int __init zynqmp_plat_init(void)
        return ret;
 }

+static const struct of_device_id firmware_of_match[] = {
+       { .compatible = "xlnx,zynqmp-firmware", },
+       { /* end of table */ },
+};
+
+MODULE_DEVICE_TABLE(of, firmware_of_match);
+
+static int zynqmp_firmware_probe(struct platform_device *pdev)
+{
+       zynqmp_pm_ggs_init(&pdev->dev);
+
+       return 0;
+}
+
+static struct platform_driver zynqmp_firmware_platform_driver = {
+       .probe   = zynqmp_firmware_probe,
+       .driver  = {
+                       .name             = DRIVER_NAME,
+                       .of_match_table   = firmware_of_match,
+                  },
+};
+builtin_platform_driver(zynqmp_firmware_platform_driver);
+
 early_initcall(zynqmp_plat_init);
diff --git a/include/linux/firmware/xilinx/zynqmp/firmware.h b/include/linux/firmware/xilinx/zynqmp/firmware.h
index 42d6e74..97b3b7b 100644
--- a/include/linux/firmware/xilinx/zynqmp/firmware.h
+++ b/include/linux/firmware/xilinx/zynqmp/firmware.h
@@ -561,6 +561,8 @@ int invoke_pm_fn(u32 pm_api_id, u32 arg0, u32 arg1, u32 arg2, u32 arg3,
                 u32 *ret_payload);
 int zynqmp_pm_ret_code(u32 ret_status);

+void zynqmp_pm_ggs_init(struct device *dev);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *get_eemi_ops(void);
 #else
--
2.7.4

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
