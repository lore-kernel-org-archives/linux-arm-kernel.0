From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 13 Jun 2016 11:35:15 +0200
Subject: [PATCH] ARM: dts: sun8i: Add dts file for inet86dz board
In-Reply-To: <CAGb2v66cbx0jta1unrKeYm1t9JKO9Unw8z75rXbW3JSi2=NuMw@mail.gmail.com>
References: <1465754150-16753-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v66cbx0jta1unrKeYm1t9JKO9Unw8z75rXbW3JSi2=NuMw@mail.gmail.com>
Message-ID: <f080dda9-6410-ec79-f083-29a20d147d61@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 13-06-16 05:16, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Jun 13, 2016 at 1:55 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> The inet86dz board is a board used in 7" tablets from various oems.
>>
>> These tablets are a23 based 7" tablets featuring a 1024x600 LCD,
>> 512MB RAM, 4G NAND, rtl8188etv usb wifi, gsl1680 touchschreen,
>> micro-sd slot, 3.5mm headphone jack and a micro-usb otg connector
>> which doubles as charging port.
>
> This seems awfully similar to the sun8i-a23-q8-tablet, any reason
> not to include that or sun8i-q8-common.dtsi?

So to answer this both for this board and for the Polaroid MID2407PXE03
one, these are not q8 tablets, they are not using the standard q8 casing
at least. So using q8 for them would seem to be a bit confusing to users
and figuring out how to do proper autodetect is already hard enough without
throwing these into the mix too.

OTOH you are right that there is a lot of code duplication here. Since I
plan to start working on touchscreen autodetect soon-ish, let me see how
that goes first.

Maxime can you drop the Polaroid MID2407PXE03 patch for now ?

Regards,

Hans



