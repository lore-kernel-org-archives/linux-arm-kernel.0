From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 May 2015 09:46:16 +0200
Subject: [PATCH 1/2] ARM: dts: sun9i: cubieboard4: Enable USB support
In-Reply-To: <1431017037-28331-2-git-send-email-wens@csie.org>
References: <1431017037-28331-1-git-send-email-wens@csie.org>
 <1431017037-28331-2-git-send-email-wens@csie.org>
Message-ID: <20150508074616.GP11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 08, 2015 at 12:43:56AM +0800, Chen-Yu Tsai wrote:
> The Cubieboard4 has 4 USB ports. 3 of them are connected to a GL850G
> USB hub chip on usb1. The fourth one, the lower port of 2 ports next
> to the power barrel, is directly connected to usb3.
> 
> 2 power enable GPIOs are used between the 2 port groups, 1 for each.
> This raises the possibility of having no power for hub-connected port
> next to the power barrel, if usb3 is not enabled.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> index 6484dcf69873..42ddc046213c 100644
> --- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> +++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
> @@ -62,6 +62,30 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	reg_usb3_vbus: usb3-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb3_vbus_pin_cubieboard4>;
> +		regulator-name = "usb3-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15 */
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +/* usb1 is connected to a GL850G USB hub chip, so no need to enable OHCI */

You're mentionning usb1, but I don't see it enabled anywhere, is that
a typo?

> +
> +&ohci2 {
> +	status = "okay";
>  };
>  
>  &pio {
> @@ -71,6 +95,20 @@
>  		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  	};
> +
> +	usb1_vbus_pin_cubieboard4: usb1_vbus_pin at 1 {
> +		allwinner,pins = "PH14";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
> +	usb3_vbus_pin_cubieboard4: usb3_vbus_pin at 1 {
> +		allwinner,pins = "PH15";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
>  };
>  
>  &mmc0 {
> @@ -92,8 +130,30 @@
>  	status = "okay";
>  };
>  
> +&reg_usb1_vbus {
> +	pinctrl-0 = <&usb1_vbus_pin_cubieboard4>;
> +	gpio = <&pio 7 14 GPIO_ACTIVE_HIGH>; /* PH14 */
> +	status = "okay";
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pins_a>;
>  	status = "okay";
>  };
> +
> +&usbphy1 {
> +	phy-supply = <&reg_usb1_vbus>;
> +	status = "okay";
> +};
> +
> +/*
> + * Unfortunately reg_usb1_vbus also powers one of the ports from usb3's hub.
> + * One should always make sure both regulators are enabled and working for
> + * all USB ports to have power.
> + */

Can't we just provide the two regulators, and enable both of them so
that we know that we always have the needed regulators enabled,
disregarding which USB port is used?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/037b263e/attachment.sig>
