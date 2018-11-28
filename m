From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 28 Nov 2018 14:03:47 -0800
Subject: [PATCH 6/6] arm64: dts: marvell: Add cpu clock node on Armada
 7K/8K
In-Reply-To: <87a7lzq1jz.fsf@bootlin.com>
References: <20180922181709.13007-1-gregory.clement@bootlin.com>
 <20180922181709.13007-7-gregory.clement@bootlin.com>
 <153936613666.5275.6122138233361141260@swboyd.mtv.corp.google.com>
 <87a7lzq1jz.fsf@bootlin.com>
Message-ID: <154344262734.88331.5318941402726866903@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gregory CLEMENT (2018-11-23 07:02:56)
> Hi Stephen,
>  
>  On ven., oct. 12 2018, Stephen Boyd <sboyd@kernel.org> wrote:
> 
> > +Rob
> >
> > Quoting Gregory CLEMENT (2018-09-22 11:17:09)
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> index 4a65e4e830aa..27c840e91abe 100644
> >> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> >> @@ -280,6 +280,12 @@
> >>                                 #address-cells = <1>;
> >>                                 #size-cells = <1>;
> >>  
> >> +                               cpu_clk: clock-cpu {
> >> +                                       compatible = "marvell,ap806-cpu-clock";
> >> +                                       clocks = <&ap_clk 0>, <&ap_clk 1>;
> >> +                                       #clock-cells = <1>;
> >> +                               };
> >
> > This looks like the wrong place because there isn't a reg property. It
> 
> There is no reg property because we are inside a syscon node where the
> registers are shared between multiple IPs.

The node right after this node has a reg property. What's going on?

> 
> > should go to the root of the tree. And then it looks like we're adding
> > something to DT to get a driver to probe, which is improper DT design.
> 
> There is nothing related to the driver, this subnode describes the way
> the hardware is designed. Under the system controller node there are
> several IPs , like the CPU clocks, but also the GPIO or the pinctrl.
> 

Ok. And some of them have reg properties and others don't? We should
somehow deprecate the idea of a syscon with child nodes. It leads to
this weird twisting of DT. The only use for syscon from my perspective
is when we have a register region that other random devices with their
own 'reg' property need to peek/poke random things into.
