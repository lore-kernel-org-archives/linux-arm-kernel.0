From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 26 Nov 2014 19:09:05 +0100
Subject: [PATCH] clk: rockchip: rk3288 export i2s0_clkout for use in DT
In-Reply-To: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
References: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
Message-ID: <13759993.X1UzQR0utx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sonny,

Am Dienstag, 18. November 2014, 23:15:19 schrieb Sonny Rao:
> This exposes the clock that comes out of the i2s block which generally
> goes to the audio codec.
> 
> Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3288.c      | 3 ++-
>  include/dt-bindings/clock/rk3288-cru.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index 2327829..8777737 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -305,7 +305,8 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
> __initdata = { RK3288_CLKGATE_CON(4), 2, GFLAGS),
>  	MUX(0, "i2s_pre", mux_i2s_pre_p, CLK_SET_RATE_PARENT,
>  			RK3288_CLKSEL_CON(4), 8, 2, MFLAGS),
> -	COMPOSITE_NODIV(0, "i2s0_clkout", mux_i2s_clkout_p, CLK_SET_RATE_PARENT,
> +	COMPOSITE_NODIV(SCLK_I2S0_OUT, "i2s0_clkout", mux_i2s_clkout_p,
> +			CLK_SET_RATE_PARENT,

this patch fails to apply, as the current i2s_clkout definition does not have 
the CLK_SET_RATE_PARENT yet. I'm not sure if I missed a patch somewhere but my 
search in my inbox for _not yet handled_ patches has come up empty so far.

But having CLK_SET_RATE_PARENT there will probably cause problems anyway.
i2s0_clkout is sourced by either i2s_pre or xin12m. i2s_pre also is the source 
for the core SCLK_I2S0 going to the i2s controller. So having both SCLK_I2S0 
and (the new) SCLK_I2S0_OUT fiddling with the i2s_pre rate calls for trouble.

So I think the i2s0_clkout should limit itself to selecting the best frequency 
from its sources without changing i2s_pre.


And a personal style nitpick: the macros are laid out in a way to facilitate 
ease of reading by for example always having the same number of lines per 
COMPOSITE definition and having each element in roughly the same place. So a 
CLK_SET_RATE_PARENT param should stay on the first line :-) .


Heiko
