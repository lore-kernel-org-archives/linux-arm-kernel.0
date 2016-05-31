From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 May 2016 11:03:51 +0800
Subject: [PATCH] ARM: dts: sun7i: Add dts file for Bananapi M1 Plus board
In-Reply-To: <20160530194340.GE4908@lukather>
References: <20160530123013.11575-1-luoyi.ly@gmail.com>
 <20160530194340.GE4908@lukather>
Message-ID: <CAGb2v66ojJfSoCQ13rGyfi4XjbzkZfMn=gfPFN+mQmv8NoBqfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 31, 2016 at 3:43 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, May 30, 2016 at 08:30:13PM +0800, luoyi.ly at gmail.com wrote:
>> From: luoyi <luoyi.ly@gmail.com>
>>
>> Add support for the Bananapi M1 Plus A20 development board from sinovoip.com.cn .
>> This board features 1G RAM, 2 USB A receptacles, 1 micro USB receptacle for
>> OTG, 1 micro USB receptacle for power, HDMI, sata, Gbit ethernet, ir receiver,
>> 3.5 mm jack for stero sound out, on board microphone, 40 gpio pins and sdio wifi.
>
> What is the difference between the M1+ and the M1?
>
>>
>> Signed-off-by: Luo Yi <luoyi.ly@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                       |   1 +
>>  arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 270 +++++++++++++++++++++++
>>  2 files changed, 271 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index e06a5ab..fde407f 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -685,6 +685,7 @@ dtb-$(CONFIG_MACH_SUN6I) += \
>>       sun6i-a31s-yones-toptech-bs1078-v2.dtb
>>  dtb-$(CONFIG_MACH_SUN7I) += \
>>       sun7i-a20-bananapi.dtb \
>> +     sun7i-a20-bananapi-m1-plus.dtb \
>>       sun7i-a20-bananapro.dtb \
>>       sun7i-a20-cubieboard2.dtb \
>>       sun7i-a20-cubietruck.dtb \
>> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
>> new file mode 100644
>> index 0000000..b62fc1d
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
>> @@ -0,0 +1,270 @@
>> +/*
>> + * Copyright 2016 Luo Yi <luoyi.ly@gmail.com>
>> + *
>> + * Thanks to the original work by Hans de Goede <hdegoede@redhat.com>
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
>> +#include "sun7i-a20.dtsi"
>> +#include "sunxi-common-regulators.dtsi"
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +     model = "Banana Pi BPI-M1-Plus";
>> +     compatible = "sinovoip,bpi-m1-plus", "allwinner,sun7i-a20";
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     leds {
>> +             compatible = "gpio-leds";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&led_pins_bananapi>;
>> +
>> +             red {
>> +                     label = "bananapi:red:usr";
>
> The first part the label is the board name, in that case that would be
> bananapi-m1-plus.
>
>> +                     gpios = <&pio 7 25 GPIO_ACTIVE_HIGH>;
>> +                     linux,default-trigger = "default-on";
>
> So that's the power led?
>
>> +             };
>> +
>> +             green {
>> +                     label = "bananapi:green:usr";
>> +                     gpios = <&pio 7 24 GPIO_ACTIVE_HIGH>;
>> +                     linux,default-trigger = "heartbeat";
>
> We don't enforce any trigger by default.
>
>> +
>> +             };
>> +     };
>> +
>> +     reg_gmac_3v3: gmac-3v3 {
>> +             compatible = "regulator-fixed";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&gmac_power_pin_bananapi>;
>> +             regulator-name = "gmac-3v3";
>> +             regulator-min-microvolt = <3300000>;
>> +             regulator-max-microvolt = <3300000>;
>> +             startup-delay-us = <100000>;
>> +             enable-active-high;
>> +             gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>;
>> +     };
>> +
>> +     reg_vmmc3: vmmc3 {
>> +             compatible = "regulator-fixed";
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&vmmc3_pin_bananapi>;
>> +             regulator-name = "vmmc3";
>> +             regulator-min-microvolt = <3300000>;
>> +             regulator-max-microvolt = <3300000>;
>> +             regulator-always-on;
>> +             regulator-boot-on;
>> +             enable-active-high;
>> +             gpio = <&pio 7 22 GPIO_ACTIVE_HIGH>;
>> +     };
>
> You can use reg_vcc3v3 from sunxi-common-regulators.dtsi.

This is a GPIO controlled one, not just a fixed regulator.

However, this is a misrepresentation of what is on the board.

PH22 here is connected to the REG_ON pin on the WiFi chip.
So either you represent this as a GPIO toggled fixed
regulator with a source from reg_vcc3v3, and use this as
vmmc on mmc3. Or you use the pwrseq_simple bindings for
this.


ChenYu

>
>> +
>> +};
>> +
>> +&ahci {
>> +     status = "okay";
>> +};
>> +
>> +&codec {
>> +     status = "okay";
>> +};
>> +
>> +&ehci0 {
>> +     status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +     status = "okay";
>> +};
>> +
>> +&ohci0 {
>> +     status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +     status = "okay";
>> +};
>
> Please order your nodes alphabetically.
>
>> +
>> +&gmac {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&gmac_pins_rgmii_a>;
>> +     phy = <&phy1>;
>> +     phy-mode = "rgmii";
>> +     phy-supply = <&reg_gmac_3v3>;
>> +     status = "okay";
>> +
>> +     phy1: ethernet-phy at 1 {
>> +             reg = <1>;
>> +     };
>> +};
>> +
>> +&i2c0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c0_pins_a>;
>> +     status = "okay";
>> +
>> +     axp209: pmic at 34 {
>> +             compatible = "x-powers,axp209";
>> +             reg = <0x34>;
>> +             interrupt-parent = <&nmi_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +
>> +             interrupt-controller;
>> +             #interrupt-cells = <1>;
>> +     };
>> +};
>> +
>> +&ir0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&ir0_rx_pins_a>;
>> +     status = "okay";
>> +};
>> +
>> +&mmc0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bananapi>;
>> +     vmmc-supply = <&reg_vcc3v3>;
>> +     bus-width = <4>;
>> +     cd-gpios = <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
>> +     cd-inverted;
>> +     status = "okay";
>> +};
>> +
>> +&mmc3 {
>> +     #address-cells = <1>;
>> +     #size-cells = <0>;
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc3_pins_a>;
>> +     vmmc-supply = <&reg_vmmc3>;
>> +     bus-width = <4>;
>> +     non-removable;
>> +     enable-sdio-wakeup;
>> +     status = "okay";
>> +
>> +     brcmf: bcrmf at 1 {
>> +             reg = <1>;
>> +             compatible = "brcm,bcm4329-fmac";
>> +             interrupt-parent = <&pio>;
>> +             interrupts = <7 15 IRQ_TYPE_LEVEL_LOW>;
>> +             interrupt-names = "host-wake";
>> +     };
>> +
>> +};
>> +
>> +&mmc3_pins_a {
>> +    /* AP6210 requires pull-up */
>> +     allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +};
>> +
>> +&pio {
>> +     gmac_power_pin_bananapi: gmac_power_pin at 0 {
>> +             allwinner,pins = "PH23";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +
>> +     led_pins_bananapi: led_pins at 0 {
>> +             allwinner,pins = "PH24", "PG2";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +
>> +     mmc0_cd_pin_bananapi: mmc0_cd_pin at 0 {
>> +             allwinner,pins = "PH10";
>> +             allwinner,function = "gpio_in";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>> +     };
>> +
>> +     usb1_vbus_pin_bananapi: usb1_vbus_pin at 0 {
>> +             allwinner,pins = "PH0";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +
>> +     usb2_vbus_pin_bananapi: usb2_vbus_pin at 0 {
>> +             allwinner,pins = "PH1";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +
>> +     vmmc3_pin_bananapi: vmmc3_pin at 0 {
>> +             allwinner,pins = "PH22";
>> +             allwinner,function = "gpio_out";
>> +             allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +             allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +     };
>> +};
>> +
>> +&reg_usb1_vbus {
>> +     pinctrl-0 = <&usb1_vbus_pin_bananapi>;
>> +     gpio = <&pio 7 0 GPIO_ACTIVE_HIGH>; /* PH0 */
>> +     status = "okay";
>> +};
>> +
>> +&reg_usb2_vbus {
>> +     pinctrl-0 = <&usb2_vbus_pin_bananapi>;
>> +     gpio = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>> +     status = "okay";
>> +};
>> +
>> +&uart0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&uart0_pins_a>;
>> +     status = "okay";
>> +};
>> +
>> +&usbphy {
>> +     usb1_vbus-supply = <&reg_usb1_vbus>;
>> +     usb2_vbus-supply = <&reg_usb2_vbus>;
>> +     status = "okay";
>> +};
>> --
>> 2.8.3
>>
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
