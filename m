From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 13 Aug 2015 09:57:24 +0200
Subject: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to
 clk_hw_get_name(hw)
In-Reply-To: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
 <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <1489587.uKDjVe3x3J@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 12. August 2015, 16:12:41 schrieb Stephen Boyd:
> Use the provider based method to get a clock's name so that we
> can get rid of the clk member in struct clk_hw one day. Mostly
> converted with the following coccinelle script.
> 
> @@
> struct clk_hw *E;
> @@
> 
> -__clk_get_name(E->clk)
> +clk_hw_get_name(E)
> 

For the Rockchip part
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko

> diff --git a/drivers/clk/rockchip/clk-inverter.c
> b/drivers/clk/rockchip/clk-inverter.c index 8054fdb5effb..7cbf43beb3c6
> 100644
> --- a/drivers/clk/rockchip/clk-inverter.c
> +++ b/drivers/clk/rockchip/clk-inverter.c
> @@ -50,7 +50,7 @@ static int rockchip_inv_set_phase(struct clk_hw *hw, int
> degrees) val = !!degrees;
>  	} else {
>  		pr_err("%s: unsupported phase %d for %s\n",
> -		       __func__, degrees, __clk_get_name(hw->clk));
> +		       __func__, degrees, clk_hw_get_name(hw));
>  		return -EINVAL;
>  	}
> 
> diff --git a/drivers/clk/rockchip/clk-mmc-phase.c
> b/drivers/clk/rockchip/clk-mmc-phase.c index 77e19097bdc7..9b613426e968
> 100644
> --- a/drivers/clk/rockchip/clk-mmc-phase.c
> +++ b/drivers/clk/rockchip/clk-mmc-phase.c
> @@ -108,7 +108,7 @@ static int rockchip_mmc_set_phase(struct clk_hw *hw, int
> degrees) writel(HIWORD_UPDATE(raw_value, 0x07ff, mmc_clock->shift),
> mmc_clock->reg);
> 
>  	pr_debug("%s->set_phase(%d) delay_nums=%u reg[0x%p]=0x%03x
> actual_degrees=%d\n", -		__clk_get_name(hw->clk), degrees, delay_num,
> +		clk_hw_get_name(hw), degrees, delay_num,
>  		mmc_clock->reg, raw_value>>(mmc_clock->shift),
>  		rockchip_mmc_get_phase(hw)
>  	);
