From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Nov 2017 14:58:55 +0100
Subject: [PATCH v2] arm64: dts: renesas: r8a7795: Move nodes which have no
 reg property out of bus
In-Reply-To: <CAL_JsqKffs+5s92kWFeDivdgk2mVBmHrKuNDCfR9Lb=te5k33A@mail.gmail.com>
References: <20171124105234.25774-1-horms+renesas@verge.net.au>
 <CAMuHMdW9V6Bkh5uS9qNA7awtygEs=qRd7jigwSHmpV2VM3n9dA@mail.gmail.com>
 <20171127110430.ulgjrzgy3pdugs2s@verge.net.au>
 <CAMuHMdUm=PiGVWVg9pyNTR5z2WjLcoG1uecBNBeKsSxbAxBt8w@mail.gmail.com>
 <20171128085645.ofrk33bfqd736sip@verge.net.au>
 <CAMuHMdXoDNt7j-hEZmDA2BFFPUAfsi1ukZWowJ3=kTswyYMk5Q@mail.gmail.com>
 <CAL_JsqKffs+5s92kWFeDivdgk2mVBmHrKuNDCfR9Lb=te5k33A@mail.gmail.com>
Message-ID: <CAMuHMdVaL6WeOiZhBU2qfXQK7a9NjshUow2GpJJqkwXywiQmaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Nov 29, 2017 at 2:35 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Nov 28, 2017 at 3:04 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Nov 28, 2017 at 9:56 AM, Simon Horman <horms@verge.net.au> wrote:
>>> On Mon, Nov 27, 2017 at 12:15:39PM +0100, Geert Uytterhoeven wrote:
>>>> On Mon, Nov 27, 2017 at 12:04 PM, Simon Horman <horms@verge.net.au> wrote:
>>>> > I just noticed that with this patch applied I now see:
>>>> >
>>>> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a57
>>>> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a53
>>>> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a57
>>>> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a53arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /timer
>>>> >
>>>> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /timer
>>>>
>>>> Right, the "interrupt-parent = <&gic>;" inside the /soc node applies to child
>>>> nodes of the /soc node only.
>>>>
>>>> You can find this in two ways:
>>
>> s/find/fix/
>>
>>>>
>>>>   1. Add "interrupt-parent = <&gic>;" to the /pmu_a57 and /pmu_a53 nodes.
>>>>   2. Switch those nodes from "interrupt" to "interrupts-extended", e.g. turn
>>>>
>>>>         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>>>>
>>>>      into
>>>>
>>>>         interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
>>>>
>>>> The latter is what e.g. arch/arm/boot/dts/armada-375.dtsi does.
>>>
>>> Thanks, I took option 1 as it seems consistent with the rest of the
>>> Renesas DT files. I also added it to the /timer node.
>>
>> Actually we recently had a discussion about this on IRC, triggered by a
>> similar issue in board files (see e.g, Ethernet PHY interrupts).
>>
>> Given the following comment:
>>
>> drivers/of/irq.c:       /* Try the new-style interrupts-extended first */
>> drivers/of/irq.c:       res = of_parse_phandle_with_args(device,
>> "interrupts-extended",
>>
>> I think it would be better to use interrupts-extended for individual/isolated
>> use outside the /soc node.
>
> I disagree. There's no point to use interrupts-extended unless you
> have 2 or more interrupt parents. Just set interrupt-parent in the
> root node.

The on-SoC devices (all under the /soc node, except for the weird ones without
reg properties that are now being moved out) all have "&gic" as their interrupt
parents.

Off-SoC devices use one of the on-SoC interrupt controllers for external
interrupts ("&irqc", "&irqpin", "&irqpin0", "&irqpin1"), or one of the on-SoC
GPIO controllers that can also serve external interrupts ("&gpioN").

For the latter, I think interrupts-extended definitely makes sense.

For the former (incl. the "pmu_aN" nodes discussed here), it is debatable.
But using interrupts-extended makes it easier to catch mistakes in board files,
as they will be flagged by dtc ("Missing interrupt-parent").
With interrupt-parent in the root node, they may go undetected.

If the tools can help us, I prefer to use them.

Do you agree?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
