From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 Sep 2011 16:00:28 +0200
Subject: [PATCH 6/7] common: dma-mapping: change alloc/free_coherent	method
	to more generic alloc/free_attrs
In-Reply-To: <20110905104352.GD5203@8bytes.org>
References: <1314971599-14428-1-git-send-email-m.szyprowski@samsung.com>
	<1314971599-14428-7-git-send-email-m.szyprowski@samsung.com>
	<20110905104352.GD5203@8bytes.org>
Message-ID: <006301cc792f$fc3a3a40$f4aeaec0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Monday, September 05, 2011 12:44 PM Joerg Roedel wrote:

> On Fri, Sep 02, 2011 at 03:53:18PM +0200, Marek Szyprowski wrote:
> >  struct dma_map_ops {
> > -	void* (*alloc_coherent)(struct device *dev, size_t size,
> > -				dma_addr_t *dma_handle, gfp_t gfp);
> > -	void (*free_coherent)(struct device *dev, size_t size,
> > -			      void *vaddr, dma_addr_t dma_handle);
> > +	void* (*alloc)(struct device *dev, size_t size,
> > +				dma_addr_t *dma_handle, gfp_t gfp,
> > +				struct dma_attrs *attrs);
> > +	void (*free)(struct device *dev, size_t size,
> > +			      void *vaddr, dma_addr_t dma_handle,
> > +			      struct dma_attrs *attrs);
> > +	int (*mmap)(struct device *, struct vm_area_struct *,
> > +			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
> > +
> >  	dma_addr_t (*map_page)(struct device *dev, struct page *page,
> >  			       unsigned long offset, size_t size,
> >  			       enum dma_data_direction dir,
> > --
> > 1.7.1.569.g6f426
> 
> This needs conversion of all drivers implementing dma_map_ops or you
> will break a lot of architectures. A better approach is to keep
> *_coherent and implement alloc/free/mmap side-by-side until all drivers
> are converted.
> Also I miss some documentation about the new call-backs.

Right this patch will break all other architectures, however it was just 
a snapshot of my work-in-progress. Converting all other architectures from
alloc_coherent to alloc with NULL attribute shouldn't be really hard and will
be added in the final version - together with documentation.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
