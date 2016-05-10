From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:53 +0900
Subject: [RFC PATCH 12/21] reset: uniphier: add core support for UniPhier
 reset driver
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-13-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core support for UniPhier reset drivers.

On UniPhier SoCs, registers for clock, reset, and other system
controlling are mixed in one hardware block.  It is difficult
to have one independent reset node.
So, I chose to use MFD from which clocks and resets (and
power in the future) are populated.

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS                                  |   1 +
 drivers/reset/Kconfig                        |   1 +
 drivers/reset/Makefile                       |   1 +
 drivers/reset/uniphier/Kconfig               |   9 ++
 drivers/reset/uniphier/Makefile              |   1 +
 drivers/reset/uniphier/reset-uniphier-core.c | 151 +++++++++++++++++++++++++++
 drivers/reset/uniphier/reset-uniphier.h      |  33 ++++++
 7 files changed, 197 insertions(+)
 create mode 100644 drivers/reset/uniphier/Kconfig
 create mode 100644 drivers/reset/uniphier/Makefile
 create mode 100644 drivers/reset/uniphier/reset-uniphier-core.c
 create mode 100644 drivers/reset/uniphier/reset-uniphier.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 38c6bb5..95a4030 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,6 +1732,7 @@ F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/mfd/uniphier-mfd.c
 F:	drivers/mmc/host/uniphier-sd.c
 F:	drivers/pinctrl/uniphier/
+F:	drivers/reset/uniphier/
 F:	drivers/tty/serial/8250/8250_uniphier.c
 N:	uniphier
 
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 6a0b24b..f7e5381 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -16,5 +16,6 @@ if RESET_CONTROLLER
 
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
+source "drivers/reset/uniphier/Kconfig"
 
 endif
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index a1fc8ed..e2bb8c6 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -6,5 +6,6 @@ obj-$(CONFIG_MACH_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_ARCH_STI) += sti/
 obj-$(CONFIG_ARCH_HISI) += hisilicon/
+obj-$(CONFIG_RESET_UNIPHIER) += uniphier/
 obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
 obj-$(CONFIG_ATH79) += reset-ath79.o
diff --git a/drivers/reset/uniphier/Kconfig b/drivers/reset/uniphier/Kconfig
new file mode 100644
index 0000000..e82f7a7
--- /dev/null
+++ b/drivers/reset/uniphier/Kconfig
@@ -0,0 +1,9 @@
+menuconfig RESET_UNIPHIER
+	bool "Reset drivers for UniPhier SoCs"
+	depends on (ARCH_UNIPHIER && MFD_UNIPHIER) || COMPILE_TEST
+	depends on OF && MFD_CORE && MFD_SYSCON
+	default ARCH_UNIPHIER && MFD_UNIPHIER
+
+if RESET_UNIPHIER
+
+endif
diff --git a/drivers/reset/uniphier/Makefile b/drivers/reset/uniphier/Makefile
new file mode 100644
index 0000000..ba660bc
--- /dev/null
+++ b/drivers/reset/uniphier/Makefile
@@ -0,0 +1 @@
+obj-y					+= reset-uniphier-core.o
diff --git a/drivers/reset/uniphier/reset-uniphier-core.c b/drivers/reset/uniphier/reset-uniphier-core.c
new file mode 100644
index 0000000..95217d5
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-core.c
@@ -0,0 +1,151 @@
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
+	unsigned int nr_ids;
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
+		val = p->deassert_val;
+		if (assert)
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
+		if ((val & p->mask) != p->deassert_val)
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
+int uniphier_reset_probe(struct platform_device *pdev,
+			 const struct uniphier_reset_data *data)
+{
+	struct device *dev = &pdev->dev;
+	struct uniphier_reset_priv *priv;
+	const struct uniphier_reset_data *p;
+	struct regmap *regmap;
+	unsigned int nr_resets = 0;
+
+	/* parent should be MFD and syscon node */
+	regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	for (p = data; p->id != UNIPHIER_RESET_ID_END; p++)
+		nr_resets = max(nr_resets, p->id + 1);
+
+	priv->rcdev.ops = &uniphier_reset_ops;
+	priv->rcdev.owner = dev->driver->owner;
+	priv->rcdev.of_node = dev->parent->of_node;
+	priv->rcdev.nr_resets = nr_resets;
+	priv->dev = dev;
+	priv->regmap = regmap;
+	priv->data = data;
+
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
+}
+EXPORT_SYMBOL_GPL(uniphier_reset_probe);
diff --git a/drivers/reset/uniphier/reset-uniphier.h b/drivers/reset/uniphier/reset-uniphier.h
new file mode 100644
index 0000000..1b26efd
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier.h
@@ -0,0 +1,33 @@
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
+struct platform_device;
+
+struct uniphier_reset_data {
+	unsigned int id;
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int deassert_val;
+};
+
+#define UNIPHIER_RESET_ID_END		(unsigned int)(-1)
+
+int uniphier_reset_probe(struct platform_device *pdev,
+			 const struct uniphier_reset_data *data);
+
+#endif /* __RESET_UNIPHIER_H__ */
-- 
1.9.1
