From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 14:08:21 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Add power key support
In-Reply-To: <1387473934-10188-1-git-send-email-b20788@freescale.com>
References: <1387473934-10188-1-git-send-email-b20788@freescale.com>
Message-ID: <20131219060820.GW6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 12:25:34PM -0500, Anson Huang wrote:
> This patch adds support for imx6qdl-sabresd board's power
> key, the key is named "SW1" on board, press it can wake up
> system from suspend.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index e75e11b..85e3487 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -47,6 +47,13 @@
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> +		power {
> +			label = "Power Button";
> +			gpios = <&gpio3 29 0>;
> +			linux,code = <116>; /* KEY_POWER */

The patch looks good.  But I want to ask for more.

 - Move linux,code to the bottom, so that it follows the order used in
   volume-up and volume-down.

 - Replace magic number 116 with macro KEY_POWER defined in
   include/dt-bindings/input/input.h, as well as the numbers in
   volume-up and volume-down.

 - Create a pinctrl entry in gpio-keys node, and move the following out
   from pinctrl_hog into there.

	MX6QDL_PAD_EIM_D29__GPIO3_IO29
	MX6QDL_PAD_GPIO_4__GPIO1_IO04
	MX6QDL_PAD_GPIO_5__GPIO1_IO05

Shawn

> +			gpio-key,wakeup;
> +		};
> +
>  		volume-up {
>  			label = "Volume Up";
>  			gpios = <&gpio1 4 0>;
> @@ -182,6 +189,7 @@
>  				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
>  				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
>  				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
> +				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x80000000
>  			>;
>  		};
>  	};
> -- 
> 1.7.9.5
> 
> 
