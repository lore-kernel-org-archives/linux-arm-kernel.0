From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:59 +0900
Subject: [RFC PATCH 18/21] reset: uniphier: add reset driver for UniPhier
 PH1-LD11 SoC
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-19-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/uniphier/Kconfig               |  4 +++
 drivers/reset/uniphier/Makefile              |  1 +
 drivers/reset/uniphier/reset-uniphier-ld11.c | 46 ++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 drivers/reset/uniphier/reset-uniphier-ld11.c

diff --git a/drivers/reset/uniphier/Kconfig b/drivers/reset/uniphier/Kconfig
index 022aef4..d9a2123 100644
--- a/drivers/reset/uniphier/Kconfig
+++ b/drivers/reset/uniphier/Kconfig
@@ -26,4 +26,8 @@ config RESET_UNIPHIER_PXS2
 	tristate "Reset driver for UniPhier ProXstream2/PH1-LD6b SoC"
 	default ARM
 
+config RESET_UNIPHIER_LD11
+	tristate "Reset driver for UniPhier PH1-LD11 SoC"
+	default ARM
+
 endif
diff --git a/drivers/reset/uniphier/Makefile b/drivers/reset/uniphier/Makefile
index 50847db..f25f648 100644
--- a/drivers/reset/uniphier/Makefile
+++ b/drivers/reset/uniphier/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_RESET_UNIPHIER_PRO4)	+= reset-uniphier-pro4.o
 obj-$(CONFIG_RESET_UNIPHIER_SLD8)	+= reset-uniphier-sld8.o
 obj-$(CONFIG_RESET_UNIPHIER_PRO5)	+= reset-uniphier-pro5.o
 obj-$(CONFIG_RESET_UNIPHIER_PXS2)	+= reset-uniphier-pxs2.o
+obj-$(CONFIG_RESET_UNIPHIER_LD11)	+= reset-uniphier-ld11.o
diff --git a/drivers/reset/uniphier/reset-uniphier-ld11.c b/drivers/reset/uniphier/reset-uniphier-ld11.c
new file mode 100644
index 0000000..75cb379
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-ld11.c
@@ -0,0 +1,46 @@
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
+static const struct uniphier_reset_data uniphier_ld11_reset_data[] = {
+	{
+		.id = 7,
+		.reg = 0x200c,
+		.mask = BIT(8),
+		.deassert_val = BIT(8),
+	},
+	{ .id = UNIPHIER_RESET_ID_END }
+};
+
+static int uniphier_ld11_reset_probe(struct platform_device *pdev)
+{
+	return uniphier_reset_probe(pdev, uniphier_ld11_reset_data);
+}
+
+static struct platform_driver uniphier_ld11_reset_driver = {
+	.probe = uniphier_ld11_reset_probe,
+	.driver = {
+		.name = "uniphier-ld11-reset",
+	},
+};
+module_platform_driver(uniphier_ld11_reset_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PH1-LD11 Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
