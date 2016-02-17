From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Wed, 17 Feb 2016 12:15:15 +0300
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160216164245.GC8022@leverpostej>
References: <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com>
 <CAKv+Gu8WE=fTZF0Pou24FKDocgshWu8dJRbaC5SJ11E-6T=2Hw@mail.gmail.com>
 <56C34204.60605@virtuozzo.com> <20160216164245.GC8022@leverpostej>
Message-ID: <56C43A23.1020301@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/16/2016 07:42 PM, Mark Rutland wrote:
> On Tue, Feb 16, 2016 at 06:36:36PM +0300, Andrey Ryabinin wrote:
>>
>> On 02/16/2016 06:17 PM, Ard Biesheuvel wrote:
>>> On 16 February 2016 at 13:59, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>>> +static void verify_shadow(void)
>>>> +{
>>>> +       struct memblock_region *reg;
>>>> +       int i = 0;
>>>> +
>>>> +       for_each_memblock(memory, reg) {
>>>> +               void *start = (void *)__phys_to_virt(reg->base);
>>>> +               void *end = (void *)__phys_to_virt(reg->base + reg->size);
>>>> +               int *shadow_start, *shadow_end;
>>>> +
>>>> +               if (start >= end)
>>>> +                       break;
>>>> +               shadow_start = (int *)((unsigned long)kasan_mem_to_shadow(start) & ~(PAGE_SIZE - 1));
>>>> +               shadow_end =  (int *)kasan_mem_to_shadow(end);
>>>
>>> shadow_start and shadow_end can refer to the same page as in the
>>> previous iteration. For instance, I have these two regions
>>>
>>>   0x00006e090000-0x00006e0adfff [Conventional Memory|   |  |  |  |  |
>>> |   |WB|WT|WC|UC]
>>>   0x00006e0ae000-0x00006e0affff [Loader Data        |   |  |  |  |  |
>>> |   |WB|WT|WC|UC]
>>>
>>> which are covered by different memblocks since the second one is
>>> marked as MEMBLOCK_NOMAP, due to the fact that it contains the UEFI
>>> memory map.
>>>
>>> I get the following output
>>>
>>> kasan: screwed shadow mapping 23575, 23573
>>>
>>> which I think is simply a result from the fact the shadow_start refers
>>> to the same page as in the previous iteration(s)
>>>
>>
>> You are right. 
>> So we should write 'shadow_start' instead of 'i'.
> 
> FWIW with the below patch I don't see any "screwed shadow mapping"
> warnings on my board, and still later see a tonne of KASAN splats in the
> scheduler.
> 

It is possible that I missed something, but I think it means that shadow is alright.

I wonder whether this happens on 4.4. If not, than something in 4.5-rc1 caused this, and the obvious suspect
here is irq stack.
