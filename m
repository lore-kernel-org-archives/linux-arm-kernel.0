From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:54 +0900
Subject: [RFC PATCH 13/21] reset: uniphier: add reset driver for UniPhier
 PH1-LD4 SoC
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-14-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/uniphier/Kconfig              |  4 +++
 drivers/reset/uniphier/Makefile             |  2 ++
 drivers/reset/uniphier/reset-uniphier-ld4.c | 46 +++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/reset/uniphier/reset-uniphier-ld4.c

diff --git a/drivers/reset/uniphier/Kconfig b/drivers/reset/uniphier/Kconfig
index e82f7a7..875afd9 100644
--- a/drivers/reset/uniphier/Kconfig
+++ b/drivers/reset/uniphier/Kconfig
@@ -6,4 +6,8 @@ menuconfig RESET_UNIPHIER
 
 if RESET_UNIPHIER
 
+config RESET_UNIPHIER_LD4
+	tristate "Reset driver for UniPhier PH1-LD4 SoC"
+	default ARM
+
 endif
diff --git a/drivers/reset/uniphier/Makefile b/drivers/reset/uniphier/Makefile
index ba660bc..c99a420 100644
--- a/drivers/reset/uniphier/Makefile
+++ b/drivers/reset/uniphier/Makefile
@@ -1 +1,3 @@
 obj-y					+= reset-uniphier-core.o
+
+obj-$(CONFIG_RESET_UNIPHIER_LD4)	+= reset-uniphier-ld4.o
diff --git a/drivers/reset/uniphier/reset-uniphier-ld4.c b/drivers/reset/uniphier/reset-uniphier-ld4.c
new file mode 100644
index 0000000..be6e06c
--- /dev/null
+++ b/drivers/reset/uniphier/reset-uniphier-ld4.c
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
+static const struct uniphier_reset_data uniphier_ld4_reset_data[] = {
+	{
+		.id = 7,
+		.reg = 0x2000,
+		.mask = BIT(10),
+		.deassert_val = BIT(10),
+	},
+	{ .id = UNIPHIER_RESET_ID_END }
+};
+
+static int uniphier_ld4_reset_probe(struct platform_device *pdev)
+{
+	return uniphier_reset_probe(pdev, uniphier_ld4_reset_data);
+}
+
+static struct platform_driver uniphier_ld4_reset_driver = {
+	.probe = uniphier_ld4_reset_probe,
+	.driver = {
+		.name = "uniphier-ld4-reset",
+	},
+};
+module_platform_driver(uniphier_ld4_reset_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier PH1-LD4 Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
