From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Aug 2012 14:21:22 +0200
Subject: [v3 1/4] ARM: dma-mapping: atomic_pool with struct page **pages
In-Reply-To: <20120824.145200.843951079622652894.hdoyu@nvidia.com>
References: <1345796945-21115-1-git-send-email-hdoyu@nvidia.com>
 <1345796945-21115-2-git-send-email-hdoyu@nvidia.com>
 <20120824111323.GB11007@konrad-lan.dumpdata.com>
 <20120824.145200.843951079622652894.hdoyu@nvidia.com>
Message-ID: <026901cd81f2$fffea680$fffbf380$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, August 24, 2012 1:52 PM Hiroshi Doyu wrote:

> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote @ Fri, 24 Aug 2012 13:13:23 +0200:
> 
> > On Fri, Aug 24, 2012 at 11:29:02AM +0300, Hiroshi Doyu wrote:
> > > struct page **pages is necessary to align with non atomic path in
> > > __iommu_get_pages(). atomic_pool() has the intialized **pages instead
> > > of just *page.
> > >
> > > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > > ---
> > >  arch/arm/mm/dma-mapping.c |   17 +++++++++++++----
> > >  1 files changed, 13 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > > index 601da7a..b14ee64 100644
> > > --- a/arch/arm/mm/dma-mapping.c
> > > +++ b/arch/arm/mm/dma-mapping.c
> > > @@ -296,7 +296,7 @@ struct dma_pool {
> > >  	unsigned long *bitmap;
> > >  	unsigned long nr_pages;
> > >  	void *vaddr;
> > > -	struct page *page;
> > > +	struct page **pages;
> > >  };
> > >
> > >  static struct dma_pool atomic_pool = {
> > > @@ -335,12 +335,16 @@ static int __init atomic_pool_init(void)
> > >  	unsigned long nr_pages = pool->size >> PAGE_SHIFT;
> > >  	unsigned long *bitmap;
> > >  	struct page *page;
> > > +	struct page **pages;
> > >  	void *ptr;
> > >  	int bitmap_size = BITS_TO_LONGS(nr_pages) * sizeof(long);
> > > +	size_t size = nr_pages * sizeof(struct page *);
> > >
> > > -	bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > > +	size += bitmap_size;
> > > +	bitmap = kzalloc(size, GFP_KERNEL);
> > >  	if (!bitmap)
> > >  		goto no_bitmap;
> > > +	pages = (void *)bitmap + bitmap_size;
> >
> > So you stuck a bitmap field in front of the array then?
> > Why not just define a structure where this is clearly defined
> > instead of doing the casting.
> 
> I just wanted to allocate only once for the members "pool->bitmap" and
> "pool->pages" at once. Since the size of a whole bitmap isn't known in
> advance, I couldn't find any fixed type for this bitmap, which pointer
> can be shifted without casting. IOW, they are variable length.

IMHO it is better to avoid any non-trivial things in generic arch code. Merging
those 2 allocations doesn't save any significant bit of memory and might confuse
someone. Better just allocate them separately.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
