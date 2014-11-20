From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 20 Nov 2014 20:38:51 +0100
Subject: [PATCH v2 2/4] clk: rockchip: setup pll_mux data earlier
In-Reply-To: <1416512333-15438-1-git-send-email-heiko@sntech.de>
References: <1416512333-15438-1-git-send-email-heiko@sntech.de>
Message-ID: <1416512333-15438-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases we might need to access the data of the pll mux before the actual
mux gets registered - like in the following patch adding an init-callback.

Therefore populate pll_mux before registering the core pll-clock.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-pll.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index feb9cad..1bb6891 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -349,6 +349,19 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	pll->flags = clk_pll_flags;
 	pll->lock = lock;
 
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
 	pll_clk = clk_register(NULL, &pll->hw);
 	if (IS_ERR(pll_clk)) {
 		pr_err("%s: failed to register pll clock %s : %ld\n",
@@ -357,10 +370,6 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 		goto err_pll;
 	}
 
-	/* create the mux on top of the real pll */
-	pll->pll_mux_ops = &clk_mux_ops;
-	pll_mux = &pll->pll_mux;
-
 	/* the actual muxing is xin24m, pll-output, xin32k */
 	pll_parents[0] = parent_names[0];
 	pll_parents[1] = pll_name;
@@ -372,16 +381,6 @@ struct clk *rockchip_clk_register_pll(enum rockchip_pll_type pll_type,
 	init.parent_names = pll_parents;
 	init.num_parents = ARRAY_SIZE(pll_parents);
 
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
 	mux_clk = clk_register(NULL, &pll_mux->hw);
 	if (IS_ERR(mux_clk))
 		goto err_mux;
-- 
2.1.1
