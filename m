From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 16:01:41 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140521105034.GA2014@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <5371868.4QO1YJ0hU2@wuerfel> <20140521105034.GA2014@ulmo>
Message-ID: <4994892.2gk6QRjAPD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 12:50:38 Thierry Reding wrote:
> On Wed, May 21, 2014 at 11:36:32AM +0200, Arnd Bergmann wrote:
> > On Wednesday 21 May 2014 11:00:38 Thierry Reding wrote:
> > > On Wed, May 21, 2014 at 10:50:38AM +0200, Arnd Bergmann wrote:
> > > > On Wednesday 21 May 2014 10:26:11 Thierry Reding wrote:
> > 
> > > > > > > For determining dma masks, it is the output address that it
> > > > > > > important.  Santosh's code can probably be taught to handle this,
> > > > > > > if given an additional traversal rule for following "iommus"
> > > > > > > properties.  However, deploying an IOMMU whose output address size
> > > > > > > is smaller than the 
> > > > > > 
> > > > > > Something seems to be missing here. I don't think we want to handle
> > > > > > the case where the IOMMU output cannot the entire memory address
> > > > > > space. If necessary, that would mean using both an IOMMU driver
> > > > > > and swiotlb, but I think it's a reasonable assumption that hardware
> > > > > > isn't /that/ crazy.
> > > > > 
> > > > > Similarily, should the IOMMU not be treated like any other device here?
> > > > > Its DMA mask should determine what address range it can access.
> > > > 
> > > > Right. But for that we need a dma-ranges property in the parent of the
> > > > iommu, just so the mask can be set correctly and we don't have to
> > > > rely on the 32-bit fallback case.
> > > 
> > > Shouldn't the IOMMU driver be the one to set the DMA mask for the device
> > > in exactly the same way that other drivers override the 32-bit default?
> > 
> > The IOMMU driver could /ask/ for an appropriate mask based on its internal
> > design, but if you have an IOMMU with a 64-bit output address connected
> > to a 32-bit bus, that should fail.
> 
> Are there real use-cases where that really happens? I guess if we need
> that the correct thing would be to bitwise AND both the DMA mask of the
> IOMMU device (as set by the driver) with that derived from the IOMMU's
> parent bus' dma-ranges property.

It would be unusual for an IOMMU to need this, but it's how the DMA
mask is supposed to work for normal devices. As mentioned before, I
would probably just error out if we ever encounter such an IOMMU.

> > Note that it's not obvious what the IOMMU's DMA mask actually means.
> > It clearly has to be the mask that is used for allocating the IO page
> > tables, but it wouldn't normally be used in the path that allocates
> > pages on behalf of a DMA master attached to the IOMMU, because that
> > allocation is performed by the code that looks at the other device's
> > dma mask.
> 
> Interesting. If a DMA buffer is allocated using the master's DMA mask
> wouldn't that cause breakage if the IOMMU and master's DMA masks don't
> match. It seems to me like the right thing to do for buffer allocation
> is to use the IOMMU's DMA mask if a device uses the IOMMU for
> translation and use the device's DMA mask when determining to what I/O
> virtual address to map that buffer.

Unfortunately not all code agrees regarding how dma mask is actually
interpreted. The most important use is within the dma_map_ops, and
that is aware of the IOMMU. The dma_map_ops use that to decide what
IOVA (bus address) to generate that is usable for the device, normally
this would be a 32-bit range.

When driver code looks at the dma mask of the device itself to make
an allocation decision without taking the IOMMU or swiotlb into
account, things can indeed go wrong.

Russell has recently done a good cleanup of various issues around
dma masks, and I can't find any drivers that get this wrong.
However, there is an issue with the two or three subsystems using
"PCI_DMA_BUS_IS_PHYS" to decide how they should treat high buffers
coming from user space that get passed to hardware.

If the SCSI layer or the network layer find the horribly misnamed
PCI_DMA_BUS_IS_PHYS (which is hardcoded to "1" on ARM32), they
will create copy in low memory for any data that is above
the device dma_mask (SCSI) or above max_low_pfn (network).

This is not normally a bug, and won't hurt for the swiotlb case,
but will give us worse performance for the IOMMU case, and
we should probably change this code to calculate the boundary
per device by calling a function from dma_map_ops.

We also really need to implement swiotlb support on ARM32 to deal
with any other device (besides SCSI and network) that does not
have an IOMMU but wants to use the streaming DMA API on pages
outside of the dma_mask. We already have this case on shmobile.

> Obviously if we always assume that IOMMU hardware is sane and can always
> access at least the whole memory then this isn't an issue. But what if a
> device can do DMA to a 64-bit address space, but the IOMMU can only
> address 32 bits. If the device's DMA mask is used for allocations, then
> buffers could reside beyond the 4 GiB boundary that the IOMMU can
> address, so effectively the IOMMU wouldn't be able to write to those
> buffers.

The mask of the device is not even an issue here, it's more the general
case of passing a buffer outside of the IOMMU's upstream bus DMA mask
into a driver connected to the IOMMU.

	Arnd