>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/Makefile               |   1 +
>>  arch/arm/boot/dts/sun8i-a23-inet86dz.dts | 293 +++++++++++++++++++++++++++++++
>>  2 files changed, 294 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-a23-inet86dz.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 8223602..1ff5434 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -751,6 +751,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>>  dtb-$(CONFIG_MACH_SUN8I) += \
>>         sun8i-a23-evb.dtb \
>>         sun8i-a23-gt90h-v4.dtb \
>> +       sun8i-a23-inet86dz.dtb \
>>         sun8i-a23-ippo-q8h-v5.dtb \
>>         sun8i-a23-ippo-q8h-v1.2.dtb \
>>         sun8i-a23-polaroid-mid2407pxe03.dtb \
>> diff --git a/arch/arm/boot/dts/sun8i-a23-inet86dz.dts b/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
>> new file mode 100644
>> index 0000000..0405258
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-a23-inet86dz.dts
>> @@ -0,0 +1,293 @@
>> +/*
>> + * Copyright 2016 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This file is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This file is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +#include "sun8i-a23.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +
>> +/ {
>> +       model = "INet-86DZ Rev 01";
>> +       compatible = "primux,inet86dz", "allwinner,sun8i-a23";
>> +
>> +       aliases {
>> +               serial0 = &r_uart;
>> +       };
>> +
>> +       backlight: backlight {
>> +               compatible = "pwm-backlight";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&bl_en_pin_inet86dz>;
>> +               pwms = <&pwm 0 50000 PWM_POLARITY_INVERTED>;
>> +               brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
>> +               default-brightness-level = <8>;
>> +               enable-gpios = <&pio 7 6 GPIO_ACTIVE_HIGH>; /* PH6 */
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +};
>> +
>> +&ehci0 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&i2c0_pins_a>;
>> +       status = "okay";
>> +       /*
>> +        * The gsl1680 is rated at 400KHz and it will not work reliable at
>> +        * 100KHz, this has been confirmed on multiple different tablets.
>> +        * The gsl1680 is the only device on this bus.
>> +        */
>> +       clock-frequency = <400000>;
>> +
>> +       gsl1680: touchscreen at 40 {
>> +               compatible = "silead,gsl1680";
>
> Do we already have a driver for this? I don't see one in linux-next.
>
>> +               reg = <0x40>;
>> +               interrupt-parent = <&pio>;
>> +               interrupts = <1 5 IRQ_TYPE_EDGE_FALLING>; /* PB5 */
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&ts_power_pin_inet86dz>;
>> +               power-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>> +               touchscreen-size-x = <960>;
>> +               touchscreen-size-y = <640>;
>> +               touchscreen-max-fingers = <5>;
>> +               touchscreen-fw-name = "silead/gsl1680-inet86dz.fw";
>> +       };
>> +};
>> +
>> +&i2c1 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&i2c1_pins_a>;
>> +       status = "okay";
>> +};
>> +
>> +&lradc {
>> +       vref-supply = <&reg_vcc3v0>;
>> +       status = "okay";
>> +
>> +       button at 200 {
>> +               label = "Volume Up";
>> +               linux,code = <KEY_VOLUMEUP>;
>> +               channel = <0>;
>> +               voltage = <200000>;
>> +       };
>> +
>> +       button at 400 {
>> +               label = "Volume Down";
>> +               linux,code = <KEY_VOLUMEDOWN>;
>> +               channel = <0>;
>> +               voltage = <400000>;
>> +       };
>> +};
>> +
>> +&mmc0 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_inet86dz>;
>> +       vmmc-supply = <&reg_dcdc1>;
>> +       bus-width = <4>;
>> +       cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
>> +       cd-inverted;
>> +       status = "okay";
>> +};
>> +
>> +&pio {
>> +       bl_en_pin_inet86dz: bl_en_pin at 0 {
>> +               allwinner,pins = "PH6";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +       };
>> +
>> +       mmc0_cd_pin_inet86dz: mmc0_cd_pin at 0 {
>> +               allwinner,pins = "PB4";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +       };
>> +
>> +       ts_power_pin_inet86dz: ts_power_pin at 0 {
>> +               allwinner,pins = "PH1";
>> +               allwinner,function = "gpio_out";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +       };
>> +
>> +       usb0_id_detect_pin: usb0_id_detect_pin at 0 {
>> +               allwinner,pins = "PH8";
>> +               allwinner,function = "gpio_in";
>> +               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +               allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +       };
>> +};
>> +
>> +&pwm {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pwm0_pins>;
>> +       status = "okay";
>> +};
>> +
>> +&r_rsb {
>> +       status = "okay";
>> +
>> +       axp22x: pmic at 3a3 {
>> +               compatible = "x-powers,axp223";
>> +               reg = <0x3a3>;
>> +               interrupt-parent = <&nmi_intc>;
>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +               eldoin-supply = <&reg_dcdc1>;
>
> Adding a drivevbus-supply referencing vcc_5v0 so it doesn't
> show 0V would be nice.
>
> ChenYu
>
>> +               x-powers,drive-vbus-en;
>> +       };
>> +};
>> +
>> +&r_uart {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&r_uart_pins_a>;
>> +       status = "okay";
>> +};
>> +
>> +#include "axp22x.dtsi"
>> +
>> +&reg_aldo1 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <3000000>;
>> +       regulator-max-microvolt = <3000000>;
>> +       regulator-name = "vcc-io";
>> +};
>> +
>> +&reg_aldo2 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <2350000>;
>> +       regulator-max-microvolt = <2650000>;
>> +       regulator-name = "vdd-dll";
>> +};
>> +
>> +&reg_aldo3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <2700000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-pll-avcc";
>> +};
>> +
>> +&reg_dc1sw {
>> +       regulator-name = "vcc-lcd";
>> +};
>> +
>> +&reg_dc5ldo {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <900000>;
>> +       regulator-max-microvolt = <1400000>;
>> +       regulator-name = "vdd-cpus";
>> +};
>> +
>> +&reg_dcdc1 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <3000000>;
>> +       regulator-max-microvolt = <3000000>;
>> +       regulator-name = "vcc-3v0";
>> +};
>> +
>> +&reg_dcdc2 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <900000>;
>> +       regulator-max-microvolt = <1400000>;
>> +       regulator-name = "vdd-sys";
>> +};
>> +
>> +&reg_dcdc3 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <900000>;
>> +       regulator-max-microvolt = <1400000>;
>> +       regulator-name = "vdd-cpu";
>> +};
>> +
>> +&reg_dcdc5 {
>> +       regulator-always-on;
>> +       regulator-min-microvolt = <1500000>;
>> +       regulator-max-microvolt = <1500000>;
>> +       regulator-name = "vcc-dram";
>> +};
>> +
>> +&reg_dldo1 {
>> +       regulator-min-microvolt = <3300000>;
>> +       regulator-max-microvolt = <3300000>;
>> +       regulator-name = "vcc-wifi";
>> +};
>> +
>> +&reg_drivevbus {
>> +       regulator-name = "usb0-vbus";
>> +       status = "okay";
>> +};
>> +
>> +&reg_rtc_ldo {
>> +       regulator-name = "vcc-rtc";
>> +};
>> +
>> +&simplefb_lcd {
>> +       vcc-lcd-supply = <&reg_dc1sw>;
>> +};
>> +
>> +&usb_otg {
>> +       dr_mode = "otg";
>> +       status = "okay";
>> +};
>> +
>> +&usb_power_supply {
>> +       status = "okay";
>> +};
>> +
>> +&usbphy {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&usb0_id_detect_pin>;
>> +       usb0_id_det-gpio = <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
>> +       usb0_vbus_power-supply = <&usb_power_supply>;
>> +       usb0_vbus-supply = <&reg_drivevbus>;
>> +       usb1_vbus-supply = <&reg_dldo1>;
>> +       status = "okay";
>> +};
>> --
>> 2.7.4
>>
