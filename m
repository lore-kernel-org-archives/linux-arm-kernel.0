From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 9 Jun 2016 23:36:07 +0300
Subject: [PATCH v3 06/12] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <CAMuHMdU0e=pS+q8PmXX9gwc6bHv-YdJo4G8nc-EA3NaKMuTrqQ@mail.gmail.com>
References: <12536856.AsKMEpuejQ@wasted.cogentembedded.com>
 <1788169.FUQDsLAmXg@wasted.cogentembedded.com>
 <CAMuHMdU0e=pS+q8PmXX9gwc6bHv-YdJo4G8nc-EA3NaKMuTrqQ@mail.gmail.com>
Message-ID: <e4b85e72-e5bf-39c8-6a57-2712ba2dae51@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2016 01:05 PM, Geert Uytterhoeven wrote:

>> The initial R8A7792 SoC device tree including CPU cores, GIC, timer, SYSC,
>> and the required  clock descriptions.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> Changes in version 3:
>
> Thanks for the update!
>
>> --- /dev/null
>> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
>> @@ -0,0 +1,180 @@
>> +/*
>> + * Device Tree Source for the r8a7792 SoC
>> + *
>> + * Copyright (C) 2016 Cogent Embedded Inc.
>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2.  This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include <dt-bindings/clock/r8a7792-clock.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/power/r8a7792-sysc.h>
>> +
>> +/ {
>> +       compatible = "renesas,r8a7792";
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>
> This is gonna need
>
>                 enable-method = "renesas,apmu";
>
> soon.

    When Magnus' patchset lands, we'll see...

>> +       soc {
>
>> +               p_clk: p {
>> +               compatible = "fixed-factor-clock";
>
> Missing TAB.

    Argh!

>> +                       clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
>> +                       #clock-cells = <0>;
>> +                       clock-div = <24>;
>> +                       clock-mult = <1>;
>> +               };
>> +               cp_clk: cp {
>> +                       compatible = "fixed-factor-clock";
>> +                       clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
>> +                       #clock-cells = <0>;
>> +                       clock-div = <3>;
>
> 48

    Thank you.

>
> (did you check /sys/kernel/debug/clk/clk_summary matches Table 7.2c?)

    Now I have! Only the Z clock seem to be out of range -- 1.5 GHz vs 1 GHz max.

>> +                       clock-mult = <1>;
>> +               };
>> +
>> +               /* Gate clocks */
>
>> +               mstp7_clks: mstp7_clks at e615014c {
>> +                       compatible = "renesas,r8a7792-mstp-clocks",
>> +                                    "renesas,cpg-mstp-clocks";
>> +                       reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
>> +                       clocks = <&zs_clk>, <&zs_clk>, <&p_clk>, <&p_clk>,
>> +                                <&p_clk>, <&p_clk>;
>> +                       #clock-cells = <1>;
>> +                       clock-indices = <
>> +                               R8A7792_CLK_HSCIF1 R8A7792_CLK_HSCIF0
>> +                               R8A7792_CLK_SCIF3 R8A7792_CLK_SCIF2
>> +                               R8A7792_CLK_SCIF1 R8A7792_CLK_SCIF0
>> +                       >;
>> +                       clock-output-names = "hscif1", "hscif0", "scif3",
>> +                                            "scif2", "scif1", "scif0",
>> +                                            "du1", "du0";
>
> You forgot to drop "du1" and "du0".

    Argh again...

>> +               };
>
> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
