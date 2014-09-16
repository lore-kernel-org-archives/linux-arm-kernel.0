From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 16 Sep 2014 16:12:46 +0800
Subject: [PATCH v2 1/2] clk: sunxi: Add sun8i MBUS clock support
In-Reply-To: <1410855167-1121-1-git-send-email-wens@csie.org>
References: <1410855167-1121-1-git-send-email-wens@csie.org>
Message-ID: <1410855167-1121-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MBUS clock on sun8i is slightly different from the old mod0 clocks.
The divider is 3 bits wider, while also needing a divider table for the
higher 4 values, which all set the same divider.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
 drivers/clk/sunxi/Makefile                        |  1 +
 drivers/clk/sunxi/clk-sun8i-mbus.c                | 76 +++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-sun8i-mbus.c

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 425b109..fb3b7aa 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -50,6 +50,7 @@ Required properties:
 	"allwinner,sun4i-a10-mmc-output-clk" - for the MMC output clock on A10
 	"allwinner,sun4i-a10-mmc-sample-clk" - for the MMC sample clock on A10
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
+	"allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
 	"allwinner,sun4i-a10-usb-clk" - for usb gates + resets on A10 / A20
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 833f086..7ddc2b5 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -6,6 +6,7 @@ obj-y += clk-sunxi.o clk-factors.o
 obj-y += clk-a10-hosc.o
 obj-y += clk-a20-gmac.o
 obj-y += clk-mod0.o
+obj-y += clk-sun8i-mbus.o
 
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
 	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
new file mode 100644
index 0000000..539f10b
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright 2014 Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
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
+#include <linux/of_address.h>
+
+#include "clk-factors.h"
+
+/**
+ * sun8i_a23_get_mbus_factors() - calculates m factor for MBUS clocks
+ * MBUS rate is calculated as follows
+ * rate = parent_rate / (m + 1);
+ */
+
+static void sun8i_a23_get_mbus_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div;
+
+	/* These clocks can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency */
+	if (*freq > parent_rate)
+		*freq = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, *freq);
+
+	if (div > 8)
+		div = 8;
+
+	*freq = parent_rate / div;
+
+	/* we were called to round the frequency, we can now return */
+	if (m == NULL)
+		return;
+
+	*m = div - 1;
+}
+
+static struct clk_factors_config sun8i_a23_mbus_config = {
+	.mshift = 0,
+	.mwidth = 3,
+};
+
+static const struct factors_data sun8i_a23_mbus_data __initconst = {
+	.enable = 31,
+	.mux = 24,
+	.table = &sun8i_a23_mbus_config,
+	.getter = sun8i_a23_get_mbus_factors,
+};
+
+static DEFINE_SPINLOCK(sun8i_a23_mbus_lock);
+
+static void __init sun8i_a23_mbus_setup(struct device_node *node)
+{
+	struct clk *mbus = sunxi_factors_register(node, &sun8i_a23_mbus_data,
+						  &sun8i_a23_mbus_lock);
+
+	/* The MBUS clocks needs to be always enabled */
+	__clk_get(mbus);
+	clk_prepare_enable(mbus);
+}
+CLK_OF_DECLARE(sun8i_a23_mbus, "allwinner,sun8i-a23-mbus-clk", sun8i_a23_mbus_setup);
-- 
2.1.0
