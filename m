From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 03:06:13 +0800
Subject: [PATCH 1/5] soc: imx: add imx8 soc device support
In-Reply-To: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524855977-15719-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8 soc device support. The device id & revision information
is retrieved via SCU firmware call.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/Kconfig    |   4 ++
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/soc-imx8.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/soc/imx/soc-imx8.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 8d56e9b..003690d 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -18,4 +18,8 @@ config HAVE_IMX_SC_PD
 	bool
 	depends on HAVE_IMX_SCU
 
+config HAVE_IMX8_SOC
+	bool
+	depends on HAVE_IMX_SCU
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 40ad2a5..775d29d 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_HAVE_IMX_MU) += imx_mu.o
 obj-$(CONFIG_HAVE_IMX_SCU) += sc/
 obj-$(CONFIG_HAVE_IMX_SC_PD) += sc-pd.o
+obj-$(CONFIG_HAVE_IMX8_SOC) += soc-imx8.o
diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
new file mode 100644
index 0000000..ef3dacd
--- /dev/null
+++ b/drivers/soc/imx/soc-imx8.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/of.h>
+#include <soc/imx/revision.h>
+#include <soc/imx/sc/sci.h>
+
+struct imx8_soc_data {
+	char *name;
+	u32 (*soc_revision)(void);
+};
+
+static u32 imx_init_revision_from_scu(void)
+{
+	sc_ipc_t ipc_soc_handle;
+	sc_err_t sci_err;
+	u32 id, rev;
+
+	sci_err = sc_ipc_get_handle(&ipc_soc_handle);
+	if (sci_err != SC_ERR_NONE) {
+		pr_err("imx8_soc: failed to get sc ipc handle\n");
+		return IMX_CHIP_REVISION_UNKNOWN;
+	}
+
+	sci_err = sc_misc_get_control(ipc_soc_handle, SC_R_SYSTEM,
+				      SC_C_ID, &id);
+	if (sci_err != SC_ERR_NONE) {
+		pr_err("imx8_soc: failed to get soc revision\n");
+		return IMX_CHIP_REVISION_UNKNOWN;
+	};
+
+	rev = (id >> 5) & 0xf;
+	rev = (((rev >> 2) + 1) << 4) | (rev & 0x3);
+
+	return rev;
+}
+
+static const struct imx8_soc_data imx8qxp_soc_data = {
+	.name = "i.MX8QXP",
+	.soc_revision = imx_init_revision_from_scu,
+};
+
+static const struct of_device_id imx8_soc_match[] = {
+	{ .compatible = "fsl,imx8qxp", .data = &imx8qxp_soc_data, },
+	{ /* sentinel */ }
+};
+
+static int __init imx8_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const struct imx8_soc_data *data;
+	const struct of_device_id *id;
+	struct soc_device *soc_dev;
+	struct device_node *root;
+	u32 imx_soc_revision = 0;
+	int ret;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENODEV;
+
+	soc_dev_attr->family = "Freescale i.MX";
+
+	root = of_find_node_by_path("/");
+	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	if (ret)
+		goto free_soc;
+
+	id = of_match_node(imx8_soc_match, root);
+	if (!id)
+		goto free_soc;
+
+	of_node_put(root);
+
+	data = id->data;
+	soc_dev_attr->soc_id = data->name;
+	if (data->soc_revision)
+		imx_soc_revision = data->soc_revision();
+
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d.%d",
+					   (imx_soc_revision >> 4) & 0xf,
+					   imx_soc_revision & 0xf);
+	if (!soc_dev_attr->revision)
+		goto free_soc;
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		goto free_rev;
+
+	return 0;
+
+free_rev:
+	kfree(soc_dev_attr->revision);
+free_soc:
+	kfree(soc_dev_attr);
+	return -ENODEV;
+}
+device_initcall(imx8_soc_init);
-- 
2.7.4
