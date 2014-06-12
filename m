From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 12 Jun 2014 15:07:20 +0900
Subject: [PATCH v2 04/10] DMA, CMA: support alignment constraint on cma
 region
In-Reply-To: <20140612055219.GG12415@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612055219.GG12415@bbox>
Message-ID: <20140612060720.GD30128@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 02:52:20PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:41PM +0900, Joonsoo Kim wrote:
> > ppc kvm's cma area management needs alignment constraint on
> > cma region. So support it to prepare generalization of cma area
> > management functionality.
> > 
> > Additionally, add some comments which tell us why alignment
> > constraint is needed on cma region.
> > 
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> > index 8a44c82..bc4c171 100644
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/swap.h>
> >  #include <linux/mm_types.h>
> >  #include <linux/dma-contiguous.h>
> > +#include <linux/log2.h>
> >  
> >  struct cma {
> >  	unsigned long	base_pfn;
> > @@ -219,6 +220,7 @@ core_initcall(cma_init_reserved_areas);
> >   * @size: Size of the reserved area (in bytes),
> >   * @base: Base address of the reserved area optional, use 0 for any
> >   * @limit: End address of the reserved memory (optional, 0 for any).
> > + * @alignment: Alignment for the contiguous memory area, should be power of 2
> >   * @res_cma: Pointer to store the created cma region.
> >   * @fixed: hint about where to place the reserved area
> >   *
> 
> Pz, move the all description to new API function rather than internal one.

Reason I leave all description as is is that I will remove it in
following patch. I think that moving these makes patch bigger and hard
to review.

But, if it is necessary, I will do it. :)

> 
> > @@ -233,15 +235,15 @@ core_initcall(cma_init_reserved_areas);
> >   */
> >  static int __init __dma_contiguous_reserve_area(phys_addr_t size,
> >  				phys_addr_t base, phys_addr_t limit,
> > +				phys_addr_t alignment,
> >  				struct cma **res_cma, bool fixed)
> >  {
> >  	struct cma *cma = &cma_areas[cma_area_count];
> > -	phys_addr_t alignment;
> >  	int ret = 0;
> >  
> > -	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
> > -		 (unsigned long)size, (unsigned long)base,
> > -		 (unsigned long)limit);
> > +	pr_debug("%s(size %lx, base %08lx, limit %08lx align_order %08lx)\n",
> 
> Why is it called by "align_order"?

Oops... mistake.
I will fix it.

Thanks.
