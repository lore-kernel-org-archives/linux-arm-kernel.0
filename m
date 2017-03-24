From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 24 Mar 2017 13:23:28 +0800
Subject: [PATCH 07/12] ARM: dts: imx6ul-isiot: Add Sound card with codec
 node
In-Reply-To: <1490204897-14525-8-git-send-email-jagan@openedev.com>
References: <1490204897-14525-1-git-send-email-jagan@openedev.com>
 <1490204897-14525-8-git-send-email-jagan@openedev.com>
Message-ID: <20170324052324.GF30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:18:12PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Add support for Sound card and related codec(via i2c1) nodes
> on Engicam Is.IoT MX6UL variant module boards.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm/boot/dts/imx6ul-isiot-common.dtsi | 11 +++++++++++
>  arch/arm/boot/dts/imx6ul-isiot.dtsi        | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
> index b149b5e..c79fa42 100644
> --- a/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-isiot-common.dtsi
> @@ -41,6 +41,17 @@
>   */
>  
>  &i2c1 {
> +	codec: sgtl5000 at 0a {

	sgtl5000: codec at a {

> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		clocks = <&clks IMX6UL_CLK_OSC>;
> +		clock-names = "mclk";
> +		wlf,shared-lrclk;

This is a property for wm8960 not sgtl5000.

> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +		VDDD-supply = <&reg_1p8v>;
> +	};
> +
>  	touch: stmpe811 at 44 {
>  		compatible = "st,stmpe811";
>  		reg = <0x44>;
> diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
> index ea30380..7cbcaea 100644
> --- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
> @@ -69,6 +69,36 @@
>  				    100>;
>  		default-brightness-level = <100>;
>  	};
> +
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "1P8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	sound {
> +		compatible = "fsl,imx-audio-sgtl5000";
> +		model = "imx6ul-isiot-sgtl5000";
> +		cpu-dai = <&sai2>;
> +		audio-codec = <&codec>;
> +		gpr = <&gpr>;

I do not see this 'gpr' thing in bindings/sound/imx-audio-sgtl5000.txt.

Shawn

> +		audio-routing =
> +			"MIC_IN", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"Headphone Jack", "HP_OUT";
> +	};
>  };
>  
>  &i2c1 {
> -- 
> 1.9.1
> 
