From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 19 Aug 2015 15:06:55 +0200
Subject: [PATCH] clk: rockchip: register pll mux before pll itself
Message-ID: <7060610.CC2Q1RMG2L@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The structure is xin24m -> pll -> pll-mux (xin24m,pll,xin32k). The pll
does have an init callback to make sure the boot-selected frequency is
using the expected pll settings and resets the same frequency using
the values provided in the driver if necessary.

The setting itself also involves remuxing the pll-mux temporarily to
the xin24m source to let the new pll rate settle. Until now this worked
flawlessly, even when it had the flaw of accessing the mux settings
before the mux actually got registered.

With the recent clock-core conversions this flaw became apparent in
null pointer dereference in
[<c03fc400>] (clk_hw_get_num_parents) from [<c0400df0>] (clk_mux_get_parent+0x14/0xc8)
[<c0400ddc>] (clk_mux_get_parent) from [<c040246c>] (rockchip_rk3066_pll_set_rate+0xd8/0x320)

So to fix that, simply register the pll-mux before the pll, so that
it will be fully initialized when the pll clock executes its init-
callback and possibly touches the pll-mux clock.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This only surfaced with the clk_core changes for 4.3, so should
probably just go on top.

 drivers/clk/rockchip/clk-pll.c | 63 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index eab4304..7737a1d 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -353,6 +353,35 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
+	/* create the mux on top of the real pll */
+	pll->pll_mux_ops = &clk_mux_ops;
+	pll_mux = &pll->pll_mux;
+	pll_mux->reg = base + mode_offset;
+	pll_mux->shift = mode_shift;
+	pll_mux->mask = PLL_MODE_MASK;
+	pll_mux->flags = 0;
+	pll_mux->lock = lock;
+	pll_mux->hw.init = &init;
+
+	if (pll_type == pll_rk3066)
+		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
+
+	/* the actual muxing is xin24m, pll-output, xin32k */
+	pll_parents[0] = parent_names[0];
+	pll_parents[1] = pll_name;
+	pll_parents[2] = parent_names[1];
+
+	init.name = name;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.ops = pll->pll_mux_ops;
+	init.parent_names = pll_parents;
+	init.num_parents = ARRAY_SIZE(pll_parents);
+
+	mux_clk = clk_register(NULL, &pll_mux->hw);
+	if (IS_ERR(mux_clk))
+		goto err_mux;
+
+	/* now create the actual pll */
 	init.name = pll_name;
 
 	/* keep all plls untouched for now */
@@ -398,47 +427,19 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	pll->flags = clk_pll_flags;
 	pll->lock = lock;
 
-	/* create the mux on top of the real pll */
-	pll->pll_mux_ops = &clk_mux_ops;
-	pll_mux = &pll->pll_mux;
-	pll_mux->reg = base + mode_offset;
-	pll_mux->shift = mode_shift;
-	pll_mux->mask = PLL_MODE_MASK;
-	pll_mux->flags = 0;
-	pll_mux->lock = lock;
-	pll_mux->hw.init = &init;
-
-	if (pll_type == pll_rk3066)
-		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
-
 	pll_clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(pll_clk)) {
 		pr_err("%s: failed to register pll clock %s : %ld\n",
 			__func__, name, PTR_ERR(pll_clk));
-		mux_clk = pll_clk;
 		goto err_pll;
 	}
 
-	/* the actual muxing is xin24m, pll-output, xin32k */
-	pll_parents[0] = parent_names[0];
-	pll_parents[1] = pll_name;
-	pll_parents[2] = parent_names[1];
-
-	init.name = name;
-	init.flags = CLK_SET_RATE_PARENT;
-	init.ops = pll->pll_mux_ops;
-	init.parent_names = pll_parents;
-	init.num_parents = ARRAY_SIZE(pll_parents);
-
-	mux_clk = clk_register(NULL, &pll_mux->hw);
-	if (IS_ERR(mux_clk))
-		goto err_mux;
-
 	return mux_clk;
 
-err_mux:
-	clk_unregister(pll_clk);
 err_pll:
+	clk_unregister(mux_clk);
+	mux_clk = pll_clk;
+err_mux:
 	kfree(pll);
 	return mux_clk;
 }
-- 
2.1.4
