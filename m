From: labbott@redhat.com (Laura Abbott)
Date: Tue, 10 Jan 2017 11:49:03 -0800
Subject: [PATCH] of: alloc anywhere from memblock if range not specified
In-Reply-To: <717b117d-9b8b-d4e9-6135-3c52afd635c8@gmail.com>
References: <1456148744-7583-1-git-send-email-vinmenon@codeaurora.org>
 <717b117d-9b8b-d4e9-6135-3c52afd635c8@gmail.com>
Message-ID: <ec66df44-3997-cfae-8f44-a46b16da896b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2017 08:16 AM, Leonard Crestez wrote:
> Hello,
> 
> I have some trouble with this patch.
> 
> It seems the intention is to allow CMA to be placed in highmem. If the CMA area is
> larger than highmem and no alloc-ranges is specified (just a size) it is possible
> to end up allocating a area that spans from multiple zones. This later breaks
> checks in cma_activate_area and makes most dma allocations fail.
> 
> Am I missing something or this a bug?
> 

This has been discussed in previous threads

https://marc.info/?l=linux-kernel&m=147990760506179&w=2
https://marc.info/?l=linux-kernel&m=147928325113103&w=2

I haven't seen any follow up since then though.

> On Mon, Feb 22, 2016 at 3:45 PM, Vinayak Menon <vinmenon@codeaurora.org> wrote:
>>
>> early_init_dt_alloc_reserved_memory_arch passes end as 0 to
>> __memblock_alloc_base, when limits are not specified. But
>> __memblock_alloc_base takes end value of 0 as MEMBLOCK_ALLOC_ACCESSIBLE
>> and limits the end to memblock.current_limit. This results in regions
>> never being placed in HIGHMEM area, for e.g. CMA.
>> Let __memblock_alloc_base allocate from anywhere in memory if limits are
>> not specified.
>>
>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
>> ---
>>  drivers/of/of_reserved_mem.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 1a3556a..ed01c01 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -32,11 +32,13 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>>         phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
>>         phys_addr_t *res_base)
>>  {
>> +       phys_addr_t base;
>>         /*
>>          * We use __memblock_alloc_base() because memblock_alloc_base()
>>          * panic()s on allocation failure.
>>          */
>> -       phys_addr_t base = __memblock_alloc_base(size, align, end);
>> +       end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
>> +       base = __memblock_alloc_base(size, align, end);
>>         if (!base)
>>                 return -ENOMEM;
>>
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
