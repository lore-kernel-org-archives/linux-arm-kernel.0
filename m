From: codekipper@gmail.com (Code Kipper)
Date: Thu, 12 Jan 2017 18:39:06 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun8i-h3: Add dts for the Beelink
 X2 STB
In-Reply-To: <20170112172813.cbwqfpjlprkxdzcp@lukather>
References: <20170112171135.7822-1-codekipper@gmail.com>
 <20170112172813.cbwqfpjlprkxdzcp@lukather>
Message-ID: <CAEKpxBk-PJb70s-kPur86mW1OYLvuGg3oXQkyH94+2qGZhon4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 January 2017 at 18:28, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Jan 12, 2017 at 06:11:35PM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The Beelink X2 is an STB based on the Allwinner H3 SoC with a uSD slot,
>> 2 USB ports( 1 * USB-2 Host, 1 USB OTG), a 10/100M ethernet port using the
>> SoC's integrated PHY, Wifi via a RTL8189ETV sdio wifi chip, HDMI, an IR
>> receiver, 1 LEDs and an optical S/PDIF connector.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                |   1 +
>>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 187 ++++++++++++++++++++++++++++++
>>  2 files changed, 188 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 78a94b747059..75960b1468a4 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -857,6 +857,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>       sun8i-a83t-cubietruck-plus.dtb \
>>       sun8i-h2-plus-orangepi-zero.dtb \
>>       sun8i-h3-bananapi-m2-plus.dtb \
>> +     sun8i-h3-beelink-x2.dtb \
>>       sun8i-h3-nanopi-m1.dtb  \
>>       sun8i-h3-nanopi-neo.dtb \
>>       sun8i-h3-orangepi-2.dtb \
>> diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
>> new file mode 100644
>> index 000000000000..bc5aed52cb1d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
>> @@ -0,0 +1,187 @@
>> +/*
>> + * Copyright (C) 2017 Marcus Cooper <codekipper@gmail.com>
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
>> +#include "sun8i-h3.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>> +
>> +/ {
>> +     model = "Beelink X2";
>> +     compatible = "roofull,beelink-x2", "allwinner,sun8i-h3";
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +             /* ethernet0 is the H3 emac, defined in sun8i-h3.dtsi */
>> +             ethernet1 = &rtl8189ftv;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     leds {
>> +             compatible = "gpio-leds";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pwr_led_x2>;
>
> Please drop all the pinctrl nodes for the GPIOs. They're useless, and
> will be harmful when we'll switch to a stricter pinctrl driver.
>
ACK
>> +
>> +             pwr_led {
>> +                     label = "beelink-x2:red:pwr";
>> +                     gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
>> +                     default-state = "on";
>> +             };
>> +     };
>> +
>> +     gpio_keys {
>> +             compatible = "gpio-keys";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&sw_r_x2>;
>> +
>> +             sw4 {
>> +                     label = "power";
>> +                     linux,code = <BTN_0>;
>
> Should that be BTN_0 then if the label is that one?
>
ACK
>> +                     gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
>> +             };
>> +     };
>> +
>> +     wifi_pwrseq: wifi_pwrseq {
>> +             compatible = "mmc-pwrseq-simple";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&wifi_en_x2>;
>> +             reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>> +     };
>> +};
>> +
>> +&ehci1 {
>> +     status = "okay";
>> +};
>> +
>> +&ir {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&ir_pins_a>;
>> +     status = "okay";
>> +};
>> +
>> +&mmc0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>> +     vmmc-supply = <&reg_vcc3v3>;
>> +     bus-width = <4>;
>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
>> +     cd-inverted;
>> +     status = "okay";
>> +};
>> +
>> +&mmc1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc1_pins_a>;
>> +     vmmc-supply = <&reg_vcc3v3>;
>> +     bus-width = <4>;
>> +     non-removable;
>> +     status = "okay";
>> +
>> +     /*
>> +      * Explicitly define the sdio device, so that we can add an ethernet
>> +      * alias for it (which e.g. makes u-boot set a mac-address).
>> +      */
>> +     rtl8189ftv: sdio_wifi at 1 {
>> +             reg = <1>;
>> +     };
>> +};
>> +
>> +&mmc2 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc2_8bit_pins>;
>> +     vmmc-supply = <&reg_vcc3v3>;
>> +     bus-width = <8>;
>> +     non-removable;
>> +     cap-mmc-hw-reset;
>> +     status = "okay";
>> +};
>> +
>> +&mmc2_8bit_pins {
>> +     /* Increase drive strength for DDR modes */
>> +     drive-strength = <40>;
>
> Have you actually tested that it was needed?
>
I'll confess that I've rushed this one as I just wanted to verify my
spdif changes. I'll respin this,
BR,
CK
>> +     /* eMMC is missing pull-ups */
>> +     bias-pull-up;
>
> This is already enabled in the DTSI.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
