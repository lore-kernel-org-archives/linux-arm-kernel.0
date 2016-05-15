From: carlo@caione.org (Carlo Caione)
Date: Sun, 15 May 2016 20:10:45 +0200
Subject: [RFC PATCH] soc: Amlogic: Add secure monitor driver
Message-ID: <1463335845-23534-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Introduce a driver to provide calls into secure monitor mode.

In the Amlogic SoCs these calls are used for multiple reasons: access to
NVMEM, reboot, set USB boot, enable JTAG, etc...

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi |   4 +
 drivers/soc/Kconfig                         |   1 +
 drivers/soc/Makefile                        |   1 +
 drivers/soc/amlogic/Kconfig                 |   8 ++
 drivers/soc/amlogic/Makefile                |   1 +
 drivers/soc/amlogic/meson_sm.c              | 141 ++++++++++++++++++++++++++++
 include/linux/soc/amlogic/meson_sm.h        |  57 +++++++++++
 7 files changed, 213 insertions(+)
 create mode 100644 drivers/soc/amlogic/Kconfig
 create mode 100644 drivers/soc/amlogic/Makefile
 create mode 100644 drivers/soc/amlogic/meson_sm.c
 create mode 100644 include/linux/soc/amlogic/meson_sm.h

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 76b3b6d..e4017c3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -98,6 +98,10 @@
 		method = "smc";
 	};
 
