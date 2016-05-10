From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:51 +0900
Subject: [RFC PATCH 10/21] clk: uniphier: add clock driver for Media I/O block
 on UniPhier SoCs
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-11-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/Kconfig            |   4 +
 drivers/clk/uniphier/Makefile           |   2 +
 drivers/clk/uniphier/clk-uniphier-mio.c | 215 ++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mio.c

diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
index 6e0a311..895c4a0 100644
--- a/drivers/clk/uniphier/Kconfig
+++ b/drivers/clk/uniphier/Kconfig
@@ -34,4 +34,8 @@ config CLK_UNIPHIER_LD20
 	tristate "Clock driver for UniPhier PH1-LD20 SoC"
 	default ARM64
 
+config CLK_UNIPHIER_MIO
+	tristate "Clock driver for UniPhier Media I/O block"
+	default y
+
 endif
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
index 59272a6..ae71f04 100644
--- a/drivers/clk/uniphier/Makefile
+++ b/drivers/clk/uniphier/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_CLK_UNIPHIER_PRO5)	+= clk-uniphier-pro5.o
 obj-$(CONFIG_CLK_UNIPHIER_PXS2)	+= clk-uniphier-pxs2.o
 obj-$(CONFIG_CLK_UNIPHIER_LD11)	+= clk-uniphier-ld11.o
 obj-$(CONFIG_CLK_UNIPHIER_LD20)	+= clk-uniphier-ld20.o
+
+obj-$(CONFIG_CLK_UNIPHIER_MIO)	+= clk-uniphier-mio.o
diff --git a/drivers/clk/uniphier/clk-uniphier-mio.c b/drivers/clk/uniphier/clk-uniphier-mio.c
new file mode 100644
index 0000000..28691b7
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-mio.c
@@ -0,0 +1,215 @@
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
+#define UNIPHIER_MIO_CLK_SD_FIXED					\
+	{								\
+		.name = "sd-44m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 44444444,				\
+		},							\
+	},								\
+	{								\
+		.name = "sd-33m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 33333333,				\
+		},							\
+	},								\
+	{								\
+		.name = "sd-50m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 50000000,				\
+		},							\
+	},								\
+	{								\
+		.name = "sd-67m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 66666666,				\
+		},							\
+	},								\
+	{								\
+		.name = "sd-100m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 100000000,			\
+		},							\
+	},								\
+	{								\
+		.name = "sd-40m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 40000000,				\
+		},							\
+	},								\
+	{								\
+		.name = "sd-25m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 25000000,				\
+		},							\
+	},								\
+	{								\
+		.name = "sd-22m",					\
+		.type = UNIPHIER_CLK_TYPE_FIXED_RATE,			\
+		.output_index = -1,					\
+		.data.rate = {						\
+			.fixed_rate = 22222222,				\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_SD(ch, index)					\
+	{								\
+		.name = "sd" #ch "-sel",				\
+		.type = UNIPHIER_CLK_TYPE_MUX,				\
+		.output_index = -1,					\
+		.data.mux = {						\
+			.parent_names = {				\
+				"sd-44m",				\
+				"sd-33m",				\
+				"sd-50m",				\
+				"sd-67m",				\
+				"sd-100m",				\
+				"sd-40m",				\
+				"sd-25m",				\
+				"sd-22m",				\
+			},						\
+			.num_parents = 8,				\
+			.reg = 0x30 + 0x200 * ch,			\
+			.masks = {					\
+				0x00031000,				\
+				0x00031000,				\
+				0x00031000,				\
+				0x00031000,				\
+				0x00001300,				\
+				0x00001300,				\
+				0x00001300,				\
+				0x00001300,				\
+			},						\
+			.vals = {					\
+				0x00000000,				\
+				0x00010000,				\
+				0x00020000,				\
+				0x00030000,				\
+				0x00001000,				\
+				0x00001100,				\
+				0x00001200,				\
+				0x00001300,				\
+			},						\
+		},							\
+	},								\
+	{								\
+		.name = "sd" #ch,					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "sd" #ch "-sel",			\
+			.reg = 0x20 + 0x200 * ch,			\
+			.mask = BIT(8),					\
+			.enable_val = BIT(8),				\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_EHCI(ch, index)				\
+	{								\
+		.name = "ehci" #ch,					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "ehci",				\
+			.reg = 0x20 + 0x200 * ch,			\
+			.mask = BIT(29) | BIT(28),			\
+			.enable_val = BIT(29) | BIT(28),		\
+		},							\
+	}
+
+#define UNIPHIER_MIO_CLK_DMAC(index)					\
+	{								\
+		.name = "miodmac",					\
+		.type = UNIPHIER_CLK_TYPE_GATE,				\
+		.output_index = (index),				\
+		.data.gate = {						\
+			.parent_name = "stdmac",			\
+			.reg = 0x20,					\
+			.mask = BIT(25),				\
+			.enable_val = BIT(25),				\
+		},							\
+	}
+
+static const struct uniphier_clk_data uniphier_ld4_mio_clk_data[] = {
+	UNIPHIER_MIO_CLK_SD_FIXED,
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	UNIPHIER_MIO_CLK_SD(2, 2),	/* for Pro4 */
+	UNIPHIER_MIO_CLK_DMAC(3),
+	UNIPHIER_MIO_CLK_EHCI(0, 4),
+	UNIPHIER_MIO_CLK_EHCI(1, 5),
+	UNIPHIER_MIO_CLK_EHCI(2, 6),	/* for LD4/sLD8 */
+	{ /* sentinel */ }
+};
+
+static int uniphier_ld4_mio_clk_probe(struct platform_device *pdev)
+{
+	return uniphier_clk_probe(pdev, uniphier_ld4_mio_clk_data);
+}
+
+static struct platform_driver uniphier_ld4_mio_clk_driver = {
+	.probe = uniphier_ld4_mio_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-ld4-mio-clk",
+	},
+};
+module_platform_driver(uniphier_ld4_mio_clk_driver);
+
+static const struct uniphier_clk_data uniphier_pro5_mio_clk_data[] = {
+	UNIPHIER_MIO_CLK_SD_FIXED,
+	UNIPHIER_MIO_CLK_SD(0, 0),
+	UNIPHIER_MIO_CLK_SD(1, 1),
+	{ /* sentinel */ }
+};
+
+static int uniphier_pro5_mio_clk_probe(struct platform_device *pdev)
+{
+	return uniphier_clk_probe(pdev, uniphier_pro5_mio_clk_data);
+}
+
+static struct platform_driver uniphier_pro5_mio_clk_driver = {
+	.probe = uniphier_pro5_mio_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-pro5-mio-clk",
+	},
+};
+module_platform_driver(uniphier_pro5_mio_clk_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Media I/O Clock Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
