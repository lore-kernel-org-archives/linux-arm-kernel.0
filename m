From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 7 Apr 2017 21:19:15 +0800
Subject: [PATCH v3 2/9] ARM: dts: imx6ul-geam: Add Sound card with codec
 node
In-Reply-To: <1491501735-1649-3-git-send-email-jagan@openedev.com>
References: <1491501735-1649-1-git-send-email-jagan@openedev.com>
 <1491501735-1649-3-git-send-email-jagan@openedev.com>
Message-ID: <20170407131914.GI16503@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 06, 2017 at 11:32:08PM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Add support for Sound card and related codec(via i2c1) nodes
> on Engicam GEAM6UL variant module boards.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - Replace fsl,imx-audio-sgtl5000 and use simple-audio-card
> Changes for v2:
> - Use proper [label:] node-name[@unit-address] for codec
> - Remove incorrect codec property 'wlf,shared-lrclk'
> - Remove 'gpr' from sound card node
> 
>  arch/arm/boot/dts/imx6ul-geam-kit.dts | 12 ++++++++++++
>  arch/arm/boot/dts/imx6ul-geam.dtsi    | 26 ++++++++++++++++++++++++++

Same question here: why is sgtl5000 added to imx6ul-geam-kit.dts, while
sound code that references to sgtl5000 is added to imx6ul-geam.dtsi?

Shawn

>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-geam-kit.dts b/arch/arm/boot/dts/imx6ul-geam-kit.dts
> index 142e60c..02edcba 100644
> --- a/arch/arm/boot/dts/imx6ul-geam-kit.dts
> +++ b/arch/arm/boot/dts/imx6ul-geam-kit.dts
> @@ -58,6 +58,18 @@
>  	status = "okay";
>  };
>  
> +&i2c1 {
> +	sgtl5000: codec at a {
> +		compatible = "fsl,sgtl5000";
> +		reg = <0x0a>;
> +		clocks = <&clks IMX6UL_CLK_OSC>;
> +		clock-names = "mclk";
> +		VDDA-supply = <&reg_3p3v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +		VDDD-supply = <&reg_1p8v>;
> +	};
> +};
> +
>  &lcdif {
>  	display = <&display0>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/imx6ul-geam.dtsi b/arch/arm/boot/dts/imx6ul-geam.dtsi
> index eb94d95..3bc3238 100644
> --- a/arch/arm/boot/dts/imx6ul-geam.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-geam.dtsi
> @@ -87,6 +87,32 @@
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "imx6ul-geam-sgtl5000";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&dailink_master>;
> +		simple-audio-card,frame-master = <&dailink_master>;
> +		simple-audio-card,widgets =
> +			"Microphone", "Mic Jack",
> +			"Line", "Line In",
> +			"Line", "Line Out",
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"Headphone Jack", "HP_OUT";
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&sai2>;
> +		};
> +
> +		dailink_master: simple-audio-card,codec {
> +			sound-dai = <&sgtl5000>;
> +			clocks = <&clks IMX6UL_CLK_SAI2>;
> +		};
> +	};
>  };
>  
>  &can1 {
> -- 
> 1.9.1
> 
