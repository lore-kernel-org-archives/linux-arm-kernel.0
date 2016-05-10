From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:51:01 +0900
Subject: [RFC PATCH 20/21] reset: uniphier: add reset driver for Media I/O
 block on UniPhier SoCs
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-21-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/uniphier/Kconfig              |   4 ++
 drivers/reset/uniphier/Makefile             |   2 +
 drivers/reset/uniphier/reset-uniphier-mio.c | 106 ++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/reset/uniphier/reset-uniphier-mio.c

diff --git a/drivers/reset/uniphier/Kconfig b/drivers/reset/uniphier/Kconfig
index 8509e71..a582938 100644
--- a/drivers/reset/uniphier/Kconfig
+++ b/drivers/reset/uniphier/Kconfig
@@ -34,4 +34,8 @@ config RESET_UNIPHIER_LD20
 	tristate "Reset driver for UniPhier PH1-LD20 SoC"
 	default ARM64
 
+config RESET_UNIPHIER_MIO
+	tristate "Reset driver for UniPhier Media I/O block"
+	default y
+
 endif
diff --git a/drivers/reset/uniphier/Makefile b/drivers/reset/uniphier/Makefile
index a33cb0a..e83bd14 100644
--- a/drivers/reset/uniphier/Makefile
+++ b/drivers/reset/uniphier/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_RESET_UNIPHIER_PRO5)	+= reset-uniphier-pro5.o
 obj-$(CONFIG_RESET_UNIPHIER_PXS2)	+= reset-uniphier-pxs2.o
 obj-$(CONFIG_RESET_UNIPHIER_LD11)	+= reset-uniphier-ld11.o
 obj-$(CONFIG_RESET_UNIPHIER_LD20)	+= reset-uniphier-ld20.o
+
+obj-$(CONFIG_RESET_UNIPHIER_MIO)	+= reset-uniphier-mio.o
diff --git a/drivers/reset/uniphier/reset-uniphier-mio.c b/drivers/reset/uniphier/reset-uniphier-mio.c
new file mode 100644
index 0000000..f68a8cf
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-mio.c
@@ -0,0 +1,106 @@
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
+#define UNIPHIER_MIO_RESET_SD(ch, index)		\
+	{						\
+		.id = (index),				\
+		.reg = 0x110 + 0x200 * (ch),		\
+		.mask = BIT(26) | BIT(0),		\
+		.deassert_val = BIT(26) | BIT(0),	\
+	}
+
+#define UNIPHIER_MIO_RESET_EMMC_HW_RESET(ch, index)	\
+	{						\
+		.id = (index),				\
+		.reg = 0x80 + 0x200 * (ch),		\
+		.mask = BIT(0),				\
+		.deassert_val = BIT(0),			\
+	}
+
+#define UNIPHIER_MIO_RESET_EHCI(ch, index)		\
+	{						\
+		.id = (index),				\
+		.reg = 0x110 + 0x200 * (ch),		\
+		.mask = BIT(24),			\
+		.deassert_val = BIT(24),		\
+	},						\
+	{						\
+		.id = (index),				\
+		.reg = 0x114 + 0x200 * (ch),		\
+		.mask = BIT(0),				\
+		.deassert_val = BIT(0),			\
+	}
+
+#define UNIPHIER_MIO_RESET_DMAC(index)			\
+	{						\
+		.id = (index),				\
+		.reg = 0x110,				\
+		.mask = BIT(17),			\
+		.deassert_val = BIT(17),		\
+	}
+
+static const struct uniphier_reset_data uniphier_ld4_mio_reset_data[] = {
+	UNIPHIER_MIO_RESET_SD(0, 0),
+	UNIPHIER_MIO_RESET_SD(1, 1),
+	UNIPHIER_MIO_RESET_SD(2, 2),
+	UNIPHIER_MIO_RESET_DMAC(3),
+	UNIPHIER_MIO_RESET_EHCI(0, 4),
+	UNIPHIER_MIO_RESET_EHCI(1, 5),
+	UNIPHIER_MIO_RESET_EHCI(2, 6),
+	UNIPHIER_MIO_RESET_EMMC_HW_RESET(1, 9),
+	{ .id = UNIPHIER_RESET_ID_END }
+};
+
+static int uniphier_ld4_mio_reset_probe(struct platform_device *pdev)
+{
+	return uniphier_reset_probe(pdev, uniphier_ld4_mio_reset_data);
+}
+
+static struct platform_driver uniphier_ld4_mio_reset_driver = {
+	.probe = uniphier_ld4_mio_reset_probe,
+	.driver = {
+		.name = "uniphier-ld4-mio-reset",
+	},
+};
+module_platform_driver(uniphier_ld4_mio_reset_driver);
+
+static const struct uniphier_reset_data uniphier_pro5_mio_reset_data[] = {
+	UNIPHIER_MIO_RESET_SD(0, 0),
+	UNIPHIER_MIO_RESET_SD(1, 1),
+	UNIPHIER_MIO_RESET_EMMC_HW_RESET(1, 9),
+	{ .id = UNIPHIER_RESET_ID_END }
+};
+
+static int uniphier_pro5_mio_reset_probe(struct platform_device *pdev)
+{
+	return uniphier_reset_probe(pdev, uniphier_pro5_mio_reset_data);
+}
+
+static struct platform_driver uniphier_pro5_mio_reset_driver = {
+	.probe = uniphier_pro5_mio_reset_probe,
+	.driver = {
+		.name = "uniphier-mio-reset",
+	},
+};
+module_platform_driver(uniphier_pro5_mio_reset_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Media I/O Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
