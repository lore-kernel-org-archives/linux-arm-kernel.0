From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 Aug 2017 15:42:21 +0800
Subject: [linux-sunxi] [PATCH v5] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <CAD6G_RQqppv7yYQ0-KQvFJL6XrAuNRoSD=10AR4jvGVEKZpAFg@mail.gmail.com>
References: <1502516317-4563-1-git-send-email-jteki@openedev.com>
 <CAGb2v67k6qvvSpJB65ORj6rSZhR0rHCvCJeBvnM-exBrGSaJZQ@mail.gmail.com>
 <CAD6G_RQqppv7yYQ0-KQvFJL6XrAuNRoSD=10AR4jvGVEKZpAFg@mail.gmail.com>
Message-ID: <CAGb2v652qs44LWjRg0e0KzUQ+bJYpjrxphTnxgNeshfbcX4mKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 3:22 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 12:20 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> Hi,
>>
>> On Sat, Aug 12, 2017 at 1:38 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>>> From: Jagan Teki <jagan@amarulasolutions.com>
>>>
>>> NanoPi A64 is a new board of high performance with low cost
>>> designed by FriendlyElec., using the Allwinner A64 SOC.
>>>
>>> Nanopi A64 features
>>> - Allwinner A64, 64-bit Quad-core Cortex-A53 at 648MHz to 1.152GHz, DVFS
>>> - 1GB DDR3 RAM
>>> - MicroSD
>>> - Gigabit Ethernet (RTL8211E)
>>> - Wi-Fi 802.11b/g/n
>>> - IR receiver
>>> - Audio In/Out
>>> - Video In/Out
>>> - Serial Debug Port
>>> - microUSB 5V 2A DC power-supply
>>>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>> Changes for v5:
>>> - Add AXP803 PMIC regulator support.
>>> Changes for v4:
>>> - Rebased and droped wi-fi related nodes, since it require
>>>   other changes to taken care.
>>> Changes for v3:
>>> - Fix to use mmc1 for SDIO instead of mmc2
>>> - Replace buswidth by 4 instead of 8 mmc1
>>> - Drop cap-mmc-hw-reset for mmc1
>>> Changes for v2:
>>> - Added ohci0, ehci0, ohic1, ehci1, usbphy.
>>> - Tested on A64
>>>
>>>  arch/arm64/boot/dts/allwinner/Makefile             |   1 +
>>>  .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   | 205 +++++++++++++++++++++
>>>  2 files changed, 206 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>> index 108f12c..c997b5c 100644
>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>> @@ -1,4 +1,5 @@
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb
>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-plus.dtb sun50i-a64-pine64.dtb
>>>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-sopine-baseboard.dtb
>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>> new file mode 100644
>>> index 0000000..de98da1
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
>>> @@ -0,0 +1,205 @@
>>> +/*
>>> + * Copyright (C) 2017 Jagan Teki <jteki@openedev.com>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This library is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This library is distributed in the hope that it will be useful,
>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *     GNU General Public License for more details.
>>> + *
>>> + * Or, alternatively,
>>> + *
>>> + *  b) Permission is hereby granted, free of charge, to any person
>>> + *     obtaining a copy of this software and associated documentation
>>> + *     files (the "Software"), to deal in the Software without
>>> + *     restriction, including without limitation the rights to use,
>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>> + *     sell copies of the Software, and to permit persons to whom the
>>> + *     Software is furnished to do so, subject to the following
>>> + *     conditions:
>>> + *
>>> + *     The above copyright notice and this permission notice shall be
>>> + *     included in all copies or substantial portions of the Software.
>>> + *
>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "sun50i-a64.dtsi"
>>> +
>>> +#include <dt-bindings/gpio/gpio.h>
>>> +
>>> +/ {
>>> +       model = "FriendlyARM NanoPi A64";
>>> +       compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";
>>> +
>>> +       aliases {
>>> +               serial0 = &uart0;
>>> +       };
>>> +
>>> +       chosen {
>>> +               stdout-path = "serial0:115200n8";
>>> +       };
>>> +};
>>> +
>>> +&ehci0 {
>>> +       status = "okay";
>>> +};
>>
>> Does this actually work? Our drivers don't force the OTG/xHCI0 mux
>> one way or the other if there isn't an ID pin.
>
> Yes, based on previous tests. but will verify again..if not will make
> further change or drop for this initial support.

Not really needed. I simply wanted to know the state of support for this
part under a non-OTG design. If it works, very nice. If it doesn't, it
can be fixed in the driver (though it might be complicated).

>>
>>> +
>>> +&ehci1 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&i2c1 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&i2c1_pins>;
>>> +       status = "okay";
>>
>> Please add a note saying this is on the standard RPi-compatible header,
>> as the ID I2C controller. And we normally don't enable peripherals on
>> the GPIO expansion by default either.
>>
>>> +};
>>> +
>>> +&i2c1_pins {
>>> +       bias-pull-up;
>>> +};
>>> +
>>> +&mmc0 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&mmc0_pins>;
>>> +       vmmc-supply = <&reg_dcdc1>;
>>> +       cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>>> +       cd-inverted;
>>> +       disable-wp;
>>> +       bus-width = <4>;
>>> +       status = "okay";
>>> +};
>>> +
>>> +&ohci0 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&ohci1 {
>>> +       status = "okay";
>>> +};
>>> +
>>> +&r_rsb {
>>> +       status = "okay";
>>> +
>>> +       axp803: pmic at 3a3 {
>>> +               compatible = "x-powers,axp803";
>>> +               reg = <0x3a3>;
>>> +               interrupt-parent = <&r_intc>;
>>> +               interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>> +       };
>>> +};
>>> +
>>> +&uart0 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&uart0_pins_a>;
>>> +       status = "okay";
>>> +};
>>
>> Please move uart0 below the bunch of regulators.
>
> OK.
>
>>
>>> +
>>> +#include "axp803.dtsi"
>>> +
>>> +&reg_aldo2 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <1800000>;
>>> +       regulator-max-microvolt = <3300000>;
>>> +       regulator-name = "vcc-pl";
>>> +};
>>> +
>>> +&reg_aldo3 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3000000>;
>>> +       regulator-max-microvolt = <3000000>;
>>> +       regulator-name = "vcc-pll-avcc";
>>> +};
>>> +
>>> +&reg_dcdc1 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3000000>;
>>> +       regulator-max-microvolt = <3000000>;
>>> +       regulator-name = "vcc-3v";
>>> +};
>>> +
>>> +&reg_dcdc2 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <1100000>;
>>> +       regulator-max-microvolt = <1100000>;
>>> +       regulator-name = "vdd-cpux";
>>> +};
>>> +
>>> +/* DCDC3 is polyphased with DCDC2 */
>>> +
>>> +&reg_dcdc5 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <1500000>;
>>> +       regulator-max-microvolt = <1500000>;
>>> +       regulator-name = "vcc-dram";
>>> +};
>>> +
>>> +&reg_dcdc6 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <1100000>;
>>> +       regulator-max-microvolt = <1100000>;
>>> +       regulator-name = "vdd-sys";
>>> +};
>>> +
>>> +&reg_dldo1 {
>>> +       regulator-min-microvolt = <3300000>;
>>> +       regulator-max-microvolt = <3300000>;
>>> +       regulator-name = "vcc-hdmi";
>>> +};
>>> +
>>> +&reg_dldo2 {
>>> +       regulator-min-microvolt = <3200000>;
>>> +       regulator-max-microvolt = <3200000>;
>>> +       regulator-name = "vcc-mipi";
>>
>> The schematics say vcc-mipi is tied to DLDO1, and DLDO2 is unused.
>
> PFA schematic page-3 DLDO1 for vcc3v3-hdmi and DLDO2 for vcc-mipi

And yet it is not used on page 7. I would trust the actual schematics
more than the summary graph.

>>
>>> +};
>>
>> DLDO4 is used to power the PG pin group (which should be always-on)
>> and I/O for the WiFi chip. It is missing here.
>
> OK, but why it should always-on?

In general, some pins in the pin group might have other uses, so
either we set it to always-on, or have the pinctrl driver deal with
enabling it, or have every peripheral driver handle it. The second
option is a bit complicated, as it would require a separate device
apart from the pinctrl driver to handle the regulators. Otherwise
if the pinctrl driver is needed for whatever interface needed to
talk to the PMIC, you get a cyclic probe dependency. As for the
third, it would be a major pain to have to do this for every
peripheral we use, unless there's some sort of framework that
deals with power sequencing, which there currently isn't.

However in this case I seem to have been misled by the schematic.
It shows UART and PCM also being used for Bluetooth, but the chip
(RTL8189) does not have these functions. So for this it's actually
easier. We don't need it to be always-on.

ChenYu

> thanks!
> --
> Jagan Teki
> Free Software Engineer | www.openedev.com
> U-Boot, Linux | Upstream Maintainer
> Hyderabad, India.
