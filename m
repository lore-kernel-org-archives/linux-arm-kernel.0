From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 07 Feb 2014 15:05:46 +0100
Subject: [PATCH] Adding basic support for the INet-97F_Rev_02 board
In-Reply-To: <9275469.c2bJ2hMSsV@dizzy-6.o2s.ch>
References: <9275469.c2bJ2hMSsV@dizzy-6.o2s.ch>
Message-ID: <52F4E83A.1060109@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thanks for the patch, I've added it to my sunxi-devel tree.

It seems this has been missed by Maxime, because you did not send it directly
to him. Can you please rebase it one 3.14-rc1, and then send it directly to
Maxime Ripard, with the relevant mailinglists in the CC?

Thanks & Regards,

Hans


On 01/23/2014 08:38 PM, David Lanzend?rfer wrote:
> This patch adds basic support for the INet-97F_Rev_02 board found in various
> low cost consumer tablet devices (http://linux-sunxi.org/INet-97F_Rev_02)
>
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> ---
>   arch/arm/boot/dts/Makefile                |   1 +
>   arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 106
> ++++++++++++++++++++++++++++++
>   2 files changed, 107 insertions(+)
>   create mode 100644 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b663ed7..57ec008 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -253,6 +253,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
>   	sun4i-a10-cubieboard.dtb \
>   	sun4i-a10-mini-xplus.dtb \
>   	sun4i-a10-hackberry.dtb \
> +	sun4i-a10-inet97fv2.dtb \
>   	sun5i-a10s-olinuxino-micro.dtb \
>   	sun5i-a13-olinuxino.dtb \
>   	sun5i-a13-olinuxino-micro.dtb \
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> new file mode 100644
> index 0000000..82b4306
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> @@ -0,0 +1,106 @@
> +/*
> + * Copyright 2014 Open Source Support GmbH
> + *
> + * David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun4i-a10.dtsi"
> +
> +/ {
> +	model = "INet-97F Rev 02";
> +	compatible = "primux,inet97fv2", "allwinner,sun4i-a10";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	soc at 01c00000 {
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>;
> +			pinctrl-1 = <&mmc0_cd_pin_inet97fv2>;
> +			cd-gpios = <&pio 7 1 0>; /* PH1 */
> +			cd-mode = <1>;
> +			status = "okay";
> +		};
> +
> +		pinctrl at 01c20800 {
> +			mmc0_cd_pin_inet97fv2: mmc0_cd_pin at 0 {
> +				allwinner,pins = "PH1";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			usb1_vbus_pin: usb1_vbus_pin at 0 {
> +					allwinner,pins = "PH6";
> +					allwinner,function = "gpio_out";
> +					allwinner,drive = <0>;
> +					allwinner,pull = <2>;
> +			};
> +
> +			usb2_vbus_pin: usb2_vbus_pin at 0 {
> +					allwinner,pins = "PH3";
> +					allwinner,function = "gpio_out";
> +					allwinner,drive = <0>;
> +					allwinner,pull = <2>;
> +			};
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		ehci0: ehci0 at 0x01c14000 {
> +			vbus-supply = <&reg_usb1_vbus>;
> +			status = "okay";
> +		};
> +
> +		ehci1: ehci1 at 0x01c1c000 {
> +			vbus-supply = <&reg_usb2_vbus>;
> +			status = "okay";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_usb1_vbus: usb1-vbus {
> +			compatible = "regulator-fixed";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&usb1_vbus_pin>;
> +			regulator-name = "usb1-vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			gpio = <&pio 7 6 0>;
> +		};
> +
> +		reg_usb2_vbus: usb2-vbus {
> +			compatible = "regulator-fixed";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&usb2_vbus_pin>;
> +			regulator-name = "usb2-vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			gpio = <&pio 7 3 0>;
> +		};
> +	};
> +};
>
