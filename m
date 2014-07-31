From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Thu, 31 Jul 2014 18:28:08 -0300
Subject: [PATCH 5/9] clk: sunxi: codec clock support
In-Reply-To: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1406842092-25207-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The codec clock on sun4i, sun5i and sun7i is a simple gate with PLL2 as
parent.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Changes from RFC:
 * Document the compatible used
 * Collect ack from Maxime

 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/Makefile                        |  1 +
 drivers/clk/sunxi/clk-a10-codec.c                 | 41 +++++++++++++++++++++++
 3 files changed, 43 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-a10-codec.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 41ada31..d18b89b 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -48,6 +48,7 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
+	"allwinner,sun4i-a10-codec-clk" - for the codec clock on A10
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index dcd5709..a7a96f8 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-y += clk-sunxi.o clk-factors.o
+obj-y += clk-a10-codec.o
 obj-y += clk-a10-hosc.o
 obj-y += clk-a10-pll2.o
 obj-y += clk-a20-gmac.o
diff --git a/drivers/clk/sunxi/clk-a10-codec.c b/drivers/clk/sunxi/clk-a10-codec.c
new file mode 100644
index 0000000..ab4d948
--- /dev/null
+++ b/drivers/clk/sunxi/clk-a10-codec.c
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2014 Emilio L?pez
+ *
+ * Emilio L?pez <emilio@elopez.com.ar>
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
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define SUN4I_CODEC_GATE	31
+
+static void __init sun4i_codec_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name, *parent_name;
+	void __iomem *reg;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	parent_name = of_clk_get_parent_name(node, 0);
+	reg = of_iomap(node, 0);
+
+	clk = clk_register_gate(NULL, clk_name, parent_name,
+				CLK_SET_RATE_PARENT, reg,
+				SUN4I_CODEC_GATE, 0, NULL);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(sun4i_codec, "allwinner,sun4i-a10-codec-clk", sun4i_codec_clk_setup);
-- 
2.0.3
