From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 May 2014 16:01:21 +0800
Subject: [PATCH 1/2] ARM: clk: imx: add a new helper which can re-parent
 the clock
In-Reply-To: <1401081633-12190-1-git-send-email-b32955@freescale.com>
References: <1401081633-12190-1-git-send-email-b32955@freescale.com>
Message-ID: <20140526080120.GE2650@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 01:20:32PM +0800, Huang Shijie wrote:
> The clocks for Quadspi controller may be different when different
> NOR flashes are connected to the board.
> 
> This patch adds a new helper to register the clock which needs the
> re-parent capability.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

So what you need is to register a mux clock without
CLK_SET_RATE_NO_REPARENT flag, right?

I'm think about just dropping the flag from imx_clk_mux() and
imx_clk_mux_flags(), since this is the default behavior of basic mux
clock, and I doubt dropping the flag will cause problem for mux clocks
on i.MX.

Shawn

> ---
>  arch/arm/mach-imx/clk.h |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> index e29f6eb..2e3c4fe 100644
> --- a/arch/arm/mach-imx/clk.h
> +++ b/arch/arm/mach-imx/clk.h
> @@ -112,6 +112,16 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
>  			&imx_ccm_lock);
>  }
>  
> +/* we can use this helper to register the clock which needs the re-parent. */
> +static inline struct clk *imx_clk_mux_flags_reparent(const char *name,
> +		void __iomem *reg, u8 shift, u8 width, const char **parents,
> +		int num_parents, unsigned long flags)
> +{
> +	return clk_register_mux(NULL, name, parents, num_parents,
> +			flags, reg, shift, width, 0,
> +			&imx_ccm_lock);
> +}
> +
>  static inline struct clk *imx_clk_fixed_factor(const char *name,
>  		const char *parent, unsigned int mult, unsigned int div)
>  {
> -- 
> 1.7.8
> 
