From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Jul 2016 03:20:08 +0900
Subject: [PATCH v2] reset: uniphier: add reset controller drivers for UniPhier
 SoCs
Message-ID: <1469557209-13089-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial commit for UniPhier reset controller drivers.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2 (mostly suggested by Philipp Zabel):
  - Unify multiple module_platform_driver() boilerplates into one
  - Unify tiny driver code and decrease the number of files
  - Invert the logic of .deassert_val, changing it into .assert_val
  - Show error code when failed to get regmap
  - Add a binding document
  - Support more reset signals

 .../devicetree/bindings/reset/uniphier-reset.txt   |  99 ++++++++
 MAINTAINERS                                        |   1 +
 drivers/reset/Kconfig                              |   1 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/uniphier/Kconfig                     |   9 +
 drivers/reset/uniphier/Makefile                    |   5 +
 drivers/reset/uniphier/reset-uniphier-core.c       | 270 +++++++++++++++++++++
 drivers/reset/uniphier/reset-uniphier-mio.c        |  55 +++++
 drivers/reset/uniphier/reset-uniphier-peri.c       |  55 +++++
 drivers/reset/uniphier/reset-uniphier-sys.c        |  77 ++++++
 drivers/reset/uniphier/reset-uniphier.h            |  57 +++++
 11 files changed, 630 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt
 create mode 100644 drivers/reset/uniphier/Kconfig
 create mode 100644 drivers/reset/uniphier/Makefile
 create mode 100644 drivers/reset/uniphier/reset-uniphier-core.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-mio.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-peri.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier-sys.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier.h

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
new file mode 100644
index 0000000..c2fb0d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -0,0 +1,99 @@
+UniPhier reset controller
+
+
+System reset
+------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-reset" - for PH1-sLD3 SoC.
+    "socionext,uniphier-ld4-reset"  - for PH1-LD4 SoC.
+    "socionext,uniphier-pro4-reset" - for PH1-Pro4 SoC.
+    "socionext,uniphier-sld8-reset" - for PH1-sLD8 SoC.
+    "socionext,uniphier-pro5-reset" - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-reset" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-ld11-reset" - for PH1-LD11 SoC.
+    "socionext,uniphier-ld20-reset" - for PH1-LD20 SoC.
+- #reset-cells: should be 1.
+
+Note:
+The reset node should be a child of a syscon node.
+
+Example:
+
+	sysctrl at 61840000 {
+		compatible = "simple-mfd", "syscon";
+		reg = <0x61840000 0x4000>;
+
+		reset {
+			compatible = "socionext,uniphier-ld20-reset";
+			#reset-cells = <1>;
+		};
+
+		other nodes ...
+	};
+
+
+Media I/O (MIO) reset
+---------------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sld3-mio-reset" - for PH1-sLD3 SoC.
+    "socionext,uniphier-ld4-mio-reset"  - for PH1-LD4 SoC.
+    "socionext,uniphier-pro4-mio-reset" - for PH1-Pro4 SoC.
+    "socionext,uniphier-sld8-mio-reset" - for PH1-sLD8 SoC.
+    "socionext,uniphier-pro5-mio-reset" - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-mio-reset" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-ld11-mio-reset" - for PH1-LD11 SoC.
+    "socionext,uniphier-ld20-mio-reset" - for PH1-LD20 SoC.
+- #reset-cells: should be 1.
+
+Note:
+The reset node should be a child of a syscon node.
+
+Example:
+
+	mioctrl at 59810000 {
+		compatible = "simple-mfd", "syscon";
+		reg = <0x59810000 0x800>;
+
+		reset {
+			compatible = "socionext,uniphier-ld20-mio-reset";
+			#reset-cells = <1>;
+		};
+
+		other nodes ...
+	};
+
+
+Peripheral reset
+----------------
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-ld4-peri-reset"  - for PH1-LD4 SoC.
+    "socionext,uniphier-pro4-peri-reset" - for PH1-Pro4 SoC.
+    "socionext,uniphier-sld8-peri-reset" - for PH1-sLD8 SoC.
+    "socionext,uniphier-pro5-peri-reset" - for PH1-Pro5 SoC.
+    "socionext,uniphier-pxs2-peri-reset" - for ProXstream2/PH1-LD6b SoC.
+    "socionext,uniphier-ld11-peri-reset" - for PH1-LD11 SoC.
+    "socionext,uniphier-ld20-peri-reset" - for PH1-LD20 SoC.
+- #reset-cells: should be 1.
+
+Note:
+The reset node should be a child of a syscon node.
+
+Example:
+
+	perictrl at 59820000 {
+		compatible = "simple-mfd", "syscon";
+		reg = <0x59820000 0x200>;
+
+		reset {
+			compatible = "socionext,uniphier-ld20-peri-reset";
+			#reset-cells = <1>;
+		};
+
+		other nodes ...
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index d28df0b..3cac26a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1826,6 +1826,7 @@ F:	arch/arm64/boot/dts/socionext/
 F:	drivers/bus/uniphier-system-bus.c
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/pinctrl/uniphier/
+F:	drivers/reset/uniphier/
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 4be1b8c..9ad5a01 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -29,5 +29,6 @@ config TI_SYSCON_RESET
 
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
+source "drivers/reset/uniphier/Kconfig"
 
 endif
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 5d65a93..e9498a7 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_MESON) += reset-meson.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
+obj-$(CONFIG_RESET_UNIPHIER) += uniphier/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/uniphier/Kconfig b/drivers/reset/uniphier/Kconfig
new file mode 100644
index 0000000..2d9f3d2
--- /dev/null
+++ b/drivers/reset/uniphier/Kconfig
@@ -0,0 +1,9 @@
+config RESET_UNIPHIER
+	tristate "Reset controller driver for UniPhier SoCs"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && MFD_SYSCON
+	default ARCH_UNIPHIER
+	help
+	  Support for reset controllers on UniPhier SoCs.
+	  Say Y if you want to control reset signals provided by System Control
+	  block, Media I/O block, Peripheral Block.
diff --git a/drivers/reset/uniphier/Makefile b/drivers/reset/uniphier/Makefile
new file mode 100644
index 0000000..f05c6f3
--- /dev/null
+++ b/drivers/reset/uniphier/Makefile
@@ -0,0 +1,5 @@
+obj-$(CONFIG_RESET_UNIPHIER)		+= reset-uniphier.o
+reset-uniphier-y			+= reset-uniphier-core.o
+reset-uniphier-y			+= reset-uniphier-sys.o
+reset-uniphier-y			+= reset-uniphier-mio.o
+reset-uniphier-y			+= reset-uniphier-peri.o
diff --git a/drivers/reset/uniphier/reset-uniphier-core.c b/drivers/reset/uniphier/reset-uniphier-core.c
new file mode 100644
index 0000000..a757e1a
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-core.c
@@ -0,0 +1,270 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include "reset-uniphier.h"
+
+struct uniphier_reset_priv {
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	struct regmap *regmap;
+	const struct uniphier_reset_data *data;
+};
+
+#define to_uniphier_reset_priv(_rcdev) \
+			container_of(_rcdev, struct uniphier_reset_priv, rcdev)
+
+static int uniphier_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
+{
+	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
+	const struct uniphier_reset_data *p;
+	bool handled = false;
+
+	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
+		unsigned int val;
+		int ret;
+
+		if (p->id != id)
+			continue;
+
+		val = p->assert_val;
+		if (!assert)
+			val = ~val;
+
+		ret = regmap_write_bits(priv->regmap, p->reg, p->mask, val);
+		if (ret)
+			return ret;
+
+		handled = true;
+	}
+
+	if (!handled) {
+		dev_err(priv->dev, "reset_id=%lu was not handled\n", id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int uniphier_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return uniphier_reset_update(rcdev, id, true);
+}
+
+static int uniphier_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
+{
+	return uniphier_reset_update(rcdev, id, false);
+}
+
+static int uniphier_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
+	const struct uniphier_reset_data *p;
+	bool handled = false;
+
+	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
+		unsigned int val;
+		int ret;
+
+		if (p->id != id)
+			continue;
+
+		ret = regmap_read(priv->regmap, p->reg, &val);
+		if (ret)
+			return ret;
+
+		if ((val ^ ~p->assert_val) & p->mask)
+			return 1;
+
+		handled = true;
+	}
+
+	if (!handled) {
+		dev_err(priv->dev, "reset_id=%lu was not found\n", id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct reset_control_ops uniphier_reset_ops = {
+	.assert = uniphier_reset_assert,
+	.deassert = uniphier_reset_deassert,
+	.status = uniphier_reset_status,
+};
+
+static const struct of_device_id uniphier_reset_match[] = {
+	/* System reset */
+	{
+		.compatible = "socionext,uniphier-sld3-reset",
+		.data = uniphier_sld3_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld4-reset",
+		.data = uniphier_sld3_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-reset",
+		.data = uniphier_pro4_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-reset",
+		.data = uniphier_sld3_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-reset",
+		.data = uniphier_pro5_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-reset",
+		.data = uniphier_pxs2_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-reset",
+		.data = uniphier_ld11_sys_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-reset",
+		.data = uniphier_ld20_sys_reset_data,
+	},
+	/* Media I/O reset */
+	{
+		.compatible = "socionext,uniphier-sld3-mio-reset",
+		.data = uniphier_sld3_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld4-mio-reset",
+		.data = uniphier_sld3_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-mio-reset",
+		.data = uniphier_sld3_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-mio-reset",
+		.data = uniphier_sld3_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-mio-reset",
+		.data = uniphier_pro5_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-mio-reset",
+		.data = uniphier_pro5_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-mio-reset",
+		.data = uniphier_sld3_mio_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-mio-reset",
+		.data = uniphier_pro5_mio_reset_data,
+	},
+	/* Peripheral reset */
+	{
+		.compatible = "socionext,uniphier-ld4-peri-reset",
+		.data = uniphier_ld4_peri_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro4-peri-reset",
+		.data = uniphier_pro4_peri_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-sld8-peri-reset",
+		.data = uniphier_ld4_peri_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pro5-peri-reset",
+		.data = uniphier_pro4_peri_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-pxs2-peri-reset",
+		.data = uniphier_pro4_peri_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld11-peri-reset",
+		.data = uniphier_pro4_peri_reset_data,
+	},
+	{
+		.compatible = "socionext,uniphier-ld20-peri-reset",
+		.data = uniphier_pro4_peri_reset_data,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_reset_match);
+
+int uniphier_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct uniphier_reset_priv *priv;
+	const struct uniphier_reset_data *p;
+	struct regmap *regmap;
+	struct device_node *parent;
+	unsigned int nr_resets = 0;
+
+	match = of_match_node(uniphier_reset_match, pdev->dev.of_node);
+	if (!match)
+		return -ENODEV;
+
+	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
+	regmap = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	for (p = match->data; p->id != UNIPHIER_RESET_ID_END; p++)
+		nr_resets = max(nr_resets, p->id + 1);
+
+	priv->rcdev.ops = &uniphier_reset_ops;
+	priv->rcdev.owner = dev->driver->owner;
+	priv->rcdev.of_node = dev->of_node;
+	priv->rcdev.nr_resets = nr_resets;
+	priv->dev = dev;
+	priv->regmap = regmap;
+	priv->data = match->data;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+
+static struct platform_driver uniphier_reset_driver = {
+	.probe = uniphier_reset_probe,
+	.driver = {
+		.name = "uniphier-reset",
+		.of_match_table = uniphier_reset_match,
+	},
+};
+module_platform_driver(uniphier_reset_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Reset Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/uniphier/reset-uniphier-mio.c b/drivers/reset/uniphier/reset-uniphier-mio.c
new file mode 100644
index 0000000..cbcad75
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-mio.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+
+#include "reset-uniphier.h"
+
+#define UNIPHIER_MIO_RESET_SD(index, ch)				\
+	{								\
+		.id = (index),						\
+		.reg = 0x110 + 0x200 * (ch),				\
+		.mask = BIT(26) | BIT(0),				\
+	}
+
+#define UNIPHIER_MIO_RESET_EMMC_HW_RESET(index, ch)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x80 + 0x200 * (ch), BIT(0))
+
+#define UNIPHIER_MIO_RESET_USB2(index, ch)				\
+	UNIPHIER_RESETX_SIMPLE((index), 0x110 + 0x200 * (ch), BIT(24)),	\
+	UNIPHIER_RESETX_SIMPLE((index), 0x114 + 0x200 * (ch), BIT(0))
+
+#define UNIPHIER_MIO_RESET_DMAC(index)					\
+	UNIPHIER_RESETX_SIMPLE((index), 0x110, BIT(17))
+
+const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
+	UNIPHIER_MIO_RESET_SD(0, 0),
+	UNIPHIER_MIO_RESET_SD(1, 1),
+	UNIPHIER_MIO_RESET_SD(2, 2),
+	UNIPHIER_MIO_RESET_DMAC(3),
+	UNIPHIER_MIO_RESET_USB2(4, 0),
+	UNIPHIER_MIO_RESET_USB2(5, 1),
+	UNIPHIER_MIO_RESET_USB2(6, 2),
+	UNIPHIER_MIO_RESET_USB2(7, 3),
+	UNIPHIER_MIO_RESET_EMMC_HW_RESET(9, 1),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro5_mio_reset_data[] = {
+	UNIPHIER_MIO_RESET_SD(0, 0),
+	UNIPHIER_MIO_RESET_SD(1, 1),
+	UNIPHIER_MIO_RESET_EMMC_HW_RESET(9, 1),
+	UNIPHIER_RESET_END,
+};
diff --git a/drivers/reset/uniphier/reset-uniphier-peri.c b/drivers/reset/uniphier/reset-uniphier-peri.c
new file mode 100644
index 0000000..d5567d7
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-peri.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+
+#include "reset-uniphier.h"
+
+#define UNIPHIER_PERI_RESET_UART(index, ch)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x114, BIT(19 + (ch)))
+
+#define UNIPHIER_PERI_RESET_I2C(index, ch)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x114, BIT(5 + (ch)))
+
+#define UNIPHIER_PERI_RESET_FI2C(index, ch)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x114, BIT(24 + (ch)))
+
+const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
+	UNIPHIER_PERI_RESET_UART(0, 0),
+	UNIPHIER_PERI_RESET_UART(1, 1),
+	UNIPHIER_PERI_RESET_UART(2, 2),
+	UNIPHIER_PERI_RESET_UART(3, 3),
+	UNIPHIER_PERI_RESET_I2C(4, 0),
+	UNIPHIER_PERI_RESET_I2C(5, 1),
+	UNIPHIER_PERI_RESET_I2C(6, 2),
+	UNIPHIER_PERI_RESET_I2C(7, 3),
+	UNIPHIER_PERI_RESET_I2C(8, 4),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
+	UNIPHIER_PERI_RESET_UART(0, 0),
+	UNIPHIER_PERI_RESET_UART(1, 1),
+	UNIPHIER_PERI_RESET_UART(2, 2),
+	UNIPHIER_PERI_RESET_UART(3, 3),
+	UNIPHIER_PERI_RESET_FI2C(4, 0),
+	UNIPHIER_PERI_RESET_FI2C(5, 1),
+	UNIPHIER_PERI_RESET_FI2C(6, 2),
+	UNIPHIER_PERI_RESET_FI2C(7, 3),
+	UNIPHIER_PERI_RESET_FI2C(8, 4),
+	UNIPHIER_PERI_RESET_FI2C(9, 5),
+	UNIPHIER_PERI_RESET_FI2C(10, 6),
+	UNIPHIER_RESET_END,
+};
diff --git a/drivers/reset/uniphier/reset-uniphier-sys.c b/drivers/reset/uniphier/reset-uniphier-sys.c
new file mode 100644
index 0000000..bda96c0
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-sys.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/bitops.h>
+
+#include "reset-uniphier.h"
+
+#define UNIPHIER_SLD3_SYS_RESET_STDMAC(index)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x2000, BIT(10))
+
+#define UNIPHIER_LD11_SYS_RESET_STDMAC(index)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x200c, BIT(8))
+
+#define UNIPHIER_PRO4_SYS_RESET_GIO(index)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x2000, BIT(6))
+
+#define UNIPHIER_LD20_SYS_RESET_GIO(index)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x200c, BIT(5))
+
+#define UNIPHIER_PRO4_SYS_RESET_USB3(index, ch)			\
+	UNIPHIER_RESETX_SIMPLE((index), 0x2000 + 0x4 * (ch), BIT(17))
+
+const struct uniphier_reset_data uniphier_sld3_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),		/* Ether, HSC, MIO */
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),		/* HSC, MIO, RLE */
+	UNIPHIER_PRO4_SYS_RESET_GIO(12),		/* Ether, SATA, USB3 */
+	UNIPHIER_PRO4_SYS_RESET_USB3(16, 0),
+	UNIPHIER_PRO4_SYS_RESET_USB3(17, 1),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),		/* HSC */
+	UNIPHIER_PRO4_SYS_RESET_GIO(12),		/* PCIe, USB3 */
+	UNIPHIER_PRO4_SYS_RESET_USB3(16, 0),
+	UNIPHIER_PRO4_SYS_RESET_USB3(17, 1),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),		/* HSC, RLE */
+	UNIPHIER_PRO4_SYS_RESET_USB3(16, 0),
+	UNIPHIER_PRO4_SYS_RESET_USB3(17, 1),
+	UNIPHIER_RESETX_SIMPLE(18, 0x2014, 0x15),	/* USB30PHY */
+	UNIPHIER_RESETX_SIMPLE(19, 0x2014, 0x22),	/* USB31PHY */
+	UNIPHIER_RESETX_SIMPLE(20, 0x2014, BIT(12)),	/* SATA */
+	UNIPHIER_RESET_SIMPLE(21, 0x2014, BIT(8)),	/* SATA-PHY */
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
+	UNIPHIER_LD11_SYS_RESET_STDMAC(8),		/* HSC, MIO */
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
+	UNIPHIER_LD11_SYS_RESET_STDMAC(8),		/* HSC */
+	UNIPHIER_LD20_SYS_RESET_GIO(12),		/* PCIe, USB3 */
+	UNIPHIER_RESETX_SIMPLE(18, 0x200c, 0xf000),	/* USB30PHY */
+	UNIPHIER_RESET_END,
+};
diff --git a/drivers/reset/uniphier/reset-uniphier.h b/drivers/reset/uniphier/reset-uniphier.h
new file mode 100644
index 0000000..8d221f8
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __RESET_UNIPHIER_H__
+#define __RESET_UNIPHIER_H__
+
+struct uniphier_reset_data {
+	unsigned int id;
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int assert_val;
+};
+
+#define UNIPHIER_RESET_ID_END		(unsigned int)(-1)
+
+#define UNIPHIER_RESET_END				\
+	{ .id = UNIPHIER_RESET_ID_END }
+
+#define UNIPHIER_RESETX_SIMPLE(_id, _reg, _mask)	\
+	{						\
+		.id = _id,				\
+		.reg = _reg,				\
+		.mask = _mask,				\
+	}
+
+#define UNIPHIER_RESET_SIMPLE(_id, _reg, _mask)		\
+	{						\
+		.id = _id,				\
+		.reg = _reg,				\
+		.mask = _mask,				\
+		.assert_val = _mask,			\
+	}
+
+extern const struct uniphier_reset_data uniphier_sld3_sys_reset_data[];
+extern const struct uniphier_reset_data uniphier_pro4_sys_reset_data[];
+extern const struct uniphier_reset_data uniphier_pro5_sys_reset_data[];
+extern const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[];
+extern const struct uniphier_reset_data uniphier_ld11_sys_reset_data[];
+extern const struct uniphier_reset_data uniphier_ld20_sys_reset_data[];
+extern const struct uniphier_reset_data uniphier_sld3_mio_reset_data[];
+extern const struct uniphier_reset_data uniphier_pro5_mio_reset_data[];
+extern const struct uniphier_reset_data uniphier_ld4_peri_reset_data[];
+extern const struct uniphier_reset_data uniphier_pro4_peri_reset_data[];
+
+#endif /* __RESET_UNIPHIER_H__ */
-- 
1.9.1
