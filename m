From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 09 Mar 2016 13:29:09 +0100
Subject: [PATCH v3 5/7] clk: rockchip: add new pll-type for rk3399 and
 similar socs
In-Reply-To: <1457491378-31077-1-git-send-email-zhengxing@rock-chips.com>
References: <1457491027-30936-1-git-send-email-zhengxing@rock-chips.com>
 <1457491378-31077-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2688473.EyteJL2oqe@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

Am Mittwoch, 9. M?rz 2016, 10:42:58 schrieb Xing Zheng:
> The rk3399's pll and clock are similar with rk3036's, it different
> with base on the rk3066(rk3188, rk3288, rk3368 use it), there are
> different adjust foctors and control registers, so these should be
> independent and separate from the series of rk3066s.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/clk/rockchip/clk-pll.c |  279
> +++++++++++++++++++++++++++++++++++++++- drivers/clk/rockchip/clk.h     |  
>  3 +-
>  2 files changed, 280 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 27be66a..62d2f0e 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -593,6 +593,275 @@ static const struct clk_ops
> rockchip_rk3066_pll_clk_ops = { .init = rockchip_rk3066_pll_init,
>  };
> 
> +/**
> + * PLL used in RK3399
> + */
> +
> +#define RK3399_PLLCON(i)			(i * 0x4)
> +#define RK3399_PLLCON0_FBDIV_MASK		0xfff
> +#define RK3399_PLLCON0_FBDIV_SHIFT		0
> +#define RK3399_PLLCON1_REFDIV_MASK		0x3f
> +#define RK3399_PLLCON1_REFDIV_SHIFT		0
> +#define RK3399_PLLCON1_POSTDIV1_MASK		0x7
> +#define RK3399_PLLCON1_POSTDIV1_SHIFT		8
> +#define RK3399_PLLCON1_POSTDIV2_MASK		0x7
> +#define RK3399_PLLCON1_POSTDIV2_SHIFT		12
> +#define RK3399_PLLCON2_FRAC_MASK		0xffffff
> +#define RK3399_PLLCON2_FRAC_SHIFT		0
please move RK3399_PLLCON2_LOCK_STATUS here

> +#define RK3399_PLLCON3_DSMPD_MASK		0x1
> +#define RK3399_PLLCON3_DSMPD_SHIFT		12

DSMPD_SHIFT should be 3, right?

> +
> +#define RK3399_PLLCON2_LOCK_STATUS		(31 << 0)

that is wrong, you want (1 << 31), or even better BIT(31) here


> +#define RK3399_PLLCON3_PWRDOWN			(1 << 0)

dito, BIT(0) please

[...]

> +static int rockchip_rk3399_pll_set_rate(struct clk_hw *hw, unsigned long
> drate, +					unsigned long prate)
> +{
> +	struct rockchip_clk_pll *pll = to_rockchip_clk_pll(hw);
> +	const struct rockchip_pll_rate_table *rate;
> +	unsigned long old_rate = rockchip_rk3399_pll_recalc_rate(hw, prate);
> +	struct regmap *grf = rockchip_clk_get_grf(pll->ctx);
> +
> +	if (IS_ERR(grf)) {
> +		pr_debug("%s: grf regmap not available, aborting rate change\n",
> +			 __func__);
> +		return PTR_ERR(grf);
> +	}

the pll lock-status moved to the pll registers it seems, so you don't need to 
get the GRF here at all, as we don't need it for the lock status.


Heiko
