From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 11:40:43 +0000
Subject: [PATCH 7/7] Minor compiling fix
In-Reply-To: <4F4F36DD.3020005@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <201202291235.04113.arnd@arndb.de> <4F4F36DD.3020005@gmail.com>
Message-ID: <201203011140.44364.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, bill4carson wrote:
> On 2012?02?29? 20:35, Arnd Bergmann wrote:
> > On Monday 13 February 2012, Bill Carson wrote:
> >> --- a/arch/arm/mm/dma-mapping.c
> >> +++ b/arch/arm/mm/dma-mapping.c
> >> @@ -152,9 +152,6 @@ static struct arm_vmregion_head consistent_head = {
> >>          .vm_end         = CONSISTENT_END,
> >>   };
> >>
> >> -#ifdef CONFIG_HUGETLB_PAGE
> >> -#error ARM Coherent DMA allocator does not (yet) support huge TLB
> >> -#endif
> >
> > This one needs an explanation, too. What has changed that now allows
> > dma_alloc_coherent to work with CONFIG_HUGETLB_PAGE set that did not
> > work before?
> >
> 
> AFAIK, __dma_alloc has the finest granularity at 4k page size even when
> user requests 1M bytes memory.
> 
> but current hugetlb low level set_hugepte_at *ONLY*/*MUST* support 2M 
> page mapping, so it can't be used to create huge dma mapping in a more
> general way.
> 
> comments this error out doesn't mean that it could support huge page dma
> mapping now with this patch, just shut up gcc when compiling.
> 
> Adding a single low level hook to create 1M page mapping can satisfy
> the needs, but apparently that's out of hugetlb scope.
> And it's on my TODO list :)

Hmm, I'm still not sure I'm following. The coherent DMA area is currently
limited to 2MB or a small multiple of that, so you would not be able
to allocate coherent hugepages anyway.

Further, I don't think there are any device drivers that call
dma_alloc_coherent and expect to map the resulting page into
user space, or that we even have an interface for that.

This entire chunk of code is also getting changed with the addition of CMA.

	Arnd
