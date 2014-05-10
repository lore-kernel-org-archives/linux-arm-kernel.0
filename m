From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  9 May 2014 22:33:38 -0500
Subject: [PATCH 3/6] clk: sunxi: Move the GMAC clock to a file of its own
In-Reply-To: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399692821-20988-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399692821-20988-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have a folder of our own, we can actually make use of it by splitting
the huge clock file into several sub drivers.

The gmac clock is pretty easy to deal with, since it's pretty much isolated and
doesn't have any dependency on the other clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/Makefile       |   3 +-
 drivers/clk/sunxi/clk-a20-gmac.c | 119 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c    |  98 --------------------------------
 3 files changed, 121 insertions(+), 99 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a20-gmac.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 2c3d2fed2560..839029e36144 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -3,4 +3,5 @@
 #
 
 obj-y += clk-sunxi.o clk-factors.o
-obj-y += clk-a10-hosc.o
\ No newline at end of file
+obj-y += clk-a10-hosc.o
+obj-y += clk-a20-gmac.o
diff --git a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
new file mode 100644
index 000000000000..633ddc4389ef
--- /dev/null
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright 2013 Emilio L??pez
+ * Emilio L??pez <emilio@elopez.com.ar>
+ *
+ * Copyright 2013 Chen-Yu Tsai
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
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+static DEFINE_SPINLOCK(gmac_lock);
+
+/**
+ * sun7i_a20_gmac_clk_setup - Setup function for A20/A31 GMAC clock module
+ *
+ * This clock looks something like this
+ *                               ________________________
+ *  MII TX clock from PHY >-----|___________    _________|----> to GMAC core
+ *  GMAC Int. RGMII TX clk >----|___________\__/__gate---|----> to PHY
+ *  Ext. 125MHz RGMII TX clk >--|__divider__/            |
+ *                              |________________________|
+ *
+ * The external 125 MHz reference is optional, i.e. GMAC can use its
+ * internal TX clock just fine. The A31 GMAC clock module does not have
+ * the divider controls for the external reference.
+ *
+ * To keep it simple, let the GMAC use either the MII TX clock for MII mode,
+ * and its internal TX clock for GMII and RGMII modes. The GMAC driver should
+ * select the appropriate source and gate/ungate the output to the PHY.
+ *
+ * Only the GMAC should use this clock. Altering the clock so that it doesn't
+ * match the GMAC's operation parameters will result in the GMAC not being
+ * able to send traffic out. The GMAC driver should set the clock rate and
+ * enable/disable this clock to configure the required state. The clock
+ * driver then responds by auto-reparenting the clock.
+ */
+
+#define SUN7I_A20_GMAC_GPIT	2
+#define SUN7I_A20_GMAC_MASK	0x3
+#define SUN7I_A20_GMAC_PARENTS	2
+
+static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_mux *mux;
+	struct clk_gate *gate;
+	const char *clk_name = node->name;
+	const char *parents[SUN7I_A20_GMAC_PARENTS];
+	void *reg;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+
+	/* allocate mux and gate clock structs */
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	if (!mux)
+		return;
+
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	if (!gate)
+		goto free_mux;
+
+	/* gmac clock requires exactly 2 parents */
+	parents[0] = of_clk_get_parent_name(node, 0);
+	parents[1] = of_clk_get_parent_name(node, 1);
+	if (!parents[0] || !parents[1])
+		goto free_gate;
+
+	reg = of_iomap(node, 0);
+	if (!reg)
+		goto free_gate;
+
+	/* set up gate and fixed rate properties */
+	gate->reg = reg;
+	gate->bit_idx = SUN7I_A20_GMAC_GPIT;
+	gate->lock = &gmac_lock;
+	mux->reg = reg;
+	mux->mask = SUN7I_A20_GMAC_MASK;
+	mux->flags = CLK_MUX_INDEX_BIT;
+	mux->lock = &gmac_lock;
+
+	clk = clk_register_composite(NULL, clk_name,
+			parents, SUN7I_A20_GMAC_PARENTS,
+			&mux->hw, &clk_mux_ops,
+			NULL, NULL,
+			&gate->hw, &clk_gate_ops,
+			0);
+
+	if (IS_ERR(clk))
+		goto iounmap_reg;
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	clk_register_clkdev(clk, clk_name, NULL);
+
+	return;
+
+iounmap_reg:
+	iounmap(reg);
+free_gate:
+	kfree(gate);
+free_mux:
+	kfree(mux);
+}
+CLK_OF_DECLARE(sun7i_a20_gmac, "allwinner,sun7i-a20-gmac-clk",
+		sun7i_a20_gmac_clk_setup);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index c719e40cfb31..291a2605afa7 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -351,104 +351,6 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
 	*p = calcp;
 }
 
