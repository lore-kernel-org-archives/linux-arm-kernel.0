From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 9 Oct 2013 18:31:17 +0100
Subject: [PATCH v6 14/19] swiotlb: print a warning when the swiotlb is full
In-Reply-To: <20130930155808.GT3106@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1309271653420.5498@kaball.uk.xensource.com>
 <1380298207-29151-14-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130930155808.GT3106@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1310091830350.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Konrad Rzeszutek Wilk wrote:
> On Fri, Sep 27, 2013 at 05:10:02PM +0100, Stefano Stabellini wrote:
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > ---
> >  drivers/xen/swiotlb-xen.c |    1 +
> >  lib/swiotlb.c             |    1 +
> >  2 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index 96ad316..790c2eb 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -674,6 +674,7 @@ xen_swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl,
> >  								 sg->length,
> >  								 dir);
> >  			if (map == SWIOTLB_MAP_ERROR) {
> > +				pr_warn("swiotlb buffer is full\n");
> 
> It would be beneficial to use dev_warn instead.

OK

> And perhaps even call debug_dma_dump_mappings to help in diagnosing
> a problem?

I don't think that would be very beneficial because this is an internal
swiotlb issue: we just run out of buffer space.


> >  				/* Don't panic here, we expect map_sg users
> >  				   to do proper error handling. */
> >  				xen_swiotlb_unmap_sg_attrs(hwdev, sgl, i, dir,
> > diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> > index eb45d17..f06da0d 100644
> > --- a/lib/swiotlb.c
> > +++ b/lib/swiotlb.c
> > @@ -502,6 +502,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
> >  
> >  not_found:
> >  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> > +	pr_warn("swiotlb buffer is full\n");
> >  	return SWIOTLB_MAP_ERROR;
> >  found:
> >  	spin_unlock_irqrestore(&io_tlb_lock, flags);
> > -- 
> > 1.7.2.5
> > 
> 
