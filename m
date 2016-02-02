From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  2 Feb 2016 09:47:14 +0100
Subject: [PATCH 5/5] clk: sunxi: Remove clk_register_clkdev calls
In-Reply-To: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1454402834-6385-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that our protection code doesn't use the global name lookup anymore, we
can remove the clkdev registrations.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-a10-hosc.c         | 3 +--
 drivers/clk/sunxi/clk-a20-gmac.c         | 2 --
 drivers/clk/sunxi/clk-factors.c          | 7 -------
 drivers/clk/sunxi/clk-factors.h          | 1 -
 drivers/clk/sunxi/clk-mod0.c             | 1 +
 drivers/clk/sunxi/clk-sun6i-apb0-gates.c | 2 --
 drivers/clk/sunxi/clk-sun9i-core.c       | 1 +
 drivers/clk/sunxi/clk-sunxi.c            | 3 ---
 8 files changed, 3 insertions(+), 17 deletions(-)

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
index 1611b036421c..3437f734c9bf 100644
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -17,7 +17,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
@@ -107,7 +106,6 @@ static void __init sun7i_a20_gmac_clk_setup(struct device_node *node)
 		goto iounmap_reg;
 
 	of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
 
 	return;
 
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 6e97f46c0c37..ddefe9668863 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -258,14 +258,8 @@ struct clk *sunxi_factors_register(struct device_node *node,
 	if (ret)
 		goto err_provider;
 
-	ret = clk_register_clkdev(clk, clk_name, NULL);
-	if (ret)
-		goto err_clkdev;
-
 	return clk;
 
-err_clkdev:
-	of_clk_del_provider(node);
 err_provider:
 	/* TODO: The composite clock stuff will leak a bit here. */
 	clk_unregister(clk);
@@ -291,7 +285,6 @@ void sunxi_factors_unregister(struct device_node *node, struct clk *clk)
 	factors = to_clk_factors(hw);
 	name = clk_hw_get_name(hw);
 
-	/* No unregister call for clkdev_* */
 	of_clk_del_provider(node);
 	/* TODO: The composite clock stuff will leak a bit here. */
 	clk_unregister(clk);
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index a44a865a6b9e..1e63c5b2d5f4 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -2,7 +2,6 @@
 #define __MACH_SUNXI_CLK_FACTORS_H
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/spinlock.h>
 
 #define SUNXI_FACTORS_NOT_APPLICABLE	(0)
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index 578bff0dd251..b38d71cec74c 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
index 23d042aabb4f..68021fa5ecd9 100644
--- a/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
+++ b/drivers/clk/sunxi/clk-sun6i-apb0-gates.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -87,7 +86,6 @@ static int sun6i_a31_apb0_gates_clk_probe(struct platform_device *pdev)
 						      clk_parent, 0, reg, i,
 						      0, NULL);
 		WARN_ON(IS_ERR(clk_data->clks[i]));
-		clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
 
 		j++;
 	}
diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index a81211062ecb..43f014f85803 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 5f2f3e0408bd..91f6d8ef81df 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -685,7 +685,6 @@ static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
 
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
 	}
 
 	return clk;
@@ -796,7 +795,6 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
 					 data->table, &clk_lock);
 	if (clk) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
 	}
 }
 
@@ -1020,7 +1018,6 @@ static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
 						 clkflags);
 
 		WARN_ON(IS_ERR(clk_data->clks[i]));
-		clk_register_clkdev(clks[i], clk_name, NULL);
 	}
 
 	/* Adjust to the real max */
-- 
2.6.4
