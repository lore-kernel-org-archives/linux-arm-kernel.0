From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 26 Dec 2016 11:45:30 +0800
Subject: [PATCH v3 4/4] clk: rockchip: add new pll-type for rk3328
In-Reply-To: <1482723930-5876-1-git-send-email-zhangqing@rock-chips.com>
References: <1482723930-5876-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1482723930-5876-5-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328's pll and clock are similar with rk3036's,
it different with pll_mode_mask, the rk3328 soc
pll mode only one bit(rk3036 soc have two bits)
so these should be independent and separate from
the series of rk3328s.

Changes in v3:
  fix up the pll type pll_rk3328 description and use

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 6ed605776abd..eec51893a7e6 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -29,6 +29,7 @@
 #define PLL_MODE_SLOW		0x0
 #define PLL_MODE_NORM		0x1
 #define PLL_MODE_DEEP		0x2
+#define PLL_RK3328_MODE_MASK	0x1
 
 struct rockchip_clk_pll {
 	struct clk_hw		hw;
@@ -848,7 +849,8 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	struct clk *pll_clk, *mux_clk;
 	char pll_name[20];
 
-	if (num_parents != 2) {
+	if ((pll_type != pll_rk3328 && num_parents != 2) ||
+	    (pll_type == pll_rk3328 && num_parents != 1)) {
 		pr_err("%s: needs two parent clocks\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -865,13 +867,17 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	pll_mux = &pll->pll_mux;
 	pll_mux->reg = ctx->reg_base + mode_offset;
 	pll_mux->shift = mode_shift;
-	pll_mux->mask = PLL_MODE_MASK;
+	if (pll_type == pll_rk3328)
+		pll_mux->mask = PLL_RK3328_MODE_MASK;
+	else
+		pll_mux->mask = PLL_MODE_MASK;
 	pll_mux->flags = 0;
 	pll_mux->lock = &ctx->lock;
 	pll_mux->hw.init = &init;
 
 	if (pll_type == pll_rk3036 ||
 	    pll_type == pll_rk3066 ||
+	    pll_type == pll_rk3328 ||
 	    pll_type == pll_rk3399)
 		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
 
@@ -884,7 +890,10 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	init.flags = CLK_SET_RATE_PARENT;
 	init.ops = pll->pll_mux_ops;
 	init.parent_names = pll_parents;
-	init.num_parents = ARRAY_SIZE(pll_parents);
+	if (pll_type == pll_rk3328)
+		init.num_parents = 2;
+	else
+		init.num_parents = ARRAY_SIZE(pll_parents);
 
 	mux_clk = clk_register(NULL, &pll_mux->hw);
 	if (IS_ERR(mux_clk))
@@ -918,6 +927,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 
 	switch (pll_type) {
 	case pll_rk3036:
+	case pll_rk3328:
 		if (!pll->rate_table || IS_ERR(ctx->grf))
 			init.ops = &rockchip_rk3036_pll_clk_norate_ops;
 		else
-- 
1.9.1
