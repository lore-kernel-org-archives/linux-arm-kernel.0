From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 4 Dec 2017 23:18:15 +0000
Subject: [linux-sunxi] [PATCH 2/2] clk: sunxi-ng: sun50i: a64: Add 2x
 fixed post-divider to MMC module clocks
In-Reply-To: <20171204051912.7485-3-wens@csie.org>
References: <20171204051912.7485-1-wens@csie.org>
 <20171204051912.7485-3-wens@csie.org>
Message-ID: <d39b26fb-8d8c-1a97-2b36-ae6a365e29ca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/17 05:19, Chen-Yu Tsai wrote:
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

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

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
> +static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2",
> +					  mmc_default_parents, 0x090,
> +					  0, 4,		/* M */
> +					  16, 2,	/* P */
> +					  24, 2,	/* mux */
> +					  BIT(31),	/* gate */
> +					  2,		/* post-div */
> +					  0);
>  
>  static const char * const ts_parents[] = { "osc24M", "pll-periph0", };
>  static SUNXI_CCU_MP_WITH_MUX_GATE(ts_clk, "ts", ts_parents, 0x098,
> 
