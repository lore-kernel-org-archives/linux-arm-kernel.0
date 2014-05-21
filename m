From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 May 2014 11:36:32 +0200
Subject: [PATCH] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140521090037.GA19268@ulmo>
References: <1400242998-437-1-git-send-email-thierry.reding@gmail.com>
 <4367469.BqpJyVF8PT@wuerfel> <20140521090037.GA19268@ulmo>
Message-ID: <5371868.4QO1YJ0hU2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 May 2014 11:00:38 Thierry Reding wrote:
> On Wed, May 21, 2014 at 10:50:38AM +0200, Arnd Bergmann wrote:
> > On Wednesday 21 May 2014 10:26:11 Thierry Reding wrote:

> > > > > For determining dma masks, it is the output address that it
> > > > > important.  Santosh's code can probably be taught to handle this,
> > > > > if given an additional traversal rule for following "iommus"
> > > > > properties.  However, deploying an IOMMU whose output address size
> > > > > is smaller than the 
> > > > 
> > > > Something seems to be missing here. I don't think we want to handle
> > > > the case where the IOMMU output cannot the entire memory address
> > > > space. If necessary, that would mean using both an IOMMU driver
> > > > and swiotlb, but I think it's a reasonable assumption that hardware
> > > > isn't /that/ crazy.
> > > 
> > > Similarily, should the IOMMU not be treated like any other device here?
> > > Its DMA mask should determine what address range it can access.
> > 
> > Right. But for that we need a dma-ranges property in the parent of the
> > iommu, just so the mask can be set correctly and we don't have to
> > rely on the 32-bit fallback case.
> 
> Shouldn't the IOMMU driver be the one to set the DMA mask for the device
> in exactly the same way that other drivers override the 32-bit default?

The IOMMU driver could /ask/ for an appropriate mask based on its internal
design, but if you have an IOMMU with a 64-bit output address connected
to a 32-bit bus, that should fail.

Note that it's not obvious what the IOMMU's DMA mask actually means.
It clearly has to be the mask that is used for allocating the IO page
tables, but it wouldn't normally be used in the path that allocates
pages on behalf of a DMA master attached to the IOMMU, because that
allocation is performed by the code that looks at the other device's
dma mask.

	Arnd
