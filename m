From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Jun 2017 09:54:02 +0800
Subject: [PATCH 2/3] ARM: dts: imx7d-sdb: Add Wifi support
In-Reply-To: <1496084460-20910-2-git-send-email-festevam@gmail.com>
References: <1496084460-20910-1-git-send-email-festevam@gmail.com>
 <1496084460-20910-2-git-send-email-festevam@gmail.com>
Message-ID: <20170605015401.GF4094@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 29, 2017 at 04:00:59PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx7d-sdb has a BCM4339 Wifi chip connected to USDHC2.
> 
> Add support for it.
> 
> While at it, move the WL_REG_ON pin to the correct pinctrl node.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 38944ca..fc7e0b0 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -105,6 +105,18 @@
>  		regulator-min-microvolt = <1800000>;
>  		regulator-max-microvolt = <1800000>;
>  	};
> +
> +	reg_brcm: regulator-brcm {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-name = "brcm_reg";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_brcm_reg>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <200000>;
> +	};
>  };
>  
>  &adc1 {
> @@ -379,6 +391,19 @@
>  	status = "okay";
>  };
>  
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	enable-sdio-wakeup;

Use 'wakeup-source' instead.

Shawn

> +	keep-power-in-suspend;
> +	non-removable;
> +	vmmc-supply = <&reg_brcm>;
> +	fsl,tuning-step = <2>;
> +	status = "okay";
> +};
> +
>  &usdhc3 {
>  	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>  	pinctrl-0 = <&pinctrl_usdhc3>;
> @@ -403,6 +428,12 @@
>  	pinctrl-0 = <&pinctrl_hog>;
>  
>  	imx7d-sdb {
> +		pinctrl_brcm_reg: brcmreggrp {
> +			fsl,pins = <
> +				MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x14
> +			>;
> +		};
> +
>  		pinctrl_ecspi3: ecspi3grp {
>  			fsl,pins = <
>  				MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO	0x2
> @@ -570,7 +601,6 @@
>  				MX7D_PAD_SD2_DATA1__SD2_DATA1		0x59
>  				MX7D_PAD_SD2_DATA2__SD2_DATA2		0x59
>  				MX7D_PAD_SD2_DATA3__SD2_DATA3		0x59
> -				MX7D_PAD_ECSPI2_MOSI__GPIO4_IO21	0x59 /* WL_REG_ON */
>  			>;
>  		};
>  
> -- 
> 2.7.4
> 
