From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Aug 2016 20:57:45 +0200
Subject: [PATCH v4 3/3] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <ce704da79c6263a4a5048af8f8e90f22e0849188.1471637309.git.ccc94453@vip.cybercity.dk>
References: <9f39145aa6a46a1e130c4b91bd120eabeb7c8929.1471637309.git.ccc94453@vip.cybercity.dk>
 <ce704da79c6263a4a5048af8f8e90f22e0849188.1471637309.git.ccc94453@vip.cybercity.dk>
Message-ID: <20160822185745.GC7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Aug 13, 2016 at 12:03:57AM +0200, Rask Ingemann Lambertsen wrote:
> The Suncip CX-A99 board is found in at least four brands of TV boxes.
> It features an Allwinner A80 SOC, with either 2 GiB DDR3 DRAM and
> 16 GB eMMC or 4 GiB DDR3 DRAM and 32 GB eMMC, as well as several support
> chips for Ethernet, wireless networking, video output, SATA and power
> management. For details, see the linux-sunxi page about the board
> <URL:https://linux-sunxi.org/Sunchip_CX-A99>.
> 
> This patch only adds support for the SD and eMMC storage, real-time clock,
> USB 2.0 ports (and by extension the SATA port), the UART port and the LEDs.
> All of this relies on the boot loader to leave those parts powered up, as
> I'm still working on a driver for the AXP808 PMIC.
> 
> Signed-off-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>

It looks mostly good, but I have a couple of comments though, see below.

> ---
> 
> Although the vendor U-Boot lets you boot the kernel on one of the
> Cortex-A15 cores, the kernel gpio-regulator driver currently glitches
> the GPIO lines to the OZ80120 regulator such that the system crashes
> during startup. This part needs further work to be useful.

So it doesn't power the CPU through one of the AXP regulators?
Interesting design.

> The driver for the AC100 real-time clock is found in Lee Jones' MFD branch
> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-rtc-v4.9
> and is not essential for using the board.
> 
> Changes in v4:
> Node names had underscores changed to hyphens.
> Changed formatting of the ac100/rtc node's clock output name list to match
> that of the same node in the cubieboard4 and a80-optimus device trees.
> 
> Changes in v3:
> None.
> 
> Changes in v2:
> Fixed formatting and style issues found by scripts/checkpatch.pl.
> 
>  arch/arm/boot/dts/Makefile             |   3 +-
>  arch/arm/boot/dts/sun9i-a80-cx-a99.dts | 261 +++++++++++++++++++++++++++++++++
>  2 files changed, 263 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6b3bdb6..8b77a53 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -796,7 +796,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>  	sun8i-r16-parrot.dtb
>  dtb-$(CONFIG_MACH_SUN9I) += \
>  	sun9i-a80-optimus.dtb \
> -	sun9i-a80-cubieboard4.dtb
> +	sun9i-a80-cubieboard4.dtb \
> +	sun9i-a80-cx-a99.dtb
>  dtb-$(CONFIG_ARCH_TANGO) += \
>  	tango4-vantage-1172.dtb
>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
> diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> new file mode 100644
> index 0000000..d08a35e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> @@ -0,0 +1,261 @@
> +/*
> + * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
> + *
> + * Copyright (C) 2016 Rask Ingemann Lamberten <ccc94453@vip.cybercity.dk>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/* The Sunchip CX-A99 board is found in several similar Android TV box
> + * products, such as:
> + *
> + * Instabox Fantasy A8 (no external antenna)
> + * Jesurun CS-Q8 (ships with larger remote control)
> + * Jesurun Maxone
> + * Rikomagic (RKM) MK80/MK80LE
> + * Tronsmart Draco AW80 Meta/Telos
> + *
> + * See <URL:https://linux-sunxi.org/Sunchip_cx_a99> for more information.
> + */
> +
> +/dts-v1/;
> +#include "sun9i-a80.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +
> +/ {
> +	model = "Sunchip CX-A99";
> +	compatible = "sunchip,cx-a99", "allwinner,sun9i-a80";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pins_cx_a99>;
> +
> +		blue {
> +			gpios = <&pio 6 10 GPIO_ACTIVE_HIGH>;	/* PG10 */
> +			label = "cx-a99:blue:normal";
> +			default-state = "on";
> +		};
> +
> +		red {
> +			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>;	/* PG11 */
> +			label = "cx-a99:red:standby";

The last part of the label should be the function.

> +		};
> +	};
> +
> +	/* Power supply for the four Cortex-A15 cores. */
> +	reg_vdd_cpub: oz80120 {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vdd-cpub";
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-type = "voltage";
> +		regulator-min-microvolt = < 800000>;
> +		regulator-max-microvolt = <1100000>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_cpub_r_pins_cx_a99>;
> +		enable-gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>;	/* PL2 */
> +		enable-active-high;
> +		gpios = <&r_pio 0 3 GPIO_ACTIVE_HIGH>,		/* PL3 */
> +			<&r_pio 0 4 GPIO_ACTIVE_HIGH>,		/* PL4 */
> +			<&r_pio 0 5 GPIO_ACTIVE_HIGH>;		/* PL5 */
> +		/* There appears to be an external pull-up on PL3. */
> +		gpios-states = <1 0 0>;
> +		states = <	 750000 0x7
> +				 800000 0x3
> +				 850000 0x5
> +				 900000 0x1
> +				 950000 0x6
> +				1000000 0x2
> +				1100000 0x4
> +				1200000 0x0>;
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
> +&mmc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_cx_a99>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 17 GPIO_ACTIVE_LOW>; /* PH17 */
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc2_8bit_pins>;
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&osc32k {
> +	clocks = <&ac100_rtc 0>;
> +};
> +
> +&pio {
> +	led_pins_cx_a99: led-pins {
> +		allwinner,pins = "PG10", "PG11";
> +		allwinner,function = "gpio_out";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +	};
> +
> +	mmc0_cd_pin_cx_a99: mmc0-cd {
> +		allwinner,pins = "PH17";
> +		allwinner,function = "gpio_in";
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
> +};
> +
> +/* Each GPIO controls VBUS for a port on the GL850G hub connected to ehci0;
> + * PL7 for port 1, the USB connector closest to the 12 V power connector, and
> + * PL8 for port 2, the USB connector next to the (micro)SD card slot.
> + * Note: The regulators are not chained like this in reality, but
> + * regulator-fixed doesn't support a gpio list, and allwinner,sun9i-a80-usb-phy
> + * doesn't support more than one supply, so this will have to do (for now).
> + */
> +&reg_usb1_vbus {
> +	pinctrl-0 = <&usb1_vbus_r_pin_cx_a99>;
> +	gpio = <&r_pio 0 7 GPIO_ACTIVE_HIGH>;	/* PL7 */
> +	status = "okay";
> +};
> +
> +&reg_usb2_vbus {
> +	pinctrl-0 = <&usb2_vbus_r_pin_cx_a99>;
> +	gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>;	/* PL8 */

I'd really prefer it to be modelled properly, and not attached to the
wrong device.

I have some work pending to allow multiple regulators in the same
property, but that won't be ready soon.

For the time being, I would suggest having two usb1 regulators
defined, each with their respective GPIOs, and one set to always on
(and keep that great comment).

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/aeedbfcc/attachment-0001.sig>
