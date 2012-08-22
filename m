From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Aug 2012 11:24:13 +0800
Subject: [PATCH] ARM: olinuxino: Add gpio-led support
In-Reply-To: <1345513396-12320-1-git-send-email-festevam@gmail.com>
References: <1345513396-12320-1-git-send-email-festevam@gmail.com>
Message-ID: <20120822032409.GQ24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 10:43:15PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Olinuxino has a LED connected to MX23_PAD_SSP1_DETECT__GPIO_2_1 pin.
> 
> Since mmc0_4bit_pins_a defines MX23_PAD_SSP1_DETECT as SSP function, create
> a new mmc0_4bit_pins_b.
> 

mmc0_4bit_pins_b should be used where there is same number of pins in
the group as mmc0_4bit_pins_a but with a different pinmux option.

I think we drop MX23_PAD_SSP1_DETECT__SSP1_DETECT from mmc0_4bit_pins_a
and change the current mmc0_4bit_pins_a users to have it set up in hog,
so that mmc0_4bit_pins_a becomes more generic.

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx23-olinuxino.dts |   28 +++++++++++++++++++++++++++-
>  arch/arm/boot/dts/imx23.dtsi          |   15 +++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
> index a286873..dece3fe 100644
> --- a/arch/arm/boot/dts/imx23-olinuxino.dts
> +++ b/arch/arm/boot/dts/imx23-olinuxino.dts
> @@ -27,10 +27,25 @@
>  			ssp0: ssp at 80010000 {
>  				compatible = "fsl,imx23-mmc";
>  				pinctrl-names = "default";
> -				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
> +				pinctrl-0 = <&mmc0_4bit_pins_b &mmc0_pins_fixup>;
>  				bus-width = <4>;
>  				status = "okay";
>  			};
> +
> +			pinctrl at 80018000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&hog_pins_a>;
> +
> +				hog_pins_a: hog-gpios at 0 {

I suggest to have it be:

				hog_pins: hog at 0 {

because I see we will probably need to set up some non-gpio pins here
too.

-- 
Regards,
Shawn

> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
> +					>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +			};
>  		};
>  
>  		apbx at 80040000 {
> @@ -47,4 +62,15 @@
>  			};
>  		};
>  	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		user {
> +			label = "green";
> +			gpios = <&gpio2 1 0>;
> +			linux,default-trigger = "default-on";
> +			default-state = "on";
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 9700872..a8b423a 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -202,6 +202,21 @@
>  					fsl,pull-up = <1>;
>  				};
>  
> +				mmc0_4bit_pins_b: mmc0-4bit_b at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <
> +						0x2020 /* MX23_PAD_SSP1_DATA0__SSP1_DATA0 */
> +						0x2030 /* MX23_PAD_SSP1_DATA1__SSP1_DATA1 */
> +						0x2040 /* MX23_PAD_SSP1_DATA2__SSP1_DATA2 */
> +						0x2050 /* MX23_PAD_SSP1_DATA3__SSP1_DATA3 */
> +						0x2000 /* MX23_PAD_SSP1_CMD__SSP1_CMD */
> +						0x2060 /* MX23_PAD_SSP1_SCK__SSP1_SCK */
> +					>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};
> +
>  				mmc0_8bit_pins_a: mmc0-8bit at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <
> -- 
> 1.7.9.5
> 
