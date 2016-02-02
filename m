From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 2 Feb 2016 14:53:07 +0800
Subject: [PATCH 1/4] ARM: dts: imx53: add ethernet PHY supply regulator
In-Reply-To: <1453295362-18798-2-git-send-email-LW@KARO-electronics.de>
References: <1453295362-18798-1-git-send-email-LW@KARO-electronics.de>
 <1453295362-18798-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <20160202065306.GH8307@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2016 at 02:09:19PM +0100, Lothar Wa?mann wrote:
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  arch/arm/boot/dts/imx53-tx53.dtsi | 40 ++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
> index d3e50b2..8f08389 100644
> --- a/arch/arm/boot/dts/imx53-tx53.dtsi
> +++ b/arch/arm/boot/dts/imx53-tx53.dtsi
> @@ -87,9 +87,20 @@
>  			regulator-max-microvolt = <3300000>;
>  		};
>  
> -		reg_can_xcvr: regulator at 2 {
> +		reg_3v3_etn: regulator at 2 {

Why cannot this be added as regulator at 5 to avoid changing every node?

>  			compatible = "regulator-fixed";
>  			reg = <2>;
> +			regulator-name = "ETN 3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_etn_phy>;
> +			gpio = <&gpio3 20 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		reg_can_xcvr: regulator at 3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
>  			regulator-name = "CAN XCVR";
>  			regulator-min-microvolt = <3300000>;
>  			regulator-max-microvolt = <3300000>;
> @@ -98,9 +109,9 @@
>  			gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
>  		};
>  
> -		reg_usbh1_vbus: regulator at 3 {
> +		reg_usbh1_vbus: regulator at 4 {
>  			compatible = "regulator-fixed";
> -			reg = <3>;
> +			reg = <4>;
>  			regulator-name = "usbh1_vbus";
>  			regulator-min-microvolt = <5000000>;
>  			regulator-max-microvolt = <5000000>;
> @@ -110,9 +121,9 @@
>  			enable-active-high;
>  		};
>  
> -		reg_usbotg_vbus: regulator at 4 {
> +		reg_usbotg_vbus: regulator at 5 {
>  			compatible = "regulator-fixed";
> -			reg = <4>;
> +			reg = <5>;
>  			regulator-name = "usbotg_vbus";
>  			regulator-min-microvolt = <5000000>;
>  			regulator-max-microvolt = <5000000>;
> @@ -204,13 +215,20 @@
>  	phy-mode = "rmii";
>  	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
>  	phy-handle = <&phy0>;
> +	phy-supply = <&reg_3v3_etn>;
>  	mac-address = [000000000000]; /* placeholder; will be overwritten by bootloader */
>  	status = "okay";
>  
> -	phy0: ethernet-phy at 0 {
> -		interrupt-parent = <&gpio2>;
> -		interrupts = <4>;
> -		device_type = "ethernet-phy";
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy at 0 {
> +			compatible = "ethernet-phy-id0007.c0f1", "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			interrupt-parent = <&gpio2>;
> +			interrupts = <4>;
> +		};

This should be a separate change.

Shawn

>  	};
>  };
>  
> @@ -309,6 +327,10 @@
>  			fsl,pins = <MX53_PAD_DISP0_DAT0__GPIO4_21 0xe0>; /* Flexcan XCVR enable */
>  		};
>  
> +		pinctrl_etn_phy: etn-phygrp {
> +			fsl,pins = <MX53_PAD_EIM_D20__GPIO3_20 0xe0>; /* ETN PHY Power enable */
> +		};
> +
>  		pinctrl_ds1339: ds1339grp {
>  			fsl,pins = <MX53_PAD_DI0_PIN4__GPIO4_20 0xe0>;
>  		};
> -- 
> 2.1.4
> 
> 
