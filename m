From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 Nov 2017 09:56:51 +0100
Subject: [PATCH v2] arm64: dts: renesas: r8a7795: Move nodes which have
 no reg property out of bus
In-Reply-To: <CAMuHMdUm=PiGVWVg9pyNTR5z2WjLcoG1uecBNBeKsSxbAxBt8w@mail.gmail.com>
References: <20171124105234.25774-1-horms+renesas@verge.net.au>
 <CAMuHMdW9V6Bkh5uS9qNA7awtygEs=qRd7jigwSHmpV2VM3n9dA@mail.gmail.com>
 <20171127110430.ulgjrzgy3pdugs2s@verge.net.au>
 <CAMuHMdUm=PiGVWVg9pyNTR5z2WjLcoG1uecBNBeKsSxbAxBt8w@mail.gmail.com>
Message-ID: <20171128085645.ofrk33bfqd736sip@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 12:15:39PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Nov 27, 2017 at 12:04 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Nov 24, 2017 at 12:09:47PM +0100, Geert Uytterhoeven wrote:
> >> On Fri, Nov 24, 2017 at 11:52 AM, Simon Horman
> >> <horms+renesas@verge.net.au> wrote:
> >> > Move pmu_a5[73], timer and thermal-zones nodes from soc node to root node.
> >> > The nodes that have been moved do not have any register properties and thus
> >> > shouldn't be placed on the bus.
> >> >
> >> > This problem is flagged by the compiler as follows:
> >> > $ make
> >> > ...
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >> >
> >> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> > ---
> >> > v2
> >> > * Preserve alphabetical order of nodes present in root node.
> >>
> >> Thanks for the update!
> >>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > I just noticed that with this patch applied I now see:
> >
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a57
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a53
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a57
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a53arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /timer
> >
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /timer
> 
> Right, the "interrupt-parent = <&gic>;" inside the /soc node applies to child
> nodes of the /soc node only.
> 
> You can find this in two ways:
> 
>   1. Add "interrupt-parent = <&gic>;" to the /pmu_a57 and /pmu_a53 nodes.
>   2. Switch those nodes from "interrupt" to "interrupts-extended", e.g. turn
> 
>         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> 
>      into
> 
>         interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> 
> The latter is what e.g. arch/arm/boot/dts/armada-375.dtsi does.

Thanks, I took option 1 as it seems consistent with the rest of the
Renesas DT files. I also added it to the /timer node.
