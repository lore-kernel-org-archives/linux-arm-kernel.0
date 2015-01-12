From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 12 Jan 2015 13:59:21 +0100
Subject: [PATCH] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1421043061-2837-1-git-send-email-ottxor@gentoo.org>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
 <1421043061-2837-1-git-send-email-ottxor@gentoo.org>
Message-ID: <20150112125921.GB19533@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 11:11:01PM -0700, Christoph Junghans wrote:
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux.
> A version of this patch was included in Arch Linux
> on Arm since Jun 2014:
> https://github.com/archlinuxarm/PKGBUILDs/commit/250c2f0aa6ffe66c0ebda61efaa356e5dc709cc7
> A similar patch is available for OpenWrt:
> https://dev.openwrt.org/browser/trunk/target/linux/kirkwood/patches-3.14/150-pogoplug_e02.patch
> 
> Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
> Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/kirkwood-pogo_e02.dts            | 114 +++++++++++++++++++++
>  3 files changed, 116 insertions(+)
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
> index 0000000..286a6be
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
> @@ -0,0 +1,114 @@

Hi Christoph

Do you have any idea of the license on this file? Since there is
nothing stated, i assume it falls under the general Linux kernel
licence, GPL v2. Please could you add a normal GPLv2 header.

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
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
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
> +		serial at 12000 {
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
> +			label = "status:green:health";
> +			gpios = <&gpio1 16 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
> +		};
> +		fault {
> +			label = "status:orange:fault";
> +			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
> +		};
> +	};

Documentation/leds/leds-class.txt says:

LED Device Naming
=================

Is currently of the form:

"devicename:colour:function"

Please could you change status to pogo_e02.

The rest looks good, and thanks for remembering the vendor.txt file.

    Andrew

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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
