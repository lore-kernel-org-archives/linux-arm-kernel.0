From: chinnikishore369@gmail.com (chinnikishore369 at gmail.com)
Date: Sun, 25 Mar 2018 00:41:00 +0530
Subject: [RFC 2/2] reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
 controller.
In-Reply-To: <20180324191100.18363-1-chinnikishore369@gmail.com>
References: <20180324191100.18363-1-chinnikishore369@gmail.com>
Message-ID: <20180324191100.18363-2-chinnikishore369@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nava kishore Manne <navam@xilinx.com>

Add a reset controller driver for Xilinx Zynq UltraScale+ MPSoC.
The zynqmp reset-controller has the ability to reset lines
connected to different blocks and peripheral in the Soc.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-zynqmp.c | 106 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 drivers/reset/reset-zynqmp.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 132c24f5ddb5..4e1a94acf83f 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
+obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
 
diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
new file mode 100644
index 000000000000..c8510fa93ad9
--- /dev/null
+++ b/drivers/reset/reset-zynqmp.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+#define ZYNQMP_NR_RESETS (ZYNQMP_PM_RESET_END - ZYNQMP_PM_RESET_START - 2)
+#define ZYNQMP_RESET_ID (ZYNQMP_PM_RESET_START + 1)
+
+static const struct zynqmp_eemi_ops *eemi_ops;
+
+struct zynqmp_reset {
+	struct reset_controller_dev rcdev;
+};
+
+static int zynqmp_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+						PM_RESET_ACTION_ASSERT);
+}
+
+static int zynqmp_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+						PM_RESET_ACTION_RELEASE);
+}
+
+static int zynqmp_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	int val;
+
+	eemi_ops->reset_get_status(ZYNQMP_RESET_ID + id, &val);
+	return val;
+}
+
+static int zynqmp_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return eemi_ops->reset_assert(ZYNQMP_RESET_ID + id,
+						PM_RESET_ACTION_PULSE);
+}
+
+static struct reset_control_ops zynqmp_reset_ops = {
+	.reset = zynqmp_reset_reset,
+	.assert = zynqmp_reset_assert,
+	.deassert = zynqmp_reset_deassert,
+	.status = zynqmp_reset_status,
+};
+
+static int zynqmp_reset_probe(struct platform_device *pdev)
+{
+	struct zynqmp_reset *zynqmp_reset;
+	int ret;
+
+	zynqmp_reset = devm_kzalloc(&pdev->dev,
+				sizeof(*zynqmp_reset), GFP_KERNEL);
+	if (!zynqmp_reset)
+		return -ENOMEM;
+
+	eemi_ops = zynqmp_pm_get_eemi_ops();
+	if (!eemi_ops)
+		return -ENXIO;
+
+	platform_set_drvdata(pdev, zynqmp_reset);
+
+	zynqmp_reset->rcdev.ops = &zynqmp_reset_ops;
+	zynqmp_reset->rcdev.owner = THIS_MODULE;
+	zynqmp_reset->rcdev.of_node = pdev->dev.of_node;
+	zynqmp_reset->rcdev.of_reset_n_cells = 1;
+	zynqmp_reset->rcdev.nr_resets = ZYNQMP_NR_RESETS;
+
+	ret = reset_controller_register(&zynqmp_reset->rcdev);
+	if (!ret)
+		dev_info(&pdev->dev, "Xilinx zynqmp reset driver probed\n");
+
+	return ret;
+}
+
+static const struct of_device_id zynqmp_reset_dt_ids[] = {
+	{ .compatible = "xlnx,zynqmp-reset", },
+	{ },
+};
+
+static struct platform_driver zynqmp_reset_driver = {
+	.probe	= zynqmp_reset_probe,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= zynqmp_reset_dt_ids,
+	},
+};
+
+static int __init zynqmp_reset_init(void)
+{
+	return platform_driver_register(&zynqmp_reset_driver);
+}
+
+arch_initcall(zynqmp_reset_init);
-- 
2.16.1
