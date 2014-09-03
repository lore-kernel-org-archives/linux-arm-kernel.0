From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Wed, 3 Sep 2014 13:18:41 +0530
Subject: [PATCH 11/14] arm64: dts: Add initial device tree support for
 EXYNOS7
In-Reply-To: <20140827104231.GB7773@leverpostej>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-3-git-send-email-ch.naveen@samsung.com>
 <20140827104231.GB7773@leverpostej>
Message-ID: <CAHfPSqD2_=-zr8p0STSThfdik296tHZkHhXemdxCrSqTx7e1UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 27 August 2014 16:12, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Naveen,
>
> On Wed, Aug 27, 2014 at 10:44:18AM +0100, Naveen Krishna Chatradhi wrote:
>> Add initial device tree nodes for EXYNOS7 SoC.
>> Also, includes the dt-binding definitions for clock ids.
>
> Fallout from a rebase? That latter part doesn't seem to be relevant.

Yes, this is fixed now.

>
>> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>> Cc: Thomas Abraham <thomas.ab@samsung.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  arch/arm64/boot/dts/exynos7.dtsi |  553 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 553 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/exynos7.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/exynos7.dtsi b/arch/arm64/boot/dts/exynos7.dtsi
>> new file mode 100644
>> index 0000000..6b9eaf4
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/exynos7.dtsi
>> @@ -0,0 +1,553 @@
>> +/*
>> + * SAMSUNG EXYNOS7 SoC device tree source
>> + *
>> + * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>> + *             http://www.samsung.com
>> + *
>> + * SAMSUNG EXYNOS7 SoC device nodes are listed in this file.
>> + * EXYNOS7 based board files can include this file and provide
>> + * values for board specfic bindings.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <dt-bindings/clock/exynos7-clk.h>
>> +
>> +/ {
>> +       compatible = "samsung,exynos7";
>> +       interrupt-parent = <&gic>;
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>
> Can we guarantee everything going to live within 0x0 - 0xffffffff for
> all boards using the SoC?
>
> I suspect that we can't, so the addresses and sizes at the top level
> should be two cells. At some point there is bound to be something above
> 4GB that we'll need to map, so to save us from a painful dts refactoring
> we should have the dts organised to support that from the outside.

Ok, this is fixed with #address-cells = 2 and #size-cells = 2.

>
> [...]
>
>> +       cpus {
>> +               #address-cells = <2>;
>> +               #size-cells = <0>;
>> +
>> +               cpu at 0 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a57", "arm,armv8";
>> +                       reg = <0x0 0x0>;
>> +               };
>> +       };
>
> Only UP?

This is a quad core SoC and the rest of the CPU nodes have been added
in the second version of this series.

>
> [...]
>
>> +       gic: interrupt-controller at 11001000 {
>> +               compatible = "arm,gic-400";
>> +               #interrupt-cells = <3>;
>> +               #address-cells = <0>;
>> +               interrupt-controller;
>> +               reg =   <0x11001000 0x1000>,
>> +                       <0x11002000 0x1000>,
>> +                       <0x11004000 0x2000>,
>> +                       <0x11006000 0x2000>;
>> +       };
>
> Nice to see GICV and GICH.
>
> [...]
>
>> +       mct at 101C0000 {
>> +               compatible = "samsung,exynos4210-mct";
>> +               reg = <0x101C0000 0x800>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <1>;
>> +               interrupt-parent = <&mct_map>;
>> +               interrupts =    <0>, <1>, <2>, <3>,
>> +                               <4>, <5>, <6>, <7>,
>> +                               <8>, <9>, <10>, <11>;
>> +               clocks = <&fin_pll>, <&clock_peris PCLK_MCT>;
>> +               clock-names = "fin_pll", "mct";
>> +
>> +               mct_map: mct-map {
>> +                       #interrupt-cells = <1>;
>> +                       #address-cells = <0>;
>> +                       #size-cells = <0>;
>> +                       interrupt-map = <0 &gic 0 112 0>,
>> +                                       <1 &gic 0 113 0>,
>> +                                       <2 &gic 0 114 0>,
>> +                                       <3 &gic 0 115 0>,
>> +                                       <4 &gic 0 116 0>,
>> +                                       <5 &gic 0 117 0>,
>> +                                       <6 &gic 0 118 0>,
>> +                                       <7 &gic 0 119 0>,
>> +                                       <8 &gic 0 120 0>,
>> +                                       <9 &gic 0 121 0>,
>> +                                       <10 &gic 0 122 0>,
>> +                                       <11 &gic 0 123 0>;
>> +               };
>> +       };
>
> I don't see why need the map here. Why can't we describe the GIC
> interrupts directly?

Right, it was not required. Also, we will try and use only arch timer
and not MCT.

>
> [...]
>
>> +       timer {
>> +               compatible = "arm,armv8-timer";
>> +               interrupts = <1 13 0xff01>,
>> +                            <1 14 0xff01>,
>> +                            <1 11 0xff01>,
>> +                            <1 10 0xff01>;
>> +               clock-frequency = <24000000>;
>
> Your firmware/bootloader should configure CNTFRQ, and this shouldn't be
> necessary. The clock-frequency property is an incomplete workaround for
> broken firmware that in an ideal world we could kill off.
>
>> +               use-clocksource-only;
>> +               use-physical-timer;
>
> Neither of these properties were introduced by this series, and no
> rationale was given.
>
> What are these properties for, and why do you believe they are
> necessary?

Sorry, that was a mistake. This has been fixed.

>
> Thanks,
> Mark.

Thanks.

-- 
Shine bright,
(: Nav :)
