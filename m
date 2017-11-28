From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 28 Nov 2017 19:11:29 +0800
Subject: [PATCH] ARM: dts: sun8i: h3: Add dts file for Libre Computer
 Board ALL-H3-CC H3 ver.
In-Reply-To: <20171128041211.17375-1-wens@csie.org>
References: <20171128041211.17375-1-wens@csie.org>
Message-ID: <e570dc9534eaabe5925a450414406d25@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-11-28 12:12?Chen-Yu Tsai ???
> The Libre Computer Board ALL-H3-CC from Libre Technology is a Raspberry
> Pi B+ form factor single board computer based on the Allwinner H3 SoC.
> The board has 1GB DDR3 SDRAM, provided by 4 2Gb chips. The mounting 
> holes
> and connectors are in the exact same position as on the Raspberry Pi 
> B+.
> 
> Raspberry Pi B+ like peripherals supported on this board include:
> 
>   - Power input through micro-USB connector (without USB OTG)
>   - Native 100 Mbps ethernet using the internal PHY, as opposed to
>     USB-based on the RPi
>   - 4x USB 2.0 host ports, directly connected to the SoC, as opposed to
>     being connected through a USB 2.0 hub on the RPi
>   - TV and audio output on a 3.5mm TRRS jack
>   - HDMI output
>   - Micro-SD card slot
>   - Standard RPi B+ GPIO header, with the standard peripherals routed 
> to
>     the same pins.
> 
>     * 5V, 3.3V power, and ground
>     * I2C0 on the H3 is routed to I2C1 pins on the RPi header
>     * I2C1 on the H3 is routed to I2C0 pins on the RPi header
>     * UART1 on the H3 is routed to UART0 pins on the RPi header
>     * SPI0 on the H3 is routed to SPI0 pins on the RPi header,
>       with GPIO pin PA17 replacing the missing Chip Select 1
>     * I2S1 on the H3 is routed to PCM pins on the RPi header
> 
>   - Additional peripherals from the H3 are available on different pins.
>     These include I2S0, JTAG, PWM1, SPDIF, SPI1, and UART3
> 
> In addition, there are a number of new features:
> 
>   - Console UART header
>   - Consumer IR receiver
>   - Camera interface (not compatible with RPi)
>   - Onboard microphone
>   - eMMC expansion module port
>   - Heatsink mounting holes
> 
> This patch adds a dts file for this board that enables all "onboard"
> peripherals currently supported. This means no display or camera
> support.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> There are two other variants [1] of this board, with different SoCs and
> DRAM configuration. But the board remains the same, thanks to the SoCs
> being pin compatible.
> 
> Do we need different board compatible strings? FWIW the soc compatible
> string already encodes the soc variant, and the DRAM stuff is handled
> by the bootloader. The filename also has the SoC family and chip name.
> The displayed board model also has the SoC variant included. The board
> itself is named "ALL-H3-CC".
> 
> I'm asking as we have the same issue with the Bananapi M2+ [2], where
> they've released new variants with different SoCs and DRAM capacities
> using the same board. Not sure if they are commercially available 
> though.

BPi M2+ H5 is not yet commercially available.

> 
> Last, the LED polarity is wrong. This is due to the EMAC driver not
> following the DT binding and looking for the 
> "allwinner,leds-active-low"
> under the PHY node, instead of the EMAC node. I've notified Corentin of
> this issue.
> 
> [1]
> https://www.kickstarter.com/projects/librecomputer/libre-computer-board-tritium-sbc-linux-android-7-n
> [2] http://www.banana-pi.org/m2plus.html
> ---
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 196 
> +++++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3c139c63098f..aa68f719692f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -953,6 +953,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-h2-plus-orangepi-zero.dtb \
>  	sun8i-h3-bananapi-m2-plus.dtb \
>  	sun8i-h3-beelink-x2.dtb \
> +	sun8i-h3-libretech-all-h3-cc.dtb \

There's also a H5 variant of this board, so I think the
peripherals should be placed into a DTSI, and have the
board DTS include the SoC DTSI and peripheral DTSI.

>  	sun8i-h3-nanopi-m1.dtb	\
>  	sun8i-h3-nanopi-m1-plus.dtb \
>  	sun8i-h3-nanopi-neo.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> new file mode 100644
> index 000000000000..6f544e007f71
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
> + *
> + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> + */
> +
> +/dts-v1/;
> +#include "sun8i-h3.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Libre Computer Board ALL-H3-CC H3";
> +	compatible = "libretech,all-h3-cc", "allwinner,sun8i-h3";
> +
> +	aliases {
> +		ethernet0 = &emac;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pwr_led {
> +			label = "librecomputer:pwr";
> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
> +			default-state = "on";
> +		};
> +
> +		status_led {
> +			label = "librecomputer:status";
> +			gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +
> +		recovery {
> +			label = "recovery";
> +			linux,code = <BTN_0>;
> +			gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
> +		};
> +	};
> +
> +	reg_vcc1v2: vcc1v2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc1v2";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&reg_vcc5v0>;
> +		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +		enable-active-high;
> +	};
> +
> +	reg_vcc3v3: vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&reg_vcc5v0>;
> +	};
> +
> +	/* This represents the board's 5V input */
> +	reg_vcc5v0: vcc5v0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_vcc_dram: vcc-dram {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-dram";
> +		regulator-min-microvolt = <1500000>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&reg_vcc5v0>;
> +		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
> +		enable-active-high;
> +	};
> +
> +	reg_vcc_io: vcc-io {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-io";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&reg_vcc3v3>;
> +		gpio = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL5 */
> +	};
> +
> +	reg_vdd_cpux: vdd-cpux {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-cpux";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&reg_vcc5v0>;
> +		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +		enable-active-high;
> +	};
> +};
> +
> +&codec {
> +	allwinner,audio-routing =
> +		"Line Out", "LINEOUT",
> +		"MIC1", "Mic",
> +		"Mic",  "MBIAS";
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ehci3 {
> +	status = "okay";
> +};
> +
> +&emac {
> +	phy-handle = <&int_mii_phy>;
> +	phy-mode = "mii";
> +	allwinner,leds-active-low;
> +	status = "okay";
> +};
> +
> +&ir {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&ir_pins_a>;
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins_a>;
> +	vmmc-supply = <&reg_vcc_io>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
> +	cd-inverted;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci1 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&ohci3 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_a>;
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	/* VBUS on USB ports are always on */
> +	usb0_vbus-supply = <&reg_vcc5v0>;
> +	usb1_vbus-supply = <&reg_vcc5v0>;
> +	usb2_vbus-supply = <&reg_vcc5v0>;
> +	usb3_vbus-supply = <&reg_vcc5v0>;
> +	status = "okay";
> +};
