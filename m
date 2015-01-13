From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 13 Jan 2015 03:11:56 +0100
Subject: [PATCH v2] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1421112132-9651-1-git-send-email-ottxor@gentoo.org>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
 <1421112132-9651-1-git-send-email-ottxor@gentoo.org>
Message-ID: <20150113021156.GB2434@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 06:22:12PM -0700, Christoph Junghans wrote:
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux and is
> based on dts files from Arch Linux ARM and OpenWrt.

Hi Christoph

I just tried compiling this with 3.19-rc1:

  DTC     arch/arm/boot/dts/kirkwood-pogo_e02.dtb
ERROR (duplicate_label): Duplicate label 'pinctrl' on /ocp at f1000000/pinctrl at 10000 and /ocp at f1000000/pin-controller at 10000
ERROR: Input tree has errors, aborting (use -f to force output)

> Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
> Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---

It is normal to say here, after the --- what you have changed since
the previous version.

>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/kirkwood-pogo_e02.dts            | 129 +++++++++++++++++++++
>  3 files changed, 131 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-pogo_e02.dts
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..e5f58c6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -32,6 +32,7 @@ cdns	Cadence Design Systems Inc.
>  chrp	Common Hardware Reference Platform
>  chunghwa	Chunghwa Picture Tubes Ltd.
>  cirrus	Cirrus Logic, Inc.
> +cloudengines	Cloud Engines, Inc.
>  cortina	Cortina Systems, Inc.

This failed to apply. cnm was added Wed May 14 2014, so i guess you are not using 3.19-rc1?

>  crystalfontz	Crystalfontz America, Inc.
>  dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..cd974eb 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -143,6 +143,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += kirkwood-b3.dtb \
>  	kirkwood-openrd-base.dtb \
>  	kirkwood-openrd-client.dtb \
>  	kirkwood-openrd-ultimate.dtb \
> +	kirkwood-pogo_e02.dtb \
>  	kirkwood-rd88f6192.dtb \
>  	kirkwood-rd88f6281-a0.dtb \
>  	kirkwood-rd88f6281-a1.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-pogo_e02.dts b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
> new file mode 100644
> index 0000000..be38dab
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
> @@ -0,0 +1,129 @@
> +/*
> + * kirkwood-sheevaplug.dts - Device tree file for Pogoplug E02
> + *
> + * Copyright (C) 2015 Christoph Junghans <ottxor@gentoo.org>
> + *
> + * based on information of dts files from
> + *  Arch Linux ARM by Oleg Rakhmanov <moonman.ca@gmail.com>
> + *  OpenWrt by Felix Kaechele <heffer@fedoraproject.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "Cloud Engines Pogoplug E02";
> +	compatible = "cloudengines,pogoe02", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +		linux,stdout-path = &serial1;

This is not what i was expecting. I would expect it to be

                stdout-path = &uart0;


> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pmx_usb_power_enable: pmx-usb-power-enable {
> +				marvell,pins = "mpp29";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_green: pmx-led-green {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +			pmx_led_orange: pmx-led-orange {
> +				marvell,pins = "mpp49";
> +				marvell,function = "gpio";
> +			};
> +		};

To fix the error above, i suggest you take a look at:

https://lkml.org/lkml/2014/12/28/34

	Andrew

> +		serial1: serial at 12000 {
> +			status = "ok";
> +		};
> +	};
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = < &pmx_usb_power_enable &pmx_led_orange
> +			      &pmx_led_green >;
> +		pinctrl-names = "default";
> +
> +		health {
> +			label = "pogo_e02:green:health";
> +			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
> +		};
> +		fault {
> +			label = "pogo_e02:orange:fault";
> +			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_usb_power_enable>;
> +		pinctrl-names = "default";
> +
> +		usb_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&nand {
> +	chip-delay = <40>;
> +	status = "okay";
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x100000>;
> +		read-only;
> +	};
> +
> +	partition at 100000 {
> +		label = "uImage";
> +		reg = <0x0100000 0x400000>;
> +	};
> +
> +	partition at 500000 {
> +		label = "pogoplug";
> +		reg = <0x0500000 0x2000000>;
> +	};
> +
> +	partition at 2500000 {
> +		label = "root";
> +		reg = <0x02500000 0x5b00000>;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy at 0 {
> +		reg = <0>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> -- 
> 2.0.5
> 
