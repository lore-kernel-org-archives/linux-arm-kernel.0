From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jan 2015 09:37:23 +0800
Subject: [PATCH v3 01/13] clk: sunxi: Add a common setup function for mmc
 module clocks
In-Reply-To: <1421113055-17867-1-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
Message-ID: <1421113055-17867-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only difference between module clocks on different platforms is the
width of the mux register bits and the valid values, which are passed in
through struct factors_data. The phase clocks parts are identical.

This patch generalizes the setup function, so most of the code can be
reused when adding sun9i support, which has a wider mux register.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-mod0.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index e37eb6fe19e8..4430d1398ce6 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -272,9 +272,16 @@ static const struct clk_ops mmc_clk_ops = {
 	.set_phase	= mmc_set_phase,
 };
 
-static DEFINE_SPINLOCK(sun4i_a10_mmc_lock);
-
-static void __init sun4i_a10_mmc_setup(struct device_node *node)
+/*
+ * sunxi_mmc_setup - Common setup function for mmc module clocks
+ *
+ * The only difference between module clocks on different platforms is the
+ * width of the mux register bits and the valid values, which are passed in
+ * through struct factors_data. The phase clocks parts are identical.
+ */
+static void __init sunxi_mmc_setup(struct device_node *node,
+				   const struct factors_data *data,
+				   spinlock_t *lock)
 {
 	struct clk_onecell_data *clk_data;
 	const char *parent;
@@ -296,9 +303,7 @@ static void __init sun4i_a10_mmc_setup(struct device_node *node)
 		goto err_free_data;
 
 	clk_data->clk_num = 3;
-	clk_data->clks[0] = sunxi_factors_register(node,
-						   &sun4i_a10_mod0_data,
-						   &sun4i_a10_mmc_lock, reg);
+	clk_data->clks[0] = sunxi_factors_register(node, data, lock, reg);
 	if (!clk_data->clks[0])
 		goto err_free_clks;
 
@@ -318,7 +323,7 @@ static void __init sun4i_a10_mmc_setup(struct device_node *node)
 
 		phase->hw.init = &init;
 		phase->reg = reg;
-		phase->lock = &sun4i_a10_mmc_lock;
+		phase->lock = lock;
 
 		if (i == 1)
 			phase->offset = 8;
@@ -345,4 +350,11 @@ err_free_clks:
 err_free_data:
 	kfree(clk_data);
 }
+
+static DEFINE_SPINLOCK(sun4i_a10_mmc_lock);
+
+static void __init sun4i_a10_mmc_setup(struct device_node *node)
+{
+	sunxi_mmc_setup(node, &sun4i_a10_mod0_data, &sun4i_a10_mmc_lock);
+}
 CLK_OF_DECLARE(sun4i_a10_mmc, "allwinner,sun4i-a10-mmc-clk", sun4i_a10_mmc_setup);
-- 
2.1.4
