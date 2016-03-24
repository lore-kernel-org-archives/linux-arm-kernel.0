From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:04 +0100
Subject: [PATCH v3 07/18] reset: Add PLX Technology Reset Controller driver
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-8-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add System reset controller driver for PLX Technology OXNAS SoC Family.

CC: Ma Haijun <mahaijuns@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/Kconfig       |   3 +
 drivers/reset/Makefile      |   1 +
 drivers/reset/reset-oxnas.c | 136 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 drivers/reset/reset-oxnas.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index df37212..0b2733d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -12,5 +12,8 @@ menuconfig RESET_CONTROLLER
 
 	  If unsure, say no.
 
+config RESET_OXNAS
+	bool
+
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a1fc8ed..f173fc3 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
+obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
new file mode 100644
index 0000000..c60fb2d
--- /dev/null
+++ b/drivers/reset/reset-oxnas.c
@@ -0,0 +1,136 @@
+/*
+ * drivers/reset/reset-oxnas.c
+ *
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ * Copyright (C) 2014 Ma Haijun <mahaijuns@gmail.com>
+ * Copyright (C) 2009 Oxford Semiconductor Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+/* Regmap offsets */
+#define RST_SET_REGOFFSET	0x34
+#define RST_CLR_REGOFFSET	0x38
+
+struct oxnas_reset {
+	struct regmap *regmap;
+	struct reset_controller_dev rcdev;
+};
+
+static int oxnas_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct oxnas_reset *data =
+		container_of(rcdev, struct oxnas_reset, rcdev);
+
+	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
+	msleep(50);
+	regmap_write(data->regmap, RST_CLR_REGOFFSET, BIT(id));
+
+	return 0;
+}
+
+static int oxnas_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct oxnas_reset *data =
+		container_of(rcdev, struct oxnas_reset, rcdev);
+
+	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
+
+	return 0;
+}
+
+static int oxnas_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct oxnas_reset *data =
+		container_of(rcdev, struct oxnas_reset, rcdev);
+
+	regmap_write(data->regmap, RST_CLR_REGOFFSET, BIT(id));
+
+	return 0;
+}
+
+static const struct reset_control_ops oxnas_reset_ops = {
+	.reset		= oxnas_reset_reset,
+	.assert		= oxnas_reset_assert,
+	.deassert	= oxnas_reset_deassert,
+};
+
+static const struct of_device_id oxnas_reset_dt_ids[] = {
+	 { .compatible = "oxsemi,ox810se-reset", },
+	 { /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, oxnas_reset_dt_ids);
+
+static int oxnas_reset_probe(struct platform_device *pdev)
+{
+	struct oxnas_reset *data;
+	struct device *parent;
+
+	parent = pdev->dev.parent;
+	if (!parent) {
+		dev_err(&pdev->dev, "no parent\n");
+		return -ENODEV;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = syscon_node_to_regmap(parent->of_node);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&pdev->dev, "failed to get parent regmap\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	platform_set_drvdata(pdev, data);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = 32;
+	data->rcdev.ops = &oxnas_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return reset_controller_register(&data->rcdev);
+}
+
+static int oxnas_reset_remove(struct platform_device *pdev)
+{
+	struct oxnas_reset *data = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&data->rcdev);
+
+	return 0;
+}
+
+static struct platform_driver oxnas_reset_driver = {
+	.probe	= oxnas_reset_probe,
+	.remove	= oxnas_reset_remove,
+	.driver = {
+		.name		= "oxnas-reset",
+		.of_match_table	= oxnas_reset_dt_ids,
+	},
+};
+
+module_platform_driver(oxnas_reset_driver);
-- 
1.9.1
