From: omycle@gmail.com (Li Haifeng)
Date: Wed, 31 Oct 2012 17:42:01 +0800
Subject: Two questions about streaming DMA flushing
In-Reply-To: <20121031090821.GK21164@n2100.arm.linux.org.uk>
References: <CAFNq8R7Fb5Dn6pMDDNvQp=kgpY9vmdpxyhNAPUXYA0-QbfHoJg@mail.gmail.com>
 <20121031090821.GK21164@n2100.arm.linux.org.uk>
Message-ID: <CAFNq8R4v0rfQgC0yFbSyc_xJe37nVX_QqQeEUPuyBz6_Z1edsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Wed, Oct 31, 2012 at 10:15:04AM +0800, Li Haifeng wrote:
>> Sorry to disturb you.
>>
>> I have two questions for streaming DMA flushing @ arch/arm/mm/cache-v7.S.
>>
>> 1.
>> 332 ENTRY(v7_dma_map_area)
>> 333         add     r1, r1, r0
>> 334         teq     r2, #DMA_FROM_DEVICE
>> 335         beq     v7_dma_inv_range
>> 336         b       v7_dma_clean_range
>> 337 ENDPROC(v7_dma_map_area)
>>
>> The function of v7_dma_map_area will invalidate corresponding cache line
>> firstly and then clean the cache for ?DMA_FROM_DEVICE?. I am confused the
>> sequence of the operations. IMO, the invalidate should be followed by the
>> clean action. Is it right?
>
> Wrong.  beq is not a function call.

Yes, It's my wrong. sorry for my careless.

>
>> 2.
>> 345 ENTRY(v7_dma_unmap_area)
>> 346         add     r1, r1, r0
>> 347         teq     r2, #DMA_TO_DEVICE
>> 348         bne     v7_dma_inv_range
>> 349         mov     pc, lr
>> 350 ENDPROC(v7_dma_unmap_area)
>>
>> v7_dma_unmap_area, will invalidate corresponding cache line for
>> ?DMA_FROM_DEVICE?. But, at v7_dma_map_area, the invalidate has been done.
>> Why do this again?
>
> Cache prefetching.

Thanks!
