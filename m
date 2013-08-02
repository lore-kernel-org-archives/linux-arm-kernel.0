From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Aug 2013 18:08:13 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <1375393309.2070.12.camel@dabdike>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
 <1375393309.2070.12.camel@dabdike>
Message-ID: <20130802170813.GI5292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Thu, Aug 01, 2013 at 10:41:49PM +0100, James Bottomley wrote:
> On Thu, 2013-08-01 at 19:35 +0100, Will Deacon wrote:
> > Whilst Linux implements a bunch of different bus types (many of which
> > are in fact virtual), devices sitting on non-probable, memory mapped
> > buses inside SoCs typically live on either the platform_bus or the
> > amba_bus. So far, this has worked out alright; the buses haven't needed
> > to be visible to software and no additional software control is really
> > required from the OS. However, as I/O coherency and hardware
> > virtualisation capabilities start to creep into ARM-based SoCs, Linux
> > needs to know the topology of the system on which it is running.
> > 
> > Naturally, this would need to be described as a device-tree binding and
> > communicate:
> > 
> >   - Buses which can be configured as coherent, including which devices
> >     on those buses can be made coherent.
> 
> I don't think coherency is a good bus property:  we have PCI systems
> which are incoherent by virtue of the CPU they're attached to rather
> than because of any fundamental bus property.

Ok, but this information surely needs to be propagated to the bus driver,
no? I guess I'm asking where all of this information should be correlated so
that devices can be made coherent or not at runtime.

> >   - How IOMMUs sit on the bus and interact with masters on that bus (the
> >     current one-IOMMU-driver-per-bus may not work well for the
> >     platform_bus).
> 
> That's really not a good model.  On most parisc system, we have a split
> IOMMU model (we mostly have two iommus and the topology determines which
> one you have to use), but our two upper iommus are exposed as parisc
> devices sitting at the root of the device tree.  When we program the
> device for DMA we walk up the bus until we find the correct iommu to
> program.

I think this follows on from Greg's points about writing new bus_types. At
the moment, there is no bus topology in Linux for most of the SoCs in the
ARM-space and, as such, sideband information in the device-tree is used to
work out what links to what. This then localises the topology information to
the IOMMU driver and makes it impossible to co-ordinate with other drivers
and subsystems.

An example of this is that we have a bunch of IOMMU drivers for ARM under
drivers/iommu/, each with a different notion of topology. They then register
with the IOMMU framework as per usual, but at the same time call
bus_set_iommu(&platform_bus_type, ...) to receive notifications of devices
being added on the bus. We have private fields in struct dev_archdata so the
IOMMU driver can keep track of where the device lives in the topology (i.e.
which IOMMU it's mastering through). This is fine within the driver, but how
on Earth are users supposed to create mappings without duplicating and/or
spreading the knowledge ingrained in the driver?

To this end, a global arm_iommu_create_mapping symbol was added, which has
exactly *1* caller in the entire kernel, which seems to be... another IOMMU
driver.

> >   - QoS and PM constraints. This isn't really in my area, but we do have
> >     buses that have these features and expect software to control them.
> > 
> >   - The system topology and linkages between buses and devices.
> 
> Actually, topology isn't really about linkages between busses and
> devices.  Topology is about linkages between devices and devices.  A bus
> type is a grouping of a set of devices which share common properties so
> if you look at parisc for example, which is closest to ARM, our bus
> topology at the top is usually two iommus connected to a set of end
> points connected to several parisc specific things, all of which are bus
> type parisc.  PCI is the same since PCI bridges are also PCI devices,
> you can get device topologies nesting quite deep.

Maybe we're discussing across terminology, but the buses I'm referring to
also have a device aspect to them, so there's a bit of a blur here. It's
probably worth making the distinction though, because the interface
controlling a bus is likely to sit on a different bus itself.

Will
