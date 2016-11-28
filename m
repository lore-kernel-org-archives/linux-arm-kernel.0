From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 28 Nov 2016 00:29:07 +0000
Subject: [PATCH v2 2/3] ARM: dts: sunxi: add support for Orange Pi Zero
 board
In-Reply-To: <5373671480239408@web31m.yandex.ru>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-2-icenowy@aosc.xyz> <5373671480239408@web31m.yandex.ru>
Message-ID: <cdfd3c65-d473-badb-ea6a-035f7ab79217@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/16 09:36, Icenowy Zheng wrote:

Hi,

> 22.11.2016, 00:26, "Icenowy Zheng" <icenowy@aosc.xyz>:
>> Orange Pi Zero is a board that came with the new Allwinner H2+ SoC.
>>
>> Add a device tree file for it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ---
>> Changes since v2:
>> - Use generic pinconf binding instead of legacy allwinner pinctrl binding.
>> - removed uart3, which is not accessible on Orange Pi Zero.
>> - Removed sun8i-h2plus.dtsi and make Orange Pi Zero dts directly include
>>   sun8i-h3.dtsi.
>> - Removed allwinner,sun8i-h3 compatible.
>>
>>  arch/arm/boot/dts/Makefile | 1 +
>>  arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts | 137 +++++++++++++++++++++++
>>  2 files changed, 138 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 802a10d..51a1dd7 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -834,6 +834,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>          sun8i-a33-sinlinx-sina33.dtb \
>>          sun8i-a83t-allwinner-h8homlet-v2.dtb \
>>          sun8i-a83t-cubietruck-plus.dtb \
>> + sun8i-h2plus-orangepi-zero.dtb \
>>          sun8i-h3-bananapi-m2-plus.dtb \
>>          sun8i-h3-nanopi-neo.dtb \
>>          sun8i-h3-orangepi-2.dtb \
>> diff --git a/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
>> new file mode 100644
>> index 0000000..b428e47
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
>> @@ -0,0 +1,137 @@
>> +/*
>> + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.xyz>
>> + *
>> + * Based on sun8i-h3-orangepi-one.dts, which is:
>> + * Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + * a) This file is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of the
>> + * License, or (at your option) any later version.
>> + *
>> + * This file is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + * b) Permission is hereby granted, free of charge, to any person
>> + * obtaining a copy of this software and associated documentation
>> + * files (the "Software"), to deal in the Software without
>> + * restriction, including without limitation the rights to use,
>> + * copy, modify, merge, publish, distribute, sublicense, and/or
>> + * sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following
>> + * conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> + * included in all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
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
>> + model = "Xunlong Orange Pi Zero";
>> + compatible = "xunlong,orangepi-zero", "allwinner,sun8i-h2plus";
>> +
>> + aliases {
>> + serial0 = &uart0;
>> + };
>> +
>> + chosen {
>> + stdout-path = "serial0:115200n8";
>> + };
>> +
>> + leds {
>> + compatible = "gpio-leds";
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&leds_opi0>, <&leds_r_opi0>;
>> +
>> + pwr_led {
>> + label = "orangepi:green:pwr";
>> + gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
>> + default-state = "on";
>> + };
>> +
>> + status_led {
>> + label = "orangepi:red:status";
>> + gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
>> + };
>> + };
>> +};
>> +
>> +&ehci1 {
>> + status = "okay";
>> +};
>> +
>> +&mmc0 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>> + vmmc-supply = <&reg_vcc3v3>;
>> + bus-width = <4>;
>> + cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
>> + cd-inverted;
>> + status = "okay";
>> +};
>> +
>> +&ohci1 {
>> + status = "okay";
>> +};
>> +
>> +&pio {
>> + leds_opi0: led_pins at 0 {
>> + pins = "PA17";
>> + function = "gpio_out";
>> + };
>> +};
>> +
>> +&r_pio {
>> + leds_r_opi0: led_pins at 0 {
>> + pins = "PL10";
>> + function = "gpio_out";
>> + };
>> +};
>> +
>> +&uart0 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&uart0_pins_a>;
>> + status = "okay";
>> +};
>> +
>> +&uart1 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&uart1_pins>;
>> + status = "disabled";
>> +};
>> +
>> +&uart2 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&uart2_pins>;
>> + status = "disabled";
>> +};
>> +
>> +&usbphy {
>> + /* USB VBUS is always on */
>> + status = "okay";
>> +};
> 
> Something more interesting happened.
> 
> Xunlong made a add-on board for Orange Pi Zero, which exposes the two USB Controllers exported at expansion bus as USB Type-A connectors.
> 
> Also it exposes a analog A/V jack and a microphone.
> 
> Should I enable {e,o}hci{2.3} in the device tree?

Actually we should do this regardless of this extension board. The USB
pins are not multiplexed and are exposed on user accessible pins (just
not soldered, but that's a detail), so I think they qualify for DT
enablement. And even if a user can't use them, it doesn't hurt to have
them (since they are not multiplexed).

Cheers,
Andre.
