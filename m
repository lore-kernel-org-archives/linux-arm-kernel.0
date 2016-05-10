From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:52 +0900
Subject: [RFC PATCH 11/21] clk: uniphier: add clock driver for Peripheral
 block on UniPhier SoCs
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-12-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/Kconfig             |   4 +
 drivers/clk/uniphier/Makefile            |   1 +
 drivers/clk/uniphier/clk-uniphier-peri.c | 133 +++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 drivers/clk/uniphier/clk-uniphier-peri.c

diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
index 895c4a0..08edaf8 100644
--- a/drivers/clk/uniphier/Kconfig
+++ b/drivers/clk/uniphier/Kconfig
@@ -38,4 +38,8 @@ config CLK_UNIPHIER_MIO
 	tristate "Clock driver for UniPhier Media I/O block"
 	default y
 
+config CLK_UNIPHIER_PERI
+	tristate "Clock driver for UniPhier Peripheral block"
+	default y
+
 endif
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
index ae71f04..a69d6fe 100644
--- a/drivers/clk/uniphier/Makefile
+++ b/drivers/clk/uniphier/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_UNIPHIER_LD11)	+= clk-uniphier-ld11.o
 obj-$(CONFIG_CLK_UNIPHIER_LD20)	+= clk-uniphier-ld20.o
 
 obj-$(CONFIG_CLK_UNIPHIER_MIO)	+= clk-uniphier-mio.o
+obj-$(CONFIG_CLK_UNIPHIER_PERI)	+= clk-uniphier-peri.o
diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
new file mode 100644
index 0000000..e5510f5
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -0,0 +1,133 @@
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-uniphier.h"
+
+#define UNIPHIER_PERI_CLK_UART(ch, index)			\
+	{							\
+		.name = "uart" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "uart",			\
+			.reg = 0x24,				\
+			.mask = BIT(19 + ch),			\
+			.enable_val = BIT(19 + ch),		\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_I2C_COMMON				\
+	{							\
+		.name = "i2c-common",				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = -1,				\
+		.data.gate = {					\
+			.parent_name = "i2c",			\
+			.reg = 0x20,				\
+			.mask = BIT(1),				\
+			.enable_val = BIT(1),			\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_I2C(ch, index)			\
+	{							\
+		.name = "i2c" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "i2c-common",		\
+			.reg = 0x24,				\
+			.mask = BIT(5 + ch),			\
+			.enable_val = BIT(5 + ch),		\
+		},						\
+	}
+
+#define UNIPHIER_PERI_CLK_FI2C(ch, index)			\
+	{							\
+		.name = "fi2c" #ch,				\
+		.type = UNIPHIER_CLK_TYPE_GATE,			\
+		.output_index = (index),			\
+		.data.gate = {					\
+			.parent_name = "fi2c",			\
+			.reg = 0x24,				\
+			.mask = BIT(24 + ch),			\
+			.enable_val = BIT(24 + ch),		\
+		},						\
+	}
+
+static const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_I2C_COMMON,
+	UNIPHIER_PERI_CLK_I2C(0, 4),
+	UNIPHIER_PERI_CLK_I2C(1, 5),
+	UNIPHIER_PERI_CLK_I2C(2, 6),
+	UNIPHIER_PERI_CLK_I2C(3, 7),
+	UNIPHIER_PERI_CLK_I2C(4, 8),
+	{ /* sentinel */ }
+};
+
+static int uniphier_ld4_peri_clk_probe(struct platform_device *pdev)
+{
+	return uniphier_clk_probe(pdev, uniphier_ld4_peri_clk_data);
+}
+
+static struct platform_driver uniphier_ld4_peri_clk_driver = {
+	.probe = uniphier_ld4_peri_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-ld4-peri-clk",
+	},
+};
+module_platform_driver(uniphier_ld4_peri_clk_driver);
+
+static const struct uniphier_clk_data uniphier_pro4_peri_clk_data[] = {
+	UNIPHIER_PERI_CLK_UART(0, 0),
+	UNIPHIER_PERI_CLK_UART(1, 1),
+	UNIPHIER_PERI_CLK_UART(2, 2),
+	UNIPHIER_PERI_CLK_UART(3, 3),
+	UNIPHIER_PERI_CLK_FI2C(0, 4),
+	UNIPHIER_PERI_CLK_FI2C(1, 5),
+	UNIPHIER_PERI_CLK_FI2C(2, 6),
+	UNIPHIER_PERI_CLK_FI2C(3, 7),
+	UNIPHIER_PERI_CLK_FI2C(4, 8),
+	UNIPHIER_PERI_CLK_FI2C(5, 9),
+	UNIPHIER_PERI_CLK_FI2C(6, 10),
+	{ /* sentinel */ }
+};
+
+static int uniphier_pro4_peri_clk_probe(struct platform_device *pdev)
+{
+	return uniphier_clk_probe(pdev, uniphier_pro4_peri_clk_data);
+}
+
+static struct platform_driver uniphier_pro4_peri_clk_driver = {
+	.probe = uniphier_pro4_peri_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-pro4-peri-clk",
+	},
+};
+module_platform_driver(uniphier_pro4_peri_clk_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Peripheral Clock Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
