From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 16 Jun 2014 14:19:52 +0900
Subject: [PATCH v2 04/10] DMA, CMA: support alignment constraint on cma
 region
In-Reply-To: <xa1t8up2jvi9.fsf@mina86.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-5-git-send-email-iamjoonsoo.kim@lge.com>
 <xa1t8up2jvi9.fsf@mina86.com>
Message-ID: <20140616051952.GB23210@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 12:02:38PM +0200, Michal Nazarewicz wrote:
> On Thu, Jun 12 2014, Joonsoo Kim <iamjoonsoo.kim@lge.com> wrote:
> > ppc kvm's cma area management needs alignment constraint on
> 
> I've noticed it earlier and cannot seem to get to terms with this.  It
> should IMO be PPC, KVM and CMA since those are acronyms.  But if you
> have strong feelings, it's not a big issue.

Yes, I will fix it.

> 
> > cma region. So support it to prepare generalization of cma area
> > management functionality.
> >
> > Additionally, add some comments which tell us why alignment
> > constraint is needed on cma region.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> 
> > diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> > index 8a44c82..bc4c171 100644
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -219,6 +220,7 @@ core_initcall(cma_init_reserved_areas);
> >   * @size: Size of the reserved area (in bytes),
> >   * @base: Base address of the reserved area optional, use 0 for any
> >   * @limit: End address of the reserved memory (optional, 0 for any).
> > + * @alignment: Alignment for the contiguous memory area, should be
> >  	power of 2
> 
> ?must be power of 2 or zero?.

Okay.

> >   * @res_cma: Pointer to store the created cma region.
> >   * @fixed: hint about where to place the reserved area
> >   *
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
> > +		__func__, (unsigned long)size, (unsigned long)base,
> > +		(unsigned long)limit, (unsigned long)alignment);
> 
> Nit: Align with the rest of the arguments, i.e.:
> 
> +	pr_debug("%s(size %lx, base %08lx, limit %08lx align_order %08lx)\n",
> +		 __func__, (unsigned long)size, (unsigned long)base,
> +		 (unsigned long)limit, (unsigned long)alignment);

What's the difference between mine and yours?

Thanks.
