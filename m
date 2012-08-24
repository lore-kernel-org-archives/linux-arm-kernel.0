From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 24 Aug 2012 13:39:55 +0200
Subject: [v3 2/4] ARM: dma-mapping: Refactor out to introduce
 __in_atomic_pool
In-Reply-To: <20120824111455.GC11007@konrad-lan.dumpdata.com>
References: <1345796945-21115-1-git-send-email-hdoyu@nvidia.com><1345796945-21115-3-git-send-email-hdoyu@nvidia.com><20120824111455.GC11007@konrad-lan.dumpdata.com>
Message-ID: <20120824.143955.659265444078193982.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote @ Fri, 24 Aug 2012 13:14:55 +0200:

> On Fri, Aug 24, 2012 at 11:29:03AM +0300, Hiroshi Doyu wrote:
> > Check the given range("start", "size") is included in "atomic_pool" or not.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > ---
> >  arch/arm/mm/dma-mapping.c |   25 +++++++++++++++++++------
> >  1 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index b14ee64..508fde1 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -501,19 +501,32 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
> >  	return ptr;
> >  }
> >  
> > +static bool __in_atomic_pool(void *start, size_t size)
> > +{
> > +	struct dma_pool *pool = &atomic_pool;
> > +	void *end = start + size;
> > +	void *pool_start = pool->vaddr;
> > +	void *pool_end = pool->vaddr + pool->size;
> > +
> > +	if (start < pool_start || start > pool_end)
> > +		return false;
> > +
> > +	if (end > pool_end) {
> > +		WARN(1, "freeing wrong coherent size from pool\n");
> 
> That does not tell what size or from what pool. Perhaps you should
> include some details, such as the 'size' value, the pool used, the
> range of the pool, etc. Something that will help _you_in the field
> be able to narrow down what might be wrong.

True. I'll.
