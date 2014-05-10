From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 May 2014 22:33:37 -0500
Subject: [PATCH 2/6] clk: sunxi: Move the 24M oscillator to a file of its own
In-Reply-To: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399692821-20988-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have a folder of our own, we can actually make use of it by splitting
the huge clock file into several sub drivers.

The main oscillator is pretty easy to deal with, since it's pretty much
isolated.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/Makefile       |  1 +
 drivers/clk/sunxi/clk-a10-hosc.c | 73 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c    | 57 -------------------------------
 3 files changed, 74 insertions(+), 57 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-hosc.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index b5bac917612c..2c3d2fed2560 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y += clk-sunxi.o clk-factors.o
+obj-y += clk-a10-hosc.o
\ No newline at end of file
diff --git a/drivers/clk/sunxi/clk-a10-hosc.c b/drivers/clk/sunxi/clk-a10-hosc.c
new file mode 100644
index 000000000000..0481d5d673d6
--- /dev/null
+++ b/drivers/clk/sunxi/clk-a10-hosc.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2013 Emilio L??pez
+ *
+ * Emilio L??pez <emilio@elopez.com.ar>
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
+#define SUNXI_OSC24M_GATE	0
+
+static DEFINE_SPINLOCK(hosc_lock);
+
+static void __init sun4i_osc_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_fixed_rate *fixed;
+	struct clk_gate *gate;
+	const char *clk_name = node->name;
+	u32 rate;
+
+	if (of_property_read_u32(node, "clock-frequency", &rate))
+		return;
+
+	/* allocate fixed-rate and gate clock structs */
+	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
+	if (!fixed)
+		return;
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	if (!gate)
+		goto err_free_fixed;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	/* set up gate and fixed rate properties */
+	gate->reg = of_iomap(node, 0);
+	gate->bit_idx = SUNXI_OSC24M_GATE;
+	gate->lock = &hosc_lock;
+	fixed->fixed_rate = rate;
+
+	clk = clk_register_composite(NULL, clk_name,
+			NULL, 0,
+			NULL, NULL,
+			&fixed->hw, &clk_fixed_rate_ops,
+			&gate->hw, &clk_gate_ops,
+			CLK_IS_ROOT);
+
+	if (IS_ERR(clk))
+		goto err_free_gate;
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	clk_register_clkdev(clk, clk_name, NULL);
+
+	return;
+
+err_free_gate:
+	kfree(gate);
+err_free_fixed:
+	kfree(fixed);
+}
+CLK_OF_DECLARE(sun4i_osc, "allwinner,sun4i-a10-osc-clk", sun4i_osc_clk_setup);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index b1fde0f89bc1..c719e40cfb31 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -28,63 +28,6 @@ static DEFINE_SPINLOCK(clk_lock);
 #define SUNXI_MAX_PARENTS	5
 
 /**
- * sun4i_osc_clk_setup() - Setup function for gatable oscillator
- */
-
-#define SUNXI_OSC24M_GATE	0
-
-static void __init sun4i_osc_clk_setup(struct device_node *node)
-{
-	struct clk *clk;
-	struct clk_fixed_rate *fixed;
-	struct clk_gate *gate;
-	const char *clk_name = node->name;
-	u32 rate;
-
-	if (of_property_read_u32(node, "clock-frequency", &rate))
-		return;
-
-	/* allocate fixed-rate and gate clock structs */
-	fixed = kzalloc(sizeof(struct clk_fixed_rate), GFP_KERNEL);
-	if (!fixed)
-		return;
-	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
-	if (!gate)
-		goto err_free_fixed;
-
-	of_property_read_string(node, "clock-output-names", &clk_name);
-
-	/* set up gate and fixed rate properties */
-	gate->reg = of_iomap(node, 0);
-	gate->bit_idx = SUNXI_OSC24M_GATE;
-	gate->lock = &clk_lock;
-	fixed->fixed_rate = rate;
-
-	clk = clk_register_composite(NULL, clk_name,
-			NULL, 0,
-			NULL, NULL,
-			&fixed->hw, &clk_fixed_rate_ops,
-			&gate->hw, &clk_gate_ops,
-			CLK_IS_ROOT);
-
-	if (IS_ERR(clk))
-		goto err_free_gate;
-
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
-
-	return;
-
-err_free_gate:
-	kfree(gate);
-err_free_fixed:
-	kfree(fixed);
-}
-CLK_OF_DECLARE(sun4i_osc, "allwinner,sun4i-a10-osc-clk", sun4i_osc_clk_setup);
-
-
-
-/**
  * sun4i_get_pll1_factors() - calculates n, k, m, p factors for PLL1
  * PLL1 rate is calculated as follows
  * rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
-- 
1.9.1
