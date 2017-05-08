From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  8 May 2017 22:07:40 +0200
Subject: [PATCH 2/2 v2] reset: Add a Gemini reset controller
Message-ID: <20170508200740.26194-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortina Systems Gemini reset controller is a simple
32bit register with self-deasserting reset lines. It is
accessed using regmap over syscon.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add an explicit GPL license statement.
- Move the reset controller to be identical to the sycon
  node, no need to a separate child node for this.
- Drop unneeded struct device *dev pointer from state
  container.
- Print error code on missing regmap.
- Use #define from the <dt-bindings/*> to indicate that we
  always set the CPU1 reset line to 1 when writing the
  resets.
---
 drivers/reset/Kconfig        |   7 +++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-gemini.c | 110 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 drivers/reset/reset-gemini.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index f4cdfe94b9ec..a82e1a78de25 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -27,6 +27,13 @@ config RESET_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
+config RESET_GEMINI
+	bool "Gemini Reset Driver" if COMPILE_TEST
+	default ARCH_GEMINI
+	select MFD_SYSCON
+	help
+	  This enables the reset controller driver for Cortina Systems Gemini.
+
 config RESET_LPC18XX
 	bool "LPC18xx/43xx Reset Driver" if COMPILE_TEST
 	default ARCH_LPC18XX
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 2cd3f6c45165..99e90ad18545 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+obj-$(CONFIG_RESET_GEMINI) += reset-gemini.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-gemini.c b/drivers/reset/reset-gemini.c
new file mode 100644
index 000000000000..ebe59eb25b20
--- /dev/null
+++ b/drivers/reset/reset-gemini.c
@@ -0,0 +1,110 @@
+/*
+ * Cortina Gemini Reset controller driver
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <dt-bindings/reset/cortina,gemini-reset.h>
+
+/**
+ * struct gemini_reset - gemini reset controller
+ * @map: regmap to access the containing system controller
+ * @rcdev: reset controller device
+ */
+struct gemini_reset {
+	struct regmap *map;
+	struct reset_controller_dev rcdev;
+};
+
+#define GEMINI_GLOBAL_SOFT_RESET 0x0c
+
+#define to_gemini_reset(p) \
+	container_of((p), struct gemini_reset, rcdev)
+
+/*
+ * This is a self-deasserting reset controller.
+ */
+static int gemini_reset(struct reset_controller_dev *rcdev,
+			unsigned long id)
+{
+	struct gemini_reset *gr = to_gemini_reset(rcdev);
+
+	/* Manual says to always set BIT 30 (CPU1) to 1 */
+	return regmap_write(gr->map,
+			    GEMINI_GLOBAL_SOFT_RESET,
+			    BIT(GEMINI_RESET_CPU1) | BIT(id));
+}
+
+static int gemini_reset_status(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct gemini_reset *gr = to_gemini_reset(rcdev);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(gr->map, GEMINI_GLOBAL_SOFT_RESET, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(id));
+}
+
+static const struct reset_control_ops gemini_reset_ops = {
+	.reset = gemini_reset,
+	.status = gemini_reset_status,
+};
+
+static int gemini_reset_probe(struct platform_device *pdev)
+{
+	struct gemini_reset *gr;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	gr = devm_kzalloc(dev, sizeof(*gr), GFP_KERNEL);
+	if (!gr)
+		return -ENOMEM;
+
+	gr->map = syscon_node_to_regmap(np);
+	if (IS_ERR(gr->map)) {
+		ret = PTR_ERR(gr->map);
+		dev_err(dev, "unable to get regmap (%d)", ret);
+		return ret;
+	}
+	gr->rcdev.owner = THIS_MODULE;
+	gr->rcdev.nr_resets = 32;
+	gr->rcdev.ops = &gemini_reset_ops;
+	gr->rcdev.of_node = pdev->dev.of_node;
+
+	ret = devm_reset_controller_register(&pdev->dev, &gr->rcdev);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "registered Gemini reset controller\n");
+	return 0;
+}
+
+static const struct of_device_id gemini_reset_dt_ids[] = {
+	{ .compatible = "cortina,gemini-reset", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver gemini_reset_driver = {
+	.probe	= gemini_reset_probe,
+	.driver = {
+		.name		= "gemini-reset",
+		.of_match_table	= gemini_reset_dt_ids,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver(gemini_reset_driver);
-- 
2.9.3
