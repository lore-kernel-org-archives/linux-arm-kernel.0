From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 13:57:04 +0800
Subject: [PATCH] ARM: dts: imx7s-warp: Add Bluetooth support
In-Reply-To: <1471886526-19251-1-git-send-email-vanessa.maegima@nxp.com>
References: <1471886526-19251-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <20160829055704.GF30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 02:22:06PM -0300, Vanessa Maegima wrote:
> WaRP7 has a BCM4343 Bluetooth chip.
> 
> Add support for it.
> 
> Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
> ---
>  arch/arm/boot/dts/imx7s-warp.dts | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
> index 92d9c85..6ce8953 100644
> --- a/arch/arm/boot/dts/imx7s-warp.dts
> +++ b/arch/arm/boot/dts/imx7s-warp.dts
> @@ -66,6 +66,16 @@
>  		startup-delay-us = <200000>;
>  	};
>  
> +	reg_bt: bt-reg {

Please name the fixed regulator like regulator-xxx.

> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +		regulator-name = "bt_reg";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;

Why should it be always-on?

> +	};
> +
>  	sound {
>  		compatible = "simple-audio-card";
>  		simple-audio-card,name = "imx7-sgtl5000";
> @@ -228,6 +238,15 @@
>  	status = "okay";
>  };
>  
> +&uart3  {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	fsl,uart-has-rtscts;

This vendor specific property is deprecated.  Please use generic one,
uart-has-rtscts, instead.

> +	status = "okay";
> +};
> +
>  &usbotg1 {
>  	dr_mode = "peripheral";
>  	status = "okay";
> @@ -302,6 +321,16 @@
>  		>;
>  	};
>  
> +	pinctrl_uart3: uart3grp {
> +		fsl,pins = <
> +			MX7D_PAD_UART3_TX_DATA__UART3_DCE_TX 0x79
> +			MX7D_PAD_UART3_RX_DATA__UART3_DCE_RX 0x79
> +			MX7D_PAD_UART3_CTS_B__UART3_DCE_CTS 0x79
> +			MX7D_PAD_UART3_RTS_B__UART3_DCE_RTS 0x79
> +			MX7D_PAD_SD2_DATA3__GPIO5_IO17 0x14 /*BT_REG_ON*/

It should be in a separate pinctrl entry for regulator.

Shawn

> +		>;
> +	};
> +
>  	pinctrl_usdhc1: usdhc1grp {
>  		fsl,pins = <
>  			MX7D_PAD_SD1_CMD__SD1_CMD	0x59
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
