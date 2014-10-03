From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 3 Oct 2014 17:36:26 +0100
Subject: [PATCH v2 2/2] xen/arm: introduce GNTTABOP_cache_flush
In-Reply-To: <1412354047.12695.38.camel@citrix.com>
References: <alpine.DEB.2.02.1410031549150.17038@kaball.uk.xensource.com>	
 <1412348006-27884-2-git-send-email-stefano.stabellini@eu.citrix.com>	
 <542EBB2A.6030104@citrix.com>	
 <alpine.DEB.2.02.1410031717420.17038@kaball.uk.xensource.com>
 <1412354047.12695.38.camel@citrix.com>
Message-ID: <542ED08A.1090507@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/14 17:34, Ian Campbell wrote:
> On Fri, 2014-10-03 at 17:20 +0100, Stefano Stabellini wrote:
>> On Fri, 3 Oct 2014, David Vrabel wrote:
>>> On 03/10/14 15:53, Stefano Stabellini wrote:
>>>> Introduce support for new hypercall GNTTABOP_cache_flush.
>>>> Use it to perform cache flashing on pages used for dma when necessary.
>>> [..]
>>>>  /* functions called by SWIOTLB */
>>>> @@ -22,16 +25,31 @@ static void dma_cache_maint(dma_addr_t handle, unsigned long offset,
>>>>  		size_t len = left;
>>>>  		void *vaddr;
>>>>  	
>>>> +		if (len + offset > PAGE_SIZE)
>>>> +			len = PAGE_SIZE - offset;
>>>> +
>>>>  		if (!pfn_valid(pfn))
>>>>  		{
>>>> -			/* TODO: cache flush */
>>>> +			struct gnttab_cache_flush cflush;
>>>> +
>>>> +			cflush.op = 0;
>>>> +			cflush.a.dev_bus_addr = pfn << PAGE_SHIFT;
>>>> +			cflush.offset = offset;
>>>> +			cflush.size = len;
>>>> +
>>>> +			if (op == dmac_unmap_area && dir != DMA_TO_DEVICE)
>>>> +				cflush.op = GNTTAB_CACHE_INVAL;
>>>> +			if (op == dmac_map_area) {
>>>> +				cflush.op = GNTTAB_CACHE_CLEAN;
>>>> +				if (dir == DMA_FROM_DEVICE)
>>>> +					cflush.op |= GNTTAB_CACHE_INVAL;
>>>> +			}
>>>
>>> Are all these cache operations needed?  You do a clean on map regardless
>>> of the direction and INVAL on map seems unnecessary.
> 
> Isn't the inval on map so that the processor doesn't decide to
> evict/clean the cache line all over your newly DMA'd data?

Ah, yes that makes sense.

>>> I would have thought it would be:
>>>
>>> map && (TO_DEVICE || BOTH)
>>>    op = CLEAN
>>>
>>> unmap && (FROM_DEVICE || BOTH)
>>>    op = INVAL
>>
>> I was trying to do the same thing Linux is already doing on native to
>> stay on the safe side.
>>
>> See arch/arm/mm/cache-v7.S:v7_dma_map_area and
>> arch/arm/mm/cache-v7.S:v7_dma_unmap_area.
>>
>> Unless I misread the assembly they should match.
> 
> I think you have, beq doesn't set lr, so the called function will return
> to its "grandparent". i.e. the caller of v7_dma_map_area in this case
> (which will have used bl), so:
> ENTRY(v7_dma_map_area)
>         add     r1, r1, r0
>         teq     r2, #DMA_FROM_DEVICE
>         beq     v7_dma_inv_range
>         b       v7_dma_clean_range
> ENDPROC(v7_dma_map_area)
> 
> Is actually
> 	if (dir == from device)
> 		inv
> 	else
> 		clean
> 
> which makes much more sense I think.

This is how I read the assembler too.

David
