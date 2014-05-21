From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 20:11:19 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140521170954.GC3830@e103592.cambridge.arm.com>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <20140521090037.GA19268@ulmo>
 <20140521170954.GC3830@e103592.cambridge.arm.com>
Message-ID: <4393962.rf2bYfTJVU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 18:09:54 Dave Martin wrote:
> On Wed, May 21, 2014 at 11:00:38AM +0200, Thierry Reding wrote:
> > On Wed, May 21, 2014 at 10:50:38AM +0200, Arnd Bergmann wrote:
> > > On Wednesday 21 May 2014 10:26:11 Thierry Reding wrote:
> > > > 
> > > > Similarily, should the IOMMU not be treated like any other device here?
> > > > Its DMA mask should determine what address range it can access.
> > > 
> > > Right. But for that we need a dma-ranges property in the parent of the
> > > iommu, just so the mask can be set correctly and we don't have to
> > > rely on the 32-bit fallback case.
> > 
> > Shouldn't the IOMMU driver be the one to set the DMA mask for the device
> > in exactly the same way that other drivers override the 32-bit default?
> > 
> 
> Are we confusing the "next-hop DMA mask" with the "end-to-end DMA mask"
> here?  The device has a next-hop mask which may be non-trivial.  The
> IOMMU also has a next-hop mask and/or remapping, but I think we agree
> that in sensible systems that will be trivial.  There might be other
> non-trivial remappings between the IOMMU and memory (but again, not
> in the common case).
> 
> If we just use the same name for all these, we are liable to get
> confused.
> 
> To answer the question "what memory can the kernel allocate for DMA
> with this device", it is the end-to-end transformation that is
> important.

Yes, but that is not the same as the dma mask of the device. The DMA
mask gets set by the device according to its capabilities, and may
get limited by what the bus to either memory or to the iommu can do,
if one is in use.

Without an IOMMU, the mask is used for allocations, with an IOMMU,
The iommu code makes the decision what to allocate without taking
dev->dma_mask into account.

As mentioned, this is currently not handled well for SCSI and network,
where we use a smaller mask than necessary and can end up copying
data.

	Arnd
