From: contact@paulk.fr (Paul Kocialkowski)
Date: Thu, 12 Apr 2018 01:08:51 +0200
Subject: [PATCH 3/3] ARM: dts: sun7i: Add support for the Ainol AW1 tablet
In-Reply-To: <20180411070657.kw6uckqtmwb7p5hf@flea>
References: <20180410213129.24049-1-contact@paulk.fr>
 <20180410213129.24049-3-contact@paulk.fr>
 <20180411070657.kw6uckqtmwb7p5hf@flea>
Message-ID: <7f6d6a6a5a0cc2d37ebba046509d4f25d3bfa600.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi and thanks for the review !

Le mercredi 11 avril 2018 ? 09:06 +0200, Maxime Ripard a ?crit :
> Hi,
> 
> On Tue, Apr 10, 2018 at 11:31:29PM +0200, Paul Kocialkowski wrote:
> > This adds support for the Ainol AW1, an A20-based 7" tablet from
> > Ainol.
> > 
> > The following board-specific features are supported:
> > * LCD panel
> > * Backlight
> > * USB OTG
> > * Buttons
> > * Touchscreen (doesn't work without non-free firmware)
> > * Accelerometer
> > * Battery
> > 
> > The following are untested:
> > * Audio output
> > * Audio speakers
> > * USB via SPCI connector
> > 
> > The following are not supported:
> > * Wi-Fi
> > * Bluetooth
> > * NAND
> > * Audio via SPCI connector
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  arch/arm/boot/dts/Makefile                |   1 +
> >  arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts | 358
> > ++++++++++++++++++++++++++++++
> >  2 files changed, 359 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 9f7133b6fba0..03bfacebfdbd 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -929,6 +929,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
> >  	sun6i-a31s-sinovoip-bpi-m2.dtb \
> >  	sun6i-a31s-yones-toptech-bs1078-v2.dtb
> >  dtb-$(CONFIG_MACH_SUN7I) += \
> > +	sun7i-a20-ainol-aw1.dtb \
> >  	sun7i-a20-bananapi.dtb \
> >  	sun7i-a20-bananapi-m1-plus.dtb \
> >  	sun7i-a20-bananapro.dtb \
> > diff --git a/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> > b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> > new file mode 100644
> > index 000000000000..697586991aea
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun7i-a20-ainol-aw1.dts
> > @@ -0,0 +1,358 @@
> > +/*
> > + * Copyright 2018 Paul Kocialkowski <contact@paulk.fr>
> > + *
> > + * This file is dual-licensed: you can use it either under the
> > terms
> > + * of the GPL or the X11 license, at your option. Note that this
> > dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License
> > as
> > + *     published by the Free Software Foundation; either version 2
> > of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty
> > of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated
> > documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom
> > the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall
> > be
> > + *     included in all copies or substantial portions of the
> > Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> > KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
> > WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
> > OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> 
> Can you use an SPDX header instead of the whole license text?

Sure, will do in v2.

> > + */
> > +
> > +/dts-v1/;
> > +#include "sun7i-a20.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +
> > +/ {
> > +	model = "Ainol AW1";
> > +	compatible = "ainol,ainol-aw1", "allwinner,sun7i-a20";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&backlight_enable_pin>;
> 
> You don't need any of the pinctrl nodes for the GPIOs

I tried without the pinctrl nodes and got issues on various controllers
(e.g. i2c for the touchscreen) because of the missing pinctrl nodes on
4.16. Maybe I'm missing some patches here?

> > +		pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +		brightness-levels = <0 10 20 30 40 50 60 70 80 90
> > 100>;
> > +		default-brightness-level = <5>;
> > +		enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7
> > */
> > +	};
> > +
> > +	panel: panel {
> > +		compatible = "innolux,at070tn92";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		power-supply = <&panel_power>;
> > +		backlight = <&backlight>;
> > +
> > +		port at 0 {
> > +			reg = <0>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			panel_input: endpoint at 0 {
> > +				reg = <0>;
> > +				remote-endpoint =
> > <&tcon0_out_panel>;
> > +			};
> > +		};
> > +	};
> > +
> > +	panel_power: panel_power {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&panel_power_pin>;
> > +		regulator-name = "panel-power";
> > +		regulator-min-microvolt = <10400000>;
> > +		regulator-max-microvolt = <10400000>;
> > +		gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> > +		enable-active-high;
> 
> Sigh, we should really convert regulator-fixed to use the proper GPIO
> API here...
> 
> > +		regulator-boot-on;
> > +	};
> > +};
> > +
> > +&codec {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&codec_pa_pin>;
> > +	allwinner,pa-gpios = <&pio 7 15 GPIO_ACTIVE_HIGH>; /* PH15
> > */
> > +	status = "okay";
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&reg_dcdc2>;
> > +};
> 
> How was CPUfreq tested?

In fact, I haven't tried it at all, but I can definitely do that with
e.g. ssvb's stress test for various cpufreq functioning points.

