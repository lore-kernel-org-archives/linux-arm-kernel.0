From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 20:59:56 +0100
Subject: [PATCH 2/2] clk: sunxi-ng: sun50i: a64: Add 2x fixed
 post-divider to MMC module clocks
In-Reply-To: <20171204051912.7485-3-wens@csie.org>
References: <20171204051912.7485-1-wens@csie.org>
 <20171204051912.7485-3-wens@csie.org>
Message-ID: <20171205195956.xdil2dsbtfwx35jj@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 04, 2017 at 01:19:12PM +0800, Chen-Yu Tsai wrote:
> On the A64, the MMC module clocks are fixed in the new timing mode,
> i.e. they do not have a bit to select the mode. These clocks have
> a 2x divider somewhere between the clock and the MMC module.
> 
> To be consistent with other SoCs supporting the new timing mode,
> we model the 2x divider as a fixed post-divider on the MMC module
> clocks.
> 
> This patch adds the post-dividers to the MMC clocks.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I had a doubt applying that one... sorry.

> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 57 +++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 2bb4cabf802f..ee9c12cf3f08 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -400,28 +400,45 @@ static SUNXI_CCU_MP_WITH_MUX_GATE(nand_clk, "nand", mod0_default_parents, 0x080,
>  				  BIT(31),	/* gate */
>  				  0);
>  
> +/*
> + * MMC clocks are the new timing mode (see A83T & H3) variety, but without
> + * the mode switch. This means they have a 2x post divider between the clock
> + * and the MMC module. This is not documented in the manual, but is taken
> + * into consideration when setting the mmc module clocks in the BSP kernel.
> + * Without it, MMC performance is degraded.
> + *
> + * We model it here to be consistent with other SoCs supporting this mode.
> + * The alternative would be to add the 2x multiplier when setting the MMC
> + * module clock in the MMC driver, just for the A64.
> + */
>  static const char * const mmc_default_parents[] = { "osc24M", "pll-periph0-2x",
>  						    "pll-periph1-2x" };
> -static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc_default_parents, 0x088,
> -				  0, 4,		/* M */
> -				  16, 2,	/* P */
> -				  24, 2,	/* mux */
> -				  BIT(31),	/* gate */
> -				  0);
> -
> -static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc_default_parents, 0x08c,
> -				  0, 4,		/* M */
> -				  16, 2,	/* P */
> -				  24, 2,	/* mux */
> -				  BIT(31),	/* gate */
> -				  0);
> -
> -static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc_default_parents, 0x090,
> -				  0, 4,		/* M */
> -				  16, 2,	/* P */
> -				  24, 2,	/* mux */
> -				  BIT(31),	/* gate */
> -				  0);
> +static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0",
> +					  mmc_default_parents, 0x088,
> +					  0, 4,		/* M */
> +					  16, 2,	/* P */
> +					  24, 2,	/* mux */
> +					  BIT(31),	/* gate */
> +					  2,		/* post-div */
> +					  0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1",
> +					  mmc_default_parents, 0x08c,
> +					  0, 4,		/* M */
> +					  16, 2,	/* P */
> +					  24, 2,	/* mux */
> +					  BIT(31),	/* gate */
> +					  2,		/* post-div */
> +					  0);
> +

Are you sure that the divider there for the non-eMMC clocks? Usually,
the new mode is only here for the eMMC, so we would divide the rate by
two in the non-eMMC case.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/db1f3f9f/attachment.sig>
