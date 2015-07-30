From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 30 Jul 2015 10:15:52 +0200
Subject: [PATCH] arm64: override early_init_dt_add_memory_arch()
In-Reply-To: <CAL_JsqKMyOwfNVV5nfAGO0vVgTR7dpPAxMfdeW9mjMd1WfMs3w@mail.gmail.com>
References: <1438186495-18126-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAL_JsqKMyOwfNVV5nfAGO0vVgTR7dpPAxMfdeW9mjMd1WfMs3w@mail.gmail.com>
Message-ID: <CAKv+Gu9MwQO1TQ9k=BOn5yzYD5v0RaPKbdnBL5G1_t2aExC+0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 19:38, Rob Herring <robherring2@gmail.com> wrote:
> On Wed, Jul 29, 2015 at 11:14 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Override the __weak early_init_dt_add_memory_arch() with our own
>> version. This allows us to relax the imposed restrictions at memory
>> discovery time, and clip the memory we will not able to address in
>> a single go at mapping time.
>
> This doesn't really explain what is the problem you are solving.
>

True. I will improve that.

>> So copy the generic original, but only retain the check against
>> regions whose sizes become zero when clipped to page alignment.
>>
>> The clipping against the maximum size of the linear region has been
>> moved to arm64_memblock_init().
>
> IIRC, the checks in early_init_dt_add_memory_arch came from the arm64
> version of it. If you now want to remove them, then I'm okay removing
> them from the weak function (assuming my memory is correct). None of
> this seems architecture specific to me. Perhaps memblock needs handle
> the clipping itself. The arch sets the limits, DT provides the raw
> memory ranges, and then memblock sorts out the actual memory blocks.
>

What we are missing primarily is a check that the top of memory does
not exceed the range of the linear mapping, which itself is based on
where the kernel was loaded, and so it is not a build time constant.
Later on, we will ignore phys_offset, and check the distance between
memblock_start_of_DRAM () and memblock_end_of_DRAM (), which can only
be done meaningfullt after all memory has been discovered, not inside
a callback that handles each memory node in turn.

So what I proposed in the other thread was to split it off right now
rather than complicate the generic code even further, right before we
need to split it off anyway.

For now, I am happy to go with something like Mark Rutland suggested,
though, i.e., define MAX_PHYS_ADDR as (memstart_addr +
(-(s64)PAGE_OFFSET)) rather than as a constant.

-- 
Ard.

>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/mm/init.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ad87ce826cce..76a624611939 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -158,6 +158,25 @@ early_param("mem", early_mem);
>>
>>  void __init arm64_memblock_init(void)
>>  {
>> +       /*
>> +        * Remove the memory that we will not be able to cover
>> +        * with the linear mapping.
>> +        */
>> +       const s64 linear_region_size = -(s64)PAGE_OFFSET;
>> +
>> +       if (memblock_start_of_DRAM() < memstart_addr) {
>> +               pr_warn("Ignoring memory below PHYS_OFFSET (0x%012llx - 0x%012llx)\n",
>> +                       (u64)memblock_start_of_DRAM(), memstart_addr - 1);
>> +               memblock_remove(0, memstart_addr);
>> +       }
>> +
>> +       if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
>> +               pr_warn("Ignoring memory outside of linear range (0x%012llx - 0x%012llx)\n",
>> +                       memstart_addr + linear_region_size,
>> +                       (u64)memblock_end_of_DRAM() - 1);
>> +               memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
>> +       }
>> +
>>         memblock_enforce_memory_limit(memory_limit);
>>
>>         /*
>> @@ -374,3 +393,19 @@ static int __init keepinitrd_setup(char *__unused)
>>
>>  __setup("keepinitrd", keepinitrd_setup);
>>  #endif
>> +
>> +void __init early_init_dt_add_memory_arch(u64 base, u64 size)
>> +{
>> +       if (!PAGE_ALIGNED(base)) {
>> +               if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
>> +                       pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
>> +                               base, base + size);
>> +                       return;
>> +               }
>> +               size -= PAGE_SIZE - (base & ~PAGE_MASK);
>> +               base = PAGE_ALIGN(base);
>> +       }
>> +       size &= PAGE_MASK;
>> +
>> +       memblock_add(base, size);
>> +}
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
