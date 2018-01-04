From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 10:02:51 +0100
Subject: [PATCH 30/67] dma-direct: retry allocations using GFP_DMA for
 small masks
In-Reply-To: <f6139b03-0a4a-a9fe-4818-9b0bccf419e4@arm.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-31-hch@lst.de>
 <f6139b03-0a4a-a9fe-4818-9b0bccf419e4@arm.com>
Message-ID: <20180104090251.GE3251@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 04:43:15PM +0000, Vladimir Murzin wrote:
> On 29/12/17 08:18, Christoph Hellwig wrote:
> > If we got back an allocation that wasn't inside the support coherent mask,
> > retry the allocation using GFP_DMA.
> > 
> > Based on the x86 code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  lib/dma-direct.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/dma-direct.c b/lib/dma-direct.c
> > index ab81de3ac1d3..f8467cb3d89a 100644
> > --- a/lib/dma-direct.c
> > +++ b/lib/dma-direct.c
> > @@ -28,6 +28,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
> >  	return true;
> >  }
> >  
> > +static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
> > +{
> > +	return phys_to_dma(dev, phys) + size <= dev->coherent_dma_mask;
> 
> Shouldn't it be: phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask ?

Yes, I think it should.  The existing code was blindly copy and pasted
from x86.

> > +	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > +		__free_pages(page, page_order);
> > +		page = NULL;
> > +
> > +		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
> > +		    !(gfp & GFP_DMA)) {
> > +			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
> > +			goto again;
> 
> Shouldn't we limit number of attempts?

We only retty once anyway, due to the !GFP_DMA check first and then
ORing in GFP_DMA.
