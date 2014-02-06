From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 6 Feb 2014 13:32:00 +0100
Subject: [RFC/RFT 1/2] ARM: mm: introduce arch hooks for dma address
 translation routines
In-Reply-To: <20140205162325.GB2248@e103592.cambridge.arm.com>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <3284212.inOfNqnVqs@wuerfel>
 <20140205162325.GB2248@e103592.cambridge.arm.com>
Message-ID: <201402061332.00432.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 February 2014, Dave Martin wrote:
> On Tue, Feb 04, 2014 at 06:04:56PM +0100, Arnd Bergmann wrote:
> > On Tuesday 04 February 2014 11:38:32 Santosh Shilimkar wrote:
> > > On Tuesday 04 February 2014 11:15 AM, Arnd Bergmann wrote:
> > > 
> > > > 1. DMA is coherent
> > > > 2. DMA space is offset from phys space
> > > > 3. DMA space is smaller than 32-bit
> > > > 4. DMA space is larger than 32-bit
> > > > 5. DMA goes through an IOMMU
> 
> As you explain above, these are properties of end-to-end paths between
> a bus-mastering device and the destination.  They aren't properties
> of a device, or of a bus.
> 
> For example, we can have the following system, which ePAPR can't describe
> and wouldn't occur with PCI (or, at least would occur in a transparent
> way so that software does not need to understand the difference between
> this structure and a simple CPU->devices tree).
> 
>      C
>      |
>      v
>      I ---+
>     / \    \  
>    /   \    \ 
>   v     v    \
>  A ----> B    \
>   \            v
>    +---------> D
> 
> This follows from the unidirectional and minimalistic nature of ARM SoC
> buses (AMBA family, AHB, APB etc. ... and most likely many others too).
> 
> To describe A's DMA mappings correctly, the additional links must be
> described, even though thay are irrelevant for direct CPU->device
> transactions.
 
Can you be more specific about what kind of hardware would use such
a mapping? The interesting cases are normally all about accessing
RAM, while your example seems to be for device-to-device DMA and
that doesn't have to go through dma-ranges.

> dma-ranges does work for simpler cases.  In particular, it works where all
> bus-mastering children of a bus node can a) access each other using the
> address space of the bus node, and b) all have the same view of the rest
> of the system (which may be different from the view from outside the bus:
> the dma-ranges property on the bus describes the difference).
> 
> Sometimes, we may be able to describe an otherwise undescribable situation
> by introducing additional fake bus nodes.  But if there are cross-links
> between devices, this won't always work.
> 
> 
> This may not be the common case, but it does happen: we need to decide
> whether to describe it propertly, or to describe a fantasy in the DT
> and bodge around it elsewhere when it happens.

Do you think this could be fully described if we add a "dma-parent"
property that can redirect the "dma-ranges" parent address space to
another node?

If there are devices that have parts of their DMA address space on
various buses, how about a "dma-ranges-ext" property that contains
tuples of <&parent-phandle local-address parent-address size> rather
than just <local-address parent-address size>?

> Similarly, for IOMMU, the ARM SMMU is an independent component which is
> not directly associated with a bus: nor is there guaranteed to be a 1:1
> correspondence.  Simply wedging properties in a bus or device node to say
> "this is associated with an IOMMU" is not always going to work:  it is
> what you flow through on a given device->device path that matters, and
> that can vary from path to path.

Right, I'm aware that the IOMMU may be per device rather than per-bus.
This could be handled by faking extra buses, or possibly better with
the dma-parent approach above, if that is allowed to point to either
a bus or an IOMMU.

	Arnd
