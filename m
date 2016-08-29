From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 09:46:09 +0800
Subject: [PATCH 2/2] ARM: dts: imx7s-warp: Add User Button support
In-Reply-To: <1471357649-2483-2-git-send-email-vanessa.maegima@nxp.com>
References: <1471357649-2483-1-git-send-email-vanessa.maegima@nxp.com>
 <1471357649-2483-2-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <20160829014609.GD30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 11:27:29AM -0300, Vanessa Maegima wrote:
> Add User Button at GPIO7_1.
> 
> Tested by evtest.
> 
> Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
> ---
>  arch/arm/boot/dts/imx7s-warp.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
> index 71dbece..794aa94 100644
> --- a/arch/arm/boot/dts/imx7s-warp.dts
> +++ b/arch/arm/boot/dts/imx7s-warp.dts
> @@ -54,6 +54,19 @@
>  		reg = <0x80000000 0x20000000>;
>  	};
>  
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pinctrl_gpio>;
> +		autorepeat;

Please have a newline between property list and sub-node.

> +		back {
> +			label = "Back";
> +			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
> +			linux,code = <KEY_BACK>;
> +			gpio-key,wakeup;

This property is deprecated, and 'wakeup-source' should be used instead.
See Documentation/devicetree/bindings/power/wakeup-source.txt for
details.

> +			autorepeat;

Is it really necessary to have this property in both parent and child
node?

Shawn

> +		};
> +	};
> +
>  	reg_brcm: regulator-brcm {
>  		compatible = "regulator-fixed";
>  		enable-active-high;
> @@ -278,6 +291,12 @@
>  		>;
>  	};
>  
> +	pinctrl_gpio: gpiogrp {
> +		fsl,pins = <
> +			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1	0x14
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
