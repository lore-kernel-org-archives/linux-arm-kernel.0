From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 31 Oct 2016 15:45:35 +0100
Subject: [PATCH v2 2/5] ARM: bus: da8xx-mstpri: new driver
In-Reply-To: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1477925138-23457-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create the driver for the da8xx master peripheral priority
configuration and implement support for writing to the three
Master Priority registers on da850 SoCs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 .../devicetree/bindings/bus/ti,da850-mstpri.txt    |  20 ++
 drivers/bus/Kconfig                                |   9 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/da8xx-mstpri.c                         | 269 +++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
 create mode 100644 drivers/bus/da8xx-mstpri.c

diff --git a/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt b/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
new file mode 100644
index 0000000..72daefc
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/ti,da850-mstpri.txt
@@ -0,0 +1,20 @@
+* Device tree bindings for Texas Instruments da8xx master peripheral
+  priority driver
+
+DA8XX SoCs feature a set of registers allowing to change the priority of all
+peripherals classified as masters.
+
+Documentation:
+OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
+
+Required properties:
+
+- compatible:		"ti,da850-mstpri" - for da850 based boards
+- reg:			offset and length of the mstpri registers
+
+Example for da850-lcdk is shown below.
+
+mstpri {
+	compatible = "ti,da850-mstpri";
+	reg = <0x14110 0x0c>;
+};
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7875105..f5db3a7 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -167,4 +167,13 @@ config VEXPRESS_CONFIG
 	help
 	  Platform configuration infrastructure for the ARM Ltd.
 	  Versatile Express.
