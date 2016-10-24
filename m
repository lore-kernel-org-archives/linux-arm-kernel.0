From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 24 Oct 2016 18:46:36 +0200
Subject: [RFC] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
References: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1477327596-16060-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new driver for the da8xx DDR2/mDDR controller and implement
support for writing to the Peripheral Bus Burst Priority Register.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      | 187 +++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/memory/da8xx-ddrctl.c

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
new file mode 100644
index 0000000..f0eda59
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
@@ -0,0 +1,20 @@
+* Device tree bindings for Texas Instruments da8xx DDR2/mDDR memory controller
+
+The DDR2/mDDR memory controller present on Texas Instruments da8xx SoCs memory
+maps a set of registers which allow to tweak the controller's behavior.
+
+Documentation:
+OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
+
+Required properties:
+
+- compatible:		"ti,da850-ddrctl" - for da850 SoC based boards
+- reg:			a tuple containing the base address of the memory
+			controller and the size of the memory area to map
+
+Example for da850 shown below.
+
+ddrctl {
+	compatible = "ti,da850-ddrctl";
+	reg = <0xB0000000 0x100>;
+};
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 4b4c0c3..ec80e35 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -134,6 +134,14 @@ config MTK_SMI
 	  mainly help enable/disable iommu and control the power domain and
 	  clocks for each local arbiter.
 
+config DA8XX_DDRCTL
+	bool "Texas Instruments da8xx DDR2/mDDR driver"
+	depends on ARCH_DAVINCI_DA8XX
+	help
+	  This driver is for the DDR2/mDDR Memory Controller present on
+	  Texas Instruments da8xx SoCs. It's used to tweak various memory
+	  controller configuration options.
+
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
 
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index b20ae38..e88097fb 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
 obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
 obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
+obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
new file mode 100644
index 0000000..756a6f3
--- /dev/null
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -0,0 +1,187 @@
+/*
+ * TI da8xx DDR2/mDDR controller driver
+ *
+ * Copyright (C) 2016 BayLibre SAS
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+struct da8xx_ddrctl_config_knob {
+	const char *name;
+	u32 reg;
+	u32 mask;
+	u32 offset;
+};
+
+static const struct da8xx_ddrctl_config_knob da8xx_ddrctl_knobs[] = {
+	{
+		.name = "da850-pbbpr",
+		.reg = 0x20,
+		.mask = 0xffffff00,
+		.offset = 0,
+	},
+};
+
+struct da8xx_ddrctl_setting {
+	const char *name;
+	u32 val;
+};
+
+struct da8xx_ddrctl_board_settings {
+	const char *board;
+	const struct da8xx_ddrctl_setting *settings;
+};
+
+static const struct da8xx_ddrctl_setting da850_lcdk_ddrctl_settings[] = {
+	{
+		.name = "da850-pbbpr",
+		.val = 0x20,
+	},
+	{ }
+};
+
+static const struct da8xx_ddrctl_board_settings da8xx_ddrctl_board_confs[] = {
+	{
+		.board = "ti,da850-lcdk",
+		.settings = da850_lcdk_ddrctl_settings,
+	},
+};
+
+static const struct da8xx_ddrctl_config_knob *
+da8xx_ddrctl_match_knob(const struct da8xx_ddrctl_setting *setting)
+{
+	const struct da8xx_ddrctl_config_knob *knob;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(da8xx_ddrctl_knobs); i++) {
+		knob = &da8xx_ddrctl_knobs[i];
+
+		if (strcmp(knob->name, setting->name) == 0) {
+			return knob;
+		}
+	}
+
+	return NULL;
+}
+
+static const struct da8xx_ddrctl_setting *
+da8xx_ddrctl_match_board(const char *board)
+{
+	const struct da8xx_ddrctl_board_settings *board_settings;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(da8xx_ddrctl_board_confs); i++) {
+		board_settings = &da8xx_ddrctl_board_confs[0];
+
+		if (strcmp(board, board_settings->board) == 0)
+			return board_settings->settings;
+	}
+
+	return NULL;
+}
+
+static int da8xx_ddrctl_probe(struct platform_device *pdev)
+{
+	const struct da8xx_ddrctl_config_knob *knob;
+	const struct da8xx_ddrctl_setting *setting;
+	u32 regprop[2], base, memsize, reg;
+	struct device_node *node, *parent;
+	void __iomem *ddrctl;
+	const char *board;
+	struct device *dev;
+	int ret;
+
+	dev = &pdev->dev;
+	node = dev->of_node;
+
+	/* Find the board name. */
+	for (parent = node;
+	     !of_node_is_root(parent);
+	     parent = of_get_parent(parent));
+
+	ret = of_property_read_string(parent, "compatible", &board);
+	if (ret) {
+		dev_err(dev, "unable to read the soc model\n");
+		return ret;
+	}
+
+	/* Check if we have settings for this board. */
+	setting = da8xx_ddrctl_match_board(board);
+	if (!setting) {
+		dev_err(dev, "no settings for board '%s'\n", board);
+		return -EINVAL;
+	}
+
+	/* Figure out how to map the memory for the controller. */
+	ret = of_property_read_u32_array(node, "reg", regprop, 2);
+	if (ret) {
+		dev_err(dev, "unable to parse 'reg' property\n");
+		return ret;
+	}
+
+	base = regprop[0];
+	memsize = regprop[1];
+
+	ddrctl = ioremap(base, memsize);
+	if (!ddrctl) {
+		dev_err(dev, "unable to map memory controller registers\n");
+		return -EIO;
+	}
+
+	for (; setting->name; setting++) {
+		knob = da8xx_ddrctl_match_knob(setting);
+		if (!knob) {
+			dev_warn(dev,
+				 "no such config option: %s\n", setting->name);
+			continue;
+		}
+
+		if (knob->reg > (memsize - sizeof(u32))) {
+			dev_warn(dev,
+				 "register offset of '%s' exceeds mapped memory size\n",
+				 knob->name);
+			continue;
+		}
+
+		reg = __raw_readl(ddrctl + knob->reg);
+		reg &= knob->mask;
+		reg |= setting->val << knob->offset;
+
+		dev_dbg(dev, "writing 0x%08x to %s\n", reg, setting->name);
+
+		__raw_writel(reg, ddrctl + knob->reg);
+	}
+
+	iounmap(ddrctl);
+
+	return 0;
+}
+
+static const struct of_device_id da8xx_ddrctl_of_match[] = {
+	{ .compatible = "ti,da850-ddrctl", },
+	{ },
+};
+
+static struct platform_driver da8xx_ddrctl_driver = {
+	.probe = da8xx_ddrctl_probe,
+	.driver = {
+		.name = "da8xx-ddrctl",
+		.of_match_table = da8xx_ddrctl_of_match,
+	},
+};
+module_platform_driver(da8xx_ddrctl_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_DESCRIPTION("TI da8xx DDR2/mDDR controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
