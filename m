From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Feb 2015 15:41:49 +0000
Subject: [PATCH v3 5/5] ARM: dts: Alpine platform devicetree
In-Reply-To: <CABM=7kmcPyxqah8Yek1PoSOzZarMh8eMFdakgz5k418FzMvc_g@mail.gmail.com>
References: <54cf5d8c.sl7aclyeuuh66jXt%tsahee@annapurnalabs.com>
 <20150202134051.GB21175@leverpostej>
 <CABM=7kmcPyxqah8Yek1PoSOzZarMh8eMFdakgz5k418FzMvc_g@mail.gmail.com>
Message-ID: <20150202154149.GD21175@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 03:27:48PM +0000, Tsahee Zidenberg wrote:
> Thank you for your review!
> 
> On 2 February 2015 at 15:40, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Feb 02, 2015 at 11:20:44AM +0000, Tsahee Zidenberg wrote:
> >> +             arch-timer {
> >> +                     compatible = "arm,cortex-a15-timer",
> >> +                                  "arm,armv7-timer";
> >> +                     interrupts =
> >> +                             <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >> +                             <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >> +                             <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> >> +                             <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> >> +                     clock-frequency = <0>; /* Filled by loader */
> >
> > Your loader doesn't configure CNTFRQ?
> >
> 
> Not currently. setting CNTFRQ must be done in the firmware, to be
> valid across all CPUs and through power-cycles. This isn't supported
> on current firmware, which is used in currently available devices. I
> will add this as a required feature from next-gen firmware.
> clock-frequency property is read by linux-kernel before attempting to
> read CNTFRQ.

Ok.

The "clock-frequency" property is unfortunately a poor workaround for
CNTFRQ not being set, due to CNTFRQ being exposed to guests in the
presence of virtualisation (and potentially userspace were we to have a
VDSO).

> 
> 
> >> +             /* North Bridge Service Registers */
> >> +             sysfabric-service at fb070000 {
> >> +                     compatible = "al,alpine-sysfabric-service", "syscon", "simple-bus";
> >> +                     reg = <0x0 0xfb070000 0x0 0x10000>;
> >> +             };
> >
> > That compatible list makes no sense whatsoever.
> >
> > Why is "simple-bus" on the end?
> >
> 
> Nodes that are used with "syscon_regmap_lookup_by_compatible" appear
> both with and without compatibility to "simple-bus" in the
> device-trees.
> examples with: "fsl,imx6q-anatop", "xlnx,zynq-slcr"
> examples without: "fsl,imx6q-iomuxc-gpr", "rockchip,rk3066-pmu"
> Both ways work, I'm not if there is reasoning behind this difference
> in current device-trees or which is the better example to follow. I
> have no problem working either way. Is there a consensus on this?

The "simple-bus" entry is wrong, and should be removed.

In other cases it's also likely to be wrong, but I'd have to inspect
them to be sure.

Mark.
