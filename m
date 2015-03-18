From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 18 Mar 2015 11:59:41 +0100
Subject: [PATCH v2 3/3] ARM: mvebu: armada-385-ap: Enable USB3 port
In-Reply-To: <1421672474-2945-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <1421672474-2945-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <55095A9D.3050207@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, Jason, Andrew, Sebastian, Greg, Felipe, Mathias,

On 19/01/2015 14:01, Maxime Ripard wrote:
> The Armada 385 AP board has a USB3 port exposed that uses a GPIO to drive the
> VBUS line. Enable the needed drivers to support this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-385-db-ap.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-385-db-ap.dts b/arch/arm/boot/dts/armada-385-db-ap.dts
> index 3a51531eb37b..b891b4c897f5 100644
> --- a/arch/arm/boot/dts/armada-385-db-ap.dts
> +++ b/arch/arm/boot/dts/armada-385-db-ap.dts
> @@ -98,6 +98,13 @@
>  				status = "okay";
>  			};
>  
> +			pinctrl at 18000 {
> +				xhci0_vbus_pins: xhci0-vbus-pins {
> +					marvell,pins = "mpp44";
> +					marvell,function = "gpio";
> +				};
> +			};
> +
>  			ethernet at 30000 {
>  				status = "okay";
>  				phy = <&phy2>;
> @@ -122,6 +129,11 @@
>  				phy = <&phy0>;
>  				phy-mode = "rgmii-id";
>  			};
> +
> +			usb3 at f0000 {
> +				status = "okay";
> +				usb-phy = <&usb3_phy>;
> +			};
>  		};
>  
>  		pcie-controller {
> @@ -147,4 +159,20 @@
>  			};
>  		};
>  	};
> +
> +	usb3_phy: usb3_phy {
> +		compatible = "usb-nop-xceiv";
> +		vcc-supply = <&reg_xhci0_vbus>;
> +	};
> +
> +	reg_xhci0_vbus: xhci0-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&xhci0_vbus_pins>;
> +		regulator-name = "xhci0-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +	};
>  };
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
