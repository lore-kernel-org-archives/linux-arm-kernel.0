From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 14 Aug 2013 14:01:33 +0100
Subject: [PATCH v3 09/10] swiotlb-xen: support autotranslate guests
In-Reply-To: <20130809154558.GG5637@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1308051503190.4893@kaball.uk.xensource.com>
 <1375720256-8014-9-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130809154558.GG5637@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1308141348540.4470@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Aug 2013, Konrad Rzeszutek Wilk wrote:
> > @@ -193,9 +315,10 @@ retry:
> >  	/*
> >  	 * Get IO TLB memory from any location.
> >  	 */
> > -	if (early)
> > +	if (early) {
> >  		xen_io_tlb_start = alloc_bootmem_pages(PAGE_ALIGN(bytes));
> > -	else {
> > +		xen_dma_seg = alloc_bootmem(sizeof(struct xen_dma_info) * NR_DMA_SEGS);
> 
> So what if the user over-wrote the size of the SWITOLB? Meaning the nslabs is different?
> Won't that blow up in  xen_swiotlb_fixup if we try to dereference past the array?

The definition of NR_DMA_SEGS is:

#define NR_DMA_SEGS  ((xen_io_tlb_nslabs + IO_TLB_SEGSIZE - 1) / IO_TLB_SEGSIZE)

xen_io_tlb_nslabs is calculated from io_tlb_nslabs.

If the user increases io_tlb_nslabs, then xen_io_tlb_nslabs and
NR_DMA_SEGS are also going to be bigger.


> > @@ -351,14 +477,15 @@ dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
> >  	 * we can safely return the device addr and not worry about bounce
> >  	 * buffering it.
> >  	 */
> > -	if (dma_capable(dev, dev_addr, size) &&
> > +	if (!xen_feature(XENFEAT_auto_translated_physmap) &&
> > +	    dma_capable(dev, dev_addr, size) &&
> >  	    !range_straddles_page_boundary(phys, size) && !swiotlb_force)
> >  		return dev_addr;
> >  
> >  	/*
> >  	 * Oh well, have to allocate and map a bounce buffer.
> >  	 */
> > -	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir);
> > +	map = swiotlb_tbl_map_single(dev, xen_dma_seg[0].dma_addr, phys, size, dir);
> 
> That [0] really deserves a comment.

xen_dma_seg[0].dma_addr corresponds exactly to start_dma_addr, the first
machine address of the swiotlb buffer.
I think that reason why we pass the dma address of the first slab is
that we want to allocate the bounce buffer from any of the slabs in
io_tlb_start-io_tlb_end.
