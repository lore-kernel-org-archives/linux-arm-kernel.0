From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Aug 2016 15:43:43 +0200
Subject: [PATCH v3 1/6] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <1472305428-16874-1-git-send-email-carlo@caione.org>
References: <1472305428-16874-1-git-send-email-carlo@caione.org>
Message-ID: <1472305428-16874-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Introduce a driver to provide calls into secure monitor mode.

In the Amlogic SoCs these calls are used for multiple reasons: access to
NVMEM, set USB boot, enable JTAG, etc...

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/firmware/Kconfig                |   1 +
 drivers/firmware/Makefile               |   1 +
 drivers/firmware/meson/Kconfig          |   9 ++
 drivers/firmware/meson/Makefile         |   1 +
 drivers/firmware/meson/meson_sm.c       | 247 ++++++++++++++++++++++++++++++++
 include/linux/firmware/meson/meson_sm.h |  31 ++++
 6 files changed, 290 insertions(+)
 create mode 100644 drivers/firmware/meson/Kconfig
 create mode 100644 drivers/firmware/meson/Makefile
 create mode 100644 drivers/firmware/meson/meson_sm.c
 create mode 100644 include/linux/firmware/meson/meson_sm.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 0e22f24..bca172d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -209,5 +209,6 @@ config HAVE_ARM_SMCCC
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
+source "drivers/firmware/meson/Kconfig"
 
 endmenu
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 44a59dc..898ac41 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_QCOM_SCM_32)	+= qcom_scm-32.o
 CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQUIRES_SEC=1) -march=armv7-a
 
 obj-y				+= broadcom/
+obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
new file mode 100644
index 0000000..170d7e8
--- /dev/null
+++ b/drivers/firmware/meson/Kconfig
@@ -0,0 +1,9 @@
+#
+# Amlogic Secure Monitor driver
+#
+config MESON_SM
+	bool
+	default ARCH_MESON
+	depends on ARM64_4K_PAGES
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
index 0000000..bba594e
--- /dev/null
+++ b/drivers/firmware/meson/meson_sm.c
@@ -0,0 +1,247 @@
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
+#define pr_fmt(fmt) "meson-sm: " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/bug.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
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
+struct meson_sm_firmware {
+	const struct meson_sm_chip *chip;
+	void __iomem *sm_shmem_in_base;
+	void __iomem *sm_shmem_out_base;
+};
+
+static struct meson_sm_firmware fw;
+
+static u32 meson_sm_get_cmd(const struct meson_sm_chip *chip,
+			    unsigned int cmd_index)
+{
+	const struct meson_sm_cmd *cmd = chip->cmd;
+
+	while (cmd->smc_id && cmd->index != cmd_index)
+		cmd++;
+
+	return cmd->smc_id;
+}
+
+static u32 __meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+			   u32 arg3, u32 arg4)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(cmd, arg0, arg1, arg2, arg3, arg4, 0, 0, &res);
+	return res.a0;
+}
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
+/**
+ * meson_sm_call - generic SMC32 call to the secure-monitor
+ *
+ * @cmd_index:	Index of the SMC32 function ID
+ * @ret:	Returned value
+ * @arg0:	SMC32 Argument 0
+ * @arg1:	SMC32 Argument 1
+ * @arg2:	SMC32 Argument 2
+ * @arg3:	SMC32 Argument 3
+ * @arg4:	SMC32 Argument 4
+ *
+ * Return:	0 on success, a negative value on error
+ */
+int meson_sm_call(unsigned int cmd_index, u32 *ret, u32 arg0,
+		  u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 cmd, lret;
+
+	if (!fw.chip)
+		return -ENOENT;
+
+	cmd = meson_sm_get_cmd(fw.chip, cmd_index);
+	if (!cmd)
+		return -EINVAL;
+
+	lret = __meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+
+	if (ret)
+		*ret = lret;
+
+	return 0;
+}
+EXPORT_SYMBOL(meson_sm_call);
+
+/**
+ * meson_sm_call_read - retrieve data from secure-monitor
+ *
+ * @buffer:	Buffer to store the retrieved data
+ * @cmd_index:	Index of the SMC32 function ID
+ * @arg0:	SMC32 Argument 0
+ * @arg1:	SMC32 Argument 1
+ * @arg2:	SMC32 Argument 2
+ * @arg3:	SMC32 Argument 3
+ * @arg4:	SMC32 Argument 4
+ *
+ * Return:	size of read data on success, a negative value on error
+ */
+int meson_sm_call_read(void *buffer, unsigned int cmd_index, u32 arg0,
+		       u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	if (!fw.chip)
+		return -ENOENT;
+
+	if (!fw.chip->cmd_shmem_out_base)
+		return -EINVAL;
+
+	if (meson_sm_call(cmd_index, &size, arg0, arg1, arg2, arg3, arg4) < 0)
+		return -EINVAL;
+
+	if (!size || size > fw.chip->shmem_size)
+		return -EINVAL;
+
+	if (buffer)
+		memcpy(buffer, fw.sm_shmem_out_base, size);
+
+	return size;
+}
+EXPORT_SYMBOL(meson_sm_call_read);
+
+/**
+ * meson_sm_call_write - send data to secure-monitor
+ *
+ * @buffer:	Buffer containing data to send
+ * @size:	Size of the data to send
+ * @cmd_index:	Index of the SMC32 function ID
+ * @arg0:	SMC32 Argument 0
+ * @arg1:	SMC32 Argument 1
+ * @arg2:	SMC32 Argument 2
+ * @arg3:	SMC32 Argument 3
+ * @arg4:	SMC32 Argument 4
+ *
+ * Return:	size of sent data on success, a negative value on error
+ */
+int meson_sm_call_write(void *buffer, unsigned int size, unsigned int cmd_index,
+			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 written;
+
+	if (!fw.chip)
+		return -ENOENT;
+
+	if (size > fw.chip->shmem_size)
+		return -EINVAL;
+
+	if (!fw.chip->cmd_shmem_in_base)
+		return -EINVAL;
+
+	memcpy(fw.sm_shmem_in_base, buffer, size);
+
+	if (meson_sm_call(cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
+		return -EINVAL;
+
+	if (!written)
+		return -EINVAL;
+
+	return written;
+}
+EXPORT_SYMBOL(meson_sm_call_write);
+
+static const struct of_device_id meson_sm_ids[] = {
+	{ .compatible = "amlogic,meson-gxbb-sm", .data = &gxbb_chip },
+	{ /* sentinel */ },
+};
+
+int __init meson_sm_init(void)
+{
+	const struct meson_sm_chip *chip;
+	const struct of_device_id *matched_np;
+	struct device_node *np;
+
+	np = of_find_matching_node_and_match(NULL, meson_sm_ids, &matched_np);
+	if (!np)
+		return -ENODEV;
+
+	chip = matched_np->data;
+	if (!chip) {
+		pr_err("unable to setup secure-monitor data\n");
+		goto out;
+	}
+
+	if (chip->cmd_shmem_in_base) {
+		fw.sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
+							 chip->shmem_size);
+		if (WARN_ON(!fw.sm_shmem_in_base))
+			goto out;
+	}
+
+	if (chip->cmd_shmem_out_base) {
+		fw.sm_shmem_out_base = meson_sm_map_shmem(chip->cmd_shmem_out_base,
+							  chip->shmem_size);
+		if (WARN_ON(!fw.sm_shmem_out_base))
+			goto out_in_base;
+	}
+
+	fw.chip = chip;
+	pr_info("secure-monitor enabled\n");
+
+	return 0;
+
+out_in_base:
+	iounmap(fw.sm_shmem_in_base);
+out:
+	return -EINVAL;
+}
+device_initcall(meson_sm_init);
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
new file mode 100644
index 0000000..8e953c6
--- /dev/null
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -0,0 +1,31 @@
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
+enum {
+	SM_EFUSE_READ,
+	SM_EFUSE_WRITE,
+	SM_EFUSE_USER_MAX,
+};
+
+struct meson_sm_firmware;
+
+int meson_sm_call(unsigned int cmd_index, u32 *ret, u32 arg0, u32 arg1,
+		  u32 arg2, u32 arg3, u32 arg4);
+int meson_sm_call_write(void *buffer, unsigned int b_size, unsigned int cmd_index,
+			u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+int meson_sm_call_read(void *buffer, unsigned int cmd_index, u32 arg0, u32 arg1,
+		       u32 arg2, u32 arg3, u32 arg4);
+
+#endif /* _MESON_SM_FW_H_ */
-- 
2.7.4
