From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 19 Jun 2014 17:18:07 +0900
Subject: [PATCH v3 -next 4/9] DMA, CMA: support arbitrary bitmap
 granularity
In-Reply-To: <20140618134815.69c4d0a5f916846f9857e9ff@linux-foundation.org>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402897251-23639-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20140618134815.69c4d0a5f916846f9857e9ff@linux-foundation.org>
Message-ID: <20140619081807.GA28611@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 01:48:15PM -0700, Andrew Morton wrote:
> On Mon, 16 Jun 2014 14:40:46 +0900 Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> 
> > PPC KVM's CMA area management requires arbitrary bitmap granularity,
> > since they want to reserve very large memory and manage this region
> > with bitmap that one bit for several pages to reduce management overheads.
> > So support arbitrary bitmap granularity for following generalization.
> > 
> > ...
> >
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -38,6 +38,7 @@ struct cma {
> >  	unsigned long	base_pfn;
> >  	unsigned long	count;
> >  	unsigned long	*bitmap;
> > +	unsigned int order_per_bit; /* Order of pages represented by one bit */
> >  	struct mutex	lock;
> >  };
> >  
> > @@ -157,9 +158,37 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
> >  
> >  static DEFINE_MUTEX(cma_mutex);
> >  
> > +static unsigned long cma_bitmap_aligned_mask(struct cma *cma, int align_order)
> > +{
> > +	return (1 << (align_order >> cma->order_per_bit)) - 1;
> > +}
> 
> Might want a "1UL << ..." here.

Okay!

> 
> > +static unsigned long cma_bitmap_maxno(struct cma *cma)
> > +{
> > +	return cma->count >> cma->order_per_bit;
> > +}
> > +
> > +static unsigned long cma_bitmap_pages_to_bits(struct cma *cma,
> > +						unsigned long pages)
> > +{
> > +	return ALIGN(pages, 1 << cma->order_per_bit) >> cma->order_per_bit;
> > +}
> 
> Ditto.  I'm not really sure what the compiler will do in these cases,
> but would prefer not to rely on it anyway!

Okay!

Thanks for fix!
