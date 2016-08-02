From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  2 Aug 2016 13:18:29 +0900
Subject: [PATCH v3] reset: uniphier: add reset controller driver for UniPhier
 SoCs
Message-ID: <1470111510-21247-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the initial commit for UniPhier reset controller driver.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v3:
  - Fix examples in binding document to add specific compatible string
  - Assign each reset signal with a separate ID
  - Simplify reset_control operations
  - Unify to a single file because code is short enough now.

Changes in v2:
  Changes suggested by Philipp Zabel:
  - Unify multiple module_platform_driver() boilerplates into one
  - Unify tiny driver code and decrease the number of files
  - Invert the logic of .deassert_val, changing it into .assert_val
  - Show error code when failed to get regmap
  - Add a binding document
  - Support more reset signals

 .../devicetree/bindings/reset/uniphier-reset.txt   |  93 +++++
 MAINTAINERS                                        |   1 +
 drivers/reset/Kconfig                              |  10 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-uniphier.c                     | 440 +++++++++++++++++++++
 5 files changed, 545 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/uniphier-reset.txt
 create mode 100644 drivers/reset/reset-uniphier.c

diff --git a/Documentation/devicetree/bindings/reset/uniphier-reset.txt b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
new file mode 100644
index 0000000..e6bbfcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/uniphier-reset.txt
@@ -0,0 +1,93 @@
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
+Example:
+
+	sysctrl at 61840000 {
+		compatible = "socionext,uniphier-ld20-sysctrl",
+			     "simple-mfd", "syscon";
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
+Example:
+
+	mioctrl at 59810000 {
+		compatible = "socionext,uniphier-ld20-mioctrl",
+			     "simple-mfd", "syscon";
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
+Example:
+
+	perictrl at 59820000 {
+		compatible = "socionext,uniphier-ld20-perictrl",
+			     "simple-mfd", "syscon";
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
index f87eac3..96d4e99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1825,6 +1825,7 @@ F:	drivers/clk/uniphier/
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/mmc/host/uniphier-sd.c
 F:	drivers/pinctrl/uniphier/
+F:	drivers/reset/reset-uniphier.c
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 4be1b8c..7dfe8d8 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -27,6 +27,16 @@ config TI_SYSCON_RESET
 	  you wish to use the reset framework for such memory-mapped devices,
 	  say Y here. Otherwise, say N.
 
+config RESET_UNIPHIER
+	tristate "Reset controller driver for UniPhier SoCs"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && MFD_SYSCON
+	default ARCH_UNIPHIER
+	help
+	  Support for reset controllers on UniPhier SoCs.
+	  Say Y if you want to control reset signals provided by System Control
+	  block, Media I/O block, Peripheral Block.
+
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 5d65a93..a92cbde 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_MESON) += reset-meson.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
+obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
new file mode 100644
index 0000000..9de071f
--- /dev/null
+++ b/drivers/reset/reset-uniphier.c
@@ -0,0 +1,440 @@
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
+struct uniphier_reset_data {
+	unsigned int id;
+	unsigned int reg;
+	unsigned int bit;
+	unsigned int flags;
+#define UNIPHIER_RESET_ACTIVE_LOW		BIT(0)
+};
+
+#define UNIPHIER_RESET_ID_END		(unsigned int)(-1)
+
+#define UNIPHIER_RESET_END				\
+	{ .id = UNIPHIER_RESET_ID_END }
+
+#define UNIPHIER_RESET(_id, _reg, _bit)			\
+	{						\
+		.id = (_id),				\
+		.reg = (_reg),				\
+		.bit = (_bit),				\
+	}
+
+#define UNIPHIER_RESETX(_id, _reg, _bit)		\
+	{						\
+		.id = (_id),				\
+		.reg = (_reg),				\
+		.bit = (_bit),				\
+		.flags = UNIPHIER_RESET_ACTIVE_LOW,	\
+	}
+
+/* System reset data */
+#define UNIPHIER_SLD3_SYS_RESET_STDMAC(id)		\
+	UNIPHIER_RESETX((id), 0x2000, 10)
+
+#define UNIPHIER_LD11_SYS_RESET_STDMAC(id)		\
+	UNIPHIER_RESETX((id), 0x200c, 8)
+
+#define UNIPHIER_PRO4_SYS_RESET_GIO(id)			\
+	UNIPHIER_RESETX((id), 0x2000, 6)
+
+#define UNIPHIER_LD20_SYS_RESET_GIO(id)			\
+	UNIPHIER_RESETX((id), 0x200c, 5)
+
+#define UNIPHIER_PRO4_SYS_RESET_USB3(id, ch)		\
+	UNIPHIER_RESETX((id), 0x2000 + 0x4 * (ch), 17)
+
+const struct uniphier_reset_data uniphier_sld3_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* Ether, HSC, MIO */
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro4_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, MIO, RLE */
+	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* Ether, SATA, USB3 */
+	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
+	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro5_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC */
+	UNIPHIER_PRO4_SYS_RESET_GIO(12),	/* PCIe, USB3 */
+	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
+	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pxs2_sys_reset_data[] = {
+	UNIPHIER_SLD3_SYS_RESET_STDMAC(8),	/* HSC, RLE */
+	UNIPHIER_PRO4_SYS_RESET_USB3(14, 0),
+	UNIPHIER_PRO4_SYS_RESET_USB3(15, 1),
+	UNIPHIER_RESETX(16, 0x2014, 4),		/* USB30-PHY0 */
+	UNIPHIER_RESETX(17, 0x2014, 0),		/* USB30-PHY1 */
+	UNIPHIER_RESETX(18, 0x2014, 2),		/* USB30-PHY2 */
+	UNIPHIER_RESETX(20, 0x2014, 5),		/* USB31-PHY0 */
+	UNIPHIER_RESETX(21, 0x2014, 1),		/* USB31-PHY1 */
+	UNIPHIER_RESETX(28, 0x2014, 12),	/* SATA */
+	UNIPHIER_RESET(29, 0x2014, 8),		/* SATA-PHY (active high) */
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_ld11_sys_reset_data[] = {
+	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC, MIO */
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
+	UNIPHIER_LD11_SYS_RESET_STDMAC(8),	/* HSC */
+	UNIPHIER_LD20_SYS_RESET_GIO(12),	/* PCIe, USB3 */
+	UNIPHIER_RESETX(16, 0x200c, 12),	/* USB30-PHY0 */
+	UNIPHIER_RESETX(17, 0x200c, 13),	/* USB30-PHY1 */
+	UNIPHIER_RESETX(18, 0x200c, 14),	/* USB30-PHY2 */
+	UNIPHIER_RESETX(19, 0x200c, 15),	/* USB30-PHY3 */
+	UNIPHIER_RESET_END,
+};
+
+/* Media I/O reset data */
+#define UNIPHIER_MIO_RESET_SD(id, ch)			\
+	UNIPHIER_RESETX((id), 0x110 + 0x200 * (ch), 0)
+
+#define UNIPHIER_MIO_RESET_SD_BRIDGE(id, ch)		\
+	UNIPHIER_RESETX((id), 0x110 + 0x200 * (ch), 26)
+
+#define UNIPHIER_MIO_RESET_EMMC_HW_RESET(id, ch)	\
+	UNIPHIER_RESETX((id), 0x80 + 0x200 * (ch), 0)
+
+#define UNIPHIER_MIO_RESET_USB2(id, ch)			\
+	UNIPHIER_RESETX((id), 0x114 + 0x200 * (ch), 0)
+
+#define UNIPHIER_MIO_RESET_USB2_BRIDGE(id, ch)		\
+	UNIPHIER_RESETX((id), 0x110 + 0x200 * (ch), 24)
+
+#define UNIPHIER_MIO_RESET_DMAC(id)			\
+	UNIPHIER_RESETX((id), 0x110, 17)
+
+const struct uniphier_reset_data uniphier_sld3_mio_reset_data[] = {
+	UNIPHIER_MIO_RESET_SD(0, 0),
+	UNIPHIER_MIO_RESET_SD(1, 1),
+	UNIPHIER_MIO_RESET_SD(2, 2),
+	UNIPHIER_MIO_RESET_SD_BRIDGE(3, 0),
+	UNIPHIER_MIO_RESET_SD_BRIDGE(4, 1),
+	UNIPHIER_MIO_RESET_SD_BRIDGE(5, 2),
+	UNIPHIER_MIO_RESET_EMMC_HW_RESET(6, 1),
+	UNIPHIER_MIO_RESET_DMAC(7),
+	UNIPHIER_MIO_RESET_USB2(8, 0),
+	UNIPHIER_MIO_RESET_USB2(9, 1),
+	UNIPHIER_MIO_RESET_USB2(10, 2),
+	UNIPHIER_MIO_RESET_USB2(11, 3),
+	UNIPHIER_MIO_RESET_USB2_BRIDGE(12, 0),
+	UNIPHIER_MIO_RESET_USB2_BRIDGE(13, 1),
+	UNIPHIER_MIO_RESET_USB2_BRIDGE(14, 2),
+	UNIPHIER_MIO_RESET_USB2_BRIDGE(15, 3),
+	UNIPHIER_RESET_END,
+};
+
+const struct uniphier_reset_data uniphier_pro5_mio_reset_data[] = {
+	UNIPHIER_MIO_RESET_SD(0, 0),
+	UNIPHIER_MIO_RESET_SD(1, 1),
+	UNIPHIER_MIO_RESET_EMMC_HW_RESET(6, 1),
+	UNIPHIER_RESET_END,
+};
+
+/* Peripheral reset data */
+#define UNIPHIER_PERI_RESET_UART(id, ch)		\
+	UNIPHIER_RESETX((id), 0x114, 19 + (ch))
+
+#define UNIPHIER_PERI_RESET_I2C(id, ch)			\
+	UNIPHIER_RESETX((id), 0x114, 5 + (ch))
+
+#define UNIPHIER_PERI_RESET_FI2C(id, ch)		\
+	UNIPHIER_RESETX((id), 0x114, 24 + (ch))
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
+
+/* core implementaton */
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
+				 unsigned long id, int assert)
+{
+	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
+	const struct uniphier_reset_data *p;
+
+	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
+		unsigned int mask, val;
+
+		if (p->id != id)
+			continue;
+
+		mask = BIT(p->bit);
+
+		if (assert)
+			val = mask;
+		else
+			val = ~mask;
+
+		if (p->flags & UNIPHIER_RESET_ACTIVE_LOW)
+			val = ~val;
+
+		return regmap_write_bits(priv->regmap, p->reg, mask, val);
+	}
+
+	dev_err(priv->dev, "reset_id=%lu was not handled\n", id);
+	return -EINVAL;
+}
+
+static int uniphier_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return uniphier_reset_update(rcdev, id, 1);
+}
+
+static int uniphier_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
+{
+	return uniphier_reset_update(rcdev, id, 0);
+}
+
+static int uniphier_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	struct uniphier_reset_priv *priv = to_uniphier_reset_priv(rcdev);
+	const struct uniphier_reset_data *p;
+
+	for (p = priv->data; p->id != UNIPHIER_RESET_ID_END; p++) {
+		unsigned int val;
+		int ret, asserted;
+
+		if (p->id != id)
+			continue;
+
+		ret = regmap_read(priv->regmap, p->reg, &val);
+		if (ret)
+			return ret;
+
+		asserted = !!(val & BIT(p->bit));
+
+		if (p->flags & UNIPHIER_RESET_ACTIVE_LOW)
+			asserted = !asserted;
+
+		return asserted;
+	}
+
+	dev_err(priv->dev, "reset_id=%lu was not found\n", id);
+	return -EINVAL;
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
-- 
1.9.1
