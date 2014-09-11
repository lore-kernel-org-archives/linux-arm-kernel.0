From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 22:18:21 +0200
Subject: [PATCH v3 07/12] clk: sunxi: Move mod0 clock to a file of its own
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1410466706-27386-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we know have the ability to declare factors clock outside of clk-sunxi,
create a new mod0 driver to deal with the mod0 clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/Makefile    |  1 +
 drivers/clk/sunxi/clk-mod0.c  | 82 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c |  1 -
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sunxi/clk-mod0.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 6850cba35871..833f086d4a52 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -5,6 +5,7 @@
 obj-y += clk-sunxi.o clk-factors.o
 obj-y += clk-a10-hosc.o
 obj-y += clk-a20-gmac.o
+obj-y += clk-mod0.o
 
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
 	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
new file mode 100644
index 000000000000..bce09a84ab4f
--- /dev/null
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright 2013 Emilio L?pez
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
+
+#include "clk-factors.h"
+
+/**
+ * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
+ * MOD0 rate is calculated as follows
+ * rate = (parent_rate >> p) / (m + 1);
+ */
+
+static void sun4i_a10_get_mod0_factors(u32 *freq, u32 parent_rate,
+				       u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div, calcm, calcp;
+
+	/* These clocks can only divide, so we will never be able to achieve
+	 * frequencies higher than the parent frequency */
+	if (*freq > parent_rate)
+		*freq = parent_rate;
+
+	div = DIV_ROUND_UP(parent_rate, *freq);
+
+	if (div < 16)
+		calcp = 0;
+	else if (div / 2 < 16)
+		calcp = 1;
+	else if (div / 4 < 16)
+		calcp = 2;
+	else
+		calcp = 3;
+
+	calcm = DIV_ROUND_UP(div, 1 << calcp);
+
+	*freq = (parent_rate >> calcp) / calcm;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	*m = calcm - 1;
+	*p = calcp;
+}
+
+/* user manual says "n" but it's really "p" */
+static struct clk_factors_config sun4i_a10_mod0_config = {
+	.mshift = 0,
+	.mwidth = 4,
+	.pshift = 16,
+	.pwidth = 2,
+};
+
+static const struct factors_data sun4i_a10_mod0_data __initconst = {
+	.enable = 31,
+	.mux = 24,
+	.table = &sun4i_a10_mod0_config,
+	.getter = sun4i_a10_get_mod0_factors,
+};
+
+static DEFINE_SPINLOCK(sun4i_a10_mod0_lock);
+
+static void __init sun4i_a10_mod0_setup(struct device_node *node)
+{
+	sunxi_factors_register(node, &sun4i_a10_mod0_data, &sun4i_a10_mod0_lock);
+}
+CLK_OF_DECLARE(sun4i_a10_mod0, "allwinner,sun4i-a10-mod0-clk", sun4i_a10_mod0_setup);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index a3d8c633c2d6..6eec82b29bb4 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -1111,7 +1111,6 @@ static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
 	{.compatible = "allwinner,sun5i-a13-mbus-clk", .data = &sun4i_mod0_data,},
-	{.compatible = "allwinner,sun4i-a10-mod0-clk", .data = &sun4i_mod0_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
 	{}
 };
-- 
2.1.0
