From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 13 Apr 2015 10:10:37 +0200
Subject: [PATCH] ARM: socfpga: dts: Add a ciu clock node for sdmmc
In-Reply-To: <1428699386-2622-1-git-send-email-dinguyen@opensource.altera.com>
References: <1428699386-2622-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <73wq1g30ua.fsf@unicorn.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi!

dinguyen at opensource.altera.com writes:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> The CIU(Card Interface Unit) clock is used by the dw_mmc IP to clock an SD
> card. The ciu_clk is the sdmmc_clk passed through a fixed divider of 4. This patch
> adds the ciu_clk node and makes the sdmmc_clk it's parent.
>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index d9176e6..25418ee 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -451,6 +451,14 @@
>  						clk-phase = <0 135>;
>  					};
>  
> +					ciu_clk: ciu_clk {
> +						#clock-cells = <0>;
> +						compatible = "altr,socfpga-gate-clk";
> +						clocks = <&sdmmc_clk>;
> +						clk-gate = <0xa0 8>;
> +						fixed-divider = <4>;
> +					};
> +

Hm, is this correct? The clk-gate at 0xa0 is for the SDMMC_CLK, no?
Also, maybe the clock should be named "sdmmc_clk_divided" like in the
datasheet, so it is easier to find.

>  					nand_x_clk: nand_x_clk {
>  						#clock-cells = <0>;
>  						compatible = "altr,socfpga-gate-clk";
> @@ -635,7 +643,7 @@
>  			fifo-depth = <0x400>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			clocks = <&l4_mp_clk>, <&sdmmc_clk>;
> +			clocks = <&l4_mp_clk>, <&ciu_clk>;
>  			clock-names = "biu", "ciu";
>  		};
>  

Regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
