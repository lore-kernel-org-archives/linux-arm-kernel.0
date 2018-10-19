From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 18 Oct 2018 20:37:15 -0400
Subject: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
In-Reply-To: <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-8-hch@lst.de>
 <35016142-f06d-e424-5afe-6026b6d57eda@arm.com>
Message-ID: <20181019003715.GI1251@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	if (!dma_capable(dev, dma_addr, size) ||
> > +	    swiotlb_force == SWIOTLB_FORCE) {
> > +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> > +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> > +	}
> 
> FWIW I prefer the inverse condition and early return of the original code
> here, which also then allows a tail-call to swiotlb_bounce_page() (and saves
> a couple of lines), but it's no biggie.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I agree with Robin - it certainly makes it easier to read.

With that small change:
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!

> 
> > -	return DIRECT_MAPPING_ERROR;
> > +	return dma_addr;
> >   }
> >   /*
> > 
