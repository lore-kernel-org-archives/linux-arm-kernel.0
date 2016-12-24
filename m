From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 24 Dec 2016 03:18:29 +0100
Subject: [PATCH v2 4/4] clk: rockchip: add new pll-type for rk3328
In-Reply-To: <1482112573-11613-5-git-send-email-zhangqing@rock-chips.com>
References: <1482112573-11613-1-git-send-email-zhangqing@rock-chips.com>
 <1482112573-11613-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1864774.VdbssDBMbY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Montag, 19. Dezember 2016, 09:56:13 CET schrieb Elaine Zhang:
> The rk3328's pll and clock are similar with rk3036's,
> it different with pll_mode_mask,there are different
> control registers bit,
> so these should be independent and separate from
> the series of rk3328s.

not sure I understand this description. In the patch (and TRM excerpt) I see
that the number of parents is down to only xin24m but the general handling is
similar to the rk3036 and thus reuses its operations.

The description makes it sound like there are operational differences (the
"different control register bit" part), so could you clarify this a bit
please?

Also, please move the pll addition before the addition of the clock-controller
in the series and move the pll-type addition also here from the controller
patch.

Some more below:

> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk-pll.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 6ed605776abd..9650c75f61d1 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -29,6 +29,7 @@
>  #define PLL_MODE_SLOW		0x0
>  #define PLL_MODE_NORM		0x1
>  #define PLL_MODE_DEEP		0x2
> +#define PLL_RK3328_MODE_MASK	0x1
> 
>  struct rockchip_clk_pll {
>  	struct clk_hw		hw;
> @@ -865,13 +866,17 @@ struct clk *rockchip_clk_register_pll(struct
> rockchip_clk_provider *ctx, pll_mux = &pll->pll_mux;
>  	pll_mux->reg = ctx->reg_base + mode_offset;
>  	pll_mux->shift = mode_shift;
> -	pll_mux->mask = PLL_MODE_MASK;
> +	if (pll_type == pll_rk3328)
> +		pll_mux->mask = PLL_RK3328_MODE_MASK;
> +	else
> +		pll_mux->mask = PLL_MODE_MASK;

you're missing the other parts handling parents, like num_parents check
and the init.num_parents parameter.

The pll really has only one parent, xin24m, so we should handle this
correctly in the code, instead of having 2 times xin24m in the parent
array coming from the clock controller.

>  	pll_mux->flags = 0;
>  	pll_mux->lock = &ctx->lock;
>  	pll_mux->hw.init = &init;
> 
>  	if (pll_type == pll_rk3036 ||
>  	    pll_type == pll_rk3066 ||
> +	    pll_type == pll_rk3328 ||
>  	    pll_type == pll_rk3399)
>  		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
> 
> @@ -929,6 +934,12 @@ struct clk *rockchip_clk_register_pll(struct
> rockchip_clk_provider *ctx, else
>  			init.ops = &rockchip_rk3066_pll_clk_ops;
>  		break;
> +	case pll_rk3328:
> +		if (!pll->rate_table || IS_ERR(ctx->grf))
> +			init.ops = &rockchip_rk3036_pll_clk_norate_ops;
> +		else
> +			init.ops = &rockchip_rk3036_pll_clk_ops;
> +		break;

please don't duplicate the rk3036-ops assignment, when adding the
pll_rk3328 option to the rk3036 part suffices.

I'd think the pll-patch should look something like the
following (untested, so please test):
--------------- 8< -----------------
Subject: [PATCH] clk: rockchip: add new pll-type for rk3328

The rk3328's pll and clock are similar with rk3036's,
it different with pll_mode_mask,there are different
control registers bit,
so these should be independent and separate from
the series of rk3328s.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-pll.c | 18 ++++++++++++++----
 drivers/clk/rockchip/clk.h     |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 6ed6057..99ce483 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -29,6 +29,7 @@
 #define PLL_MODE_SLOW		0x0
 #define PLL_MODE_NORM		0x1
 #define PLL_MODE_DEEP		0x2
+#define PLL_RK3328_MODE_MASK	0x1
 
 struct rockchip_clk_pll {
 	struct clk_hw		hw;
@@ -848,8 +849,9 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	struct clk *pll_clk, *mux_clk;
 	char pll_name[20];
 
-	if (num_parents != 2) {
-		pr_err("%s: needs two parent clocks\n", __func__);
+	if ((pll_type != pll_rk3328 && num_parents != 2) ||
+	    (pll_type == pll_rk3328 && num_parents != 1)) {
+		pr_err("%s: missing parent clocks\n", __func__);
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
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index d67eecc..06acb7e 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -130,6 +130,7 @@ struct clk;
 enum rockchip_pll_type {
 	pll_rk3036,
 	pll_rk3066,
+	pll_rk3328,
 	pll_rk3399,
 };
 
-- 
2.10.2

--------------- 8< -----------------
