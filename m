From: anders.berg@lsi.com (Anders Berg)
Date: Tue, 15 Apr 2014 16:56:21 +0200
Subject: [PATCH 2/5] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <534D294D.7000201@arm.com>
References: <cover.1397552154.git.anders.berg@lsi.com>
 <02c006a6fc64131df82981abbc1c71c7af52254e.1397552154.git.anders.berg@lsi.com>
 <534D294D.7000201@arm.com>
Message-ID: <20140415145621.GA32285@swsaberg01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 01:42:53PM +0100, Marc Zyngier wrote:
> Hi Anders,
> 
> On 15/04/14 13:06, Anders Berg wrote:
> > Add device tree for the Amarillo validation board with an AXM5516 SoC.
> > 
> > Signed-off-by: Anders Berg <anders.berg@lsi.com>
> > ---
> >  arch/arm/boot/dts/Makefile             |   1 +
> >  arch/arm/boot/dts/axm5516-amarillo.dts |  51 ++++++
> >  arch/arm/boot/dts/axm5516-cpus.dtsi    | 204 ++++++++++++++++++++++
> >  arch/arm/boot/dts/axm55xx.dtsi         | 306 +++++++++++++++++++++++++++++++++
> >  4 files changed, 562 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/axm5516-amarillo.dts
> >  create mode 100644 arch/arm/boot/dts/axm5516-cpus.dtsi
> >  create mode 100644 arch/arm/boot/dts/axm55xx.dtsi
> > 
> 
> [...]
> 
> > +       gic: interrupt-controller at 2001001000 {
> > +               compatible = "arm,cortex-a15-gic";
> > +               #interrupt-cells = <3>;
> > +               #address-cells = <0>;
> > +               interrupt-controller;
> > +               reg = <0x20 0x01001000 0 0x1000>,
> > +                     <0x20 0x01002000 0 0x1000>,
> > +                     <0x20 0x01004000 0 0x2000>,
> > +                     <0x20 0x01006000 0 0x2000>;
> > +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
> > +                               IRQ_TYPE_LEVEL_HIGH)>;
> > +       };
> 
> Given how many CPUs this system has, what's the catch regarding the GIC?
> Is there a second one shadowing this one at the same address for another
> set of 8 CPUs? Is there an additional mechanism to IPI the other CPUs?
> 

There is actually one GIC per cluster and SPIs are used to hook the clusters
together for use as IPIs, so with this patch one cluster may be booted (using
the standard SGIs still works within each cluster).

Have a modified GIC driver to run all clusters, but this patch is a bit to
invasive to submit at the moment...

/Anders
