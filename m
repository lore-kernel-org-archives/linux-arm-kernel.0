From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 Jan 2014 16:29:38 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: Add LVDS support
In-Reply-To: <1389739887-21272-1-git-send-email-festevam@gmail.com>
References: <1389739887-21272-1-git-send-email-festevam@gmail.com>
Message-ID: <20140118082937.GB3430@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 08:51:27PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add LVDS support for mx6 sabreauto boards.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Regarding the additional change that is required by componentised device
adoption for imx-drm, let's deal with it when it comes.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 088b0d2..47c5a3f 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -22,6 +22,14 @@
>  		spdif-controller = <&spdif>;
>  		spdif-in;
>  	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm3 0 5000000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <7>;
> +		status = "okay";
> +	};
>  };
>  
>  &ecspi1 {
> @@ -86,6 +94,10 @@
>  			fsl,pins = <MX6QDL_GPMI_NAND_PINGRP1>;
>  		};
>  
> +		pinctrl_pwm3: pwm1grp {
> +			fsl,pins = <MX6QDL_PWM3_PINGRP1>;
> +		};
> +
>  		pinctrl_spdif: spdifgrp {
>  			fsl,pins = <
>  				MX6QDL_PAD_KEY_COL3__SPDIF_IN 0x1b0b0
> @@ -118,6 +130,37 @@
>  	};
>  };
>  
> +&ldb {
> +	status = "okay";
> +
> +	lvds-channel at 0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "okay";
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: hsd100pxn1 {
> +				clock-frequency = <65000000>;
> +				hactive = <1024>;
> +				vactive = <768>;
> +				hback-porch = <220>;
> +				hfront-porch = <40>;
> +				vback-porch = <21>;
> +				vfront-porch = <7>;
> +				hsync-len = <60>;
> +				vsync-len = <10>;
> +			};
> +		};
> +	};
> +};
> +
> +&pwm3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm3>;
> +	status = "okay";
> +};
> +
>  &spdif {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_spdif>;
> -- 
> 1.8.1.2
> 
