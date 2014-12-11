From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 11 Dec 2014 21:21:41 +0100
Subject: [RFC 2/3] ARM: socfpga: Add drivers for the SoC-to-FPGA bridges
In-Reply-To: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1418329302-20813-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From the datasheet:

	The HPS-FPGA bridges allow masters in the FPGA fabric to
	communicate with slaves in the HPS logic and vice versa.
	For example, you can instantiate additional memories or
	peripherals in the FPGA fabric, and master interfaces
	belonging to components in the HPS logic can access them.
	You can also instantiate components such as a NiosII
	processor in the FPGA fabric and their master interfaces
	can access memories or peripherals in the HPS logic

This patch adds support for the three bridges on SoCFPGA.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/soc/socfpga/Kconfig             |  43 ++++++
 drivers/soc/socfpga/Makefile            |   4 +
 drivers/soc/socfpga/bridges-common.c    |  84 +++++++++++
 drivers/soc/socfpga/bridges-common.h    |  28 ++++
 drivers/soc/socfpga/fpga2hps-bridge.c   |  97 ++++++++++++
 drivers/soc/socfpga/hps2fpga-bridge.c   | 258 ++++++++++++++++++++++++++++++++
 drivers/soc/socfpga/lwhps2fpga-bridge.c | 141 +++++++++++++++++
 drivers/soc/socfpga/lwhps2fpga.h        |  31 ++++
 include/soc/socfpga/bridge.h            |  65 ++++++++
 9 files changed, 751 insertions(+)
 create mode 100644 drivers/soc/socfpga/Kconfig
 create mode 100644 drivers/soc/socfpga/Makefile
 create mode 100644 drivers/soc/socfpga/bridges-common.c
 create mode 100644 drivers/soc/socfpga/bridges-common.h
 create mode 100644 drivers/soc/socfpga/fpga2hps-bridge.c
 create mode 100644 drivers/soc/socfpga/hps2fpga-bridge.c
 create mode 100644 drivers/soc/socfpga/lwhps2fpga-bridge.c
 create mode 100644 drivers/soc/socfpga/lwhps2fpga.h
 create mode 100644 include/soc/socfpga/bridge.h

