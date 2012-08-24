From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 16:00:55 +0800
Subject: [PATCH 1/2] ARM: mx28: Add SPI pinmux into imx28.dtsi
In-Reply-To: <1345778742-20994-1-git-send-email-marex@denx.de>
References: <1345778742-20994-1-git-send-email-marex@denx.de>
Message-ID: <20120824080052.GD31998@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 05:25:41AM +0200, Marek Vasut wrote:
> Add this SSP pin multiplexing configuration into the imx28.dtsi file.
> This covers pinmux for all four SSP ports available on the i.MX28.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   61 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> NOTE: Shawn, I'd like to add this altogether. I have a board scheduled in my
>       queue that uses other SSP ports, so I consider it pointless to split this.

No.  Please only add the one you're using and testing with.  I do not
want to have any unneeded and untested settings there.

>       Fabio, what does MX28EVK use?
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 91b43e9..327a33f 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -507,6 +507,67 @@
>  					fsl,voltage = <1>;
>  					fsl,pull-up = <0>;
>  				};
> +
> +				spi0_pins_a: spi0 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2000 /* MX28_PAD_SSP0_DATA0__SSP0_D0 */
> +						0x2010 /* MX28_PAD_SSP0_DATA1__SSP0_D1 */
> +						0x2020 /* MX28_PAD_SSP0_DATA2__SSP0_D2 */
> +						0x2030 /* MX28_PAD_SSP0_DATA3__SSP0_D3 */
> +						0x2040 /* MX28_PAD_SSP0_DATA4__SSP0_D4 */
> +						0x2050 /* MX28_PAD_SSP0_DATA5__SSP0_D5 */
> +						0x2060 /* MX28_PAD_SSP0_DATA6__SSP0_D6 */
> +						0x2070 /* MX28_PAD_SSP0_DATA7__SSP0_D7 */
> +						0x2080 /* MX28_PAD_SSP0_CMD__SSP0_CMD */
> +						0x2090 /* MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT */
> +						0x20a0 /* MX28_PAD_SSP0_SCK__SSP0_SCK */
> +					>;

You have a SPI connection that needs so many pins?  Please note that
we already have mmc pins setup in place.

> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi1_pins_a: spi1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x20c0 /* MX28_PAD_SSP1_SCK__SSP1_SCK */
> +						0x20d0 /* MX28_PAD_SSP1_CMD__SSP1_CMD */
> +						0x20e0 /* MX28_PAD_SSP1_DATA0__SSP1_D0 */
> +						0x20f0 /* MX28_PAD_SSP1_DATA3__SSP1_D3 */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi2_pins_a: spi2 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2100 /* MX28_PAD_SSP2_SCK__SSP2_SCK */
> +						0x2110 /* MX28_PAD_SSP2_MOSI__SSP2_CMD */
> +						0x2120 /* MX28_PAD_SSP2_MISO__SSP2_D0 */
> +						0x2130 /* MX28_PAD_SSP2_SS0__SSP2_D3 */
> +						0x2140 /* MX28_PAD_SSP2_SS1__SSP2_D4 */
> +						0x2150 /* MX28_PAD_SSP2_SS2__SSP2_D5 */
> +					>;

The SPI flash on imx28-evk uses this one but with only SS0.  So we will
probably need to have the group only define SS0 and set up the extra SS
in board's hog node, so that the group can be shared across more boards.
Or, we name the group spi2_3cs_pins_a and leave the name spi2_pins_a to
the more general case, one SS?

Regards,
Shawn

> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
> +				spi3_pins_a: spi3 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2180 /* MX28_PAD_SSP3_SCK__SSP3_SCK */
> +						0x2190 /* MX28_PAD_SSP3_MOSI__SSP3_CMD */
> +						0x21a0 /* MX28_PAD_SSP3_MISO__SSP3_D0 */
> +						0x21b0 /* MX28_PAD_SSP3_SS0__SSP3_D3 */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
>  			};
>  
>  			digctl at 8001c000 {
> -- 
> 1.7.10.4
> 
