From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 05 Nov 2018 19:49:59 +0800
Subject: [PATCH] Revert "clk: sunxi-ng: sun50i: h6: Add 2x fixed
 post-divider to MMC module clocks"
In-Reply-To: <20181105105112.5631-1-icenowy@aosc.io>
References: <20181105105112.5631-1-icenowy@aosc.io>
Message-ID: <d95d8cc3dac2849821a0c1acd5efd488e745af18.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-11-05?? 18:51 +0800?Icenowy Zheng???
> This reverts commit c2ff8383cc33c2d9c169e4daf1e37a434c3bb420.
> 
> This commit seems to lead to eMMC instability on Pine H64 board, both
> model A and model B.

Sorry.

Please ignore this revert patch.

Commit 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC
controller") seems to fixed this issue on 4.20, so the issue only
appear when apply this patch onto 4.19, which is not a valid supported
situation.

> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 43 +++++++++++++-------------
> --
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> index 2193e1495086..d425b47cef17 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
> @@ -408,29 +408,26 @@ static SUNXI_CCU_GATE(bus_nand_clk, "bus-nand", 
> "ahb3", 0x82c, BIT(0), 0);
>  
>  static const char * const mmc_parents[] = { "osc24M", "pll-periph0-
> 2x",
>  					    "pll-periph1-2x" };
> -static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0",
> mmc_parents, 0x830,
> -					  0, 4,		/* M */
> -					  8, 2,		/* N */
> -					  24, 3,	/* mux */
> -					  BIT(31),	/* gate */
> -					  2,		/* post-div
> */
> -					  0);
> -
> -static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1",
> mmc_parents, 0x834,
> -					  0, 4,		/* M */
> -					  8, 2,		/* N */
> -					  24, 3,	/* mux */
> -					  BIT(31),	/* gate */
> -					  2,		/* post-div
> */
> -					  0);
> -
> -static SUNXI_CCU_MP_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2",
> mmc_parents, 0x838,
> -					  0, 4,		/* M */
> -					  8, 2,		/* N */
> -					  24, 3,	/* mux */
> -					  BIT(31),	/* gate */
> -					  2,		/* post-div
> */
> -					  0);
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc_parents,
> 0x830,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc_parents,
> 0x834,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
> +
> +static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc_parents,
> 0x838,
> +					0, 4,	/* M */
> +					8, 2,	/* N */
> +					24, 3,	/* mux */
> +					BIT(31),/* gate */
> +					0);
>  
>  static SUNXI_CCU_GATE(bus_mmc0_clk, "bus-mmc0", "ahb3", 0x84c,
> BIT(0), 0);
>  static SUNXI_CCU_GATE(bus_mmc1_clk, "bus-mmc1", "ahb3", 0x84c,
> BIT(1), 0);
