From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Aug 2016 14:26:34 +0200
Subject: [PATCH v6 3/8] clk: rockchip: rk3399: add ddrc clock support
In-Reply-To: <1471386989-9541-4-git-send-email-hl@rock-chips.com>
References: <1471386989-9541-1-git-send-email-hl@rock-chips.com>
 <1471386989-9541-4-git-send-email-hl@rock-chips.com>
Message-ID: <3094872.dpWUHq2nPG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. August 2016, 06:36:24 CEST schrieb Lin Huang:
> add ddrc clock setting, so we can do ddr frequency
> scaling on rk3399 platform in future.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v6:
> - None
> 
> Changes in v5:
> - fit for the ddr type
> 
> Changes in v4:
> - None
> 
> Changes in v3:
> - None
> 
> Changes in v2:
> - remove clk_ddrc_dpll_src from critical clock list
> 
> Changes in v1:
> - remove ddrc source CLK_IGNORE_UNUSED flag
> - move clk_ddrc and clk_ddrc_dpll_src to critical
> 
>  drivers/clk/rockchip/clk-rk3399.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3399.c
> b/drivers/clk/rockchip/clk-rk3399.c index e445cd6..01d4945 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -120,6 +120,10 @@ PNAME(mux_armclkb_p)				= { 
"clk_core_b_lpll_src",
>  						    "clk_core_b_bpll_src",
>  						    "clk_core_b_dpll_src",
>  						    "clk_core_b_gpll_src" };
> +PNAME(mux_ddrclk_p)				= { "clk_ddrc_lpll_src",
> +						    "clk_ddrc_bpll_src",
> +						    "clk_ddrc_dpll_src",
> +						    "clk_ddrc_gpll_src" };
>  PNAME(mux_aclk_cci_p)				= { "cpll_aclk_cci_src",
>  						    "gpll_aclk_cci_src",
>  						    "npll_aclk_cci_src",
> @@ -1379,6 +1383,18 @@ static struct rockchip_clk_branch
> rk3399_clk_branches[] __initdata = { COMPOSITE_NOMUX(0, "clk_test",
> "clk_test_pre", CLK_IGNORE_UNUSED, RK3368_CLKSEL_CON(58), 0, 5, DFLAGS,
>  			RK3368_CLKGATE_CON(13), 11, GFLAGS),
> +
> +	/* ddrc */
> +	GATE(0, "clk_ddrc_lpll_src", "lpll", 0, RK3399_CLKGATE_CON(3),
> +	     0, GFLAGS),
> +	GATE(0, "clk_ddrc_bpll_src", "bpll", 0, RK3399_CLKGATE_CON(3),
> +	     1, GFLAGS),
> +	GATE(0, "clk_ddrc_dpll_src", "dpll", 0, RK3399_CLKGATE_CON(3),
> +	     2, GFLAGS),
> +	GATE(0, "clk_ddrc_gpll_src", "gpll", 0, RK3399_CLKGATE_CON(3),
> +	     3, GFLAGS),
> +	COMPOSITE_DDRCLK(SCLK_DDRC, "clk_ddrc", mux_ddrclk_p, 0,

I think I'd like to have the clock also named sclk_ddrc :-)

Otherwise that looks fine


Heiko
