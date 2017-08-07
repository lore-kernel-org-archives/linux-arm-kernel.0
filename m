From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 08 Aug 2017 00:57:45 +0200
Subject: [PATCH v2 06/23] clk: rockchip: support more clks for rv1108
In-Reply-To: <1501662837-12029-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
 <1501662837-12029-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <11738434.oWbxbgkgjP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Mittwoch, 2. August 2017, 16:33:57 CEST schrieb Andy Yan:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Added the description of the missing clock,
> make the clock tree more complete.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

[...]

>  	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
>  
> -	COMPOSITE(0, "i2s0_src", mux_pll_src_2plls_p, 0,
> +	/* PD_BUS */
> +	GATE(0, "aclk_bus_src_gpll", "gpll", CLK_IGNORE_UNUSED,
> +			RV1108_CLKGATE_CON(1), 0, GFLAGS),
> +	GATE(0, "aclk_bus_src_apll", "apll", CLK_IGNORE_UNUSED,
> +			RV1108_CLKGATE_CON(1), 1, GFLAGS),
> +	GATE(0, "aclk_bus_src_dpll", "dpll", CLK_IGNORE_UNUSED,
> +			RV1108_CLKGATE_CON(1), 2, GFLAGS),
> +	COMPOSITE_NOGATE(ACLK_PRE, "aclk_bus_pre", mux_aclk_bus_src_p, 0,
> +			RV1108_CLKSEL_CON(2), 8, 2, MFLAGS, 0, 5, DFLAGS),
> +	COMPOSITE_NOMUX(HCLK_BUS, "hclk_bus_pre", "aclk_bus_pre", 0,
> +			RV1108_CLKSEL_CON(3), 0, 5, DFLAGS,
> +			RV1108_CLKGATE_CON(1), 4, GFLAGS),

you're adding a (new / second) hclk_bus_pre here, but only drop the
old in patch 7. Please structure patch-contents in a way that each patch
is self-contained and works on its own ... aka the clock tree should not
get worse if only patch 6 is applied (like in a random git bisect), but
here the state is bad between these 2 patches.

hclk_bus_pre also is only _one_ example and there are probably more of
those hiding in these clock patches. So please fix these issues.


Thanks
Heiko
