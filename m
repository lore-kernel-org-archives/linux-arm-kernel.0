From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:51:02 +0900
Subject: [RFC PATCH 21/21] reset: uniphier: add reset driver for Peripheral
 block on UniPhier SoCs
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-22-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/uniphier/Kconfig               |   4 ++
 drivers/reset/uniphier/Makefile              |   1 +
 drivers/reset/uniphier/reset-uniphier-peri.c | 101 +++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/reset/uniphier/reset-uniphier-peri.c

diff --git a/drivers/reset/uniphier/Kconfig b/drivers/reset/uniphier/Kconfig
index a582938..d3e629e 100644
--- a/drivers/reset/uniphier/Kconfig
+++ b/drivers/reset/uniphier/Kconfig
@@ -38,4 +38,8 @@ config RESET_UNIPHIER_MIO
 	tristate "Reset driver for UniPhier Media I/O block"
 	default y
 
+config RESET_UNIPHIER_PERI
+	tristate "Reset driver for UniPhier Peripheral block"
+	default y
+
 endif
diff --git a/drivers/reset/uniphier/Makefile b/drivers/reset/uniphier/Makefile
index e83bd14..65e9d2d 100644
--- a/drivers/reset/uniphier/Makefile
+++ b/drivers/reset/uniphier/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RESET_UNIPHIER_LD11)	+= reset-uniphier-ld11.o
 obj-$(CONFIG_RESET_UNIPHIER_LD20)	+= reset-uniphier-ld20.o
 
 obj-$(CONFIG_RESET_UNIPHIER_MIO)	+= reset-uniphier-mio.o
+obj-$(CONFIG_RESET_UNIPHIER_PERI)	+= reset-uniphier-peri.o
diff --git a/drivers/reset/uniphier/reset-uniphier-peri.c b/drivers/reset/uniphier/reset-uniphier-peri.c
new file mode 100644
index 0000000..1ec1c16
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-peri.c
@@ -0,0 +1,101 @@
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
+#include <linux/platform_device.h>
+
+#include "reset-uniphier.h"
+
+#define UNIPHIER_PERI_RESET_UART(ch, index)		\
+	{						\
+		.id = (index),				\
+		.reg = 0x114,				\
+		.mask = BIT(19 + ch),			\
+		.deassert_val = BIT(19 + ch),		\
+	}
+
+#define UNIPHIER_PERI_RESET_I2C(ch, index)		\
+	{						\
+		.id = (index),				\
+		.reg = 0x114,				\
+		.mask = BIT(5 + ch),			\
+		.deassert_val = BIT(5 + ch),		\
+	}
+
+#define UNIPHIER_PERI_RESET_FI2C(ch, index)		\
+	{						\
+		.id = (index),				\
+		.reg = 0x114,				\
+		.mask = BIT(24 + ch),			\
+		.deassert_val = BIT(24 + ch),		\
+	}
+
+static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
+	UNIPHIER_PERI_RESET_UART(0, 0),
+	UNIPHIER_PERI_RESET_UART(1, 1),
+	UNIPHIER_PERI_RESET_UART(2, 2),
+	UNIPHIER_PERI_RESET_UART(3, 3),
+	UNIPHIER_PERI_RESET_I2C(0, 4),
+	UNIPHIER_PERI_RESET_I2C(1, 5),
+	UNIPHIER_PERI_RESET_I2C(2, 6),
+	UNIPHIER_PERI_RESET_I2C(3, 7),
+	UNIPHIER_PERI_RESET_I2C(4, 8),
+	{ .id = UNIPHIER_RESET_ID_END }
+};
+
+static int uniphier_ld4_peri_reset_probe(struct platform_device *pdev)
+{
+	return uniphier_reset_probe(pdev, uniphier_ld4_peri_reset_data);
+}
+
+static struct platform_driver uniphier_ld4_peri_reset_driver = {
+	.probe = uniphier_ld4_peri_reset_probe,
+	.driver = {
+		.name = "uniphier-ld4-peri-reset",
+	},
+};
+module_platform_driver(uniphier_ld4_peri_reset_driver);
+
+static const struct uniphier_reset_data uniphier_pro5_peri_reset_data[] = {
+	UNIPHIER_PERI_RESET_UART(0, 0),
+	UNIPHIER_PERI_RESET_UART(1, 1),
+	UNIPHIER_PERI_RESET_UART(2, 2),
+	UNIPHIER_PERI_RESET_UART(3, 3),
+	UNIPHIER_PERI_RESET_FI2C(0, 4),
+	UNIPHIER_PERI_RESET_FI2C(1, 5),
+	UNIPHIER_PERI_RESET_FI2C(2, 6),
+	UNIPHIER_PERI_RESET_FI2C(3, 7),
+	UNIPHIER_PERI_RESET_FI2C(4, 8),
+	UNIPHIER_PERI_RESET_FI2C(5, 9),
+	UNIPHIER_PERI_RESET_FI2C(6, 10),
+	{ .id = UNIPHIER_RESET_ID_END }
+};
+
+static int uniphier_pro5_peri_reset_probe(struct platform_device *pdev)
+{
+	return uniphier_reset_probe(pdev, uniphier_pro5_peri_reset_data);
+}
+
+static struct platform_driver uniphier_pro5_peri_reset_driver = {
+	.probe = uniphier_pro5_peri_reset_probe,
+	.driver = {
+		.name = "uniphier-pro5-peri-reset",
+	},
+};
+module_platform_driver(uniphier_pro5_peri_reset_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Peripheral Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
