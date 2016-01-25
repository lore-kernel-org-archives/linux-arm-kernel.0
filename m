From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:40 +0800
Subject: [PATCH RFC 04/11] clk: sunxi: factors: Add unregister function
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi's factors clk did not have an unregister function. This means
multiple structs were leaked whenever a factors clk was unregistered.

Add an unregister function for it. Also keep pointers to the mux and
gate structs so they can be freed.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi/clk-factors.c | 24 ++++++++++++++++++++++++
 drivers/clk/sunxi/clk-factors.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 1de57c22a358..b464ca4a232e 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -202,6 +202,8 @@ struct clk *sunxi_factors_register(struct device_node *node,
 		if (!gate)
 			goto err_gate;
 
+		factors->gate = gate;
+
 		/* set up gate properties */
 		gate->reg = reg;
 		gate->bit_idx = data->enable;
@@ -215,6 +217,8 @@ struct clk *sunxi_factors_register(struct device_node *node,
 		if (!mux)
 			goto err_mux;
 
+		factors->mux = mux;
+
 		/* set up gate properties */
 		mux->reg = reg;
 		mux->shift = data->mux;
@@ -254,3 +258,23 @@ err_gate:
 err_factors:
 	return NULL;
 }
+
+void sunxi_factors_unregister(struct device_node *node, struct clk *clk)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct clk_factors *factors;
+	const char *name;
+
+	if (!hw)
+		return;
+
+	factors = to_clk_factors(hw);
+	name = clk_hw_get_name(hw);
+
+	/* No unregister call for clkdev_* */
+	of_clk_del_provider(node);
+	clk_unregister_composite(clk);
+	kfree(factors->mux);
+	kfree(factors->gate);
+	kfree(factors);
+}
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 060319be2b99..7ea1379a7cda 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -34,6 +34,9 @@ struct clk_factors {
 	const struct clk_factors_config *config;
 	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
 	spinlock_t *lock;
+	/* for cleanup */
+	struct clk_mux *mux;
+	struct clk_gate *gate;
 };
 
 struct clk *sunxi_factors_register(struct device_node *node,
@@ -41,4 +44,6 @@ struct clk *sunxi_factors_register(struct device_node *node,
 				   spinlock_t *lock,
 				   void __iomem *reg);
 
+void sunxi_factors_unregister(struct device_node *node, struct clk *clk);
+
 #endif
-- 
2.7.0
