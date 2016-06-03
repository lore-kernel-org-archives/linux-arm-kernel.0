From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 03 Jun 2016 14:56:58 +0200
Subject: [RFC PATCH v1 3/6] clk: rockchip: rk3399: add ddrc clock support
In-Reply-To: <1464947719-6245-4-git-send-email-hl@rock-chips.com>
References: <1464947719-6245-1-git-send-email-hl@rock-chips.com>
 <1464947719-6245-4-git-send-email-hl@rock-chips.com>
Message-ID: <13084747.Amq298iRsd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 3. Juni 2016, 17:55:16 schrieb Lin Huang:
> add ddrc clock setting, so we can do ddr frequency
> scaling on rk3399 platform in future.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v1:
> - remove ddrc source CLK_IGNORE_UNUSED flag, Suggestion by Doug
> - move clk_ddrc and clk_ddrc_dpll_src to critical, Suggestion by Doug
> 
>  drivers/clk/rockchip/clk-rk3399.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3399.c
> b/drivers/clk/rockchip/clk-rk3399.c index f1d8e44..29afb88 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c

[...]

> @@ -1377,6 +1381,18 @@ static struct rockchip_clk_branch
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
> +	COMPOSITE_DDRC(SCLK_DDRCLK, "clk_ddrc", mux_ddrclk_p, 0,
> +		       RK3399_CLKSEL_CON(6), 4, 2, MFLAGS, 0, 3, DFLAGS),
>  };

as said in the other patch, just make this a regular COMPOSITE_NOGATE with 
CLK_DIVIDER_READ_ONLY | CLK_MUX_READ_ONLY until that interface to the ATF 
exists and is approved.

That way you can still read back the clock rate without anything changing the 
clock-rate, but we don't need to add duplicate code for it.


> 
>  static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
> @@ -1487,6 +1503,10 @@ static const char *const rk3399_cru_critical_clocks[]
> __initconst = { "gpll_hclk_perilp1_src",
>  	"gpll_aclk_perilp0_src",
>  	"gpll_aclk_perihp_src",
> +
> +	/* ddrc */
> +	"clk_ddrc_dpll_src",

Why does your clk_ddrc_dpll_src need a separate critical entry. Any code 
changing the clk_ddrc parent should make sure the new parent is enabled. (The 
clock-framework of course does this already).


> +	"clk_ddrc",
>  };
> 
>  static const char *const rk3399_pmucru_critical_clocks[] __initconst = {


Heiko
