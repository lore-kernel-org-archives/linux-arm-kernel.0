From: carlo@caione.org (Carlo Caione)
Date: Wed, 18 May 2016 16:56:19 +0200
Subject: [PATCH v2 1/4] soc: Amlogic: Add secure monitor driver
In-Reply-To: <1463583382-15614-1-git-send-email-carlo@caione.org>
References: <1463583382-15614-1-git-send-email-carlo@caione.org>
Message-ID: <1463583382-15614-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Introduce a driver to provide calls into secure monitor mode.

In the Amlogic SoCs these calls are used for multiple reasons: access to
NVMEM, set USB boot, enable JTAG, etc...

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/soc/Kconfig                |   1 +
 drivers/soc/Makefile               |   1 +
 drivers/soc/meson/Kconfig          |   8 ++
 drivers/soc/meson/Makefile         |   1 +
 drivers/soc/meson/meson_sm.c       | 155 +++++++++++++++++++++++++++++++++++++
 include/linux/soc/meson/meson_sm.h |  22 ++++++
 6 files changed, 188 insertions(+)
 create mode 100644 drivers/soc/meson/Kconfig
 create mode 100644 drivers/soc/meson/Makefile
 create mode 100644 drivers/soc/meson/meson_sm.c
 create mode 100644 include/linux/soc/meson/meson_sm.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cb58ef0..7e70b52 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -4,6 +4,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/brcmstb/Kconfig"
 source "drivers/soc/fsl/qe/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
+source "drivers/soc/meson/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5ade713..9024d2b 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
+obj-$(CONFIG_ARCH_MESON)	+= meson/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
diff --git a/drivers/soc/meson/Kconfig b/drivers/soc/meson/Kconfig
new file mode 100644
index 0000000..fff11a3
--- /dev/null
+++ b/drivers/soc/meson/Kconfig
@@ -0,0 +1,8 @@
+#
+# Amlogic Secure Monitor driver
+#
+config MESON_SM
+	bool
+	default ARCH_MESON
+	help
+	  Say y here to enable the Amlogic secure monitor driver
diff --git a/drivers/soc/meson/Makefile b/drivers/soc/meson/Makefile
new file mode 100644
index 0000000..9ab3884
--- /dev/null
+++ b/drivers/soc/meson/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MESON_SM) +=	meson_sm.o
diff --git a/drivers/soc/meson/meson_sm.c b/drivers/soc/meson/meson_sm.c
new file mode 100644
index 0000000..16f7e32
--- /dev/null
+++ b/drivers/soc/meson/meson_sm.c
@@ -0,0 +1,155 @@
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
+#include <linux/soc/meson/meson_sm.h>
+
+#define SM_MEM_SIZE	0x1000
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
+u32 meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
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
+
+u32 meson_sm_call_read(void *buffer, u32 cmd, u32 arg0, u32 arg1,
+		       u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+
+	if (!size || size > SM_MEM_SIZE)
+		return -EINVAL;
+
+	memcpy(buffer, sm_sharemem_out_base, size);
+	return size;
+}
+
+u32 meson_sm_call_write(void *buffer, unsigned int b_size, u32 cmd, u32 arg0,
+			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
+{
+	u32 size;
+
+	if (b_size > SM_MEM_SIZE)
+		return -EINVAL;
+
+	memcpy(sm_sharemem_in_base, buffer, b_size);
+
+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
+
+	if (!size)
+		return -EINVAL;
+
+	return size;
+}
+
+static int meson_sm_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int cmd_in, cmd_out;
+
+	if (of_property_read_u32(np, "amlogic,sm_cmd_input_base", &cmd_in))
+		return -EINVAL;
+
+	if (of_property_read_u32(np, "amlogic,sm_cmd_output_base", &cmd_out))
+		return -EINVAL;
+
+	sm_phy_in_base = meson_sm_call(cmd_in, 0, 0, 0, 0, 0);
+	sm_sharemem_in_base = ioremap_cache(sm_phy_in_base, SM_MEM_SIZE);
+	if (!sm_sharemem_in_base)
+		return -EINVAL;
+
+	sm_phy_out_base = meson_sm_call(cmd_out, 0, 0, 0, 0, 0);
+	sm_sharemem_out_base = ioremap_cache(sm_phy_out_base, SM_MEM_SIZE);
+	if (!sm_sharemem_out_base) {
+		iounmap(sm_sharemem_in_base);
+		return -EINVAL;
+	}
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
diff --git a/include/linux/soc/meson/meson_sm.h b/include/linux/soc/meson/meson_sm.h
new file mode 100644
index 0000000..6ff8317
--- /dev/null
+++ b/include/linux/soc/meson/meson_sm.h
@@ -0,0 +1,22 @@
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
+u32 meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+u32 meson_sm_call_read(void *buffer, u32 cmd, u32 arg0, u32 arg1, u32 arg2,
+		       u32 arg3, u32 arg4);
+u32 meson_sm_call_write(void *buffer, unsigned int b_size, u32 cmd, u32 arg0,
+			u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+
+#endif /* _MESON_SM_H_ */
-- 
2.7.4
