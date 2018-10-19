From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 19 Oct 2018 09:46:30 -0400
Subject: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
In-Reply-To: <20181019065258.GA29249@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-8-hch@lst.de>
 <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
 <20181019003715.GI1251@char.us.oracle.com>
 <20181019065258.GA29249@lst.de>
Message-ID: <20181019134629.GE54336@Konrads-MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 08:52:58AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 08:37:15PM -0400, Konrad Rzeszutek Wilk wrote:
> > > > +	if (!dma_capable(dev, dma_addr, size) ||
> > > > +	    swiotlb_force == SWIOTLB_FORCE) {
> > > > +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> > > > +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> > > > +	}
> > > 
> > > FWIW I prefer the inverse condition and early return of the original code
> > > here, which also then allows a tail-call to swiotlb_bounce_page() (and saves
> > > a couple of lines), but it's no biggie.
> > > 
> > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > I agree with Robin - it certainly makes it easier to read.
> > 
> > With that small change:
> > Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> So I did this edit, and in this patch it does indeed look much cleaner.
> But in patch 9 we introduce the cache maintainance, and have to invert
> the condition again if we don't want a goto mess:

Right. In which case please leave this patch as it is. And please
plaster the Reviewed-by on the patch. Thank you!
