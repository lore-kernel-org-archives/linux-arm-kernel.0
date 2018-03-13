From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 13 Mar 2018 23:47:16 +0100
Subject: [PATCH] arm64: allwinner: H5: Add Xunlong Orange Pi Zero Plus
In-Reply-To: <20180312090208.jjssbgf5t5y5dj7o@flea>
References: <20180311155932.20945-1-hauke@hauke-m.de>
 <20180312090208.jjssbgf5t5y5dj7o@flea>
Message-ID: <7d1f77ce-a171-0fc8-b0af-12a47a2d1077@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2018 10:02 AM, Maxime Ripard wrote:
> Hi,
> 
> On Sun, Mar 11, 2018 at 04:59:32PM +0100, Hauke Mehrtens wrote:
>> The Xunlong Orange Pi Zero Plus is single board computer.
>> - H5 Quad-core 64-bit Cortex-A53
>> - 512MB DDR3
>> - microSD slot
>> - Debug TTL UART
>> - 1000M/100M/10M Ethernet RJ45
>> - Realtek RTL8189FTV
>> - Spi flash (2MB)
>> - One USB 2.0 HOST, One USB 2.0 OTG
>>
>> This is based on a patch from armbian:
>> https://github.com/armbian/build/blob/master/patch/kernel/sunxi-next/sunxi-add-orangepi-zero-plus.patch
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>  .../dts/allwinner/sun50i-h5-orangepi-zero-plus.dts | 192 +++++++++++++++++++++
>>  2 files changed, 193 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index f505227b0250..d9d239affbcf 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -8,5 +8,6 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
> 
> Putting it before the Plus2 would make more sense

Ok I will change this.

>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo2.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-nanopi-neo-plus2.dtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
>> new file mode 100644
>> index 000000000000..52b29f3706a7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus.dts
>> @@ -0,0 +1,192 @@
>> +/*
>> + * Copyright (C) 2016 ARM Ltd.
> 
> Is it?

This device tree file is based on a different one, there is probably a
longer chain and the first was created by ARM. I can add my copyright in
addition.

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
> 
> Also, please use an SPDX tag instead of the full license description.

Ok will do that.

>> + */
>> +
>> +/dts-v1/;
>> +#include "sun50i-h5.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>> +
>> +/ {
>> +	model = "Xunlong Orange Pi Zero Plus";
>> +	compatible = "xunlong,orangepi-zero-plus", "allwinner,sun50i-h5";
>> +
>> +	reg_vcc3v3: vcc3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +	};
>> +
>> +	aliases {
>> +		ethernet0 = &emac;
>> +		ethernet1 = &rtl8189ftv;
>> +		serial0 = &uart0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		pwr {
>> +			label = "orangepi:green:pwr";
>> +			gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
>> +
>> +		status {
>> +			label = "orangepi:red:status";
>> +			gpios = <&pio 0 17 GPIO_ACTIVE_HIGH>;
>> +		};
>> +	};
>> +
>> +	reg_gmac_3v3: gmac-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "gmac-3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		startup-delay-us = <100000>;
>> +		enable-active-high;
>> +		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	reg_usb0_vbus: usb0-vbus {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "usb0-vbus";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		enable-active-high;
>> +		gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
> 
> It doesn't look to be right judging from the schematics. That pin
> doesn't control whether VBUS is enabled or not, it doesn't seem to be
> enabled at all.

I will have a closer look at this.

> 
> Looks good otherwise, thanks!
> Maxime
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 858 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/458175f1/attachment-0001.sig>
