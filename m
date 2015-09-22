From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 22 Sep 2015 20:57:34 +0800
Subject: [linux-sunxi] Re: [PATCH 5/5] ARM: sun5i: Add C.H.I.P DTS
In-Reply-To: <20150922124708.GZ4684@lukather>
References: <1442566130-3497-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442566130-3497-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64E-gQu1U_qi2fTWiCmfgMdMR4X6yLUerV21d3E1uQ1cw@mail.gmail.com>
 <20150922124708.GZ4684@lukather>
Message-ID: <CAGb2v662+mhFgv1DXz5muA+xGE99R1DVKOxtVPvJmc+tRFPXzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 8:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Sep 19, 2015 at 12:41:07AM +0800, Chen-Yu Tsai wrote:
>> On Fri, Sep 18, 2015 at 4:48 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > The C.H.I.P. is a small SBC with an Allwinner R8, 8GB of NAND, 512MB of
>> > RAM, USB host and OTG, a wifi / bluetooth combo chip, an audio/video jack
>> > and two connectors to plug additional boards on top of it.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  arch/arm/boot/dts/Makefile          |   3 +-
>> >  arch/arm/boot/dts/sun5i-r8-chip.dts | 261 ++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 263 insertions(+), 1 deletion(-)
>> >  create mode 100644 arch/arm/boot/dts/sun5i-r8-chip.dts
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> > index b276174b670a..7efd37b907f1 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -599,7 +599,8 @@ dtb-$(CONFIG_MACH_SUN5I) += \
>> >         sun5i-a13-inet-98v-rev2.dtb \
>> >         sun5i-a13-olinuxino.dtb \
>> >         sun5i-a13-olinuxino-micro.dtb \
>> > -       sun5i-a13-utoo-p66.dtb
>> > +       sun5i-a13-utoo-p66.dtb \
>> > +       sun5i-r8-chip.dtb
>> >  dtb-$(CONFIG_MACH_SUN6I) += \
>> >         sun6i-a31-app4-evb1.dtb \
>> >         sun6i-a31-colombus.dtb \
>> > diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
>> > new file mode 100644
>> > index 000000000000..6cb3c4f1cd61
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
>> > @@ -0,0 +1,261 @@
>> > +/*
>> > + * Copyright 2015 Free Electrons
>> > + * Copyright 2015 NextThing Co
>> > + *
>> > + * Maxime Ripard <maxime.ripard@free-electrons.com>
>> > + *
>> > + * This file is dual-licensed: you can use it either under the terms
>> > + * of the GPL or the X11 license, at your option. Note that this dual
>> > + * licensing only applies to this file, and not this project as a
>> > + * whole.
>> > + *
>> > + *  a) This file is free software; you can redistribute it and/or
>> > + *     modify it under the terms of the GNU General Public License as
>> > + *     published by the Free Software Foundation; either version 2 of the
>> > + *     License, or (at your option) any later version.
>> > + *
>> > + *     This file is distributed in the hope that it will be useful,
>> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + *     GNU General Public License for more details.
>> > + *
>> > + * Or, alternatively,
>> > + *
>> > + *  b) Permission is hereby granted, free of charge, to any person
>> > + *     obtaining a copy of this software and associated documentation
>> > + *     files (the "Software"), to deal in the Software without
>> > + *     restriction, including without limitation the rights to use,
>> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> > + *     sell copies of the Software, and to permit persons to whom the
>> > + *     Software is furnished to do so, subject to the following
>> > + *     conditions:
>> > + *
>> > + *     The above copyright notice and this permission notice shall be
>> > + *     included in all copies or substantial portions of the Software.
>> > + *
>> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> > + *     OTHER DEALINGS IN THE SOFTWARE.
>> > + */
>> > +
>> > +/dts-v1/;
>> > +#include "sun5i-a13.dtsi"
>> > +
>> > +#include <dt-bindings/gpio/gpio.h>
>> > +#include <dt-bindings/interrupt-controller/irq.h>
>> > +
>> > +/ {
>> > +       model = "NextThing C.H.I.P.";
>> > +       compatible = "nextthing,chip", "allwinner,sun5i-r8";
>> > +
>> > +       aliases {
>> > +               i2c0 = &i2c0;
>> > +               i2c1 = &i2c1;
>> > +               i2c2 = &i2c2;
>> > +               serial0 = &uart1;
>> > +               serial1 = &uart3;
>> > +       };
>> > +
>> > +       chosen {
>> > +               stdout-path = "serial0:115200n8";
>> > +       };
>> > +
>> > +       dram_vcc: dram_vcc {
>> > +               compatible = "regulator-fixed";
>> > +               regulator-name = "dram-vcc";
>> > +               regulator-min-microvolt = <1600000>;
>> > +               regulator-max-microvolt = <1600000>;
>> > +               vin-supply = <&ipsout>;
>> > +               regulator-always-on;
>> > +       };
>>
>> Do we need this if it's not controllable?
>
> Probably not, except if we want a comprehensive regulator tree.
>
>> > +
>> > +       ipsout: ipsout {
>> > +               compatible = "regulator-fixed";
>> > +               regulator-name = "ipsout";
>> > +               regulator-min-microvolt = <5000000>;
>> > +               regulator-max-microvolt = <5000000>;
>> > +               regulator-always-on;
>> > +       };
>>
>> This isn't needed. What we might want is a proper representation
>> of the AXP209's power supply.
>
> Probably.
>
>> > +
>> > +       usb0_vbus: usb0_vbus {
>> > +               compatible = "regulator-fixed";
>> > +               pinctrl-names = "default";
>> > +               pinctrl-0 = <&chip_vbus_pin>;
>> > +
>> > +               regulator-name = "vbus-usb0";
>> > +               regulator-min-microvolt = <5000000>;
>> > +               regulator-max-microvolt = <5000000>;
>> > +               vin-supply = <&vcc_5v0>;
>> > +               gpio = <&pio 1 10 GPIO_ACTIVE_HIGH>; /* PB10 */
>> > +               enable-active-high;
>> > +       };
>> > +
>> > +       vcc_3v3: vcc3v3 {
>> > +               compatible = "regulator-fixed";
>> > +               regulator-name = "vcc-3v3";
>> > +               regulator-min-microvolt = <3300000>;
>> > +               regulator-max-microvolt = <3300000>;
>> > +               vin-supply = <&ipsout>;
>> > +               regulator-always-on;
>> > +       };
>> > +
>> > +       vcc_5v0: vcc5v0 {
>> > +               compatible = "regulator-fixed";
>> > +               regulator-name = "vcc-5v0";
>> > +               regulator-min-microvolt = <5000000>;
>> > +               regulator-max-microvolt = <5000000>;
>> > +               vin-supply = <&ipsout>;
>> > +               regulator-always-on;
>> > +       };
>>
>> We have these in sunxi-common-regulators.dtsi.
>
> True, I'll change that.
>
>>
>> > +};
>> > +
>> > +&ehci0 {
>> > +       status = "okay";
>> > +};
>> > +
>> > +&i2c0 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&i2c0_pins_a>;
>> > +       status = "okay";
>> > +
>> > +       axp209: pmic at 34 {
>> > +               reg = <0x34>;
>> > +
>> > +               /*
>> > +                * The interrupt is routed through the "External Fast
>> > +                 * Interrupt Request" pin (ball G13 of the module)
>> > +                 * directly to the main interrupt controller, without
>> > +                 * any other controller interfering.
>> > +                */
>> > +               interrupts = <0>;
>> > +       };
>> > +};
>> > +
>> > +#include "axp209.dtsi"
>> > +
>> > +/*
>> > + * i2c1 is routed to the external pins and doesn't have any device
>> > + * attached to it on the C.H.I.P itself.
>> > + */
>> > +&i2c1 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&i2c1_pins_a>;
>> > +       status = "okay";
>> > +};
>> > +
>> > +&i2c2 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&i2c2_pins_a>;
>> > +       status = "okay";
>> > +
>> > +       xio: gpio at 38 {
>> > +               compatible = "nxp,pcf8574a";
>> > +               reg = <0x38>;
>> > +
>> > +               gpio-controller;
>> > +               #gpio-cells = <2>;
>> > +
>> > +               interrupt-parent = <&pio>;
>> > +               interrupts = <6 0 IRQ_TYPE_EDGE_FALLING>;
>> > +               interrupt-controller;
>> > +               #interrupt-cells = <2>;
>> > +       };
>> > +};
>> > +
>> > +&mmc0 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&mmc0_pins_a>;
>> > +       vmmc-supply = <&vcc_3v3>;
>> > +       bus-width = <4>;
>> > +       non-removable;
>> > +       status = "okay";
>> > +};
>> > +
>> > +&ohci0 {
>> > +       status = "okay";
>> > +};
>> > +
>> > +&otg_sram {
>> > +       status = "okay";
>> > +};
>> > +
>> > +&pio {
>> > +       chip_vbus_pin: chip_vbus_pin at 0 {
>> > +               allwinner,pins = "PB10";
>> > +               allwinner,function = "gpio_out";
>> > +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> > +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> > +       };
>> > +
>> > +       chip_id_det_pin: chip_id_det_pin at 0 {
>> > +               allwinner,pins = "PG2";
>> > +               allwinner,function = "gpio_in";
>> > +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> > +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> > +       };
>> > +};
>> > +
>> > +&reg_dcdc2 {
>> > +       regulator-min-microvolt = <1000000>;
>> > +       regulator-max-microvolt = <1400000>;
>> > +       regulator-name = "cpuvdd";
>> > +       regulator-always-on;
>> > +};
>> > +
>> > +&reg_dcdc3 {
>> > +       regulator-min-microvolt = <1000000>;
>> > +       regulator-max-microvolt = <1300000>;
>> > +       regulator-name = "corevdd";
>> > +       regulator-always-on;
>> > +};
>> > +
>> > +&reg_ldo1 {
>> > +       regulator-name = "rtcvdd";
>> > +};
>> > +
>> > +&reg_ldo2 {
>> > +       regulator-min-microvolt = <2700000>;
>> > +       regulator-max-microvolt = <3300000>;
>>
>> Maybe just fix this to 3.0V?
>
> Those are constraints that the board can accept. We have that
> information, why lie about it?

I'm ok either way. We fixed it to 3.0V for the cubieboard2 and the cubietruck.

>>
>> > +       regulator-name = "avcc";
>> > +       regulator-always-on;
>> > +};
>> > +
>> > +&reg_ldo5 {
>> > +       regulator-min-microvolt = <1800000>;
>> > +       regulator-max-microvolt = <1800000>;
>> > +       regulator-name = "vcc-1v8";
>>
>> A comment here saying this is found on the header, and to be used
>> by overlays would be nice.
>
> There's open schematics for that kind of information.

Fair enough.

>> > +};
>> > +
>> > +&uart1 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&uart1_pins_b>;
>> > +       status = "okay";
>> > +};
>> > +
>> > +&uart3 {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&uart3_pins_a>,
>> > +                   <&uart3_pins_cts_rts_a>;
>> > +       status = "okay";
>> > +};
>> > +
>> > +&usb_otg {
>> > +       dr_mode = "otg";
>> > +       status = "okay";
>> > +};
>> > +
>> > +&usbphy {
>> > +       pinctrl-names = "default";
>> > +       pinctrl-0 = <&chip_id_det_pin>;
>> > +       status = "okay";
>> > +
>> > +       usb0_id_det-gpio = <&pio 6 2 GPIO_ACTIVE_HIGH>; /* PG2 */
>>
>> Better leave a comment here saying VBUS detection requires AXP209
>> usb-power-supply support.
>
> Does it? It can be powered by a battery, with or without VBUS, and
> that wouldn't be tied to the fact that the power-supply is USB or
> something else.

The AXP209 VBUS / USB power-supply also doubles for VBUS detection,
which on most boards is done using a separate GPIO pin. Hans posted
support for the AXP20X power-supply driver, and support in the usb
phy driver using it for VBUS detection.

In short, this is not about "power supply" but VBUS detection. IIRC,
if no VBUS detection method is provided, the phy driver just waits a
period of time after an ID pin change and then considers VBUS invalid.


Regards
ChenYu
