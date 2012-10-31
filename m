From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 31 Oct 2012 10:50:23 +0000
Subject: Two questions about streaming DMA flushing
In-Reply-To: <CAFNq8R4DMKqRtR7junM6v_NnU=pCi8bpOCf5HP_sQgmztQr-cg@mail.gmail.com>
References: <CAFNq8R7Fb5Dn6pMDDNvQp=kgpY9vmdpxyhNAPUXYA0-QbfHoJg@mail.gmail.com>
 <20121031075047.GA15743@arm.com>
 <CAFNq8R4DMKqRtR7junM6v_NnU=pCi8bpOCf5HP_sQgmztQr-cg@mail.gmail.com>
Message-ID: <CAHkRjk41UELOc091rYrfs9mZwdn4hqg8=eeWGJVq5qTo5o7VCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2012 09:40, Li Haifeng <omycle@gmail.com> wrote:
> 2012/10/31 Catalin Marinas <catalin.marinas@arm.com>:
>> On Wed, Oct 31, 2012 at 02:15:04AM +0000, Li Haifeng wrote:
>>> Sorry to disturb you.
>>>
>>> I have two questions for streaming DMA flushing @ arch/arm/mm/cache-v7.S.
>>>
>>> 1.
>>> 332 ENTRY(v7_dma_map_area)
>>> 333         add     r1, r1, r0
>>> 334         teq     r2, #DMA_FROM_DEVICE
>>> 335         beq     v7_dma_inv_range
>>> 336         b       v7_dma_clean_range
>>> 337 ENDPROC(v7_dma_map_area)
>>>
>>> The function of v7_dma_map_area will invalidate corresponding cache line
>>> firstly and then clean the cache for  DMA_FROM_DEVICE . I am confused the
>>> sequence of the operations. IMO, the invalidate should be followed by the clean
>>> action. Is it right?
>>
>> If the direction is DMA_FROM_DEVICE, it only invalidates the cache (beq
>> instruction).
>
> Sorry for my careless.
>
> Why doesn't need clean for DMA_FROM_DEVICE? Will the data modified
> before dma mapping be lost?

Yes, that's exactly the point of DMA_FROM_DEVICE, the device is going
to write that buffer anyway.

-- 
Catalin
