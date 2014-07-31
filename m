From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jul 2014 11:58:00 +0200
Subject: [PATCH] ARM: dt: sun7i: Add Banana Pi board
In-Reply-To: <1406653348-16638-1-git-send-email-hdegoede@redhat.com>
References: <1406653348-16638-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20140731095800.GA3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Jul 29, 2014 at 07:02:28PM +0200, Hans de Goede wrote:
> The Banana Pi is an A20 based development board using Raspberry Pi compatible
> IO headers. It comes with 1 GB RAM, 1 Gb ethernet, 2x USB host, sata, hdmi
> and stereo audio out + various expenansion headers:
> 
> http://www.bananapi.org/
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts | 183 +++++++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bdbc84a..440e037 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -379,6 +379,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>  	sun6i-a31-hummingbird.dtb \
>  	sun6i-a31-m9.dtb
>  dtb-$(CONFIG_MACH_SUN7I) += \
> +	sun7i-a20-bananapi.dtb \
>  	sun7i-a20-cubieboard2.dtb \
>  	sun7i-a20-cubietruck.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> new file mode 100644
> index 0000000..0332b82
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -0,0 +1,183 @@
> +/*
> + * Copyright 2014 Hans de Goede <hdegoede@redhat.com>
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
> +/include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-common-regulators.dtsi"
> +
> +/ {
> +	model = "LeMaker Banana Pi";
> +	compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
> +
> +	soc at 01c00000 {
> +		spi0: spi at 01c05000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&spi0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
> +			vmmc-supply = <&reg_vcc3v3>;
> +			bus-width = <4>;
> +			cd-gpios = <&pio 7 10 0>; /* PH10 */
> +			cd-inverted;
> +			status = "okay";
> +		};
> +
> +		usbphy: phy at 01c13400 {
> +			usb1_vbus-supply = <&reg_usb1_vbus>;
> +			usb2_vbus-supply = <&reg_usb2_vbus>;
> +			status = "okay";
> +		};
> +
> +		ehci0: usb at 01c14000 {
> +			status = "okay";
> +		};
> +
> +		ohci0: usb at 01c14400 {
> +			status = "okay";
> +		};
> +
> +		ahci: sata at 01c18000 {
> +			status = "okay";
> +		};
> +
> +		ehci1: usb at 01c1c000 {
> +			status = "okay";
> +		};
> +
> +		ohci1: usb at 01c1c400 {
> +			status = "okay";
> +		};
> +
> +		pinctrl at 01c20800 {
> +			uart3_pins_bananapi: uart3_pin at 0 {
> +				allwinner,pins = "PH0", "PH1";
> +				allwinner,function = "uart3";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};

That node should be in the DTSI

> +
> +			mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
> +				allwinner,pins = "PH10";
> +				allwinner,function = "gpio_in";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <1>;
> +			};
> +
> +			gmac_power_pin_bananapi: gmac_power_pin at 0 {
> +				allwinner,pins = "PH23";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			led_pins_bananapi: led_pins at 0 {
> +				allwinner,pins = "PH24";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +		};
> +
> +		ir0: ir at 01c21800 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&ir0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +
> +		uart3: serial at 01c28c00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart3_pins_bananapi>;
> +			status = "okay";
> +		};
> +
> +		uart7: serial at 01c29c00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart7_pins_a>;
> +			status = "okay";
> +		};
> +
> +		i2c0: i2c at 01c2ac00 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c0_pins_a>;
> +			status = "okay";
> +
> +			axp209: pmic at 34 {
> +				compatible = "x-powers,axp209";
> +				reg = <0x34>;
> +				interrupt-parent = <&nmi_intc>;
> +				interrupts = <0 8>;
> +
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		i2c2: i2c at 01c2b400 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&i2c2_pins_a>;
> +			status = "okay";
> +		};
> +
> +		gmac: ethernet at 01c50000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gmac_pins_rgmii_a>;
> +			phy = <&phy1>;
> +			phy-mode = "rgmii";
> +			phy-supply = <&reg_gmac_3v3>;
> +			status = "okay";
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <1>;
> +			};
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_bananapi>;
> +
> +		green {
> +			label = "bananapi:green:usr";
> +			gpios = <&pio 7 24 0>;
> +		};
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		status = "okay";
> +	};
> +
> +	reg_usb2_vbus: usb2-vbus {
> +		status = "okay";
> +	};
> +
> +	reg_gmac_3v3: gmac-3v3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gmac_power_pin_bananapi>;
> +		regulator-name = "gmac-3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <50000>;
> +		enable-active-high;
> +		gpio = <&pio 7 23 0>;
> +	};
> +};

Looks fine otherwise, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/6f761c60/attachment.sig>
