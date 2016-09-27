From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue, 27 Sep 2016 06:28:43 +0000
Subject: [PATCH v2 1/3] ARM: dts: imx6qdl-apalis: Do not rely on DDC I2C
 bus bitbang for HDMI
In-Reply-To: <2263d508999ada9476268138b2922702eb50131f.1474260360.git.maitysanchayan@gmail.com>
References: <2263d508999ada9476268138b2922702eb50131f.1474260360.git.maitysanchayan@gmail.com>
Message-ID: <1474957723.3739.3.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-09-19 at 10:41 +0530, Sanchayan Maity wrote:
> Remove the use of DDC I2C bus bitbang to support reading of EDID
> and rely on support from internal HDMI I2C master controller instead.
> As a result remove the device tree property ddc-i2c-bus.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

> ---
> Changes since v1:
> 
> Change the ranking in i2c aliases
> 
> v1: https://lkml.org/lkml/2016/9/14/55
> ---
> ?arch/arm/boot/dts/imx6q-apalis-ixora.dts | 12 +++---------
> ?arch/arm/boot/dts/imx6qdl-apalis.dtsi????| 25 +++++++++-------------
> ---
> ?2 files changed, 12 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> index 207b85b..82b81e0 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> @@ -55,10 +55,9 @@
> ?		?????"fsl,imx6q";
> ?
> ?	aliases {
> -		i2c0 = &i2cddc;
> -		i2c1 = &i2c1;
> -		i2c2 = &i2c2;
> -		i2c3 = &i2c3;
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
> ?	};
> ?
> ?	aliases {
> @@ -186,11 +185,6 @@
> ?};
> ?
> ?&hdmi {
> -	ddc-i2c-bus = <&i2cddc>;
> -	status = "okay";
> -};
> -
> -&i2cddc {
> ?	status = "okay";
> ?};
> ?
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 99e323b..8c67dd8 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -53,18 +53,6 @@
> ?		status = "disabled";
> ?	};
> ?
> -	/* DDC_I2C: I2C2_SDA/SCL on MXM3 205/207 */
> -	i2cddc: i2c at 0 {
> -		compatible = "i2c-gpio";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_i2c_ddc>;
> -		gpios = <&gpio3 16 GPIO_ACTIVE_HIGH /* sda */
> -			?&gpio2 30 GPIO_ACTIVE_HIGH /* scl */
> -			>;
> -		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> -		status = "disabled";
> -	};
> -
> ?	reg_1p8v: regulator-1p8v {
> ?		compatible = "regulator-fixed";
> ?		regulator-name = "1P8V";
> @@ -209,6 +197,12 @@
> ?	};
> ?};
> ?
> +&hdmi {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi_ddc>;
> +	status = "disabled";
> +};
> +
> ?/*
> ? * GEN1_I2C: I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier
> ? * board)
> @@ -633,11 +627,10 @@
> ?		>;
> ?	};
> ?
> -	pinctrl_i2c_ddc: gpioi2cddcgrp {
> +	pinctrl_hdmi_ddc: hdmiddcgrp {
> ?		fsl,pins = <
> -			/* DDC bitbang */
> -			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x1b0b0
> -			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x1b0b0
> +			MX6QDL_PAD_EIM_EB2__HDMI_TX_DDC_SCL
> 0x4001b8b1
> +			MX6QDL_PAD_EIM_D16__HDMI_TX_DDC_SDA
> 0x4001b8b1
> ?		>;
> ?	};
