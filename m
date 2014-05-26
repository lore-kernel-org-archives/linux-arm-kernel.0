From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 26 May 2014 11:03:22 +0200
Subject: [PATCH] ARM: clk: imx: remove the CLK_SET_RATE_NO_REPARENT for
 imx_clk_mux_flags
In-Reply-To: <1401089474-14346-1-git-send-email-b32955@freescale.com>
References: <1401089474-14346-1-git-send-email-b32955@freescale.com>
Message-ID: <1401095002.3400.5.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 26.05.2014, 15:31 +0800 schrieb Huang Shijie:
> The clocks for Quadspi controller may be different when different
> NOR flashes are connected to the board.
> 
> But the CLK_SET_RATE_NO_REPARENT flag in the current imx_clk_mux_flags
> makes the clock do not have the re-parent capability.
> 
> This patch removes the CLK_SET_RATE_NO_REPARENT for imx_clk_mux_flags.
> It makes the Quadspi happy.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-imx/clk.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> index e29f6eb..32d6253 100644
> --- a/arch/arm/mach-imx/clk.h
> +++ b/arch/arm/mach-imx/clk.h
> @@ -108,8 +108,7 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
>  		int num_parents, unsigned long flags)
>  {
>  	return clk_register_mux(NULL, name, parents, num_parents,
> -			flags | CLK_SET_RATE_NO_REPARENT, reg, shift, width, 0,
> -			&imx_ccm_lock);
> +			flags, reg, shift, width, 0, &imx_ccm_lock);
>  }
>  
>  static inline struct clk *imx_clk_fixed_factor(const char *name,

We need CLK_SET_RATE_NO_REPARENT on the audio/video multiplexers.
I think this change is the right thing for imx_clk_mux_flags, but at the
same you should make sure not to drop this flag where we want to control
a video PLL through the mux.

regards
Philipp