-
-
-/**
- * sun7i_a20_gmac_clk_setup - Setup function for A20/A31 GMAC clock module
- *
- * This clock looks something like this
- *                               ________________________
- *  MII TX clock from PHY >-----|___________    _________|----> to GMAC core
- *  GMAC Int. RGMII TX clk >----|___________\__/__gate---|----> to PHY
- *  Ext. 125MHz RGMII TX clk >--|__divider__/            |
- *                              |________________________|
- *
- * The external 125 MHz reference is optional, i.e. GMAC can use its
- * internal TX clock just fine. The A31 GMAC clock module does not have
- * the divider controls for the external reference.
- *
- * To keep it simple, let the GMAC use either the MII TX clock for MII mode,
- * and its internal TX clock for GMII and RGMII modes. The GMAC driver should
- * select the appropriate source and gate/ungate the output to the PHY.
- *
- * Only the GMAC should use this clock. Altering the clock so that it doesn't
- * match the GMAC's operation parameters will result in the GMAC not being
- * able to send traffic out. The GMAC driver should set the clock rate and
- * enable/disable this clock to configure the required state. The clock
- * driver then responds by auto-reparenting the clock.
- */
-
-#define SUN7I_A20_GMAC_GPIT	2
-#define SUN7I_A20_GMAC_MASK	0x3
-#define SUN7I_A20_GMAC_PARENTS	2
-
-static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
-{
-	struct clk *clk;
-	struct clk_mux *mux;
-	struct clk_gate *gate;
-	const char *clk_name = node->name;
-	const char *parents[SUN7I_A20_GMAC_PARENTS];
-	void *reg;
-
-	if (of_property_read_string(node, "clock-output-names", &clk_name))
-		return;
-
-	/* allocate mux and gate clock structs */
-	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
-	if (!mux)
-		return;
-
-	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
-	if (!gate)
-		goto free_mux;
-
-	/* gmac clock requires exactly 2 parents */
-	parents[0] = of_clk_get_parent_name(node, 0);
-	parents[1] = of_clk_get_parent_name(node, 1);
-	if (!parents[0] || !parents[1])
-		goto free_gate;
-
-	reg = of_iomap(node, 0);
-	if (!reg)
-		goto free_gate;
-
-	/* set up gate and fixed rate properties */
-	gate->reg = reg;
-	gate->bit_idx = SUN7I_A20_GMAC_GPIT;
-	gate->lock = &clk_lock;
-	mux->reg = reg;
-	mux->mask = SUN7I_A20_GMAC_MASK;
-	mux->flags = CLK_MUX_INDEX_BIT;
-	mux->lock = &clk_lock;
-
-	clk = clk_register_composite(NULL, clk_name,
-			parents, SUN7I_A20_GMAC_PARENTS,
-			&mux->hw, &clk_mux_ops,
-			NULL, NULL,
-			&gate->hw, &clk_gate_ops,
-			0);
-
-	if (IS_ERR(clk))
-		goto iounmap_reg;
-
-	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
-
-	return;
-
-iounmap_reg:
-	iounmap(reg);
-free_gate:
-	kfree(gate);
-free_mux:
-	kfree(mux);
-}
-CLK_OF_DECLARE(sun7i_a20_gmac, "allwinner,sun7i-a20-gmac-clk",
-		sun7i_a20_gmac_clk_setup);
-
-
-
 /**
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
-- 
1.9.1
