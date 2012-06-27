From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 13:03:57 +0200
Subject: [PATCH v2] clk: Add support for rate table based dividers
In-Reply-To: <1340794893-20869-1-git-send-email-rnayak@ti.com>
References: <1340794893-20869-1-git-send-email-rnayak@ti.com>
Message-ID: <4FEAE89D.3090702@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2012 01:01 PM, Rajendra Nayak wrote:
> Some divider clks do not have any obvious relationship
> between the divider and the value programmed in the
> register. For instance, say a value of 1 could signify divide
> by 6 and a value of 2 could signify divide by 4 etc.
> Also there are dividers where not all values possible
> based on the bitfield width are valid. For instance
> a 3 bit wide bitfield can be used to program a value
> from 0 to 7. However its possible that only 0 to 4
> are valid values.
> 
> All these cases need the platform code to pass a simple
> table of divider/value tuple, so the framework knows
> the exact value to be written based on the divider
> calculation and can also do better error checking.
> 
> This patch adds support for such rate table based
> dividers.
> 
> Also since this means adding a new parameter to the
> clk_register_divider(), update all existing users of
> it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> ---
>  arch/arm/mach-imx/clk.h            |    2 +-
>  drivers/clk/clk-divider.c          |   67 ++++++++++++++++++++++++++++++++++--
>  drivers/clk/spear/spear3xx_clock.c |    4 +-
>  drivers/clk/spear/spear6xx_clock.c |    4 +-
>  include/linux/clk-private.h        |    3 +-
>  include/linux/clk-provider.h       |   10 +++++-
>  6 files changed, 80 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
> index 1bf64fe..8cb6f97 100644
> --- a/arch/arm/mach-imx/clk.h
> +++ b/arch/arm/mach-imx/clk.h
> @@ -56,7 +56,7 @@ static inline struct clk *imx_clk_divider(const char *name, const char *parent,
>  		void __iomem *reg, u8 shift, u8 width)
>  {
>  	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
> -			reg, shift, width, 0, &imx_ccm_lock);
> +			reg, shift, width, 0, , NULL, &imx_ccm_lock);
                                           ^^^^^

Is this valid C-Syntax?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
