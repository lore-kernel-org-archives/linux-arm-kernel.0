From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 09 Mar 2016 02:22:50 +0100
Subject: [RESEND PATCH v2 3/5] clk: rockchip: add new pll-type for rk3399
 and similar socs
In-Reply-To: <1456827275-8035-4-git-send-email-zhengxing@rock-chips.com>
References: <1456827275-8035-1-git-send-email-zhengxing@rock-chips.com>
 <1456827275-8035-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <3286748.Col0jAfKKX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. M?rz 2016, 18:14:33 schrieb Xing Zheng:
> The rk3399's pll and clock are similar with rk3036's, it different
> with base on the rk3066(rk3188, rk3288, rk3368 use it), there are
> different adjust foctors and control registers, so these should be
> independent and separate from the series of rk3066s.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>

[...]

> +static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
> +				const struct rockchip_pll_rate_table *rate)
> +{
> +	const struct clk_ops *pll_mux_ops = pll->pll_mux_ops;
> +	struct clk_mux *pll_mux = &pll->pll_mux;
> +	struct rockchip_pll_rate_table cur;
> +	u32 pllcon;
> +	int rate_change_remuxed = 0;
> +	int cur_parent;
> +	int ret;
> +
> +	pr_debug("%s: rate settings for %lu fbdiv: %d, postdiv1: %d, refdiv: %d,
> postdiv2: %d, dsmpd: %d, frac: %d\n", +		__func__, rate->rate,
> rate->fbdiv, rate->postdiv1, rate->refdiv, +		rate->postdiv2,
> rate->dsmpd, rate->frac);
> +
> +	rockchip_rk3399_pll_get_params(pll, &cur);
> +	cur.rate = 0;
> +
> +	cur_parent = pll_mux_ops->get_parent(&pll_mux->hw);
> +	if (cur_parent == PLL_MODE_NORM) {
> +		pll_mux_ops->set_parent(&pll_mux->hw, PLL_MODE_SLOW);
> +		rate_change_remuxed = 1;
> +	}
> +
> +	/* update pll values */
> +	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3399_PLLCON0_FBDIV_MASK,
> +					  RK3399_PLLCON0_FBDIV_SHIFT),

indentation is strange ... I guess the plan was to move 
RK3399_PLLCON0_FBDIV_SHIFT under RK3399_PLLCON0_FBDIV_MASK, currently it's 
having tabs + spaces but has no alignment whatsoever

> +		       pll->reg_base + RK3399_PLLCON(0));
> +
> +	writel_relaxed(HIWORD_UPDATE(rate->refdiv, RK3399_PLLCON1_REFDIV_MASK,
> +						   RK3399_PLLCON1_REFDIV_SHIFT) |
> +		       HIWORD_UPDATE(rate->postdiv1, RK3399_PLLCON1_POSTDIV1_MASK,
> +					     RK3399_PLLCON1_POSTDIV1_SHIFT) |

same for postdiv1

> +		       HIWORD_UPDATE(rate->postdiv2, RK3399_PLLCON1_POSTDIV2_MASK,
> +						     RK3399_PLLCON1_POSTDIV2_SHIFT),
> +		       pll->reg_base + RK3399_PLLCON(1));


rest looks nice


Heiko
