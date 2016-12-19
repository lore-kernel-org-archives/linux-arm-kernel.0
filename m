From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon, 19 Dec 2016 09:56:13 +0800
Subject: [PATCH v2 4/4] clk: rockchip: add new pll-type for rk3328
In-Reply-To: <1482112573-11613-1-git-send-email-zhangqing@rock-chips.com>
References: <1482112573-11613-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1482112573-11613-5-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3328's pll and clock are similar with rk3036's,
it different with pll_mode_mask,there are different
control registers bit,
so these should be independent and separate from
the series of rk3328s.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 6ed605776abd..9650c75f61d1 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -29,6 +29,7 @@
 #define PLL_MODE_SLOW		0x0
 #define PLL_MODE_NORM		0x1
 #define PLL_MODE_DEEP		0x2
+#define PLL_RK3328_MODE_MASK	0x1
 
 struct rockchip_clk_pll {
 	struct clk_hw		hw;
@@ -865,13 +866,17 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
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
 
@@ -929,6 +934,12 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		else
 			init.ops = &rockchip_rk3066_pll_clk_ops;
 		break;
+	case pll_rk3328:
+		if (!pll->rate_table || IS_ERR(ctx->grf))
+			init.ops = &rockchip_rk3036_pll_clk_norate_ops;
+		else
+			init.ops = &rockchip_rk3036_pll_clk_ops;
+		break;
 	case pll_rk3399:
 		if (!pll->rate_table)
 			init.ops = &rockchip_rk3399_pll_clk_norate_ops;
-- 
1.9.1
