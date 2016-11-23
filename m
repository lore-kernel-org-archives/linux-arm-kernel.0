From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 23 Nov 2016 09:23:49 +0000
Subject: [PATCH v2 2/3] ARM: dts: sunxi: add support for Orange Pi Zero
 board
In-Reply-To: <20161123075713.ks6gmud3rszjbdsh@lukather>
References: <20161121162421.800-1-icenowy@aosc.xyz>
 <20161121162421.800-2-icenowy@aosc.xyz>
 <20161123075713.ks6gmud3rszjbdsh@lukather>
Message-ID: <a4393a37-5008-ec76-9886-05f8686dadd5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 23/11/16 07:57, Maxime Ripard wrote:
> On Tue, Nov 22, 2016 at 12:24:20AM +0800, Icenowy Zheng wrote:
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
>>  arch/arm/boot/dts/Makefile                       |   1 +
>>  arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts | 137 +++++++++++++++++++++++
> 
> Ditto, h2-plus-orangepi-zero.
> 
>>  2 files changed, 138 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/sun8i-h2plus-orangepi-zero.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 802a10d..51a1dd7 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -834,6 +834,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>  	sun8i-a33-sinlinx-sina33.dtb \
>>  	sun8i-a83t-allwinner-h8homlet-v2.dtb \
>>  	sun8i-a83t-cubietruck-plus.dtb \
>> +	sun8i-h2plus-orangepi-zero.dtb \
>>  	sun8i-h3-bananapi-m2-plus.dtb \
>>  	sun8i-h3-nanopi-neo.dtb \
>>  	sun8i-h3-orangepi-2.dtb \
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
>> + *   Copyright (C) 2016 Hans de Goede <hdegoede@redhat.com>
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
>> +	model = "Xunlong Orange Pi Zero";
>> +	compatible = "xunlong,orangepi-zero", "allwinner,sun8i-h2plus";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&leds_opi0>, <&leds_r_opi0>;
>> +
>> +		pwr_led {
>> +			label = "orangepi:green:pwr";
>> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
>> +
>> +		status_led {
>> +			label = "orangepi:red:status";
>> +			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +};
>> +
>> +&ehci1 {
>> +	status = "okay";
>> +};
>> +
>> +&mmc0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>> +	vmmc-supply = <&reg_vcc3v3>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
>> +	cd-inverted;
>> +	status = "okay";
>> +};
>> +
>> +&ohci1 {
>> +	status = "okay";
>> +};
>> +
>> +&pio {
>> +	leds_opi0: led_pins at 0 {
>> +		pins = "PA17";
>> +		function = "gpio_out";
>> +	};
>> +};
>> +
>> +&r_pio {
>> +	leds_r_opi0: led_pins at 0 {
>> +		pins = "PL10";
>> +		function = "gpio_out";
>> +	};
>> +};
>> +
>> +&uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart0_pins_a>;
>> +	status = "okay";
>> +};
>> +
>> +&uart1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart1_pins>;
>> +	status = "disabled";
>> +};
>> +
>> +&uart2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&uart2_pins>;
>> +	status = "disabled";
>> +};
> 
> I'm not sure you answered me on this one. Are those exposed on the
> headers? why did you put them as disabled here?

So they are on headers, though you have to solder the actual header pins
yourself [1]. But also these are the normal pins multiplexed with GPIOs
and other peripherals, so keeping them disabled is in line with the
existing policy, if I got this correctly.

I agree that the status="disabled" is redundant, since we have that
exact line already in the .dtsi. But I saw it in other DTs as well, most
prominently in the sun8i-h3-orangepi-one.dts.

So I think we should remove the "status=" lines here, dtc will generate
an identical dtb out of it. But we should keep the uart descriptions in
to make it easier for users to see which SoC pins are used for these
pins labeled UART[012] in the board description and schematic. Also all
it takes to enable those is to overwrite the status property, which can
easily be done inline (without resizing the dtb).

Cheers,
Andre.

[1] http://linux-sunxi.org/Xunlong_Orange_Pi_Zero
