From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 21:29:59 +0800
Subject: [PATCH 2/2] ARM: MXS: Add Crystalfontz CFA-10036 DTS
In-Reply-To: <1340268415-5022-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1340268415-5022-1-git-send-email-maxime.ripard@free-electrons.com>
 <1340268415-5022-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20120621132957.GB21418@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 10:46:54AM +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Brian Lily <brian@crystalfontz.com>
> ---
>  arch/arm/boot/dts/cfa10036.dts |   66 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 arch/arm/boot/dts/cfa10036.dts
> 
> diff --git a/arch/arm/boot/dts/cfa10036.dts b/arch/arm/boot/dts/cfa10036.dts
> new file mode 100644
> index 0000000..ceae960
> --- /dev/null
> +++ b/arch/arm/boot/dts/cfa10036.dts
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright 2012 Free Electrons
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx28.dtsi"
> +
> +/ {
> +	model = "Crystalfontz CFA-10036 Board";
> +	compatible = "crystalfontz,cfa10036", "fsl,imx28-evk", "fsl,imx28";

"fsl,imx28-evk" may not need to be here.

> +
> +	memory {
> +		reg = <0x40000000 0x08000000>;
> +	};
> +
> +	apb at 80000000 {
> +		apbh at 80000000 {
> +			ssp0: ssp at 80010000 {
> +				compatible = "fsl,imx28-mmc";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&mmc0_4bit_pins_a
> +					&mmc0_cd_cfg &mmc0_sck_cfg>;
> +				bus-width = <4>;
> +				status = "okay";
> +			};

Nit: a new line is needed here.

> +			pinctrl at 80018000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,imx28-pinctrl", "simple-bus";
> +				reg = <0x80018000 2000>;
> +
> +				mmc0_4bit_pins_a: mmc0-4bit at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x2000 0x2010 0x2020
> +						0x2030 0x2080 0x2090 0x20a0>;
> +					fsl,drive-strength = <1>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <1>;
> +				};

Still, this needs to be in imx28.dtsi, so that if there is another
board designed with 4bit mmc slot on the same pins can just reuse it.

> +
> +				duart_pins_a: duart at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x3022 0x3032>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};

Same here.  If other boards pick the same pinmux on duart as your
boards, this should be shared.

Bear it in mind, what pins can be muxed on what functions is determined
by SoC design not the board.

> +			};
> +		};
> +
> +		apbx at 80040000 {
> +			duart: serial at 80074000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&duart_pins_a>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> -- 
> 1.7.9.5
> 

-- 
Regards,
Shawn