+	sm {
+		compatible = "amlogic,meson-sm";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cb58ef0..637af69 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/brcmstb/Kconfig"
 source "drivers/soc/fsl/qe/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5ade713..2eb6fd5 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
+obj-$(CONFIG_ARCH_MESON)	+= amlogic/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
new file mode 100644
index 0000000..fff11a3
--- /dev/null
+++ b/drivers/soc/amlogic/Kconfig
@@ -0,0 +1,8 @@
+#
+# Amlogic Secure Monitor driver
+#
+config MESON_SM
+	bool
+	default ARCH_MESON
+	help
+	  Say y here to enable the Amlogic secure monitor driver
diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
new file mode 100644
index 0000000..9ab3884
--- /dev/null
+++ b/drivers/soc/amlogic/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MESON_SM) +=	meson_sm.o
diff --git a/drivers/soc/amlogic/meson_sm.c b/drivers/soc/amlogic/meson_sm.c
new file mode 100644
index 0000000..e6f9c4f
--- /dev/null
+++ b/drivers/soc/amlogic/meson_sm.c
@@ -0,0 +1,141 @@
+/*
+ * Amlogic Secure Monitor driver
+ *
+ * Copyright (C) 2016 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <stdarg.h>
+#include <asm/cacheflush.h>
+#include <asm/compiler.h>
+#include <linux/arm-smccc.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+
+#include <linux/soc/amlogic/meson_sm.h>
+
+#define SM_MEM_SIZE			0x1000
+
+/*
+ * To read from / write to the secure monitor we use two bounce buffers. The
+ * physical addresses of the two buffers are obtained by querying the secure
+ * monitor itself.
+ */
+
+static u32 sm_phy_in_base;
+static u32 sm_phy_out_base;
+
+static void __iomem *sm_sharemem_in_base;
+static void __iomem *sm_sharemem_out_base;
+
+struct meson_sm_data {
+	unsigned int cmd;
+	unsigned int arg0;
+	unsigned int arg1;
+	unsigned int arg2;
+	unsigned int arg3;
+	unsigned int arg4;
+	unsigned int ret;
+};
+
+static void __meson_sm_call(void *info)
+{
+	struct meson_sm_data *data = info;
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(data->cmd,
+		      data->arg0, data->arg1, data->arg2,
+		      data->arg3, data->arg4, 0, 0, &res);
+	data->ret = res.a0;
+}
+
+unsigned int meson_sm_call(unsigned int cmd, unsigned int arg0,
+			   unsigned int arg1, unsigned int arg2,
+			   unsigned int arg3, unsigned int arg4)
+{
+	struct meson_sm_data data;
+
+	data.cmd = cmd;
+	data.arg0 = arg0;
+	data.arg1 = arg1;
+	data.arg2 = arg2;
+	data.arg3 = arg3;
+	data.arg4 = arg4;
+	data.ret = 0;
+
+	smp_call_function_single(0, __meson_sm_call, &data, 1);
+
+	return data.ret;
+}
+
+unsigned int meson_sm_call_read(void *buffer, unsigned int cmd,
+				unsigned int arg0, unsigned int arg1,
+				unsigned int arg2, unsigned int arg3,
+				unsigned int arg4)
+{
+	unsigned int size;
+
+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+
+	if (size != 0)
+		memcpy(buffer, sm_sharemem_out_base, size);
+
+	return size;
+}
+
+unsigned int meson_sm_call_write(void *buffer, unsigned int size,
+				 unsigned int cmd, unsigned int arg0,
+				 unsigned int arg1, unsigned int arg2,
+				 unsigned int arg3, unsigned int arg4)
+{
+	memcpy(sm_sharemem_in_base, buffer, size);
+
+	return meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+}
+
+static int meson_sm_probe(struct platform_device *pdev)
+{
+	sm_phy_in_base = meson_sm_call(SM_GET_SHARE_MEM_INPUT_BASE, 0, 0, 0, 0, 0);
+
+	sm_sharemem_in_base = ioremap_cache(sm_phy_in_base, SM_MEM_SIZE);
+	if (!sm_sharemem_in_base)
+		return -EINVAL;
+
+	sm_phy_out_base = meson_sm_call(SM_GET_SHARE_MEM_OUTPUT_BASE, 0, 0, 0, 0, 0);
+
+	sm_sharemem_out_base = ioremap_cache(sm_phy_out_base, SM_MEM_SIZE);
+	if (!sm_sharemem_out_base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id meson_sm_ids[] = {
+	{ .compatible = "amlogic,meson-sm" },
+	{ /* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, meson_sm_ids);
+
+static struct platform_driver meson_sm_platform_driver = {
+	.probe	= meson_sm_probe,
+	.driver	= {
+		.name		= "secmon",
+		.of_match_table	= meson_sm_ids,
+	},
+};
+module_platform_driver(meson_sm_platform_driver);
+
+MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
+MODULE_DESCRIPTION("Amlogic secure monitor driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/soc/amlogic/meson_sm.h b/include/linux/soc/amlogic/meson_sm.h
new file mode 100644
index 0000000..68b943f
--- /dev/null
+++ b/include/linux/soc/amlogic/meson_sm.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2016 Endless Mobile, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _MESON_SM_H_
+#define _MESON_SM_H_
+
+#define SM_GET_SHARE_MEM_INPUT_BASE		0x82000020
+#define SM_GET_SHARE_MEM_OUTPUT_BASE		0x82000021
+#define SM_GET_REBOOT_REASON			0x82000022
+#define SM_GET_SHARE_STORAGE_IN_BASE		0x82000023
+#define SM_GET_SHARE_STORAGE_OUT_BASE		0x82000024
+#define SM_GET_SHARE_STORAGE_BLOCK_BASE		0x82000025
+#define SM_GET_SHARE_STORAGE_MESSAGE_BASE	0x82000026
+#define SM_GET_SHARE_STORAGE_BLOCK_SIZE		0x82000027
+#define SM_EFUSE_READ				0x82000030
+#define SM_EFUSE_WRITE				0x82000031
+#define SM_EFUSE_WRITE_PATTERN			0x82000032
+#define SM_EFUSE_USER_MAX			0x82000033
+#define SM_JTAG_ON				0x82000040
+#define SM_JTAG_OFF				0x82000041
+#define SM_SET_USB_BOOT_FUNC			0x82000043
+#define SM_SECURITY_KEY_QUERY			0x82000060
+#define SM_SECURITY_KEY_READ			0x82000061
+#define SM_SECURITY_KEY_WRITE			0x82000062
+#define SM_SECURITY_KEY_TELL			0x82000063
+#define SM_SECURITY_KEY_VERIFY			0x82000064
+#define SM_SECURITY_KEY_STATUS			0x82000065
+#define SM_SECURITY_KEY_NOTIFY			0x82000066
+#define SM_SECURITY_KEY_LIST			0x82000067
+#define SM_SECURITY_KEY_REMOVE			0x82000068
+#define SM_DEBUG_EFUSE_WRITE_PATTERN		0x820000F0
+#define SM_DEBUG_EFUSE_READ_PATTERN		0x820000F1
+#define SM_AML_DATA_PROCESS			0x820000FF
+#define SM_PSCI_SYS_REBOOT			0x84000009
+
+unsigned int meson_sm_call(unsigned int cmd, unsigned int arg0,
+			   unsigned int arg1, unsigned int arg2,
+			   unsigned int arg3, unsigned int arg4);
+unsigned int meson_sm_call_read(void *buffer, unsigned int cmd,
+				unsigned int arg0, unsigned int arg1,
+				unsigned int arg2, unsigned int arg3,
+				unsigned int arg4);
+unsigned int meson_sm_call_write(void *buffer, unsigned int size,
+				 unsigned int cmd, unsigned int arg0,
+				 unsigned int arg1, unsigned int arg2,
+				 unsigned int arg3, unsigned int arg4);
+
+#endif /* _MESON_SM_H_ */
-- 
2.7.4
