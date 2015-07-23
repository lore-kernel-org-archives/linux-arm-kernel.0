From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Thu, 23 Jul 2015 15:51:02 -0700
Subject: [RFC 3/3] reset: reset-zynq-pl: Adding support for Xilinx Zynq PL
 reset.
In-Reply-To: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
References: <1437691862-21312-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1437691862-21312-4-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Zynq PL reset controller allows to control the 4
FCLK{0..3}_RESETN signals that can be used to reset custom IP in
the PL.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-zynq-pl.c | 142 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 drivers/reset/reset-zynq-pl.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 157d421..5c86f92 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
+obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq-pl.o
diff --git a/drivers/reset/reset-zynq-pl.c b/drivers/reset/reset-zynq-pl.c
new file mode 100644
index 0000000..3e04ab0
--- /dev/null
+++ b/drivers/reset/reset-zynq-pl.c
@@ -0,0 +1,142 @@
+/*
+ * Xilinx Zynq PL Reset Controller
+ *
+ * Copyright (c) 2015, National Instruments Corp.
+ * Author: Moritz Fischer <moritz.fischer@ettus.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+/* Offsets into SLCR regmap */
+#define SLCR_FPGA_RST_CTRL_OFFSET	0x240 /* FPGA Software Reset Control */
+
+struct zynq_pl_reset_data {
+	struct regmap *slcr;
+	struct reset_controller_dev rcdev;
+};
+
+static int zynq_pl_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct zynq_pl_reset_data *priv = container_of(rcdev,
+						struct zynq_pl_reset_data,
+						rcdev);
+
+	int offset = id % BITS_PER_LONG;
+
+	regmap_update_bits(priv->slcr,
+			   SLCR_FPGA_RST_CTRL_OFFSET,
+			   BIT(offset),
+			   BIT(offset));
+
+	return 0;
+}
+
+static int zynq_pl_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct zynq_pl_reset_data *priv = container_of(rcdev,
+						struct zynq_pl_reset_data,
+						rcdev);
+
+	int offset = id % BITS_PER_LONG;
+
+	regmap_update_bits(priv->slcr,
+			   SLCR_FPGA_RST_CTRL_OFFSET,
+			   BIT(offset),
+			   ~BIT(offset));
+
+	return 0;
+}
+
+static int zynq_pl_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct zynq_pl_reset_data *priv = container_of(rcdev,
+						struct zynq_pl_reset_data,
+						rcdev);
+	int offset = id % BITS_PER_LONG;
+	u32 reg;
+
+	regmap_read(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET, &reg);
+
+	return !(reg & BIT(offset));
+}
+
+static const struct reset_control_ops zynq_pl_reset_ops = {
+	.assert		= zynq_pl_reset_assert,
+	.deassert	= zynq_pl_reset_deassert,
+	.status		= zynq_pl_reset_status,
+};
+
+static int zynq_pl_reset_probe(struct platform_device *pdev)
+{
+	struct zynq_pl_reset_data *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, priv);
+
+	priv->slcr = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+		"syscon");
+	if (IS_ERR(priv->slcr)) {
+		dev_err(&pdev->dev, "unable to get zynq-slcr regmap");
+		return PTR_ERR(priv->slcr);
+	}
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.nr_resets = BITS_PER_LONG;
+	priv->rcdev.ops = &zynq_pl_reset_ops;
+	priv->rcdev.of_node = pdev->dev.of_node;
+	reset_controller_register(&priv->rcdev);
+
+	return 0;
+}
+
+static int zynq_pl_reset_remove(struct platform_device *pdev)
+{
+	struct zynq_pl_reset_data *priv = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&priv->rcdev);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_pl_reset_dt_ids[] = {
+	{ .compatible = "xlnx,zynq-reset-pl", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver zynq_pl_reset_driver = {
+	.probe	= zynq_pl_reset_probe,
+	.remove	= zynq_pl_reset_remove,
+	.driver = {
+		.name		= "zynq-pl-reset",
+		.of_match_table	= zynq_pl_reset_dt_ids,
+	},
+};
+module_platform_driver(zynq_pl_reset_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
+MODULE_DESCRIPTION("Zynq PL Reset Controller Driver");
+MODULE_ALIAS("reset:zynq-pl");
-- 
2.4.3
