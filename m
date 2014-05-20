From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 May 2014 15:34:46 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140520131741.GB6240@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <8663464.40PHEumOar@wuerfel> <20140520131741.GB6240@ulmo>
Message-ID: <4161434.ylGuoPKcfs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 May 2014 15:17:43 Thierry Reding wrote:
> On Tue, May 20, 2014 at 02:41:18PM +0200, Arnd Bergmann wrote:
> > On Tuesday 20 May 2014 14:02:43 Thierry Reding wrote:
> [...]
> > > Couldn't a single-master IOMMU be windowed?
> > 
> > Ah, yes. That would actually be like an IBM pSeries, which has a windowed
> > IOMMU but uses one window per virtual machine. In that case, the window could
> > be a property of the iommu node though, rather than part of the address
> > in the link.
> 
> Does that mean that the IOMMU has one statically configured window which
> is the same for each virtual machine? That would require some other
> mechanism to assign separate address spaces to each virtual machine,
> wouldn't it? But I suspect that if the IOMMU allows that it could be
> allocated dynamically at runtime.

The way it works on pSeries is that upon VM creation, the guest is assigned
one 256MB window for use by assigned DMA capable devices. When the guest
creates a mapping, it uses a hypercall to associate a bus address in that
range with a guest physical address. The hypervisor checks that the bus
address is within the allowed range, and translates the guest physical
address into a host physical address, then enters both into the I/O page
table or I/O TLB.

> > I would like to add an explanation about dma-ranges to the binding:
> > 
> > 8<--------
> > The parent bus of the iommu must have a valid "dma-ranges" property
> > describing how the physical address space of the IOMMU maps into
> > memory.
> 
> With physical address space you mean the addresses after translation,
> not the I/O virtual addresses, right? But even so, how will this work
> when there are multiple IOMMU devices? What determines which IOMMU is
> mapped via which entry?
> 
> Perhaps having multiple IOMMUs implies that there will have to be some
> partitioning of the parent address space to make sure two IOMMUs don't
> translate to the same ranges?

These dma-ranges properties would almost always be for the entire RAM,
and we can treat anything else as a bug.

The mapping between what goes into the IOMMU and what comes out of it
is not reflected in DT at all, since it only happens at runtime.
The dma-ranges property I mean above describes how what comes out of
the IOMMU maps into physical memory.

> > A device with an "iommus" property will ignore the "dma-ranges" property
> > of the parent node and rely on the IOMMU for translation instead.
> 
> Do we need to consider the case where an IOMMU listed in iommus isn't
> enabled (status = "disabled")? In that case presumably the device would
> either not function or may optionally continue to master onto the parent
> untranslated.

My reasoning was that the DT should specify whether we use the IOMMU
or not. Being able to just switch on or off the IOMMU sounds nice as
well, so we could change the text above to do that.

Another option would be to do this in the IOMMU code, basically
falling back to the IOMMU parent's dma-ranges property and using
linear dma_map_ops when that is disabled.

> > Using an "iommus" property in bus device nodes with "dma-ranges"
> > specifying how child devices relate to the IOMMU is a possible extension
> > but is not recommended until this binding gets extended.
> 
> Just for my understanding, bus device nodes with iommus and dma-ranges
> properties could be equivalently written by explicitly moving the iommus
> properties into the child device nodes, right? In which case they should
> be the same as the other examples. So that concept is a convenience
> notation to reduce duplication, but doesn't fundamentally introduce any
> new concept.

The one case  where that doesn't work is PCI, because we don't list the
PCI devices in DT normally, and the iommus property would only exist
at the PCI host controller node.

	Arnd
