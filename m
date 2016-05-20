From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 10:27:53 +0200
Subject: [PATCH 1/3] reset: Add support for the Amlogic Meson GXBB Reset
 Controller
In-Reply-To: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the platform driver for the Amlogic Meson GXBB Reset
Controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/Kconfig            |   6 ++
 drivers/reset/Makefile           |   1 +
 drivers/reset/reset-meson-gxbb.c | 129 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/reset/reset-meson-gxbb.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index df37212..4ac5c4d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -12,5 +12,11 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+config MESON_GXBB_RESET
+	tristate "Amlogic Meson GXBB Reset Driver"
+	depends on (ARCH_MESON && RESET_CONTROLLER)
+	help
+	  Build the Amlogic Meson GxBB reset driver.
+
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a1fc8ed..5ff83a1 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARCH_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_BERLIN) += reset-berlin.o
 obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_MESON_GXBB_RESET) += reset-meson-gxbb.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
diff --git a/drivers/reset/reset-meson-gxbb.c b/drivers/reset/reset-meson-gxbb.c
new file mode 100644
index 0000000..e96691b
--- /dev/null
+++ b/drivers/reset/reset-meson-gxbb.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright (c) 2016 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define REG_COUNT	8
+#define BITS_PER_REG	32
+
+struct meson_gxbb_reset {
+	void __iomem *reg_base;
+	struct reset_controller_dev rcdev;
+};
+
+static int meson_gxbb_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_gxbb_reset *data =
+		container_of(rcdev, struct meson_gxbb_reset, rcdev);
+	unsigned int bank = id / BITS_PER_REG;
+	unsigned int offset = id % BITS_PER_REG;
+	void __iomem *reg_addr = data->reg_base + (bank << 2);
+
+	if (bank >= REG_COUNT)
+		return -EINVAL;
+
+	writel(BIT(offset), reg_addr);
+
+	return 0;
+}
+
+static const struct reset_control_ops meson_gxbb_reset_ops = {
+	.reset		= meson_gxbb_reset_reset,
+};
+
+static const struct of_device_id meson_gxbb_reset_dt_ids[] = {
+	 { .compatible = "amlogic,meson-gxbb-reset", },
+	 { /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, meson_gxbb_reset_dt_ids);
+
+static int meson_gxbb_reset_probe(struct platform_device *pdev)
+{
+	struct meson_gxbb_reset *data;
+	struct resource *res;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->reg_base))
+		return PTR_ERR(data->reg_base);
+
+	platform_set_drvdata(pdev, data);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = REG_COUNT * BITS_PER_REG;
+	data->rcdev.ops = &meson_gxbb_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return reset_controller_register(&data->rcdev);
+}
+
+static int meson_gxbb_reset_remove(struct platform_device *pdev)
+{
+	struct meson_gxbb_reset *data = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&data->rcdev);
+
+	return 0;
+}
+
+static struct platform_driver meson_gxbb_reset_driver = {
+	.probe	= meson_gxbb_reset_probe,
+	.remove	= meson_gxbb_reset_remove,
+	.driver = {
+		.name		= "meson_gxbb_reset",
+		.of_match_table	= meson_gxbb_reset_dt_ids,
+	},
+};
+
+module_platform_driver(meson_gxbb_reset_driver);
-- 
2.7.0
