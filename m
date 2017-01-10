From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jan 2017 16:06:29 +0100
Subject: [PATCH v2] arm64: do not set dma masks that device connection
 can't handle
In-Reply-To: <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
References: <1483947002-16410-1-git-send-email-nikita.yoush@cogentembedded.com>
 <6116278.nQQUSuo3l4@wuerfel> <5c5cd4fd-4854-a2dd-10b6-9cc98e63a85c@arm.com>
Message-ID: <1900630.ldF24KWUdV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2017 2:16:57 PM CET Robin Murphy wrote:
> On 10/01/17 13:42, Arnd Bergmann wrote:
> > On Tuesday, January 10, 2017 1:25:12 PM CET Robin Murphy wrote:
> >> On 10/01/17 12:47, Nikita Yushchenko wrote:
> >>>> The point here is that an IOMMU doesn't solve your issue, and the
> >>>> IOMMU-backed DMA ops need the same treatment. In light of that, it really
> >>>> feels to me like the DMA masks should be restricted in of_dma_configure
> >>>> so that the parent mask is taken into account there, rather than hook
> >>>> into each set of DMA ops to intercept set_dma_mask. We'd still need to
> >>>> do something to stop dma_set_mask widening the mask if it was restricted
> >>>> by of_dma_configure, but I think Robin (cc'd) was playing with that.
> >>>
> >>> What issue "IOMMU doesn't solve"?
> >>>
> >>> Issue I'm trying to address is - inconsistency within swiotlb
> >>> dma_map_ops, where (1) any wide mask is silently accepted, but (2) then
> >>> mask is used to decide if bounce buffers are needed or not. This
> >>> inconsistency causes NVMe+R-Car cobmo not working (and breaking memory
> >>> instead).
> >>
> >> The fundamental underlying problem is the "any wide mask is silently
> >> accepted" part, and that applies equally to IOMMU ops as well.
> > 
> > It's a much rarer problem for the IOMMU case though, because it only
> > impacts devices that are restricted to addressing of less than 32-bits.
> > 
> > If you have an IOMMU enabled, the dma-mapping interface does not care
> > if the device can do wider than 32 bit addressing, as it will never
> > hand out IOVAs above 0xffffffff.
> 
> I can assure you that it will - we constrain allocations to the
> intersection of the IOMMU domain aperture (normally the IOMMU's physical
> input address width) and the given device's DMA mask. If both of those
> are >32 bits then >32-bit IOVAs will fall out. For the arm64/common
> implementation I have prototyped a copy of the x86 optimisation which
> always first tries to get 32-bit IOVAs for PCI devices, but even then it
> can start returning higher addresses if the 32-bit space fills up.

Ok, got it. I have to admit that most of my knowledge about the internals
of IOMMUs is from PowerPC of a few years ago, which couldn't do this at
all. I agree that we need to do the same thing on swiotlb and iommu then.

> >> The thread Will linked to describes that equivalent version of your
> >> problem - the IOMMU gives the device 48-bit addresses which get
> >> erroneously truncated because it doesn't know that only 42 bits are
> >> actually wired up. That situation still requires the device's DMA mask
> >> to correctly describe its addressing capability just as yours does.
> > 
> > That problem should only impact virtual machines which have a guest
> > bus address space covering more than 42 bits of physical RAM, whereas
> > the problem we have with swiotlb is for the dma-mapping interface.
> > 
> I actually have a third variation of this problem involving a PCI root
> complex which *could* drive full-width (40-bit) addresses, but won't,
> due to the way its PCI<->AXI interface is programmed. That would require
> even more complicated dma-ranges handling to describe the windows of
> valid physical addresses which it *will* pass, so I'm not pressing the
> issue - let's just get the basic DMA mask case fixed first.

Can you describe this a little more? We should at least try to not
make it harder to solve the next problem while solving this one,
so I'd like to understand the exact limitation you are hitting there.

	Arnd
