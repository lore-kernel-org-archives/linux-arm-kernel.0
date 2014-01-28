From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 20:12:13 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sl-evk: Add audio support
In-Reply-To: <1390443213-14061-2-git-send-email-festevam@gmail.com>
References: <1390443213-14061-1-git-send-email-festevam@gmail.com>
 <1390443213-14061-2-git-send-email-festevam@gmail.com>
Message-ID: <20140128121211.GK20583@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 12:13:33AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx6sl-evk has a wm8962 codec. Add support for it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts  | 72 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6sl-pingrp.h | 11 ++++++
>  arch/arm/boot/dts/imx6sl.dtsi     |  3 ++
>  3 files changed, 86 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 5ba15ab..9e1ab77 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -24,6 +24,22 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		reg_aud3v: wm8962_supply_3v15 {

Have node name in generic reglator at num form.

> +			compatible = "regulator-fixed";
> +			regulator-name = "wm8962-supply-3v15";
> +			regulator-min-microvolt = <3150000>;
> +			regulator-max-microvolt = <3150000>;
> +			regulator-boot-on;
> +		};
> +
> +		reg_aud4v: wm8962_supply_4v2 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "wm8962-supply-4v2";
> +			regulator-min-microvolt = <4325000>;
> +			regulator-max-microvolt = <4325000>;
> +			regulator-boot-on;
> +		};
> +
>  		reg_usb_otg1_vbus: regulator at 0 {
>  			compatible = "regulator-fixed";
>  			reg = <0>;
> @@ -44,6 +60,28 @@
>  			enable-active-high;
>  		};
>  	};
> +
> +	sound {
> +		compatible = "fsl,imx6sl-evk-wm8962", "fsl,imx-audio-wm8962";
> +		model = "wm8962-audio";
> +		ssi-controller = <&ssi2>;
> +		audio-codec = <&codec>;
> +		audio-routing =
> +			"Headphone Jack", "HPOUTL",
> +			"Headphone Jack", "HPOUTR",
> +			"Ext Spk", "SPKOUTL",
> +			"Ext Spk", "SPKOUTR",
> +			"AMIC", "MICBIAS",
> +			"IN3R", "AMIC";
> +		mux-int-port = <2>;
> +		mux-ext-port = <3>;
> +	};
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux3>;
> +	status = "okay";
>  };
>  
>  &i2c1 {
> @@ -152,6 +190,27 @@
>  	};
>  };
>  
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	codec: wm8962 at 1a {
> +		compatible = "wlf,wm8962";
> +		reg = <0x1a>;
> +		clocks = <&clks IMX6SL_CLK_EXTERN_AUDIO>;
> +		DCVDD-supply = <&vgen3_reg>;
> +		DBVDD-supply = <&reg_aud3v>;
> +		AVDD-supply = <&vgen3_reg>;
> +		CPVDD-supply = <&vgen3_reg>;
> +		MICVDD-supply = <&reg_aud3v>;
> +		PLLVDD-supply = <&vgen3_reg>;
> +		SPKVDD1-supply = <&reg_aud4v>;
> +		SPKVDD2-supply = <&reg_aud4v>;
> +	};
> +};
> +
>  &ecspi1 {
>  	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio4 11 0>;
> @@ -192,10 +251,18 @@
>  			>;
>  		};
>  
> +		pinctrl_audmux3: audmux3grp {
> +			fsl,pins = <MX6SL_AUDMUX3_PINGRP1>;
> +		};
> +
>  		pinctrl_i2c1: i2c1grp {
>  			fsl,pins = <MX6SL_I2C1_PINGRP1>;
>  		};
>  
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <MX6SL_I2C2_PINGRP1>;
> +		};
> +
>  		pinctrl_ecspi1: ecspi1grp {
>  			fsl,pins = <MX6SL_ECSPI1_PINGRP1>;
>  		};
> @@ -277,6 +344,11 @@
>  	status = "okay";
>  };
>  
> +&ssi2 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +};
> +
>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> diff --git a/arch/arm/boot/dts/imx6sl-pingrp.h b/arch/arm/boot/dts/imx6sl-pingrp.h
> index cada37a..ee50ace 100644
> --- a/arch/arm/boot/dts/imx6sl-pingrp.h
> +++ b/arch/arm/boot/dts/imx6sl-pingrp.h
> @@ -10,6 +10,13 @@
>  #ifndef __DTS_IMX6SL_PINGRP_H
>  #define __DTS_IMX6SL_PINGRP_H
>  
> +#define MX6SL_AUDMUX3_PINGRP1 \
> +	MX6SL_PAD_AUD_RXD__AUD3_RXD	  0x4130B0 \
> +	MX6SL_PAD_AUD_TXC__AUD3_TXC	  0x4130B0 \
> +	MX6SL_PAD_AUD_TXD__AUD3_TXD	  0x4110B0 \
> +	MX6SL_PAD_AUD_TXFS__AUD3_TXFS	  0x4130B0 \
> +	MX6SL_PAD_AUD_MCLK__AUDIO_CLK_OUT 0x4130B0
> +
>  #define MX6SL_ECSPI1_PINGRP1 \
>  	MX6SL_PAD_ECSPI1_MISO__ECSPI1_MISO		0x100b1 \
>  	MX6SL_PAD_ECSPI1_MOSI__ECSPI1_MOSI		0x100b1 \
> @@ -19,6 +26,10 @@
>  	MX6SL_PAD_I2C1_SCL__I2C1_SCL			0x4001b8b1 \
>  	MX6SL_PAD_I2C1_SDA__I2C1_SDA			0x4001b8b1
>  
> +#define MX6SL_I2C2_PINGRP1 \
> +	MX6SL_PAD_I2C2_SCL__I2C2_SCL			0x4001b8b1 \
> +	MX6SL_PAD_I2C2_SDA__I2C2_SDA			0x4001b8b1
> +
>  #define MX6SL_FEC_PINGRP1 \
>  	MX6SL_PAD_FEC_MDC__FEC_MDC			0x1b0b0 \
>  	MX6SL_PAD_FEC_MDIO__FEC_MDIO			0x1b0b0 \
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 95bb37b..04cf457 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -236,6 +236,7 @@
>  					       <&sdma 38 1 0>;
>  					dma-names = "rx", "tx";
>  					fsl,fifo-depth = <15>;
> +					fsl,ssi-dma-events = <38 37>;

Do you still need this custom property?

Shawn

>  					status = "disabled";
>  				};
>  
> @@ -250,6 +251,7 @@
>  					       <&sdma 42 1 0>;
>  					dma-names = "rx", "tx";
>  					fsl,fifo-depth = <15>;
> +					fsl,ssi-dma-events = <42 41>;
>  					status = "disabled";
>  				};
>  
> @@ -264,6 +266,7 @@
>  					       <&sdma 46 1 0>;
>  					dma-names = "rx", "tx";
>  					fsl,fifo-depth = <15>;
> +					fsl,ssi-dma-events = <46 45>;
>  					status = "disabled";
>  				};
>  
> -- 
> 1.8.1.2
> 
