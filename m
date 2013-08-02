From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 12:53:34 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801192730.GC9174@kroah.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <20130801192730.GC9174@kroah.com>
Message-ID: <20130802115334.GN2465@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Thu, Aug 01, 2013 at 08:27:30PM +0100, Greg KH wrote:
> On Thu, Aug 01, 2013 at 07:35:31PM +0100, Will Deacon wrote:
> > Naturally, this would need to be described as a device-tree binding and
> > communicate:
> > 
> >   - Buses which can be configured as coherent, including which devices
> >     on those buses can be made coherent.
> > 
> >   - How IOMMUs sit on the bus and interact with masters on that bus (the
> >     current one-IOMMU-driver-per-bus may not work well for the
> >     platform_bus).
> 
> I've been waiting for people to finally run into this one, and realize
> that they shouldn't be using "platform_bus" :)

But, as pointed out later in this thread, people have been doing the exact
opposite! We can change the mindset by yelling, but if you're writing a new
driver for a peripheral on an ARM SoC, platform_bus is mighty tempting
because you get a bunch of device-tree parsing code for free (see
drivers/of/platform.c).

What's worse is that this nice-and-easy auto-probing doesn't work for nested
device-nodes (i.e. a bunch of device-nodes under a common parent, something
which you might think is pretty common in a `tree') so people shy away from
nesting as a means to group devices too.

> >   - QoS and PM constraints. This isn't really in my area, but we do have
> >     buses that have these features and expect software to control them.
> > 
> >   - The system topology and linkages between buses and devices.
> 
> The driver core handles this really well, you just have to create new
> busses, and don't rely on the "catch-all" platform_bus.

Agreed, it's time that we started to describe these non-probable buses as
separate bus_types, with controller logic for configuring the bus itself
(there are weird-and-wonderful ring-based designs on the horizon which can
require a fair amount of setup).

> > The last point is increasingly important as various blocks of ARM system
> > IP start to require knowledge of masters and how things like memory
> > traffic, DVM messages, interrupts (think MSI) etc are routed between
> > them in order to configure the system correctly. For example, interfacing
> > a PCIe device with an SMMU requires knowledge of both the requester id
> > associated with the device and how that maps to incoming stream ids
> > (based off the AXI bus id) on the SMMU. Even worse, this mapping is
> > likely generated dynamically by the host controller, which would need to
> > know about downstream buses and their SMMUs.
> 
> Hm, sounds like an ACPI tree is what you need to be using :)
> 
> Seriously, why not use ACPI for stuff like this?  You already are
> starting to do that for ARM-based systems, why not just make it the
> standard?

So, like a good proportion of the ARM community, ACPI isn't something I'm
well-versed in. Yes, it's coming, but at the same time it's not going to be
everywhere and we need to continue to support new SoCs using device-tree.
Whilst it might even become a de-factor standard for servers, mobile devices
will likely continue with the bootloaders they currently have. Furthermore,
the mobile space is really the wild-west when it comes to system topology --
exynos SoCs tend to have one IOMMU per device, for example:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/181922.html

On the back of that, how does ACPI describe these relationships? It would
certainly be a good idea to see what's already being done so we don't
reinvent everything again for device-tree.

Will
