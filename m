From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 25 Jan 2016 21:15:47 +0800
Subject: [PATCH RFC 11/11] clk: sunxi: rewrite sun8i-a23-mbus-clk using the
 simpler composite clk
In-Reply-To: <1453727747-23307-1-git-send-email-wens@csie.org>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
Message-ID: <1453727747-23307-12-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun8i-a23-mbus-clk used sunxi's factors clk, which is nice for very
complicated clocks, but is not really needed here.

Convert sun8i-a23-mbus-clk to use clk_composite, as it is a gate + mux
+ divider. This makes the code easier to understand.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This patch I'm not so sure about. As stated in the cover letter,
this rewrite actually increases the LoC, but possibly making it
easier to understand.

---
 drivers/clk/sunxi/clk-sun8i-mbus.c | 120 +++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 45 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
index 78683f02a37d..d3e385337b8a 100644
--- a/drivers/clk/sunxi/clk-sun8i-mbus.c
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -15,68 +15,98 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/of_address.h>
 
-#include "clk-factors.h"
+#define SUN8I_MBUS_ENABLE	31
+#define SUN8I_MBUS_MUX_SHIFT	24
+#define SUN8I_MBUS_MUX_MASK	0x3
+#define SUN8I_MBUS_DIV_SHIFT	0
+#define SUN8I_MBUS_DIV_WIDTH	3
+#define SUN8I_MBUS_MAX_PARENTS	4
 
-/**
- * sun8i_a23_get_mbus_factors() - calculates m factor for MBUS clocks
- * MBUS rate is calculated as follows
- * rate = parent_rate / (m + 1);
- */
+static DEFINE_SPINLOCK(sun8i_a23_mbus_lock);
 
-static void sun8i_a23_get_mbus_factors(struct factors_request *req)
+static void __init sun8i_a23_mbus_setup(struct device_node *node)
 {
-	u8 div;
+	int num_parents = of_clk_get_parent_count(node);
+	const char *parents[num_parents];
+	const char *clk_name = node->name;
+	struct resource res;
+	struct clk_divider *div;
+	struct clk_gate *gate;
+	struct clk_mux *mux;
+	struct clk *clk;
+	void __iomem *reg;
+	int err;
 
-	/*
-	 * These clocks can only divide, so we will never be able to
-	 * achieve frequencies higher than the parent frequency
-	 */
-	if (req->rate > req->parent_rate)
-		req->rate = req->parent_rate;
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (!reg) {
+		pr_err("Could not get registers for sun8i-mbus-clk\n");
+		return;
+	}
 
-	div = DIV_ROUND_UP(req->parent_rate, req->rate);
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto err_unmap;
 
-	if (div > 8)
-		div = 8;
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto err_free_div;
 
-	req->rate = req->parent_rate / div;
-	req->m = div - 1;
-}
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto err_free_mux;
 
-static struct clk_factors_config sun8i_a23_mbus_config = {
-	.mshift = 0,
-	.mwidth = 3,
-};
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	of_clk_parent_fill(node, parents, num_parents);
 
-static const struct factors_data sun8i_a23_mbus_data __initconst = {
-	.enable = 31,
-	.mux = 24,
-	.muxmask = BIT(1) | BIT(0),
-	.table = &sun8i_a23_mbus_config,
-	.getter = sun8i_a23_get_mbus_factors,
-};
+	gate->reg = reg;
+	gate->bit_idx = SUN8I_MBUS_ENABLE;
+	gate->lock = &sun8i_a23_mbus_lock;
 
-static DEFINE_SPINLOCK(sun8i_a23_mbus_lock);
+	div->reg = reg;
+	div->shift = SUN8I_MBUS_DIV_SHIFT;
+	div->width = SUN8I_MBUS_DIV_WIDTH;
+	div->lock = &sun8i_a23_mbus_lock;
 
-static void __init sun8i_a23_mbus_setup(struct device_node *node)
-{
-	struct clk *mbus;
-	void __iomem *reg;
+	mux->reg = reg;
+	mux->shift = SUN8I_MBUS_MUX_SHIFT;
+	mux->mask = SUN8I_MBUS_MUX_MASK;
+	mux->lock = &sun8i_a23_mbus_lock;
 
-	reg = of_iomap(node, 0);
-	if (!reg) {
-		pr_err("Could not get registers for a23-mbus-clk\n");
-		return;
-	}
+	clk = clk_register_composite(NULL, clk_name, parents, num_parents,
+				     &mux->hw, &clk_mux_ops,
+				     &div->hw, &clk_divider_ops,
+				     &gate->hw, &clk_gate_ops,
+				     0);
+	if (IS_ERR(clk))
+		goto err_free_gate;
 
-	mbus = sunxi_factors_register(node, &sun8i_a23_mbus_data,
-				      &sun8i_a23_mbus_lock, reg);
+	err = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (err)
+		goto err_unregister_clk;
 
 	/* The MBUS clocks needs to be always enabled */
-	__clk_get(mbus);
-	clk_prepare_enable(mbus);
+	__clk_get(clk);
+	clk_prepare_enable(clk);
+
+	return;
+
+err_unregister_clk:
+	clk_unregister_composite(clk);
+err_free_gate:
+	kfree(gate);
+err_free_mux:
+	kfree(mux);
+err_free_div:
+	kfree(div);
+err_unmap:
+	iounmap(reg);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
 }
 CLK_OF_DECLARE(sun8i_a23_mbus, "allwinner,sun8i-a23-mbus-clk", sun8i_a23_mbus_setup);
-- 
2.7.0
