From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 26 May 2017 11:54:38 +0800
Subject: [linux-sunxi] [PATCH 1/3] arm64: allwinner: a64: Add initial
 Orangepi Win/WinPlus support
In-Reply-To: <5e932649-bab6-7f3e-7519-4d45d3eb8f20@arm.com>
References: <1495740382-9061-1-git-send-email-jteki@openedev.com>
 <5e932649-bab6-7f3e-7519-4d45d3eb8f20@arm.com>
Message-ID: <CAGb2v64um5gTP6kDdjZkPUBLrZbsnw+mJgG2260Np7bg8aVd3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 6:30 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> On 25/05/17 20:26, Jagan Teki wrote:
>> From: Jagan Teki <jagan@amarulasolutions.com>
>>
>> Orangepi Win/WinPlus is an open-source single-board computer
>> using the Allwinner A64 SOC.
>>
>> A64 Orangepi Win/WinPlus has
>> - A64 Quad-core Cortex-A53 64bit
>> - 1GB(Win)/2GB(Win Plus) DDR3 SDRAM
>> - Debug TTL UART
>> - Four USB 2.0
>
> I take it those are connected to a hub chip, and the micro-USB socket is
> connected as a true OTG socket?
> So you should enable the usb_otg node, but without the host mode
> override we use for the Pine64.

Agreed. Unless OTG needs PMIC support.

>
>> - HDMI
>> - LCD
>> - Audio and MIC
>> - Wifi + BT
>
> It looks like Wifi + BT are soldered on the board, so you should at
> least enable the proper UART connected to the Bluetooth chip, probably
> also MMC1 (which is surely connected to the WiFi chip) should be
> described as an SDIO node.

Those probably need regulator support. Having them enabled together
might be better.

>
>> - IR receiver
>> - 5V DC power supply
>
> I guess the board uses the AXP803 as well? You might want to coordinate
> with Icenowy what to do to describe this as well, given that her patches
> might go in before.

Still waiting for NMI driver/bindings to be merged before I merge the dts
file changes. The mfd and regulator driver changes are already in -next.

>
> Cheers,
> Andre.
>
>> http://www.orangepi.org/OrangePiWin_WinPlus/

The URL is not going to be helpful if it goes offline.

Can someone provide schematics for this board? Without it there's really
no verification for what the device tree describes.

>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>  .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 102 +++++++++++++++++++++
>>  2 files changed, 103 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>> index 244e8b7..4120ce9 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -1,5 +1,6 @@
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>
>>  always               := $(dtb-y)
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>> new file mode 100644
>> index 0000000..b16e606
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
>> @@ -0,0 +1,102 @@
>> +/*
>> + * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
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
>> +
>> +#include "sun50i-a64.dtsi"
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/ {
>> +     model = "OrangePi Win/Win Plus";
>> +     compatible = "xunlong,orangepi-win", "allwinner,sun50i-a64";
>> +
>> +     aliases {
>> +             serial0 = &uart0;
>> +     };
>> +
>> +     chosen {
>> +             stdout-path = "serial0:115200n8";
>> +     };
>> +
>> +     soc {
>> +             reg_vcc3v3: vcc3v3 {
>> +                     compatible = "regulator-fixed";
>> +                     regulator-name = "vcc3v3";
>> +                     regulator-min-microvolt = <3300000>;
>> +                     regulator-max-microvolt = <3300000>;
>> +             };

This should be outside of the soc node. Furthermore, you should
not be doing full path overrides in the dts file. If you need
to reference a node, but it doesn't have a label, add the label
first.

>> +     };
>> +};
>> +
>> +&mmc0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&mmc0_pins>;
>> +     vmmc-supply = <&reg_vcc3v3>;
>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;

Please add a comment after this denoting the pin name.

>> +     cd-inverted;
>> +     status = "okay";
>> +};
>> +
>> +&uart0 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&uart0_pins_a>;
>> +     status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +     pinctrl-names = "default";
>> +     pinctrl-0 = <&i2c1_pins>;
>> +     status = "okay";
>> +};
>> +
>> +&usbphy {
>> +       status = "okay";

No VBUS regulator supplies? Does the USB hub need a node?

Regards
ChenYu

>> +};
>> +
>> +&ohci1 {
>> +       status = "okay";
>> +};
>> +
>> +&ehci1 {
>> +       status = "okay";
>> +};
>>
>