+
+config DA8XX_MSTPRI
+	bool "TI da8xx master peripheral priority driver"
+	depends on ARCH_DAVINCI_DA8XX
+	help
+	  Driver for Texas Instruments da8xx master peripheral priority
+	  configuration. Allows to adjust the priorities of all master
+	  peripherals.
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index c6cfa6b..2adb540 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -21,3 +21,5 @@ obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
+
+obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
new file mode 100644
index 0000000..85f0b53
--- /dev/null
+++ b/drivers/bus/da8xx-mstpri.c
@@ -0,0 +1,269 @@
+/*
+ * TI da8xx master peripheral priority driver
+ *
+ * Copyright (C) 2016 BayLibre SAS
+ *
+ * Author:
+ *   Bartosz Golaszewski <bgolaszewski@baylibre.com.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <linux/of_fdt.h>
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
+#define DA8XX_MSTPRI0_OFFSET		0
+#define DA8XX_MSTPRI1_OFFSET		4
+#define DA8XX_MSTPRI2_OFFSET		8
+
+enum {
+	DA8XX_MSTPRI_ARM_I = 0,
+	DA8XX_MSTPRI_ARM_D,
+	DA8XX_MSTPRI_UPP,
+	DA8XX_MSTPRI_SATA,
+	DA8XX_MSTPRI_PRU0,
+	DA8XX_MSTPRI_PRU1,
+	DA8XX_MSTPRI_EDMA30TC0,
+	DA8XX_MSTPRI_EDMA30TC1,
+	DA8XX_MSTPRI_EDMA31TC0,
+	DA8XX_MSTPRI_VPIF_DMA_0,
+	DA8XX_MSTPRI_VPIF_DMA_1,
+	DA8XX_MSTPRI_EMAC,
+	DA8XX_MSTPRI_USB0CFG,
+	DA8XX_MSTPRI_USB0CDMA,
+	DA8XX_MSTPRI_UHPI,
+	DA8XX_MSTPRI_USB1,
+	DA8XX_MSTPRI_LCDC,
+};
+
+struct da8xx_mstpri_descr {
+	int reg;
+	int shift;
+	int mask;
+};
+
+static const struct da8xx_mstpri_descr da8xx_mstpri_priority_list[] = {
+	[DA8XX_MSTPRI_ARM_I] = {
+		.reg = DA8XX_MSTPRI0_OFFSET,
+		.shift = 0,
+		.mask = 0x0000000f,
+	},
+	[DA8XX_MSTPRI_ARM_D] = {
+		.reg = DA8XX_MSTPRI0_OFFSET,
+		.shift = 4,
+		.mask = 0x000000f0,
+	},
+	[DA8XX_MSTPRI_UPP] = {
+		.reg = DA8XX_MSTPRI0_OFFSET,
+		.shift = 16,
+		.mask = 0x000f0000,
+	},
+	[DA8XX_MSTPRI_SATA] = {
+		.reg = DA8XX_MSTPRI0_OFFSET,
+		.shift = 20,
+		.mask = 0x00f00000,
+	},
+	[DA8XX_MSTPRI_PRU0] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 0,
+		.mask = 0x0000000f,
+	},
+	[DA8XX_MSTPRI_PRU1] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 4,
+		.mask = 0x000000f0,
+	},
+	[DA8XX_MSTPRI_EDMA30TC0] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 8,
+		.mask = 0x00000f00,
+	},
+	[DA8XX_MSTPRI_EDMA30TC1] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 12,
+		.mask = 0x0000f000,
+	},
+	[DA8XX_MSTPRI_EDMA31TC0] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 16,
+		.mask = 0x000f0000,
+	},
+	[DA8XX_MSTPRI_VPIF_DMA_0] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 24,
+		.mask = 0x0f000000,
+	},
+	[DA8XX_MSTPRI_VPIF_DMA_1] = {
+		.reg = DA8XX_MSTPRI1_OFFSET,
+		.shift = 28,
+		.mask = 0xf0000000,
+	},
+	[DA8XX_MSTPRI_EMAC] = {
+		.reg = DA8XX_MSTPRI2_OFFSET,
+		.shift = 0,
+		.mask = 0x0000000f,
+	},
+	[DA8XX_MSTPRI_USB0CFG] = {
+		.reg = DA8XX_MSTPRI2_OFFSET,
+		.shift = 8,
+		.mask = 0x00000f00,
+	},
+	[DA8XX_MSTPRI_USB0CDMA] = {
+		.reg = DA8XX_MSTPRI2_OFFSET,
+		.shift = 12,
+		.mask = 0x0000f000,
+	},
+	[DA8XX_MSTPRI_UHPI] = {
+		.reg = DA8XX_MSTPRI2_OFFSET,
+		.shift = 20,
+		.mask = 0x00f00000,
+	},
+	[DA8XX_MSTPRI_USB1] = {
+		.reg = DA8XX_MSTPRI2_OFFSET,
+		.shift = 24,
+		.mask = 0x0f000000,
+	},
+	[DA8XX_MSTPRI_LCDC] = {
+		.reg = DA8XX_MSTPRI2_OFFSET,
+		.shift = 28,
+		.mask = 0xf0000000,
+	},
+};
+
+struct da8xx_mstpri_priority {
+	int which;
+	u32 val;
+};
+
+struct da8xx_mstpri_board_priorities {
+	const char *board;
+	const struct da8xx_mstpri_priority *priorities;
+	size_t numprio;
+};
+
+/*
+ * Default memory settings of da850 do not meet the throughput/latency
+ * requirements of tilcdc. This results in the image displayed being
+ * incorrect and the following warning being displayed by the LCDC
+ * drm driver:
+ *
+ *   tilcdc da8xx_lcdc.0: tilcdc_crtc_irq(0x00000020): FIFO underfow
+ */
+static const struct da8xx_mstpri_priority da850_lcdk_priorities[] = {
+	{
+		.which = DA8XX_MSTPRI_LCDC,
+		.val = 0,
+	},
+	{
+		.which = DA8XX_MSTPRI_EDMA30TC1,
+		.val = 0,
+	},
+	{
+		.which = DA8XX_MSTPRI_EDMA30TC0,
+		.val = 1,
+	},
+};
+
+static const struct da8xx_mstpri_board_priorities da8xx_mstpri_board_confs[] = {
+	{
+		.board = "ti,da850-lcdk",
+		.priorities = da850_lcdk_priorities,
+		.numprio = ARRAY_SIZE(da850_lcdk_priorities),
+	},
+};
+
+static const struct da8xx_mstpri_board_priorities *
+da8xx_mstpri_get_board_prio(void)
+{
+	const struct da8xx_mstpri_board_priorities *board_prio;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(da8xx_mstpri_board_confs); i++) {
+		board_prio = &da8xx_mstpri_board_confs[i];
+
+		if (of_machine_is_compatible(board_prio->board))
+			return board_prio;
+	}
+
+	return NULL;
+}
+
+static int da8xx_mstpri_probe(struct platform_device *pdev)
+{
+	const struct da8xx_mstpri_board_priorities *prio_list;
+	const struct da8xx_mstpri_descr *prio_descr;
+	const struct da8xx_mstpri_priority *prio;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *mstpri;
+	u32 reg;
+	int i;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mstpri = devm_ioremap_resource(dev, res);
+	if (IS_ERR(mstpri)) {
+		dev_err(dev, "unable to map MSTPRI registers\n");
+		return PTR_ERR(mstpri);
+	}
+
+	prio_list = da8xx_mstpri_get_board_prio();
+	if (!prio_list) {
+		dev_err(dev, "no master priotities defined for board '%s'\n",
+			of_flat_dt_get_machine_name());
+		return -EINVAL;
+	}
+
+	for (i = 0; i < prio_list->numprio; i++) {
+		prio = &prio_list->priorities[i];
+		prio_descr = &da8xx_mstpri_priority_list[prio->which];
+
+		if (prio_descr->reg + sizeof(u32) > resource_size(res)) {
+			dev_warn(dev, "register offset out of range\n");
+			continue;
+		}
+
+		reg = readl(mstpri + prio_descr->reg);
+		reg &= ~prio_descr->mask;
+		reg |= prio->val << prio_descr->shift;
+
+		writel(reg, mstpri + prio_descr->reg);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id da8xx_mstpri_of_match[] = {
+	{ .compatible = "ti,da850-mstpri", },
+	{ },
+};
+
+static struct platform_driver da8xx_mstpri_driver = {
+	.probe = da8xx_mstpri_probe,
+	.driver = {
+		.name = "da8xx-mstpri",
+		.of_match_table = da8xx_mstpri_of_match,
+	},
+};
+module_platform_driver(da8xx_mstpri_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bgolaszewski@baylibre.com>");
+MODULE_DESCRIPTION("TI da8xx master peripheral priority driver");
+MODULE_LICENSE("GPL v2");
-- 
2.9.3
