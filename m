From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 5 Feb 2014 16:23:41 +0000
Subject: [RFC/RFT 1/2] ARM: mm: introduce arch hooks for dma address
 translation routines
In-Reply-To: <3284212.inOfNqnVqs@wuerfel>
References: <1391470107-15927-1-git-send-email-santosh.shilimkar@ti.com>
 <201402041715.54538.arnd@arndb.de> <52F11788.4030500@ti.com>
 <3284212.inOfNqnVqs@wuerfel>
Message-ID: <20140205162325.GB2248@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 06:04:56PM +0100, Arnd Bergmann wrote:
> On Tuesday 04 February 2014 11:38:32 Santosh Shilimkar wrote:
> > On Tuesday 04 February 2014 11:15 AM, Arnd Bergmann wrote:
> > > On Tuesday 04 February 2014, Santosh Shilimkar wrote:
> 
> > > I think this is going into a wrong direction. DMA translation is not
> > > at all a platform-specific thing, but rather bus specific. The most
> > > common scenario is that you have some 64-bit capable buses and some
> > > buses that are limited to 32-bit DMA (or less if you are unfortunate).
> > >
> > I may be wrong but you could have 64 bit bus but 32 bit DMA controllers.
> > That is one of the case I am dealing with.
> 
> You are absolutely right. In fact you could have any combination of
> bus widths between a device and the RAM and the correct way to deal
> with this is probably to follow the dma-ranges properties of each
> device in-between and take the intersection (that may not be the
> right term in English, but I think you know what I mean).
> 
> > > I guess for the legacy cases (omap1, iop13xx, ks8695), we can
> > > hardcode dma_map_ops for all devices to get this right. For everything
> > > else, I'd suggest defaulting to the arm_dma_ops unless we get
> > > other information from DT. This means we have to create standardized
> > > properties to handle any combination of these:
> > > 
> > Thats the case and the $subject series doesn't change that.
> > 
> > > 1. DMA is coherent
> > > 2. DMA space is offset from phys space
> > > 3. DMA space is smaller than 32-bit
> > > 4. DMA space is larger than 32-bit
> > > 5. DMA goes through an IOMMU

As you explain above, these are properties of end-to-end paths between
a bus-mastering device and the destination.  They aren't properties
of a device, or of a bus.

For example, we can have the following system, which ePAPR can't describe
and wouldn't occur with PCI (or, at least would occur in a transparent
way so that software does not need to understand the difference between
this structure and a simple CPU->devices tree).

     C
     |
     v
     I ---+
    / \    \  
   /   \    \ 
  v     v    \
 A ----> B    \
  \            v
   +---------> D

This follows from the unidirectional and minimalistic nature of ARM SoC
buses (AMBA family, AHB, APB etc. ... and most likely many others too).

To describe A's DMA mappings correctly, the additional links must be
described, even though thay are irrelevant for direct CPU->device
transactions.


> > > 
> > > The dma-ranges property can deal with 2-4. Highbank already introduced
> > > a "dma-coherent" flag for 1, and we can decide to generalize that.
> > > I don't know what the state of IOMMU support is, but we have to come
> > > up with something better than what we had on PowerPC, because we now
> > > have to deal with a combination of different IOMMUs in the same system,
> > > whereas the most complex case on PowerPC was some devices all going
> > > through one IOMMU and the other devices being linearly mapped.
> > > 
> > Just to be clear, the patch set is not fiddling with dma_ops as such.
> > The dma_ops needs few accessors to convert addresses and these accessors
> > are different on few platforms. And hence needs to be patched.
> 
> well, iop13xx is certainly not going to be multiplatform any time
> soon, so we don't have to worry about those. ks8695 won't be multiplatform
> unless I do it I suspect. I don't know about the plans for OMAP1,
> but since only the OHCI device is special there, it would be trivial
> to do a separate dma_map_ops for that device, or to extend arm_dma_ops
> to read the offset in a per-device variable as we probably have to
> do for DT/multiplatform as well.
> 
> > We will try to look at "dma-ranges" to see if it can address my case.
> > Thanks for the pointer

dma-ranges does work for simpler cases.  In particular, it works where all
bus-mastering children of a bus node can a) access each other using the
address space of the bus node, and b) all have the same view of the rest
of the system (which may be different from the view from outside the bus:
the dma-ranges property on the bus describes the difference).

Sometimes, we may be able to describe an otherwise undescribable situation
by introducing additional fake bus nodes.  But if there are cross-links
between devices, this won't always work.


This may not be the common case, but it does happen: we need to decide
whether to describe it propertly, or to describe a fantasy in the DT
and bodge around it elsewhere when it happens.


Similarly, for IOMMU, the ARM SMMU is an independent component which is
not directly associated with a bus: nor is there guaranteed to be a 1:1
correspondence.  Simply wedging properties in a bus or device node to say
"this is associated with an IOMMU" is not always going to work:  it is
what you flow through on a given device->device path that matters, and
that can vary from path to path.


Santosh, bearing these arguments in mind, do you think that dma-ranges
is natural for your hardware?

The answer may be "yes", but if we're having to twist things to fit,
by having to describe something fake or unreal in DT and/or writing board
specific code to work around it, that motivates coming up with a better
way of describing the hardware in these cases.

I believe Jason also has examples of these issues from the Zynq family
of SoCs, which we were discussing last year.

Cheers
---Dave
