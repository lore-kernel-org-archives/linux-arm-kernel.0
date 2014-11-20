From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Nov 2014 10:47:51 +0000
Subject: [PATCH v9 12/13] swiotlb-xen: pass dev_addr to xen_dma_unmap_page
 and xen_dma_sync_single_for_cpu
In-Reply-To: <alpine.DEB.2.02.1411201033460.12596@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1411121130020.26318@kaball.uk.xensource.com>
 <1415792454-23161-12-git-send-email-stefano.stabellini@eu.citrix.com>
 <20141119210703.GE20440@laptop.dumpdata.com>
 <alpine.DEB.2.02.1411201033460.12596@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1411201046110.12596@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Nov 2014, Stefano Stabellini wrote:
> On Wed, 19 Nov 2014, Konrad Rzeszutek Wilk wrote:
> > On Wed, Nov 12, 2014 at 11:40:53AM +0000, Stefano Stabellini wrote:
> > > xen_dma_unmap_page and xen_dma_sync_single_for_cpu take a dma_addr_t
> > > handle as argument, not a physical address.
> > 
> > Ouch. Should this also go on stable tree?
> 
> Good idea

Also can I take that as an Acked-by for this patch?


There is one last bit of common and x86 changes in this series:
patch #7 adds a paramter to xen_dma_map_page, even though the x86
implementation is empty:

http://marc.info/?l=xen-devel&m=141579253829808&w=2

is that OK for you?
 
 
> > > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > ---
> > >  drivers/xen/swiotlb-xen.c |    6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > > index 3725ee4..498b654 100644
> > > --- a/drivers/xen/swiotlb-xen.c
> > > +++ b/drivers/xen/swiotlb-xen.c
> > > @@ -449,7 +449,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
> > >  
> > >  	BUG_ON(dir == DMA_NONE);
> > >  
> > > -	xen_dma_unmap_page(hwdev, paddr, size, dir, attrs);
> > > +	xen_dma_unmap_page(hwdev, dev_addr, size, dir, attrs);
> > >  
> > >  	/* NOTE: We use dev_addr here, not paddr! */
> > >  	if (is_xen_swiotlb_buffer(dev_addr)) {
> > > @@ -497,14 +497,14 @@ xen_swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
> > >  	BUG_ON(dir == DMA_NONE);
> > >  
> > >  	if (target == SYNC_FOR_CPU)
> > > -		xen_dma_sync_single_for_cpu(hwdev, paddr, size, dir);
> > > +		xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
> > >  
> > >  	/* NOTE: We use dev_addr here, not paddr! */
> > >  	if (is_xen_swiotlb_buffer(dev_addr))
> > >  		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
> > >  
> > >  	if (target == SYNC_FOR_DEVICE)
> > > -		xen_dma_sync_single_for_cpu(hwdev, paddr, size, dir);
> > > +		xen_dma_sync_single_for_cpu(hwdev, dev_addr, size, dir);
> > >  
> > >  	if (dir != DMA_FROM_DEVICE)
> > >  		return;
> > > -- 
> > > 1.7.10.4
> > > 
> > 
> 
