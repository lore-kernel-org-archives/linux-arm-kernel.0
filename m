From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 May 2016 18:30:21 +0200
Subject: [PATCH v3 1/4] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1464021024-29380-1-git-send-email-carlo@caione.org>
References: <1464021024-29380-1-git-send-email-carlo@caione.org>
Message-ID: <1464021024-29380-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Introduce a driver to provide calls into secure monitor mode.

In the Amlogic SoCs these calls are used for multiple reasons: access to
NVMEM, set USB boot, enable JTAG, etc...

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/firmware/Kconfig                |   1 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/meson/Kconfig          |   8 ++
 drivers/firmware/meson/Makefile         |   1 +
 drivers/firmware/meson/meson_sm.c       | 179 ++++++++++++++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h |  38 +++++++
 6 files changed, 228 insertions(+)
 create mode 100644 drivers/firmware/meson/Kconfig
 create mode 100644 drivers/firmware/meson/Makefile
 create mode 100644 drivers/firmware/meson/meson_sm.c
 create mode 100644 include/linux/firmware/meson/meson_sm.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6664f11..686e395 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -199,5 +199,6 @@ config HAVE_ARM_SMCCC
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
+source "drivers/firmware/meson/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 474bada..fc4bb09 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_QCOM_SCM_32)	+= qcom_scm-32.o
 CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQUIRES_SEC=1) -march=armv7-a
 
 obj-y				+= broadcom/
+obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
new file mode 100644
index 0000000..fff11a3
--- /dev/null
+++ b/drivers/firmware/meson/Kconfig
@@ -0,0 +1,8 @@
+#
+# Amlogic Secure Monitor driver
+#
+config MESON_SM
+	bool
+	default ARCH_MESON
+	help
+	  Say y here to enable the Amlogic secure monitor driver
diff --git a/drivers/firmware/meson/Makefile b/drivers/firmware/meson/Makefile
new file mode 100644
index 0000000..9ab3884
--- /dev/null
+++ b/drivers/firmware/meson/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MESON_SM) +=	meson_sm.o
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
new file mode 100644
index 0000000..445bc7f
--- /dev/null
+++ b/drivers/firmware/meson/meson_sm.c
@@ -0,0 +1,179 @@
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
+#include <linux/firmware/meson/meson_sm.h>
+
+#define SM_MEM_SIZE	0x1000
+
+struct meson_sm_data {
+	u32 cmd;
+	u32 arg0;
+	u32 arg1;
+	u32 arg2;
+	u32 arg3;
+	u32 arg4;
+	u32 ret;
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
+u32 meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+		  u32 arg3, u32 arg4)
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
+	__meson_sm_call(&data);
+
+	return data.ret;
+}
+EXPORT_SYMBOL(meson_sm_call);
+
+u32 meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
+		       u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+		       u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	if (!fw)
+		return -EINVAL;
+
+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+
+	if (!size || size > SM_MEM_SIZE)
+		return -EINVAL;
+
+	memcpy(buffer, fw->sm_sharemem_out_base, size);
+	return size;
+}
+EXPORT_SYMBOL(meson_sm_call_read);
+
+u32 meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
+			unsigned int b_size, u32 cmd, u32 arg0,
+			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	if (!fw)
+		return -EINVAL;
+
+	if (b_size > SM_MEM_SIZE)
+		return -EINVAL;
+
+	memcpy(fw->sm_sharemem_in_base, buffer, b_size);
+
+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+
+	if (!size)
+		return -EINVAL;
+
+	return size;
+}
+EXPORT_SYMBOL(meson_sm_call_write);
+
+static int meson_sm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct meson_sm_firmware *fw;
+	u32 sm_phy_in_base, sm_phy_out_base;
+	int cmd_in, cmd_out;
+
+	fw = devm_kzalloc(&pdev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return -ENOMEM;
+
+	fw->dev = &pdev->dev;
+
+	if (of_property_read_u32(np, "amlogic,sm-cmd-input-base", &cmd_in))
+		return -EINVAL;
+
+	if (of_property_read_u32(np, "amlogic,sm-cmd-output-base", &cmd_out))
+		return -EINVAL;
+
+	sm_phy_in_base = meson_sm_call(cmd_in, 0, 0, 0, 0, 0);
+	fw->sm_sharemem_in_base = ioremap_cache(sm_phy_in_base, SM_MEM_SIZE);
+	if (!fw->sm_sharemem_in_base)
+		return -EINVAL;
+
+	sm_phy_out_base = meson_sm_call(cmd_out, 0, 0, 0, 0, 0);
+	fw->sm_sharemem_out_base = ioremap_cache(sm_phy_out_base, SM_MEM_SIZE);
+	if (!fw->sm_sharemem_out_base) {
+		iounmap(fw->sm_sharemem_in_base);
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, fw);
+
+	return 0;
+}
+
+struct meson_sm_firmware *meson_sm_get_fw(struct device_node *firmware_node)
+{
+	struct platform_device *pdev = of_find_device_by_node(firmware_node);
+
+	/*
+	 * Returns NULL is the firmware device is not ready.
+	 */
+	if (!pdev)
+		return NULL;
+
+	return platform_get_drvdata(pdev);
+}
+EXPORT_SYMBOL(meson_sm_get_fw);
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
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
new file mode 100644
index 0000000..7b6b524
--- /dev/null
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -0,0 +1,38 @@
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
+#include <linux/types.h>
+#include <linux/of_device.h>
+
+struct meson_sm_firmware {
+	struct device *dev;
+	void __iomem *sm_sharemem_in_base;
+	void __iomem *sm_sharemem_out_base;
+};
+
+u32 meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+		  u32 arg3, u32 arg4);
+
+u32 meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
+			unsigned int b_size, u32 cmd, u32 arg0,
+			u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+
+u32 meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
+		       u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+		       u32 arg3, u32 arg4);
+
+struct meson_sm_firmware *meson_sm_get_fw(struct device_node *firmware_node);
+
+#endif /* _MESON_SM_H_ */
-- 
2.7.4
