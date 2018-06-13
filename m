From: Matt.Sealey@arm.com (Matt Sealey)
Date: Wed, 13 Jun 2018 15:47:12 +0000
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
In-Reply-To: <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
 <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
 <c0d531ec-9201-bfd8-e6c3-9140698b0697@arm.com>
Message-ID: <HE1PR0802MB24127EC935B9AF6F82AB3B6EEE7E0@HE1PR0802MB2412.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

> > Why not use ?unit??
> >
> > I believe we had this discussion years ago about numbering serial ports
> > and sdhci (i.e. how do you know it?s UART0 or UART1 from just the address?
> > Some SoC?s don?t address sequentially *or* in a forward direction) - I
> > believe it?s not exactly codified in ePAPR, not am I sure where it may be
> > otherwise, but it exists.
>
> We have different situation here. We need to know *the port number* as
> understood by the hardware, so that we can enable *the specific* port for
> a given path.

For the purposes of abstraction, each port will have the property of having
a node which is pointed to by other nodes, and in the case of a true ATB
endpoint, no other nodes behind it.

It doesn't matter what the HW numbers it as as long as the driver can derive
it from whatever you put in the DT. So a funnel (which is ~8 ports muxed into
one output):

   f1p0: port {
      unit = <0>;
      endpoint = <&f1out>;
   };
   f1p1: port {
      unit = <4>;
      endpoint = <&f1out>;
   };
   f1out: port {
      endpoint = <&etf1>;
   };

"unit" here is specific to the driver's understanding of ports within it's
own cycle of the graph. For a replicator you can invert the logic - input
ports don't need a unit, but the two outputs are filtered in CoreSight not
by leg but by transiting ATB ID in groups of 16 IDs. In that case maybe
you would want to describe all 8 possible units on each leg with the first
ID it would filter? Or just list tuples of filter IDs <id, first, last>

Who cares, really, as long as the driver knows what it means.

You don't need to namespace every property.

> As I mentioned above, we need the hardware numbers to enable the
> "specific" port.

Okay and how is this not able to be prescribed in a binding for "arm,coresight-funnel"
that:

"input ports are numbered from 0 to N where N is the maximum input port
number. This number is identified with the "unit" property, which directly
corresponds to the bit position in the funnel Ctrl_Reg register, and the
bit position multiplied by 3 for each 3-bit priority in the funnel
Priority_Ctrl_Reg, with N having a maximum of the defined register bitfield
DEVID[PORTCOUNT], minus one, for that component"

Or a replicator:

"output ports are numbered per the CoreSight ATB Replicator specification,
unit corresponding to the IDFILTERn register controlling ID filters for
that leg, with a maximum of the defined register bitfield DEVID[PORTNUM],
minus one"

One could clarify it, even, with labels for readability ("label" definitely
is a well defined if also completely arbitrary property).

..

> static void funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
> {
>          u32 functl;
>
>          CS_UNLOCK(drvdata->base);
>
>          functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
>          functl &= ~FUNNEL_HOLDTIME_MASK;
>          functl |= FUNNEL_HOLDTIME;
>          functl |= (1 << port);
>          writel_relaxed(functl, drvdata->base + FUNNEL_FUNCTL);
>          writel_relaxed(drvdata->priority, drvdata->base + FUNNEL_PRICTL);
>
>          CS_LOCK(drvdata->base);
> }
>
> No we don't need to parse it in both ways, up and down. Btw, the trace
> paths are not statically created. They are done at runtime, as configured
> by the user.

You do realize this isn't how the hardware works, correct?

Trace paths are fixed, they may diverge with different configurations, but
the full CoreSight topology (all funnels, replicators and intermediary
Components) is entirely unchangeable.

The DT should provide the information to provide a reference acyclic directed
graph of the entire topology (or entirely reasonably programmable topology where
at all possible) - if a user wants to trace from ETM_0 then they only
have particular paths to particular sinks, for instance ETM_0 and ETF_0
may be on their own path, so you cannot just "configure as a user"
a path from ETM_1 to ETF_0 since there isn't one.

Walking said graphs with the knowledge that CoreSight specifically disallows
loopbacks in ATB topology is basic computer science problem - literally a
matter of topological sorting. But let's build a graph once and traverse it -
don't build the graph partially each time or try and build it to cross-check
every time. The paths are wires in the design, lets not fake to the user
that there is any configurability in that or try and encode that in the
DT.

> Coming back to your suggestion of "unit", what does it imply ?

Whatever the driver likes. For uart and mmc, it was just a spurious number
but it could be applied as the end of, say, ttyS<N> or mmcblk<N>p3 or used
in any other driver-specific manner. The number you put in is up to you,
but the valid numbers would be in the binding for that particular device.

> Its too generic a term for something as concrete as a port number.

Is it?

Why would you need a whole other property type to encode a u32 that
describes an arbitrary number specific to that hardware device?

Ta,
Matt


IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
