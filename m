From: horms@verge.net.au (Simon Horman)
Date: Mon, 27 Nov 2017 12:04:31 +0100
Subject: [PATCH v2] arm64: dts: renesas: r8a7795: Move nodes which have
 no reg property out of bus
In-Reply-To: <CAMuHMdW9V6Bkh5uS9qNA7awtygEs=qRd7jigwSHmpV2VM3n9dA@mail.gmail.com>
References: <20171124105234.25774-1-horms+renesas@verge.net.au>
 <CAMuHMdW9V6Bkh5uS9qNA7awtygEs=qRd7jigwSHmpV2VM3n9dA@mail.gmail.com>
Message-ID: <20171127110430.ulgjrzgy3pdugs2s@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 12:09:47PM +0100, Geert Uytterhoeven wrote:
> On Fri, Nov 24, 2017 at 11:52 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Move pmu_a5[73], timer and thermal-zones nodes from soc node to root node.
> > The nodes that have been moved do not have any register properties and thus
> > shouldn't be placed on the bus.
> >
> > This problem is flagged by the compiler as follows:
> > $ make
> > ...
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >   DTC     arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a57 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/pmu_a53 missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm64/boot/dts/renesas/r8a7795-es1-h3ulcb-kf.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2
> > * Preserve alphabetical order of nodes present in root node.
> 
> Thanks for the update!
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I just noticed that with this patch applied I now see:

arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a57
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a53
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a57
arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /pmu_a53arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning (interrupts_property): Missing interrupt-parent for /timer

arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dtb: Warning (interrupts_property): Missing interrupt-parent for /timer
