From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Jun 2014 08:34:34 +0900
Subject: [PATCH v3 14/19] ARM: shmobile: r8a7779: Add TMU devices to DT
In-Reply-To: <1462083.WMstm6aRc1@avalon>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1402763021-4067-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140616084707.GF11582@verge.net.au> <1462083.WMstm6aRc1@avalon>
Message-ID: <20140616233433.GC24011@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 04:22:11PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 16 June 2014 17:47:07 Simon Horman wrote:
> > On Sat, Jun 14, 2014 at 06:23:36PM +0200, Laurent Pinchart wrote:
> > > Add the TMU0, TMU1 and TMU2 counters to the r8a7779 device tree and make
> > > them disabled by default.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/r8a7779.dtsi | 42 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 42 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7779.dtsi
> > > b/arch/arm/boot/dts/r8a7779.dtsi index 94e2fc8..bf716ce 100644
> > > --- a/arch/arm/boot/dts/r8a7779.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > > @@ -266,6 +266,48 @@
> > >  		reg = <0xffc48000 0x38>;
> > >  	};
> > > 
> > > +	tmu0: timer at ffd80000 {
> > > +		compatible = "renesas,tmu";
> > > +		reg = <0xffd80000 0x30>;
> > > +		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
> > > +		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
> > > +		clock-names = "fck";
> > > +
> > > +		#renesas,channels = <3>;
> > > +
> > > +		status = "disabled";
> > > +	};
> > > +
> > > +	tmu1: timer at ffd81000 {
> > > +		compatible = "renesas,tmu";
> > > +		reg = <0xffd81000 0x30>;
> > > +		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <0 45 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <0 46 IRQ_TYPE_LEVEL_HIGH>;
> > > +		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
> > > +		clock-names = "fck";
> > > +
> > > +		#renesas,channels = <3>;
> > > +
> > > +		status = "disabled";
> > > +	};
> > > +
> > > +	tmu2: timer at ffd82000 {
> > > +		compatible = "renesas,tmu";
> > > +		reg = <0xffd82000 0x30>;
> > > +		interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <0 49 IRQ_TYPE_LEVEL_HIGH>,
> > > +			     <0 50 IRQ_TYPE_LEVEL_HIGH>;
> > > +		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
> > > +		clock-names = "fck";
> > > +
> > > +		#renesas,channels = <3>;
> > > +
> > > +		status = "disabled";
> > > +	};
> > > +
> > >  	sata: sata at fc600000 {
> > >  		compatible = "renesas,rcar-sata";
> > >  		reg = <0xfc600000 0x2000>;
> > 
> > There are no interrupt-parents in in the nodes above nodes
> > although the documentation of the binding has one in the example.
> > Is it just an oversight in this patch?
> 
> Not really.
> 
> The interrupt-parent property is required but can be inherited. Furthermore, 
> the interrupts-extended property can be used to replace the interrupts and 
> interrupt-parent properties. This should all be documented in the DT bindings, 
> but not by duplicating the full explanation in dozens of different flavours in 
> all bindings. We need standard wordings for common properties such as 
> interrupts, clocks or reg.

Thanks for the clarification, I'm fine with that.

> > I believe that the IRQ numbers are not correct.
> > 
> > In setup-r8a7779.c I see gic_iid(0x40). But above I see 40.
> > I think the correct value is 0x40 - 32 = 32. Likewise
> > for the other IRQs of tmu0. And looking at the documentaiton
> > this seems true for tmu1 and tmu2 too.
> >
> > I have successfully booted a marzen board with the following incremental
> > patch to the DT nodes.
> 
> You're right, sorry about that. I'll fix the interrupt numbers and resubmit. 
> The interrupt-parent is specified at the top level so there's no need to add 
> it to the TMU nodes.
> 
> > diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> > index bf716ce..81714ce 100644
> > --- a/arch/arm/boot/dts/r8a7779.dtsi
> > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > @@ -269,9 +269,10 @@
> >  	tmu0: timer at ffd80000 {
> >  		compatible = "renesas,tmu";
> >  		reg = <0xffd80000 0x30>;
> > -		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
> >  		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
> >  		clock-names = "fck";
> > 
> > @@ -283,9 +284,10 @@
> >  	tmu1: timer at ffd81000 {
> >  		compatible = "renesas,tmu";
> >  		reg = <0xffd81000 0x30>;
> > -		interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <0 45 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <0 46 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 36 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 37 IRQ_TYPE_LEVEL_HIGH>;
> 
> If I'm not mistaken the interrupts should be 36, 37 and 38.

Yes, sorry about that.

> >  		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
> >  		clock-names = "fck";
> > 
> > @@ -296,10 +298,11 @@
> > 
> >  	tmu2: timer at ffd82000 {
> >  		compatible = "renesas,tmu";
> > +		interrupt-parent = <&gic>;
> >  		reg = <0xffd82000 0x30>;
> > -		interrupts = <0 48 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <0 49 IRQ_TYPE_LEVEL_HIGH>,
> > -			     <0 50 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupts = <0 38 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 39 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 40 IRQ_TYPE_LEVEL_HIGH>;
> 
> And 40, 41 and 42 here.

Yes. I wonder how I managed to mess these up.

> >  		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
> >  		clock-names = "fck";