diff --git a/drivers/soc/socfpga/Kconfig b/drivers/soc/socfpga/Kconfig
new file mode 100644
index 000000000000..963b38f28b91
--- /dev/null
+++ b/drivers/soc/socfpga/Kconfig
@@ -0,0 +1,43 @@
+#
+# SoCFPGA Soc drivers
+#
+
+menuconfig SOCFPGA_BRIDGES
+	bool "SoCFPGA AXI bridges support"
+	depends on ARCH_SOCFPGA
+	select REGMAP_MMIO
+	select SOCFPGA_L3NIC
+	default m
+	help
+	  Enable support for the SoCFPGA bridges that connect the HPS to the
+	  FPGA.
+
+if SOCFPGA_BRIDGES
+
+config SOCFPGA_LWHPS2FPGA
+	tristate "SoCFPGA LWHPS2FPGA bridge support"
+	depends on ARCH_SOCFPGA
+	select REGMAP_MMIO
+	select SOCFPGA_L3NIC
+	default m
+	help
+	  Enable support for the SoCFPGA LWHPS2FPGA bridge.
+
+config SOCFPGA_HPS2FPGA
+	tristate "SoCFPGA HPS2FPGA bridge support"
+	depends on ARCH_SOCFPGA
+	select REGMAP_MMIO
+	select SOCFPGA_L3NIC
+	default m
+	help
+	  Enable support for the SoCFPGA HPS2FPGA bridge.
+
+config SOCFPGA_FPGA2HPS
+	tristate "SoCFPGA FPGA2HPS bridge support"
+	depends on ARCH_SOCFPGA
+	select REGMAP_MMIO
+	select SOCFPGA_L3NIC
+	default m
+	help
+	  Enable support for the SoCFPGA FPGA2HPS bridge.
+endif
diff --git a/drivers/soc/socfpga/Makefile b/drivers/soc/socfpga/Makefile
new file mode 100644
index 000000000000..948749126907
--- /dev/null
+++ b/drivers/soc/socfpga/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_SOCFPGA_BRIDGES) += bridges-common.o
+obj-$(CONFIG_SOCFPGA_LWHPS2FPGA) += lwhps2fpga-bridge.o
+obj-$(CONFIG_SOCFPGA_HPS2FPGA) += hps2fpga-bridge.o
+obj-$(CONFIG_SOCFPGA_FPGA2HPS) += fpga2hps-bridge.o
diff --git a/drivers/soc/socfpga/bridges-common.c b/drivers/soc/socfpga/bridges-common.c
new file mode 100644
index 000000000000..2acc77c61df5
--- /dev/null
+++ b/drivers/soc/socfpga/bridges-common.c
@@ -0,0 +1,84 @@
+/*
+ * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <soc/socfpga/bridge.h>
+#include <soc/socfpga/gpv.h>
+#include "bridges-common.h"
+
+int socfpga_bridge_reset_probe(struct platform_device *pdev,
+			       struct socfpga_bridge *priv,
+			       const char *name)
+{
+	priv->rst = devm_reset_control_get(&pdev->dev, name);
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	return reset_control_deassert(priv->rst);
+}
+EXPORT_SYMBOL_GPL(socfpga_bridge_reset_probe);
+
+struct regmap *socfpga_bridge_regmap_by_phandle(struct device_node *np,
+						const char *name)
+{
+	struct socfpga_bridge *bridge;
+	struct platform_device *pdev;
+
+	pdev = socfpga_gpv_device_by_phandle(np, name);
+	if (IS_ERR(pdev))
+		return ERR_PTR(-EPROBE_DEFER);
+
+	bridge = dev_get_drvdata(&pdev->dev);
+	if (IS_ERR(bridge))
+		return ERR_PTR(-EINVAL);
+
+	return bridge->regmap;
+}
+EXPORT_SYMBOL_GPL(socfpga_bridge_regmap_by_phandle);
+
+int socfpga_bridge_probe(struct platform_device *pdev,
+			 const struct of_device_id *dt_ids)
+{
+	struct socfpga_bridge *priv;
+	struct resource *res;
+	const struct of_device_id *device;
+	unsigned int bus_width;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	device = of_match_device(dt_ids, &pdev->dev);
+	if (!device)
+		return -ENODEV;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "gpv");
+	if (!res)
+		return -EADDRNOTAVAIL;
+
+	priv->gpv_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->gpv_base))
+		return PTR_ERR(priv->gpv_base);
+
+	priv->max_register = res->end - res->start - 3;
+
+	if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width))
+		priv->width = bus_width;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(socfpga_bridge_probe);
diff --git a/drivers/soc/socfpga/bridges-common.h b/drivers/soc/socfpga/bridges-common.h
new file mode 100644
index 000000000000..513efbb29a0e
--- /dev/null
+++ b/drivers/soc/socfpga/bridges-common.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __SOC_SOCFPGA_BRIDGES_COMMON_H__
+#define __SOC_SOCFPGA_BRIDGES_COMMON_H__
+
+struct socfpga_bridge;
+struct platform_device;
+struct platform_driver;
+struct device_node;
+
+extern int socfpga_bridge_reset_probe(struct platform_device *pdev,
+				      struct socfpga_bridge *priv,
+				      const char *name);
+
+extern struct regmap *socfpga_bridge_regmap_by_phandle(struct device_node *np,
+						const char *name);
+
+extern int socfpga_bridge_probe(struct platform_device *pdev,
+				const struct of_device_id *dt_ids);
+
+#endif
diff --git a/drivers/soc/socfpga/fpga2hps-bridge.c b/drivers/soc/socfpga/fpga2hps-bridge.c
new file mode 100644
index 000000000000..8bf3a42a03ee
--- /dev/null
+++ b/drivers/soc/socfpga/fpga2hps-bridge.c
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <soc/socfpga/bridge.h>
+#include <soc/socfpga/gpv.h>
+#include <soc/socfpga/l3regs.h>
+#include "bridges-common.h"
+
+MODULE_PARM_DESC(fpga2hps_wr_trans, "Enable multiple outstanding write transactions for FPGA2HPS (default, 'y')");
+static bool fpga2hps_wr_trans = true;
+module_param(fpga2hps_wr_trans, bool, 0644);
+
+MODULE_PARM_DESC(fpga2hps_rd_trans, "Enable multiple outstanding read transactions for FPGA2HPS (default, 'y')");
+static bool fpga2hps_rd_trans = true;
+module_param(fpga2hps_rd_trans, bool, 0644);
+
+static const struct of_device_id socfpga_fpga2hps_dt_ids[] = {
+	{ .compatible = "altr,fpga2hps-axi-bridge", },
+	{ /* sentinel */ },
+};
+
+static int socfpga_fpga2hps_probe(struct platform_device *pdev)
+{
+	struct socfpga_bridge *priv;
+	int ret;
+
+	ret = socfpga_bridge_probe(pdev, socfpga_fpga2hps_dt_ids);
+	if (ret)
+		return ret;
+
+	priv = platform_get_drvdata(pdev);
+	ret = socfpga_bridge_reset_probe(pdev, priv, "fpga2hps");
+	if (ret)
+		return ret;
+
+	priv->gpv_clk = devm_clk_get(&pdev->dev, "gpv_clk");
+	if (IS_ERR(priv->gpv_clk))
+		return PTR_ERR(priv->gpv_clk);
+
+	clk_prepare_enable(priv->gpv_clk);
+
+	priv->clk = devm_clk_get(&pdev->dev, "data_clk");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	clk_prepare_enable(priv->clk);
+
+	if (priv->width == 32 || priv->width == 128) {
+		priv->gpv_master = socfpga_bridge_regmap_by_phandle(
+							pdev->dev.of_node,
+							"altr,bridge-gpv");
+		if (IS_ERR(priv->gpv_master))
+			return -EPROBE_DEFER;
+
+		dev_info(&pdev->dev, "HPS2FPGA GPV registered\n");
+	}
+
+	dev_info(&pdev->dev, "FPGA2HPS registered\n");
+
+	return 0;
+}
+
+static int socfpga_fpga2hps_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver socfpga_fpga2hps_driver = {
+	.probe	= socfpga_fpga2hps_probe,
+	.remove	= socfpga_fpga2hps_remove,
+	.driver = {
+		.name		= "socfpga-fpga2hps-bridge",
+		.owner		= THIS_MODULE,
+		.of_match_table	= socfpga_fpga2hps_dt_ids,
+	},
+};
+module_platform_driver(socfpga_fpga2hps_driver);
+
+MODULE_AUTHOR("Steffen Trumtrar <s.trumtrar at pengutronix.de");
+MODULE_DESCRIPTION("Socfpga AXI-FPGA2HPS-Bridge Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/socfpga/hps2fpga-bridge.c b/drivers/soc/socfpga/hps2fpga-bridge.c
new file mode 100644
index 000000000000..1f0f58134594
--- /dev/null
+++ b/drivers/soc/socfpga/hps2fpga-bridge.c
@@ -0,0 +1,258 @@
+/*
+ * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/types.h>
+#include <soc/socfpga/bridge.h>
+#include <soc/socfpga/gpv.h>
+#include <soc/socfpga/l3regs.h>
+#include "bridges-common.h"
+#include "lwhps2fpga.h"
+
+MODULE_PARM_DESC(wr_trans, "Enable multiple outstanding write transactions for HPS2FPGA AXI bus (default, 'y')");
+static bool wr_trans = true;
+module_param(wr_trans, bool, 0644);
+
+MODULE_PARM_DESC(rd_trans, "Enable multiple outstanding read transactions for HPS2FPGA AXI bus (default, 'y'')");
+static bool rd_trans = true;
+module_param(rd_trans, bool, 0644);
+
+MODULE_PARM_DESC(force_incr, "Enable forcing of INCR for HPS2FPGA AHB (default, 'n')");
+static bool force_incr;
+module_param(force_incr, bool, 0644);
+
+MODULE_PARM_DESC(decerr_en, "Enable DECERR responses for HPS2FPGA AHB (default, 'n'')");
+static bool decerr_en;
+module_param(decerr_en, bool, 0644);
+
+MODULE_PARM_DESC(bypass_merge, "Enable upsizing/downsizing of transactions for HPS2FPGA  AXI bus (default, 'y')");
+static bool bypass_merge = true;
+module_param(bypass_merge, bool, 0644);
+
+#define HPS2FPGA_PERIPH_ID_4		0x1fd0
+#define HPS2FPGA_PERIPH_ID_0		0x1fe0
+#define HPS2FPGA_COMP_ID_3		0x1ffc
+#define HPS2FPGA_32BIT_FN_MOD2		0x2024
+#define HPS2FPGA_32BIT_FN_MOD		0x2108
+#define HPS2FPGA_128BIT_FN_MOD2		0x4024
+#define HPS2FPGA_128BIT_FN_MOD		0x4108
+
+static const struct regmap_range hps_read_regs_range[] = {
+	regmap_reg_range(HPS2FPGA_PERIPH_ID_4, HPS2FPGA_PERIPH_ID_4),
+	regmap_reg_range(HPS2FPGA_PERIPH_ID_0, HPS2FPGA_COMP_ID_3),
+	regmap_reg_range(HPS2FPGA_32BIT_FN_MOD2, HPS2FPGA_32BIT_FN_MOD2),
+	regmap_reg_range(HPS2FPGA_32BIT_FN_MOD, HPS2FPGA_32BIT_FN_MOD),
+	regmap_reg_range(HPS2FPGA_128BIT_FN_MOD2, HPS2FPGA_128BIT_FN_MOD2),
+	regmap_reg_range(HPS2FPGA_128BIT_FN_MOD, HPS2FPGA_128BIT_FN_MOD),
+};
+
+static const struct regmap_range hps_write_regs_range[] = {
+	regmap_reg_range(HPS2FPGA_32BIT_FN_MOD2, HPS2FPGA_32BIT_FN_MOD2),
+	regmap_reg_range(HPS2FPGA_32BIT_FN_MOD, HPS2FPGA_32BIT_FN_MOD),
+	regmap_reg_range(HPS2FPGA_128BIT_FN_MOD2, HPS2FPGA_128BIT_FN_MOD2),
+	regmap_reg_range(HPS2FPGA_128BIT_FN_MOD, HPS2FPGA_128BIT_FN_MOD),
+};
+
+static const struct regmap_access_table hps_read_regs = {
+	.yes_ranges = hps_read_regs_range,
+	.n_yes_ranges = ARRAY_SIZE(hps_read_regs_range),
+};
+
+static const struct regmap_access_table hps_write_regs = {
+	.yes_ranges = hps_write_regs_range,
+	.n_yes_ranges = ARRAY_SIZE(hps_write_regs_range),
+};
+
+static struct regmap_config hps_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.rd_table = &hps_read_regs,
+	.wr_table = &hps_write_regs,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int socfpga_hps2fpga_gpv_probe(struct platform_device *pdev)
+{
+	struct socfpga_bridge *priv;
+	int ret;
+	int val;
+	int mask = 0;
+	int reg;
+
+	priv = platform_get_drvdata(pdev);
+
+	hps_regmap_config.max_register = priv->max_register;
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, priv->gpv_base,
+					&hps_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->gpv_master = socfpga_bridge_regmap_by_phandle(
+						pdev->dev.of_node,
+						"altr,bridge-gpv");
+	if (IS_ERR(priv->gpv_master))
+		return -EPROBE_DEFER;
+
+	dev_info(&pdev->dev, "HPS2FPGA GPV registered\n");
+
+	mask |= GPV_FN_MOD_BM_ISS_WR | GPV_FN_MOD_BM_ISS_RD;
+	reg = LWHPS2FPGA_HPS2FPGA_FN_MOD_BM_ISS;
+
+	val = 0;
+	if (!wr_trans)
+		val |= GPV_FN_MOD_BM_ISS_WR;
+
+	if (!rd_trans)
+		val |= GPV_FN_MOD_BM_ISS_RD;
+
+	ret = regmap_update_bits(priv->gpv_master, reg, mask, val);
+	if (ret) {
+		dev_err(&pdev->dev, "GPV configuration failure reg=0x%08x (%d)\n", reg, ret);
+		return ret;
+	}
+
+	reg = priv->width == 32 ? HPS2FPGA_32BIT_FN_MOD : HPS2FPGA_128BIT_FN_MOD;
+	ret = regmap_update_bits(priv->regmap, reg, mask, val);
+	if (ret) {
+		dev_err(&pdev->dev, "Configuration failure reg=0x%08x (%d)\n", reg, ret);
+		return ret;
+	}
+
+	val = 0;
+	mask = 0;
+	mask |= GPV_AHB_CNTL_FORCE_INCR | GPV_AHB_CNTL_DECERR_EN;
+	reg = LWHPS2FPGA_HPS2FPGA_AHB_CNTL;
+
+	if (force_incr)
+		val |= GPV_AHB_CNTL_FORCE_INCR;
+
+	if (decerr_en)
+		val |= GPV_AHB_CNTL_DECERR_EN;
+
+	ret = regmap_update_bits(priv->gpv_master, reg, mask, val);
+	if (ret) {
+		dev_err(&pdev->dev, "GPV configuration failure reg=0x%08x (%d)\n", reg, ret);
+		return ret;
+	}
+
+	val = 0;
+	mask = 0;
+	mask |= GPV_FN_MOD_BYPASS_MERGE;
+	reg = priv->width == 32 ? HPS2FPGA_32BIT_FN_MOD2 : HPS2FPGA_128BIT_FN_MOD2;
+
+	if (bypass_merge)
+		val |= GPV_FN_MOD_BYPASS_MERGE;
+
+	ret = regmap_update_bits(priv->regmap, reg, mask, val);
+	if (ret) {
+		dev_err(&pdev->dev, "Configuration failure reg=0x%08x (%d)\n", reg, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id socfpga_hps2fpga_dt_ids[] = {
+	{ .compatible = "altr,hps2fpga-axi-bridge", },
+	{ /* sentinel */ },
+};
+
+static int socfpga_hps2fpga_probe(struct platform_device *pdev)
+{
+	struct socfpga_bridge *priv;
+	int ret;
+
+	ret = socfpga_bridge_probe(pdev, socfpga_hps2fpga_dt_ids);
+	if (ret)
+		return ret;
+
+	priv = platform_get_drvdata(pdev);
+
+	ret = socfpga_bridge_reset_probe(pdev, priv, "hps2fpga");
+	if (ret)
+		return ret;
+
+	priv->gpv_clk = devm_clk_get(&pdev->dev, "gpv_clk");
+	if (IS_ERR(priv->gpv_clk))
+		return PTR_ERR(priv->gpv_clk);
+
+	clk_prepare_enable(priv->gpv_clk);
+
+	priv->clk = devm_clk_get(&pdev->dev, "data_clk");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	clk_prepare_enable(priv->clk);
+
+	if (priv->width == 32 || priv->width == 128) {
+		ret = socfpga_hps2fpga_gpv_probe(pdev);
+		if (ret)
+			return ret;
+	}
+
+	priv->l3regs = socfpga_l3nic_regmap_by_phandle(pdev->dev.of_node,
+						       "altr,l3-gpv");
+	if (IS_ERR(priv->l3regs)) {
+		dev_warn(&pdev->dev, "No GPV node found. Can not change bridge visibility\n");
+		return PTR_ERR(-EPROBE_DEFER);
+	} else {
+		ret = regmap_update_bits(priv->l3regs, L3NIC_REMAP,
+					L3NIC_HPS2FPGA_VISIBILITY,
+					L3NIC_HPS2FPGA_VISIBILITY);
+		if (ret) {
+			dev_err(&pdev->dev, "Bridge visibility not set. Access not possible\n");
+			return ret;
+		}
+	}
+
+	dev_info(&pdev->dev, "HPS2FPGA registered\n");
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static int socfpga_hps2fpga_remove(struct platform_device *pdev)
+{
+	struct socfpga_bridge *priv;
+
+	priv = platform_get_drvdata(pdev);
+
+	socfpga_bridge_reset_assert(priv);
+
+	clk_disable_unprepare(priv->gpv_clk);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static struct platform_driver socfpga_hps2fpga_driver = {
+	.probe	= socfpga_hps2fpga_probe,
+	.remove	= socfpga_hps2fpga_remove,
+	.driver = {
+		.name		= "socfpga-hps2fpga-bridge",
+		.owner		= THIS_MODULE,
+		.of_match_table	= socfpga_hps2fpga_dt_ids,
+	},
+};
+module_platform_driver(socfpga_hps2fpga_driver);
+
+MODULE_AUTHOR("Steffen Trumtrar <s.trumtrar at pengutronix.de");
+MODULE_DESCRIPTION("Socfpga AXI-HPS2FPGA-Bridge Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/socfpga/lwhps2fpga-bridge.c b/drivers/soc/socfpga/lwhps2fpga-bridge.c
new file mode 100644
index 000000000000..18282d159bf3
--- /dev/null
+++ b/drivers/soc/socfpga/lwhps2fpga-bridge.c
@@ -0,0 +1,141 @@
+/*
+ * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <soc/socfpga/bridge.h>
+#include <soc/socfpga/l3regs.h>
+#include "bridges-common.h"
+#include "lwhps2fpga.h"
+
+static const struct regmap_range lwhps_read_regs_range[] = {
+	regmap_reg_range(LWHPS2FPGA_PERIPH_ID_4, LWHPS2FPGA_PERIPH_ID_4),
+	regmap_reg_range(LWHPS2FPGA_PERIPH_ID_0, LWHPS2FPGA_COMP_ID_3),
+	regmap_reg_range(LWHPS2FPGA_FPGA2HPS_FN_MOD_BM_ISS, LWHPS2FPGA_FPGA2HPS_FN_MOD_BM_ISS),
+	regmap_reg_range(LWHPS2FPGA_FPGA2HPS_AHB_CNTL, LWHPS2FPGA_FPGA2HPS_AHB_CNTL),
+	regmap_reg_range(LWHPS2FPGA_HPS2FPGA_FN_MOD_BM_ISS, LWHPS2FPGA_HPS2FPGA_FN_MOD_BM_ISS),
+	regmap_reg_range(LWHPS2FPGA_HPS2FPGA_AHB_CNTL, LWHPS2FPGA_HPS2FPGA_AHB_CNTL),
+	regmap_reg_range(LWHPS2FPGA_32BIT_MASTER_FN_MODE_BM_ISS, LWHPS2FPGA_32BIT_MASTER_FN_MODE_BM_ISS),
+	regmap_reg_range(LWHPS2FPGA_32BIT_MASTER_WR_TIDEMARK, LWHPS2FPGA_32BIT_MASTER_WR_TIDEMARK),
+	regmap_reg_range(LWHPS2FPGA_32BIT_MASTER_FN_MOD, LWHPS2FPGA_32BIT_MASTER_FN_MOD),
+	regmap_reg_range(LWHPS2FPGA_L3_SLAVE_FN_MODE, LWHPS2FPGA_L3_SLAVE_FN_MODE),
+};
+
+static const struct regmap_range lwhps_write_regs_range[] = {
+	regmap_reg_range(LWHPS2FPGA_FPGA2HPS_FN_MOD_BM_ISS, LWHPS2FPGA_FPGA2HPS_FN_MOD_BM_ISS),
+	regmap_reg_range(LWHPS2FPGA_FPGA2HPS_AHB_CNTL, LWHPS2FPGA_FPGA2HPS_AHB_CNTL),
+	regmap_reg_range(LWHPS2FPGA_HPS2FPGA_FN_MOD_BM_ISS, LWHPS2FPGA_HPS2FPGA_FN_MOD_BM_ISS),
+	regmap_reg_range(LWHPS2FPGA_HPS2FPGA_AHB_CNTL, LWHPS2FPGA_HPS2FPGA_AHB_CNTL),
+	regmap_reg_range(LWHPS2FPGA_32BIT_MASTER_FN_MODE_BM_ISS, LWHPS2FPGA_32BIT_MASTER_FN_MODE_BM_ISS),
+	regmap_reg_range(LWHPS2FPGA_32BIT_MASTER_WR_TIDEMARK, LWHPS2FPGA_32BIT_MASTER_WR_TIDEMARK),
+	regmap_reg_range(LWHPS2FPGA_32BIT_MASTER_FN_MOD, LWHPS2FPGA_32BIT_MASTER_FN_MOD),
+	regmap_reg_range(LWHPS2FPGA_L3_SLAVE_FN_MODE, LWHPS2FPGA_L3_SLAVE_FN_MODE),
+};
+
+static const struct regmap_access_table lwhps_read_regs = {
+	.yes_ranges = lwhps_read_regs_range,
+	.n_yes_ranges = ARRAY_SIZE(lwhps_read_regs_range),
+};
+
+static const struct regmap_access_table lwhps_write_regs = {
+	.yes_ranges = lwhps_write_regs_range,
+	.n_yes_ranges = ARRAY_SIZE(lwhps_write_regs_range),
+};
+
+static struct regmap_config lwhps_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.rd_table = &lwhps_read_regs,
+	.wr_table = &lwhps_write_regs,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct of_device_id socfpga_lwhps2fpga_dt_ids[] = {
+	{ .compatible = "altr,lwhps2fpga-axi-bridge", },
+	{ /* sentinel */ },
+};
+
+static int socfpga_lwhps2fpga_probe(struct platform_device *pdev)
+{
+	struct socfpga_bridge *priv;
+	int ret;
+
+	ret = socfpga_bridge_probe(pdev, socfpga_lwhps2fpga_dt_ids);
+	if (ret)
+		return ret;
+
+	priv = platform_get_drvdata(pdev);
+
+	ret = socfpga_bridge_reset_probe(pdev, priv, "lwhps2fpga");
+	if (ret)
+		return ret;
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	clk_prepare_enable(priv->clk);
+
+	lwhps_regmap_config.max_register = priv->max_register;
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, priv->gpv_base,
+					&lwhps_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->l3regs = socfpga_l3nic_regmap_by_phandle(pdev->dev.of_node,
+						       "altr,l3-gpv");
+	if (IS_ERR(priv->l3regs)) {
+		dev_warn(&pdev->dev, "No GPV node found. Can not change bridge visibility\n");
+		return ERR_PTR(-EPROBE_DEFER);
+	} else {
+		ret = regmap_update_bits(priv->l3regs, L3NIC_REMAP,
+					 L3NIC_LWHPS2FPGA_VISIBILITY,
+					 L3NIC_LWHPS2FPGA_VISIBILITY);
+		if (ret) {
+			dev_err(&pdev->dev, "Bridge visibility not set. Access not possible\n");
+			return ret;
+		}
+	}
+
+	dev_info(&pdev->dev, "LWHPS2FPGA registered\n");
+
+	return 0;
+}
+
+static int socfpga_lwhps2fpga_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver socfpga_lwhps2fpga_driver = {
+	.probe	= socfpga_lwhps2fpga_probe,
+	.remove	= socfpga_lwhps2fpga_remove,
+	.driver = {
+		.name		= "socfpga-lwhps2fgpa-bridge",
+		.owner		= THIS_MODULE,
+		.of_match_table	= socfpga_lwhps2fpga_dt_ids,
+	},
+};
+module_platform_driver(socfpga_lwhps2fpga_driver);
+
+MODULE_AUTHOR("Steffen Trumtrar <s.trumtrar at pengutronix.de");
+MODULE_DESCRIPTION("Socfpga AXI-LWHPS2FPGA-Bridge Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/socfpga/lwhps2fpga.h b/drivers/soc/socfpga/lwhps2fpga.h
new file mode 100644
index 000000000000..d1882ba2ed81
--- /dev/null
+++ b/drivers/soc/socfpga/lwhps2fpga.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __SOC_SOCFPGA_LWHPS2FPGA_H__
+#define __SOC_SOCFPGA_LWHPS2FPGA_H__
+
+#define LWHPS2FPGA_PERIPH_ID_4			0x1FD0
+#define LWHPS2FPGA_PERIPH_ID_0			0x1FE0
+#define LWHPS2FPGA_PERIPH_ID_1			0x1FE4
+#define LWHPS2FPGA_PERIPH_ID_2			0x1FE8
+#define LWHPS2FPGA_PERIPH_ID_3			0x1FEC
+#define LWHPS2FPGA_COMP_ID_0			0x1FF0
+#define LWHPS2FPGA_COMP_ID_1			0x1FF4
+#define LWHPS2FPGA_COMP_ID_2			0x1FF8
+#define LWHPS2FPGA_COMP_ID_3			0x1FFC
+#define LWHPS2FPGA_FPGA2HPS_FN_MOD_BM_ISS	0x2008
+#define LWHPS2FPGA_FPGA2HPS_AHB_CNTL		0x2044
+#define LWHPS2FPGA_HPS2FPGA_FN_MOD_BM_ISS	0x3008
+#define LWHPS2FPGA_HPS2FPGA_AHB_CNTL		0x3044
+#define LWHPS2FPGA_32BIT_MASTER_FN_MODE_BM_ISS	0x5008
+#define LWHPS2FPGA_32BIT_MASTER_WR_TIDEMARK	0x5048
+#define LWHPS2FPGA_32BIT_MASTER_FN_MOD		0x5108
+#define LWHPS2FPGA_L3_SLAVE_FN_MODE		0x45108
+
+#endif
diff --git a/include/soc/socfpga/bridge.h b/include/soc/socfpga/bridge.h
new file mode 100644
index 000000000000..a2159da126b0
--- /dev/null
+++ b/include/soc/socfpga/bridge.h
@@ -0,0 +1,65 @@
+/*
+ * Copyright (c) 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __SOC_SOCFPGA_BRIDGE_H__
+#define __SOC_SOCFPGA_BRIDGE_H__
+
+#ifdef CONFIG_ARCH_SOCFPGA
+
+#include <linux/reset.h>
+
+struct socfpga_bridge {
+	void __iomem		*gpv_base;
+	struct reset_control	*rst;
+	struct regmap		*regmap;
+	struct regmap		*l3regs;
+	struct regmap		*gpv_master;
+	unsigned int		max_register;
+	struct clk		*clk;
+	struct clk		*gpv_clk;
+	unsigned int		width;
+};
+
+struct socfpga_bridge *socfpga_bridge_get(struct device_node *np,
+					  const char *name);
+
+static inline int socfpga_bridge_reset_assert(struct socfpga_bridge *priv)
+{
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	return reset_control_assert(priv->rst);
+}
+
+static inline int socfpga_bridge_reset_deassert(struct socfpga_bridge *priv)
+{
+	if (IS_ERR(priv->rst))
+		return PTR_ERR(priv->rst);
+
+	return reset_control_assert(priv->rst);
+}
+#else
+struct socfpga_bridge *socfpga_bridge_get(struct device_node *np,
+					  const char *name)
+{
+	return -ENOSYS;
+}
+
+static inline int socfpga_bridge_reset_assert(struct socfpga_bridge *priv)
+{
+	return -ENOSYS;
+}
+
+static inline int socfpga_bridge_reset_deassert(struct socfpga_bridge *priv)
+{
+	return -ENOSYS;
+}
+#endif
+
+#endif
-- 
2.1.3
