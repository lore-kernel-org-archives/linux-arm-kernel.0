From: koen@dominion.thruhere.net (Koen Kooi)
Date: Wed, 7 May 2014 07:10:21 +0200
Subject: [linux-sunxi] [PATCH 7/7] ARM: sunxi: dt: add APP4-EVB1 board
 support
In-Reply-To: <1399434623-20383-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <EEF98E4B-881E-469C-A1C7-8B4EB8825467@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 7 mei 2014, om 05:50 heeft Maxime Ripard <maxime.ripard@free-electrons.com> het volgende geschreven:

> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> The APP4 EVB1 development boards embeds an A31, together with some NAND, one SD
> card slot, and one SDIO + UART WiFi and Bluetooth chip, a few I2C buses, USB,
> and a LCD display.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> arch/arm/boot/dts/Makefile                |  1 +
> arch/arm/boot/dts/sun6i-a31-app4-evb1.dts | 63 +++++++++++++++++++++++++++++++
> 2 files changed, 64 insertions(+)
> create mode 100644 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index ffa3f5ef27d3..d50c0895a9d5 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -343,6 +343,7 @@ dtb-$(CONFIG_ARCH_SUNXI) += \
> 	sun5i-a10s-olinuxino-micro.dtb \
> 	sun5i-a13-olinuxino.dtb \
> 	sun5i-a13-olinuxino-micro.dtb \
> +	sun6i-a31-app4-evb1.dtb \
> 	sun6i-a31-colombus.dtb \
> 	sun6i-a31-m9.dtb \
> 	sun7i-a20-cubieboard2.dtb \
> diff --git a/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
> new file mode 100644
> index 000000000000..270ab978f858
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun6i-a31-app4-evb1.dts
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright 2014 Boris Brezillon
> + *
> + * Boris Brezillon <boris.brezillon@free-electrons.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:

Doesn't the kernel try to avoid the 'or later' clause?

regards,

Koen


> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "sun6i-a31.dtsi"
> +
> +/ {
> +	model = "Allwinner A31 APP4 EVB1 Evaluation Board";
> +	compatible = "allwinner,app4-evb1", "allwinner,sun6i-a31";
> +
> +	chosen {
> +		bootargs = "earlyprintk console=ttyS0,115200";
> +	};
> +
> +	soc at 01c00000 {
> +		pio: pinctrl at 01c20800 {
> +			usb1_vbus_pin_a: usb1_vbus_pin at 0 {
> +				allwinner,pins = "PH27";
> +				allwinner,function = "gpio_out";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +		};
> +
> +		usbphy: phy at 01c19400 {
> +			usb1_vbus-supply = <&reg_usb1_vbus>;
> +			status = "okay";
> +		};
> +
> +		ehci0: usb at 01c1a000 {
> +			status = "okay";
> +		};
> +
> +		uart0: serial at 01c28000 {
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&uart0_pins_a>;
> +			status = "okay";
> +		};
> +	};
> +
> +	reg_usb1_vbus: usb1-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb1_vbus_pin_a>;
> +		regulator-name = "usb1-vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&pio 7 27 0>;
> +		status = "okay";
> +	};
> +
> +};
> -- 
> 1.9.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
> 
