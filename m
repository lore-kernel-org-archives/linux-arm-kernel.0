From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Jun 2016 00:46:34 +0200
Subject: [PATCH] clk: rockchip: add flag CLK_SET_RATE_PARENT for
 dclk_vop0_div on RK3399
In-Reply-To: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
References: <1465724928-14611-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <2376423.L1zs1HaIGm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 12. Juni 2016, 17:48:48 schrieb Xing Zheng:
> The functions and features VOP0 more complete than VOP1's, we need to
> use it dclk_vop0_div operate VPLLI, and let VOP0 as the default primary
> screen.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
>  drivers/clk/rockchip/clk-rk3399.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3399.c
> b/drivers/clk/rockchip/clk-rk3399.c index 7ecb12c3..6affa75 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -1157,7 +1157,7 @@ static struct rockchip_clk_branch
> rk3399_clk_branches[] __initdata = { GATE(HCLK_VOP0_NOC, "hclk_vop0_noc",
> "hclk_vop0_pre", CLK_IGNORE_UNUSED, RK3399_CLKGATE_CON(28), 0, GFLAGS),
> 
> -	COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p, 0,
> +	COMPOSITE(DCLK_VOP0_DIV, "dclk_vop0_div", mux_pll_src_vpll_cpll_gpll_p,
> CLK_SET_RATE_PARENT, RK3399_CLKSEL_CON(49), 8, 2, MFLAGS, 0, 8, DFLAGS,
>  			RK3399_CLKGATE_CON(10), 12, GFLAGS),

The vpll is a possible source for multiple clocks (cci, aclk_vop0, dclk_vop0, 
clk_vop0_pwm, aclk_vop1, dclk_vop1, clk_vop1_pwm), so allowing one clock to 
hog the rate setting, might influence the other consumers of the vpll as well.
