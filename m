From: pankaj.bansal@nxp.com (Pankaj Bansal)
Date: Fri,  5 Oct 2018 14:25:05 +0530
Subject: [PATCH 2/2] fsl: add i2c controlled qixis driver
In-Reply-To: <20181005085505.29024-1-pankaj.bansal@nxp.com>
References: <20181005085505.29024-1-pankaj.bansal@nxp.com>
Message-ID: <20181005085505.29024-3-pankaj.bansal@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FPGA on LX2160AQDS/LX2160ARDB connected on I2C bus, so add qixis
driver which is basically an i2c client driver to control FPGA.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 drivers/soc/fsl/Kconfig        |  9 ++++
 drivers/soc/fsl/Makefile       |  1 +
 drivers/soc/fsl/qixis_ctrl.c   | 75 ++++++++++++++++++++++++++++++++
 include/linux/fsl/qixis_ctrl.h | 20 +++++++++
 4 files changed, 105 insertions(+)

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 8f80e8bbf29e..c355c2cbbd45 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -28,4 +28,13 @@ config FSL_MC_DPIO
 	  other DPAA2 objects. This driver does not expose the DPIO
 	  objects individually, but groups them under a service layer
 	  API.
+
+config FSL_QIXIS
+	tristate "QIXIS system controller driver"
+	select REGMAP_I2C
+	default n
+	help
+	  Say y here to enable QIXIS system controller api. The qixis driver
+	  provides FPGA functions to control system.
+
 endmenu
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 803ef1bfb5ff..47e0cfc66ca4 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -5,5 +5,6 @@
 obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
+obj-$(CONFIG_FSL_QIXIS) 		+= qixis_ctrl.o
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
 obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/soc/fsl/qixis_ctrl.c b/drivers/soc/fsl/qixis_ctrl.c
new file mode 100644
index 000000000000..b94649fb9726
--- /dev/null
+++ b/drivers/soc/fsl/qixis_ctrl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/* Freescale QIXIS system controller driver.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fsl/qixis_ctrl.h>
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static struct regmap *qixis_regmap;
+
+static struct regmap_config qixis_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int fsl_qixis_i2c_probe(struct i2c_client *client)
+{
+	struct platform_device *pdev;
+	struct device_node *child;
+	u32 qver;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -EOPNOTSUPP;
+
+	qixis_regmap = regmap_init_i2c(client, &qixis_regmap_config);
+
+	/* create platform device for  each of the child node of FPGA node */
+	for_each_child_of_node(client->dev.of_node, child) {
+		pdev = of_platform_device_create(child, NULL, &client->dev);
+	};
+
+	regmap_read(qixis_regmap, offsetof(struct fsl_qixis_regs, qixis_ver),
+		    &qver);
+
+	pr_info("Freescale QIXIS Version: 0x%08x\n", qver);
+
+	return 0;
+}
+
+static int fsl_qixis_i2c_remove(struct i2c_client *client)
+{
+	return 0;
+}
+
+static const struct of_device_id fsl_qixis_of_match[] = {
+	{ .compatible = "fsl,fpga-qixis-i2c" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, fsl_qixis_of_match);
+
+static struct i2c_driver fsl_qixis_i2c_driver = {
+	.driver = {
+		.name	= "qixis_ctrl",
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(fsl_qixis_of_match),
+	},
+	.probe_new	= fsl_qixis_i2c_probe,
+	.remove		= fsl_qixis_i2c_remove,
+};
+module_i2c_driver(fsl_qixis_i2c_driver);
+
+MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
+MODULE_DESCRIPTION("Freescale QIXIS system controller driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fsl/qixis_ctrl.h b/include/linux/fsl/qixis_ctrl.h
new file mode 100644
index 000000000000..00e80ef21adc
--- /dev/null
+++ b/include/linux/fsl/qixis_ctrl.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Definitions for Freescale QIXIS system controller.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ * Copyright 2018 NXP
+ */
+
+#ifndef _FSL_QIXIS_CTRL_H_
+#define _FSL_QIXIS_CTRL_H_
+
+/* QIXIS MAP */
+struct fsl_qixis_regs {
+	u8		id;		/* Identification Registers */
+	u8		version;	/* Version Register */
+	u8		qixis_ver;	/* QIXIS Version Register */
+	u8		reserved1[0x1f];
+};
+
+#endif
-- 
2.17.1
