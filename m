From: jason.hui.liu@nxp.com (Jason Liu)
Date: Thu, 17 Nov 2016 05:21:37 +0000
Subject: [PATCH 1/1] drivers: dma-contiguous: Ensure cma reserve region
 never cross the low/high mem boundary
In-Reply-To: <6bd1a1a9-2bc0-f5f4-0957-1826af15f4dd@redhat.com>
References: <1479305975-21670-1-git-send-email-jason.hui.liu@nxp.com>
 <6bd1a1a9-2bc0-f5f4-0957-1826af15f4dd@redhat.com>
Message-ID: <VI1PR04MB1136F319039F61FECA4DCD11AEB10@VI1PR04MB1136.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Laura Abbott [mailto:labbott at redhat.com]
> Sent: Thursday, November 17, 2016 4:00 AM
> To: Jason Liu <jason.hui.liu@nxp.com>; linux-arm-kernel at lists.infradead.org
> Cc: gregkh at linuxfoundation.org; iamjoonsoo.kim at lge.com; linux-
> kernel at vger.kernel.org; m.szyprowski at samsung.com
> Subject: Re: [PATCH 1/1] drivers: dma-contiguous: Ensure cma reserve region
> never cross the low/high mem boundary
> 
> On 11/16/2016 06:19 AM, Jason Liu wrote:
> > If the cma reserve region goes through the device-tree method, also
> > need ensure the cma reserved region not cross the low/high mem
> > boundary. This patch did the similar fix as commit:16195dd
> > ("mm: cma: Ensure that reservations never cross the low/high mem
> > boundary")
> >
> > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/dma-contiguous.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/base/dma-contiguous.c
> > b/drivers/base/dma-contiguous.c index e167a1e1..2bc093c 100644
> > --- a/drivers/base/dma-contiguous.c
> > +++ b/drivers/base/dma-contiguous.c
> > @@ -244,6 +244,7 @@ static int __init rmem_cma_setup(struct
> > reserved_mem *rmem)  {
> >  	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1,
> pageblock_order);
> >  	phys_addr_t mask = align - 1;
> > +	phys_addr_t highmem_start;
> >  	unsigned long node = rmem->fdt_node;
> >  	struct cma *cma;
> >  	int err;
> > @@ -256,6 +257,32 @@ static int __init rmem_cma_setup(struct
> reserved_mem *rmem)
> >  		pr_err("Reserved memory: incorrect alignment of CMA
> region\n");
> >  		return -EINVAL;
> >  	}
> > +#ifdef CONFIG_X86
> > +	/*
> > +	 * high_memory isn't direct mapped memory so retrieving its physical
> > +	 * address isn't appropriate.  But it would be useful to check the
> > +	 * physical address of the highmem boundary so it's justfiable to get
> > +	 * the physical address from it.  On x86 there is a validation check for
> > +	 * this case, so the following workaround is needed to avoid it.
> > +	 */
> > +	highmem_start = __pa_nodebug(high_memory); #else
> > +	highmem_start = __pa(high_memory);
> > +#endif
> 
> The inline #ifdef is not great style, we shouldn't be spreading it around.

This is the similar fix in the 16195dd ("mm: cma: Ensure that reservations never cross
the low/high mem boundary". Do you have a better idea for this? 

> 
> > +
> > +	/*
> > +	 * All pages in the reserved area must come from the same zone.
> > +	 * If the reserved region crosses the low/high memory boundary,
> > +	 * try to fix it up and then fall back to allocate from the low mem
> > +	 */
> > +	if (rmem->base < highmem_start &&
> > +		(rmem->base + rmem->size) > highmem_start) {
> > +		memblock_free(rmem->base, rmem->size);
> > +		rmem->base = memblock_alloc_range(rmem->size, align, 0,
> > +						highmem_start,
> MEMBLOCK_NONE);
> > +		if (!rmem->base)
> > +			return -ENOMEM;
> > +	}
> 
> Given the alloc happened in the of code, it seems bad form to be bringing the
> free and re-alloc here. Perhaps we should be doing the limiting and checking in
> the reserved mem code?

I original though to fix it into the drivers/of/of_reserved_mem.c, but hesitate to
do it due to this of_reserved_mem is common code to do the reservation, which
is something not related with CMA requirement. 

Appreciated that anyone can provide comments to improve this solution. Without this,
the Linux kernel will not boot up when do the CMA reservation from the DTS method,
since the dma_alloc_coherent will fail when do the dma memory allocation. 

> 
> If there is no other solution, at the least this deserves a pr_warn so users know
> why a reason specified may not be getting requested.

Yes, it deserves a pr_warn here. I will add it. 

Thanks Laura for the review. 

Jason Liu
> 
> >
> >  	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, &cma);
> >  	if (err) {
> >
> 
> 
> Thanks,
> Laura
