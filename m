From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 24 Dec 2017 20:24:54 +0800
Subject: [linux-sunxi] [PATCH v3] ARM: sun8i: h2+: add support for Banana
 Pi M2 Zero board
In-Reply-To: <20171224080208.x27o2i6v6ml3im7q@plaes.org>
References: <20171224054029.12278-1-icenowy@aosc.io>
 <20171224080208.x27o2i6v6ml3im7q@plaes.org>
Message-ID: <4598591.qIIcbk4Suq@ice-x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017?12?24???? CST ??4:02:08?Priit Laes ???
> On Sun, Dec 24, 2017 at 01:40:29PM +0800, Icenowy Zheng wrote:
> > Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
> > factor and GPIO holes similar to Raspberry Pi Zero.
> > 
> > It features:
> > - Allwinner H2+ SoC
> > - Single-chip (16-bit) 512MiB DDR3 DRAM
> > - Ampak AP6212 Wi-Fi/Bluetooth module
> > - MicroSD slot
> > - Two MicroUSB Type-B ports (one can only be used to power the board and
> > 
> >   the other features OTG functionality)
> > 
> > - Two keys, a reset and a GPIO-connected key.
> > - HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
> > - CSI connector to connect the camera sensor provided by Sinovoip.
> > 
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> > Changes in v3:
> > - Add comments about Vbus problem in &usbphy node.
> > 
> > Changes in v2:
> > - Use high active SD card detect on the production batch.
> > 
> >  arch/arm/boot/dts/Makefile                         |   1 +
> >  .../boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 162
> >  +++++++++++++++++++++ 2 files changed, 163 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 0bb8db33704a..937a8768671f 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -962,6 +962,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
> > 
> >  	sun8i-a83t-cubietruck-plus.dtb \
> >  	sun8i-a83t-tbs-a711.dtb \
> >  	sun8i-h2-plus-orangepi-r1.dtb \
> > 
> > +	sun8i-h2-plus-bananapi-m2-zero.dtb \
> > 
> >  	sun8i-h2-plus-orangepi-zero.dtb \
> >  	sun8i-h3-bananapi-m2-plus.dtb \
> >  	sun8i-h3-beelink-x2.dtb \
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts new file mode
> > 100644
> > index 000000000000..5bc182ddc5f7
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> > @@ -0,0 +1,162 @@
> > +/*
> > + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > + *
> > + * Based on sun8i-h3-bananapi-m2-plus.dts, which is:
> > + *   Copyright (C) 2016 Chen-Yu Tsai <wens@csie.org>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun8i-h3.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +
> > +/ {
> > +	model = "Banana Pi BPI-M2-Zero";
> > +	compatible = "sinovoip,bpi-m2-zero", "allwinner,sun8i-h2-plus";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +
> > +		pwr_led {
> > +			label = "bananapi-m2-zero:red:pwr";
> > +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
> > +			default-state = "on";
> > +		};
> > +	};
> > +
> > +	gpio_keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +
> > +		sw4 {
> > +			label = "power";
> > +			linux,code = <BTN_0>;
> > +			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
> > +		};
> > +	};
> > +
> > +	wifi_pwrseq: wifi_pwrseq {
> > +		compatible = "mmc-pwrseq-simple";
> > +		pinctrl-names = "default";
> > +		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
> > +	};
> > +};
> > +
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > +&mmc0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc0_pins_a>;
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	bus-width = <4>;
> > +	/*
> > +	 * On the production batch of this board the card detect GPIO is
> > +	 * high active (card inserted), although on the early samples it's
> > +	 * low active.
> > +	 */
> 
> Is there a way to differentiate between early samples and production
> batches? Board markings, etc?

in fact there's no significant markings to differentiate them.

Howeverm the early samples are never sold; you will know it's an
early sample if you manage to get it from Sinovoip.

> 
> > +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
> > +	status = "okay";
> > +};
> > +
> > +&mmc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins_a>;
> > +	vmmc-supply = <&reg_vcc3v3>;
> > +	vqmmc-supply = <&reg_vcc3v3>;
> > +	mmc-pwrseq = <&wifi_pwrseq>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	status = "okay";
> > +
> > +	brcmf: wifi at 1 {
> > +		reg = <1>;
> > +		compatible = "brcm,bcm4329-fmac";
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
> > +		interrupt-names = "host-wake";
> > +	};
> > +};
> > +
> > +&ohci0 {
> > +	status = "okay";
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_pins_a>;
> > +	status = "okay";
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> > +	status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +	dr_mode = "otg";
> > +	status = "okay";
> > +};
> > +
> > +&usbphy {
> > +	usb0_id_det-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
> > +	/*
> > +	 * There're two micro-USB connectors, one is power-only and another is
> > +	 * OTG. The Vbus of these two connectors are connected together, so
> > +	 * the external USB device will be powered just by the power input
> > +	 * from the power-only USB port.
> > +	 */
> > +	status = "okay";
> > +};
