From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Feb 2013 13:12:51 +0800
Subject: [PATCH 1/1] ARM: dts: imx6q-sabresd: Add USB support
In-Reply-To: <1360131043-10631-1-git-send-email-peter.chen@freescale.com>
References: <1360131043-10631-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20130207051250.GB7697@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 02:10:43PM +0800, Peter Chen wrote:
> Add USB support for imx6q sabresd board
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabresd.dts |   24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/imx6q.dtsi        |    5 +++++
>  2 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
> index a424025..b0f5049 100644
> --- a/arch/arm/boot/dts/imx6q-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6q-sabresd.dts
> @@ -51,6 +51,18 @@
>  		};
>  
>  		aips-bus at 02100000 { /* AIPS2 */
> +			usb at 02184000 { /* USB OTG */
> +				vbus-supply = <&reg_usb_otg_vbus>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usbotg_2>;
> +				disable-over-current;
> +				status = "okay";
> +			};

We changed the way how board level dts is written.  Please take a look
at the file below, and resend the patch based on 3.9-rc1,  as it's also
late for 3.9 merge window.

http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=blob_plain;f=arch/arm/boot/dts/imx6q-sabresd.dts;hb=1262fd06f7663c7ca5b502d48eeade037664a6af

> +
> +			usb at 02184200 { /* USB1 */
> +				status = "okay";
> +			};
> +
>  			ethernet at 02188000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_enet_1>;
> @@ -91,4 +103,16 @@
>  			linux,code = <114>; /* KEY_VOLUMEDOWN */
>  		};
>  	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		reg_usb_otg_vbus: usb_otg_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 22 0>;
> +			enable-active-high;
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d6265ca..9619ff8 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -705,6 +705,11 @@
>  							1592 0x17059	/* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
>  						>;
>  					};

Nit: please have a blank line between nodes.

Shawn

> +					pinctrl_usbotg_2: usbotggrp-2 {
> +						fsl,pins = <
> +							1591 0x17059	/* MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID */
> +						>;
> +					};
>  				};
>  
>  				usdhc2 {
> -- 
> 1.7.0.4
> 
> 
