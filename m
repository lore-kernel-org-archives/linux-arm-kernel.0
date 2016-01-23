From: codekipper@gmail.com (Code Kipper)
Date: Sat, 23 Jan 2016 15:46:26 +0100
Subject: [linux-sunxi][PATCH v3 4/5] ARM: dts: sun4i: Add Itead A10 Core
 support
In-Reply-To: <20160121155624.GH3997@lukather>
References: <1452766555-16409-1-git-send-email-codekipper@gmail.com>
 <1452766555-16409-5-git-send-email-codekipper@gmail.com>
 <20160118194410.GS4581@lukather>
 <CAEKpxBnt18EWoamdUtPO6FSyXdVc2Ct6aMgBJQo3P9HPweKi-w@mail.gmail.com>
 <20160121155624.GH3997@lukather>
Message-ID: <CAEKpxBkL+MHv3a-4vdMw2N-0=mND8NowzxAoJSWX4fa+_nGemA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 January 2016 at 16:56, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Marcus,
>
> Please keep all the recipients in Cc.
ACK
>
> On Tue, Jan 19, 2016 at 08:52:09AM +0100, Code Kipper wrote:
>> On 18 January 2016 at 20:44, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Thu, Jan 14, 2016 at 11:15:54AM +0100, codekipper at gmail.com wrote:
>> >> From: Marcus Cooper <codekipper@gmail.com>
>> >>
>> >> The A10 Itead Core module comes with 4GB NAND and 1GB DDR RAM. All of the
>> >> I/O interfaces are exposed via 4 groups of 2*30 1mm pitched female headers.
>> >>
>> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> >> ---
>> >>  arch/arm/boot/dts/sun4i-a10-itead-core.dtsi | 86 +++++++++++++++++++++++++++++
>> >>  1 file changed, 86 insertions(+)
>> >>  create mode 100644 arch/arm/boot/dts/sun4i-a10-itead-core.dtsi
>> >>
>> >> diff --git a/arch/arm/boot/dts/sun4i-a10-itead-core.dtsi b/arch/arm/boot/dts/sun4i-a10-itead-core.dtsi
>> >> new file mode 100644
>> >> index 0000000..97f653a
>> >> --- /dev/null
>> >> +++ b/arch/arm/boot/dts/sun4i-a10-itead-core.dtsi
>> >> @@ -0,0 +1,86 @@
>> >> +/*
>> >> + * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>
>> >> + *
>> >> + * This file is dual-licensed: you can use it either under the terms
>> >> + * of the GPL or the X11 license, at your option. Note that this dual
>> >> + * licensing only applies to this file, and not this project as a
>> >> + * whole.
>> >> + *
>> >> + *  a) This file is free software; you can redistribute it and/or
>> >> + *     modify it under the terms of the GNU General Public License as
>> >> + *     published by the Free Software Foundation; either version 2 of the
>> >> + *     License, or (at your option) any later version.
>> >> + *
>> >> + *     This file is distributed in the hope that it will be useful,
>> >> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> >> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> >> + *     GNU General Public License for more details.
>> >> + *
>> >> + * Or, alternatively,
>> >> + *
>> >> + *  b) Permission is hereby granted, free of charge, to any person
>> >> + *     obtaining a copy of this software and associated documentation
>> >> + *     files (the "Software"), to deal in the Software without
>> >> + *     restriction, including without limitation the rights to use,
>> >> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> >> + *     sell copies of the Software, and to permit persons to whom the
>> >> + *     Software is furnished to do so, subject to the following
>> >> + *     conditions:
>> >> + *
>> >> + *     The above copyright notice and this permission notice shall be
>> >> + *     included in all copies or substantial portions of the Software.
>> >> + *
>> >> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> >> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> >> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> >> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> >> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> >> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> >> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> >> + *     OTHER DEALINGS IN THE SOFTWARE.
>> >> + */
>> >> +
>> >> +#include "sun4i-a10.dtsi"
>> >> +#include "sunxi-itead-core-common.dtsi"
>> >> +
>> >> +&cpu0 {
>> >> +     cpu-supply = <&reg_dcdc2>;
>> >> +};
>> >> +
>> >> +&i2c0 {
>> >> +     pinctrl-names = "default";
>> >> +     pinctrl-0 = <&i2c0_pins_a>;
>> >> +     status = "okay";
>> >> +
>> >> +     axp209: pmic at 34 {
>> >> +             reg = <0x34>;
>> >> +             interrupts = <0>;
>> >> +     };
>> >> +};
>> >> +
>> >> +#include "axp209.dtsi"
>> >> +
>> >> +&reg_dcdc2 {
>> >> +     regulator-always-on;
>> >> +     regulator-min-microvolt = <1000000>;
>> >> +     regulator-max-microvolt = <1400000>;
>> >> +     regulator-name = "vdd-cpu";
>> >> +};
>> >> +
>> >> +&reg_dcdc3 {
>> >> +     regulator-always-on;
>> >> +     regulator-min-microvolt = <1000000>;
>> >> +     regulator-max-microvolt = <1400000>;
>> >> +     regulator-name = "vdd-int-dll";
>> >> +};
>> >> +
>> >> +&reg_ldo1 {
>> >> +     regulator-name = "vdd-rtc";
>> >> +};
>> >> +
>> >> +&reg_ldo2 {
>> >> +     regulator-always-on;
>> >> +     regulator-min-microvolt = <3000000>;
>> >> +     regulator-max-microvolt = <3000000>;
>> >> +     regulator-name = "avcc";
>> >> +};
>> >> --
>> >> 2.7.0
>> >
>> > Is there any difference with the A20 one?
>>
>> Yep....this one references the a10 dtsi
>
> The difference between the A10 and A20 can always be done at the board
> level anyway.
ACK
>
>> and the way interrupt for the pmic is declared is different.
>
> And you could have everything but that interrupt in the common DT from
> what I can see.
ACK
>
>
>> At first the dcdc3 max voltage was different but now they're the
>> same so maybe this can go into the common dtsi. I'll have a play
>> before the next patchset.
>
> Yep, please do. Thanks!
> Maxime
Thanks for the review and for kicking my arse in the right direction.
New patches coming soon,
CK
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
