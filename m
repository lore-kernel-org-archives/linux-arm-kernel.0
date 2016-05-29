From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 May 2016 13:12:01 +0200
Subject: [PATCH v5 1/3] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1464520323-19531-1-git-send-email-carlo@caione.org>
References: <1464520323-19531-1-git-send-email-carlo@caione.org>
Message-ID: <1464520323-19531-2-git-send-email-carlo@caione.org>
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
 drivers/firmware/meson/meson_sm.c       | 223 ++++++++++++++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h |  32 +++++
 6 files changed, 266 insertions(+)
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
index 0000000..e1ce487
--- /dev/null
+++ b/drivers/firmware/meson/meson_sm.c
@@ -0,0 +1,223 @@
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
+#include <linux/of_device.h>
+#include <linux/smp.h>
+#include <linux/firmware/meson/meson_sm.h>
+
+struct meson_sm_cmd {
+	unsigned int index;
+	u32 smc_id;
+};
+#define CMD(d, s) { .index = (d), .smc_id = (s), }
+
+struct meson_sm_chip {
+	unsigned int shmem_size;
+	u32 cmd_shmem_in_base;
+	u32 cmd_shmem_out_base;
+	struct meson_sm_cmd cmd[];
+};
+
+struct meson_sm_firmware {
+	struct device *dev;
+	const struct meson_sm_chip *chip;
+	void __iomem *sm_shmem_in_base;
+	void __iomem *sm_shmem_out_base;
+};
+
+struct meson_sm_chip gxbb_chip = {
+	.shmem_size		= 0x1000,
+	.cmd_shmem_in_base	= 0x82000020,
+	.cmd_shmem_out_base	= 0x82000021,
+	.cmd = {
+		CMD(SM_EFUSE_READ,	0x82000030),
+		CMD(SM_EFUSE_WRITE,	0x82000031),
+		CMD(SM_EFUSE_USER_MAX,	0x82000033),
+		{ /* sentinel */ },
+	},
+};
+
+static u32 meson_sm_get_cmd(const struct meson_sm_chip *chip, unsigned int cmd_index)
+{
+	unsigned int i;
+
+	for (i = 0; chip->cmd[i].smc_id; i++)
+		if (chip->cmd[i].index == cmd_index)
+			return chip->cmd[i].smc_id;
+
+	return 0;
+}
+
+static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(cmd, arg0, arg1, arg2, arg3, arg4, 0, 0, &res);
+	return res.a0;
+}
+
+u32 meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
+		  u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 cmd;
+
+	if (!fw)
+		return -EINVAL;
+
+	cmd = meson_sm_get_cmd(fw->chip, cmd_index);
+	if (!cmd)
+		return -EINVAL;
+
+	return __meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+}
+EXPORT_SYMBOL(meson_sm_call);
+
+u32 meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
+		       unsigned int cmd_index, u32 arg0, u32 arg1,
+		       u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	if (!fw->chip->cmd_shmem_out_base)
+		return -EINVAL;
+
+	size = meson_sm_call(fw, cmd_index, arg0, arg1, arg2, arg3, arg4);
+	if (size <= 0 || size > fw->chip->shmem_size)
+		return -EINVAL;
+
+	memcpy(buffer, fw->sm_shmem_out_base, size);
+
+	return size;
+}
+EXPORT_SYMBOL(meson_sm_call_read);
+
+u32 meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
+			unsigned int b_size, unsigned int cmd_index,
+			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	if (b_size > fw->chip->shmem_size)
+		return -EINVAL;
+
+	if (!fw->chip->cmd_shmem_in_base)
+		return -EINVAL;
+
+	memcpy(fw->sm_shmem_in_base, buffer, b_size);
+
+	size = meson_sm_call(fw, cmd_index, arg0, arg1, arg2, arg3, arg4);
+	if (size <= 0)
+		return -EINVAL;
+
+	return size;
+}
+EXPORT_SYMBOL(meson_sm_call_write);
+
+static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
+{
+	u32 sm_phy_base;
+
+	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
+	if (!sm_phy_base)
+		return 0;
+
+	return ioremap_cache(sm_phy_base, size);
+}
+
+static int meson_sm_probe(struct platform_device *pdev)
+{
+	const struct meson_sm_chip *chip;
+	struct meson_sm_firmware *fw;
+
+	fw = devm_kzalloc(&pdev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return -ENOMEM;
+
+	fw->dev = &pdev->dev;
+
+	chip = of_device_get_match_data(fw->dev);
+	if (!chip) {
+		dev_err(fw->dev, "Unable to setup secure-monitor data\n");
+		return -ENODEV;
+	}
+
+	if (chip->cmd_shmem_in_base) {
+		fw->sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
+							  chip->shmem_size);
+		if (!fw->sm_shmem_in_base)
+			goto out;
+	}
+
+	if (chip->cmd_shmem_out_base) {
+		fw->sm_shmem_out_base = meson_sm_map_shmem(chip->cmd_shmem_out_base,
+							   chip->shmem_size);
+		if (!fw->sm_shmem_out_base)
+			goto out;
+	}
+
+	fw->chip = chip;
+	platform_set_drvdata(pdev, fw);
+
+	dev_info(fw->dev, "secure-monitor enabled\n");
+
+	return 0;
+
+out:
+	if (fw->sm_shmem_in_base)
+		iounmap(fw->sm_shmem_in_base);
+
+	return -EINVAL;
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
+	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
+	{ /* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, meson_sm_ids);
+
+static struct platform_driver meson_sm_platform_driver = {
+	.probe	= meson_sm_probe,
+	.driver	= {
+		.name		= "secure-monitor",
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
index 0000000..f653916
--- /dev/null
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -0,0 +1,32 @@
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
+#ifndef _MESON_SM_FW_H_
+#define _MESON_SM_FW_H_
+
+#define SM_EFUSE_READ		0
+#define SM_EFUSE_WRITE		1
+#define SM_EFUSE_USER_MAX	2
+
+struct meson_sm_firmware;
+
+u32 meson_sm_call(struct meson_sm_firmware *fw, unsigned int cmd_index,
+		  u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+u32 meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
+			unsigned int b_size, unsigned int cmd_index,
+			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+u32 meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
+		       unsigned int cmd_index, u32 arg0, u32 arg1,
+		       u32 arg2, u32 arg3, u32 arg4);
+struct meson_sm_firmware *meson_sm_get_fw(struct device_node *firmware_node);
+
+#endif /* _MESON_SM_FW_H_ */
-- 
2.7.4