> > +
> > +&de {
> > +	status = "okay";
> > +};
> > +
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ehci1 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c0_pins_a>;
> > +	status = "okay";
> > +
> > +	axp209: pmic at 34 {
> > +		reg = <0x34>;
> > +		interrupt-parent = <&nmi_intc>;
> > +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins_a>;
> > +	status = "okay";
> > +
> > +	lis3dh: accelerometer at 18 {
> > +		compatible = "st,lis3dh-accel";
> > +		reg = <0x18>;
> > +		vdd-supply = <&reg_vcc3v3>;
> > +		vddio-supply = <&reg_vcc3v3>;
> > +		st,drdy-int-pin = <1>;
> > +	};
> > +};
> > +
> > +&i2c2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c2_pins_a>;
> > +	status = "okay";
> > +	clock-frequency = <400000>; /* 400 KHz required for
> > GSL1680. */
> 
> I'm not sure that comment is worth it. The only device there is the
> touchscreen, so it's kind of obvious that it's the device that needs
> that frequency.

Well, I found a similar comment in the other dts using the same
touchscreen controller. Since the information was rather valuable (it
made it clear that I needed the same clock frequency for that specific
touchscreen), it might help others in the future (even if only when
grepping for gsl1680).

> > +
> > +	gsl1680: touchscreen at 40 {
> > +		compatible = "silead,gsl1680";
> > +		reg = <0x40>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&touchscreen_power_pin>;
> > +		interrupt-parent = <&pio>;
> > +		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /*
> > EINT21 (PH21) */
> > +		power-gpios = <&pio 7 20 GPIO_ACTIVE_HIGH>; /* PH20
> > */
> > +		firmware-name = "gsl1680-ainol-aw1.fw";
> > +		touchscreen-size-x = <480>;
> > +		touchscreen-size-y = <800>;
> > +		touchscreen-swapped-x-y;
> > +		touchscreen-inverted-y;
> > +		silead,max-fingers = <5>;
> > +	};
> > +};
> > +
> > +&lradc {
> > +	vref-supply = <&reg_vcc3v0>;
> 
> You should use the proper regulator from the PMIC here.

Fair enough, I'll look into that and try to fix it in v2. I think this
was inspired from another dts using lradc for buttons.

> > +	status = "okay";
> > +
> > +	button at 571 {
> > +		label = "Volume Up";
> > +		linux,code = <KEY_VOLUMEUP>;
> > +		channel = <0>;
> > +		voltage = <571428>;
> > +	};
> > +
> > +	button at 761 {
> > +		label = "Volume Down";
> > +		linux,code = <KEY_VOLUMEDOWN>;
> > +		channel = <0>;
> > +		voltage = <761904>;
> > +	};
> > +
> > +	button at 952 {
> > +		label = "Home";
> > +		linux,code = <KEY_HOME>;
> > +		channel = <0>;
> > +		voltage = <952380>;
> > +	};
> > +};
> > +
> > +&mmc0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc0_pins_a>;
> > +	vmmc-supply = <&reg_vcc3v3>;
> 
> And here too.

I will also look into it for v2 then.

> > +	bus-width = <4>;
> > +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
> > +	cd-inverted;
> > +	status = "okay";
> > +};
> > +
> > +&ohci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ohci1 {
> > +	status = "okay";
> > +};
> > +
> > +&otg_sram {
> > +	status = "okay";
> > +};
> > +
> > +&pio {
> > +	panel_power_pin: panel_power_pin at 0 {
> > +		pins = "PH8";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	backlight_enable_pin: backlight_enable_pin at 0 {
> > +		pins = "PH7";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	touchscreen_power_pin: touchscreen_power_pin at 0 {
> > +		pins = "PH20";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	codec_pa_pin: codec_pa_pin at 0 {
> > +		pins = "PH15";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> > +		pins = "PH4";
> > +		function = "gpio_in";
> > +		bias-pull-up;
> > +	};
> > +
> > +	usb0_vbus_pin: usb0_vbus_pin at 0 {
> > +		pins = "PB9";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	usb1_vbus_pin: usb1_vbus_pin at 0 {
> > +		pins = "PH6";
> > +		function = "gpio_out";
> > +	};
> > +
> > +	usb2_vbus_pin: usb2_vbus_pin at 0 {
> > +		pins = "PH3";
> > +		function = "gpio_out";
> > +	};
> > +};
> > +
> > +&pwm {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pwm0_pins_a>;
> > +	status = "okay";
> > +};
> > +
> > +&tcon0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&lcd_rgb666_pins>;
> > +	status = "okay";
> > +};
> > +
> > +&tcon0_out {
> > +	tcon0_out_panel: endpoint at 0 {
> > +		reg = <0>;
> > +		remote-endpoint = <&panel_input>;
> > +	};
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&uart0_pins_a>;
> > +	status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +	dr_mode = "otg";
> > +	status = "okay";
> > +};
> > +
> > +&usbphy {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&usb0_id_detect_pin>;
> > +	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> > +	usb0_vbus_power-supply = <&usb_power_supply>;
> > +	usb0_vbus-supply = <&reg_usb0_vbus>;
> > +	usb1_vbus-supply = <&reg_usb1_vbus>;
> > +	usb2_vbus-supply = <&reg_usb2_vbus>;
> 
> And here as well.

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/1ad2d5c0/attachment.sig>
