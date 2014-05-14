From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 14:26:47 +0200
Subject: [PATCH] clk: sunxi: Remove clkdev registration
Message-ID: <1400070407-27366-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We actually never used clkdev at all in the Allwinner support. Hence, this
registration has always been dead code that can be removed.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-a10-hosc.c |  3 +--
 drivers/clk/sunxi/clk-a20-gmac.c |  2 --
 drivers/clk/sunxi/clk-factors.h  |  1 -
 drivers/clk/sunxi/clk-sunxi.c    | 15 ++++-----------
 4 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/sunxi/clk-a10-hosc.c b/drivers/clk/sunxi/clk-a10-hosc.c
index 0481d5d673d6..6b598c6a0213 100644
--- a/drivers/clk/sunxi/clk-a10-hosc.c
+++ b/drivers/clk/sunxi/clk-a10-hosc.c
@@ -15,9 +15,9 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/slab.h>
 
 #define SUNXI_OSC24M_GATE	0
 
@@ -61,7 +61,6 @@ static void __init sun4i_osc_clk_setup(struct device_node *node)
 		goto err_free_gate;
 
 	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
 
 	return;
 
diff --git a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
index 633ddc4389ef..4937d87f4b36 100644
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -17,7 +17,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
@@ -104,7 +103,6 @@ static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 		goto iounmap_reg;
 
 	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
 
 	return;
 
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 02e1a43ebac7..64d173184063 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -2,7 +2,6 @@
 #define __MACH_SUNXI_CLK_FACTORS_H
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 
 #define SUNXI_FACTORS_NOT_APPLICABLE	(0)
 
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 548f7113efa6..8d25d184c6fe 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -15,10 +15,10 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
+#include <linux/slab.h>
 
 #include "clk-factors.h"
 
@@ -557,10 +557,8 @@ static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
 			&factors->hw, &clk_factors_ops,
 			gate_hw, &clk_gate_ops, 0);
 
-	if (!IS_ERR(clk)) {
+	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
-	}
 
 	return clk;
 }
@@ -611,10 +609,8 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
 			       data->shift, SUNXI_MUX_GATE_WIDTH,
 			       0, &clk_lock);
 
-	if (clk) {
+	if (clk)
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
-	}
 }
 
 
@@ -671,10 +667,8 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 				   reg, data->shift, data->width,
 				   data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
 				   &clk_lock);
-	if (clk) {
+	if (clk)
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
-	}
 }
 
 
@@ -1033,7 +1027,6 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
 						 clkflags);
 
 		WARN_ON(IS_ERR(clk_data->clks[i]));
-		clk_register_clkdev(clks[i], clk_name, NULL);
 	}
 
 	/* The last clock available on the getter is the parent */
-- 
1.9.3
