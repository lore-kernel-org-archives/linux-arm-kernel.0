From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 25 Oct 2016 15:41:16 +0200
Subject: [RFC v2] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <1477402876-22472-1-git-send-email-bgolaszewski@baylibre.com>
References: <1477402876-22472-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1477402876-22472-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a new driver for the da8xx DDR2/mDDR controller and implement
support for writing to the Peripheral Bus Burst Priority Register.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      | 175 +++++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/memory/da8xx-ddrctl.c

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
new file mode 100644
index 0000000..7e271dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
@@ -0,0 +1,20 @@
+* Device tree bindings for Texas Instruments da8xx DDR2/mDDR memory controller
+
+The DDR2/mDDR memory controller present on Texas Instruments da8xx SoCs features
+a set of registers which allow to tweak the controller's behavior.
+
+Documentation:
+OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
+
+Required properties:
+
+- compatible:		"ti,da850-ddr-controller" - for da850 SoC based boards
+- reg:			a tuple containing the base address of the memory
+			controller and the size of the memory area to map
+
+Example for da850 shown below.
+
+ddrctl {
+	compatible = "ti,da850-ddr-controller";
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
index 0000000..66022df
--- /dev/null
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -0,0 +1,175 @@
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
+#include <linux/of_fdt.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+/*
+ * REVISIT: Linux doesn't have a good framework for the kind of performance
+ * knobs this driver controls. We can't use device tree properties as it deals
+ * with hardware configuration rather than description. We also don't want to
+ * commit to maintaining some random sysfs attributes.
+ *
+ * For now we just hardcode the register values for the boards that need
+ * some changes (as is the case for the LCD controller on da850-lcdk - the
+ * first board we support here). When linux gets an appropriate framework,
+ * we'll easily convert the driver to it.
+ */
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
+		if (strcmp(knob->name, setting->name) == 0)
+			return knob;
+	}
+
+	return NULL;
+}
+
+static const struct da8xx_ddrctl_setting *da8xx_ddrctl_get_board_settings(void)
+{
+	const struct da8xx_ddrctl_board_settings *board_settings;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(da8xx_ddrctl_board_confs); i++) {
+		board_settings = &da8xx_ddrctl_board_confs[0];
+
+		if (of_machine_is_compatible(board_settings->board))
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
+	struct device_node *node;
+	struct resource *res;
+	void __iomem *ddrctl;
+	struct device *dev;
+	u32 reg;
+
+	dev = &pdev->dev;
+	node = dev->of_node;
+
+	setting = da8xx_ddrctl_get_board_settings();
+	if (!setting) {
+		dev_err(dev, "no settings for board '%s'\n",
+			of_flat_dt_get_machine_name());
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ddrctl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ddrctl)) {
+		dev_err(dev, "unable to map memory controller registers\n");
+		return PTR_ERR(ddrctl);
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
+		if (knob->reg > (res->end - res->start - sizeof(u32))) {
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
+	return 0;
+}
+
+static const struct of_device_id da8xx_ddrctl_of_match[] = {
+	{ .compatible = "ti,da850-ddr-controller", },
+	{ },
+};
+
+static struct platform_driver da8xx_ddrctl_driver = {
+	.probe = da8xx_ddrctl_probe,
+	.driver = {
+		.name = "da850-ddr-controller",
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
