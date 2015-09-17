From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 11:54:22 +0200
Subject: [PATCH v2 4/9] clk: rockchip: add new clock type and controller
 for rk3036
In-Reply-To: <1442478540-15068-5-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442478540-15068-5-git-send-email-zhengxing@rock-chips.com>
Message-ID: <3322893.NNLQYMkRea@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag, 17. September 2015, 16:28:55 schrieb Xing Zheng:
> The rk3036's pll and clock are different with base on the rk3066(rk3188,
> rk3288, rk3368 use it), there are different adjust foctors and control
> registers, so these should be independent and separate from the series
> of rk3066s.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/clk/rockchip/clk-pll.c |  262
> +++++++++++++++++++++++++++++++++++++++- 1 file changed, 261 insertions(+),
> 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
> index 7737a1d..25b066a 100644
> --- a/drivers/clk/rockchip/clk-pll.c
> +++ b/drivers/clk/rockchip/clk-pll.c
> @@ -2,6 +2,9 @@
>   * Copyright (c) 2014 MundoReader S.L.
>   * Author: Heiko Stuebner <heiko@sntech.de>
>   *
> + * Copyright (c) 2015 Rockchip Electronics Co. Ltd.
> + * Author: Xing Zheng <zhengxing@rock-chips.com>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -19,6 +22,7 @@
>  #include <linux/delay.h>
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
> +#include <linux/clk.h>
>  #include "clk.h"
> 
>  #define PLL_MODE_MASK		0x3
> @@ -306,6 +310,256 @@ static void rockchip_rk3066_pll_init(struct clk_hw
> *hw) }
>  }
> 
> +/**
> + * PLL used in RK3036
> + */
> +
> +#define RK3036_PLLCON(i)			(i * 0x4)
> +#define RK3036_PLLCON0_FBDIV_MASK		0xfff
> +#define RK3036_PLLCON0_FBDIV_SHIFT		0
> +#define RK3036_PLLCON0_POSTDIV1_MASK		0x7
> +#define RK3036_PLLCON0_POSTDIV1_SHIFT		12
> +#define RK3036_PLLCON1_REFDIV_MASK		0x3f
> +#define RK3036_PLLCON1_REFDIV_SHIFT		0
> +#define RK3036_PLLCON1_POSTDIV2_MASK		0x7
> +#define RK3036_PLLCON1_POSTDIV2_SHIFT		6
> +#define RK3036_PLLCON1_DSMPD_MASK		0x1
> +#define RK3036_PLLCON1_DSMPD_SHIFT		12
> +#define RK3036_PLLCON2_FRAC_MASK		0xffffff
> +#define RK3036_PLLCON2_FRAC_SHIFT		0
> +
> +#define RK3036_PLLCON1_PWRDOWN			(1 << 13)
> +#define RK3036_PLLCON1_LOCK_STATUS		(1 << 10)
> +
> +static int rockchip_rk3036_pll_wait_lock(struct rockchip_clk_pll *pll)
> +{
> +	u32 pllcon;
> +	int delay = 24000000;
> +
> +	/* poll check the lock status in rk3036 xPLLCON1 */
> +	while (delay > 0) {
> +		pllcon = readl_relaxed(pll->reg_base + RK3036_PLLCON(1));
> +		if (pllcon & RK3036_PLLCON1_LOCK_STATUS)
> +			return 0;
> +
> +		delay--;
> +	}
> +
> +	pr_err("%s: timeout waiting for pll to lock\n", __func__);
> +	return -ETIMEDOUT;
> +}

Just saw that you responded to this in the v1 thread.

I don't necessarily object to this new lock function ... but if both the 
PLLCON1 and GRF_SOC_STATUS0 register provide the same information, I'd prefer 
to use the already existing solution.

[...]

> @@ -363,7 +617,7 @@ struct clk *rockchip_clk_register_pll(enum
> rockchip_pll_type pll_type, pll_mux->lock = lock;
>  	pll_mux->hw.init = &init;
> 
> -	if (pll_type == pll_rk3066)
> +	if (pll_type == pll_rk3066 || pll_type == pll_rk3036)

ordering please :-) (3036 before 3066)

>  		pll_mux->flags |= CLK_MUX_HIWORD_MASK;
> 
>  	/* the actual muxing is xin24m, pll-output, xin32k */
> @@ -414,6 +668,12 @@ struct clk *rockchip_clk_register_pll(enum
> rockchip_pll_type pll_type, else
>  			init.ops = &rockchip_rk3066_pll_clk_ops;
>  		break;
> +	case pll_rk3036:
> +		if (!pll->rate_table)
> +			init.ops = &rockchip_rk3036_pll_clk_norate_ops;
> +		else
> +			init.ops = &rockchip_rk3036_pll_clk_ops;
> +		break;

same here, 3036 before 3066 please


>  	default:
>  		pr_warn("%s: Unknown pll type for pll clk %s\n",
>  			__func__, name);


apart from these small issues, this looks great :-)


Thanks
Heiko
