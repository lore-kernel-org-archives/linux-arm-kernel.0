From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 01 Aug 2013 14:41:49 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Describing complex,
 non-probable system topologies
In-Reply-To: <20130801183531.GB29831@mudshark.cambridge.arm.com>
References: <20130801183531.GB29831@mudshark.cambridge.arm.com>
Message-ID: <1375393309.2070.12.camel@dabdike>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-01 at 19:35 +0100, Will Deacon wrote:
> Hello,
> 
> Whilst Linux implements a bunch of different bus types (many of which
> are in fact virtual), devices sitting on non-probable, memory mapped
> buses inside SoCs typically live on either the platform_bus or the
> amba_bus. So far, this has worked out alright; the buses haven't needed
> to be visible to software and no additional software control is really
> required from the OS. However, as I/O coherency and hardware
> virtualisation capabilities start to creep into ARM-based SoCs, Linux
> needs to know the topology of the system on which it is running.
> 
> Naturally, this would need to be described as a device-tree binding and
> communicate:
> 
>   - Buses which can be configured as coherent, including which devices
>     on those buses can be made coherent.

I don't think coherency is a good bus property:  we have PCI systems
which are incoherent by virtue of the CPU they're attached to rather
than because of any fundamental bus property.

>   - How IOMMUs sit on the bus and interact with masters on that bus (the
>     current one-IOMMU-driver-per-bus may not work well for the
>     platform_bus).

That's really not a good model.  On most parisc system, we have a split
IOMMU model (we mostly have two iommus and the topology determines which
one you have to use), but our two upper iommus are exposed as parisc
devices sitting at the root of the device tree.  When we program the
device for DMA we walk up the bus until we find the correct iommu to
program.

>   - QoS and PM constraints. This isn't really in my area, but we do have
>     buses that have these features and expect software to control them.
> 
>   - The system topology and linkages between buses and devices.

Actually, topology isn't really about linkages between busses and
devices.  Topology is about linkages between devices and devices.  A bus
type is a grouping of a set of devices which share common properties so
if you look at parisc for example, which is closest to ARM, our bus
topology at the top is usually two iommus connected to a set of end
points connected to several parisc specific things, all of which are bus
type parisc.  PCI is the same since PCI bridges are also PCI devices,
you can get device topologies nesting quite deep.

James
