From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Jan 2014 10:23:07 -0800
Subject: [RESEND][RFC PATCH 2/2] arm: Get rid of meminfo
In-Reply-To: <52E13ECC.3070203@ti.com>
References: <1389813057-26572-1-git-send-email-lauraa@codeaurora.org>
 <1389813057-26572-3-git-send-email-lauraa@codeaurora.org>
 <52E13ECC.3070203@ti.com>
Message-ID: <52E6A40B.8060505@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Thanks for the review

On 1/23/2014 8:09 AM, Grygorii Strashko wrote:
...
>>
>> @@ -692,6 +685,12 @@ int __init arm_add_memory(u64 start, u64 size)
>>    * Pick out the memory size.  We look for mem=size at start,
>>    * where start and size are "size[KkMm]"
>>    */
>> +
>> +/*
>> + * XXX this is busted when just using memblock. Need to add memblock
>> + * hook to reset.
>> + */
>> +
>>   static int __init early_mem(char *p)
>>   {
>>       static int usermem __initdata = 0;
>> @@ -706,7 +705,6 @@ static int __init early_mem(char *p)
>>        */
>>       if (usermem == 0) {
>>           usermem = 1;
>> -        meminfo.nr_banks = 0;
>>       }
>
> The below code might work here:
> memblock_remove(memblock_start_of_DRAM(),
>          memblock_end_of_DRAM() - memblock_start_of_DRAM());
>

That removes the memory but if we've already reserved any memory then 
the memblock state will be inconsistent. I guess we can assume this is 
early enough where no reserves will have taken place.

>>
>>       start = PHYS_OFFSET;
>> @@ -851,13 +849,6 @@ static void __init reserve_crashkernel(void)
>>   static inline void reserve_crashkernel(void) {}
>>   #endif /* CONFIG_KEXEC */
>>
>
> [...]
>
>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>> index e0e3968..c6ea491 100644
>> --- a/arch/arm/mm/init.c
>> +++ b/arch/arm/mm/init.c
>> @@ -81,24 +81,21 @@ __tagtable(ATAG_INITRD2, parse_tag_initrd2);
>>    * initialization functions, as well as show_mem() for the skipping
>>    * of holes in the memory map.  It is populated by arm_add_memory().
>>    */
>> -struct meminfo meminfo;
>> -
>>   void show_mem(unsigned int filter)
>>   {
>>       int free = 0, total = 0, reserved = 0;
>> -    int shared = 0, cached = 0, slab = 0, i;
>> -    struct meminfo * mi = &meminfo;
>> +    int shared = 0, cached = 0, slab = 0;
>> +    struct memblock_region *reg;
>>
>>       printk("Mem-info:\n");
>>       show_free_areas(filter);
>>
>> -    for_each_bank (i, mi) {
>> -        struct membank *bank = &mi->bank[i];
>> +    for_each_memblock (memory, reg) {
>>           unsigned int pfn1, pfn2;
>>           struct page *page, *end;
>>
>> -        pfn1 = bank_pfn_start(bank);
>> -        pfn2 = bank_pfn_end(bank);
>> +        pfn1 = memblock_region_memory_base_pfn(reg);
>> +        pfn2 = memblock_region_memory_end_pfn(reg);
>>
>>           page = pfn_to_page(pfn1);
>>           end  = pfn_to_page(pfn2 - 1) + 1;
>> @@ -130,16 +127,9 @@ void show_mem(unsigned int filter)
>>   static void __init find_limits(unsigned long *min, unsigned long
>> *max_low,
>>                      unsigned long *max_high)
>>   {
>> -    struct meminfo *mi = &meminfo;
>> -    int i;
>> -
>> -    /* This assumes the meminfo array is properly sorted */
>> -    *min = bank_pfn_start(&mi->bank[0]);
>> -    for_each_bank (i, mi)
>> -        if (mi->bank[i].highmem)
>> -                break;
>> -    *max_low = bank_pfn_end(&mi->bank[i - 1]);
>> -    *max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
>> +    *max_low = PFN_DOWN(memblock_get_current_limit());
>> +    *min = PFN_UP(memblock_start_of_DRAM());
>> +    *max_high = PFN_DOWN(memblock_end_of_DRAM());
>
> Just to notify. Above values may have different values after your
> change, because of usage arm_memblock_steal(). Is it ok?
>

Yes, I think so. The memory from arm_memblock_steal isn't really in the 
system anyway so it seems incorrect to be treating it as such.

>>   }
>>
>>   static void __init arm_bootmem_init(unsigned long start_pfn,
>> @@ -327,14 +317,8 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t
>> size, phys_addr_t align)
>>       return phys;
>>   }
>>
>> -void __init arm_memblock_init(struct meminfo *mi,
>> -    const struct machine_desc *mdesc)
>> +void __init arm_memblock_init(const struct machine_desc *mdesc)
>>   {
>> -    int i;
>> -
>> -    for (i = 0; i < mi->nr_banks; i++)
>> -        memblock_add(mi->bank[i].start, mi->bank[i].size);
>> -
>>       /* Register the kernel text, kernel data and initrd with
>> memblock. */
>>   #ifdef CONFIG_XIP_KERNEL
>>       memblock_reserve(__pa(_sdata), _end - _sdata);
>> @@ -466,48 +450,47 @@ free_memmap(unsigned long start_pfn, unsigned
>> long end_pfn)
>>   /*
>>    * The mem_map array can get very big.  Free the unused area of the
>> memory map.
>>    */
>> -static void __init free_unused_memmap(struct meminfo *mi)
>> +static void __init free_unused_memmap(void)
>>   {
>> -    unsigned long bank_start, prev_bank_end = 0;
>> -    unsigned int i;
>> +    unsigned long start, prev_end = 0;
>> +    struct memblock_region *reg;
>>
>>       /*
>>        * This relies on each bank being in address order.
>>        * The banks are sorted previously in bootmem_init().
>>        */
>> -    for_each_bank(i, mi) {
>> -        struct membank *bank = &mi->bank[i];
>> -
>> -        bank_start = bank_pfn_start(bank);
>> +    for_each_memblock(memory, reg) {
>> +        start = __phys_to_pfn(reg->base);
>>
>>   #ifdef CONFIG_SPARSEMEM
>>           /*
>>            * Take care not to free memmap entries that don't exist
>>            * due to SPARSEMEM sections which aren't present.
>>            */
>> -        bank_start = min(bank_start,
>> -                 ALIGN(prev_bank_end, PAGES_PER_SECTION));
>> +        start = min(start,
>> +                 ALIGN(prev_end, PAGES_PER_SECTION));
>>   #else
>>           /*
>>            * Align down here since the VM subsystem insists that the
>>            * memmap entries are valid from the bank start aligned to
>>            * MAX_ORDER_NR_PAGES.
>>            */
>> -        bank_start = round_down(bank_start, MAX_ORDER_NR_PAGES);
>> +        start = round_down(start, MAX_ORDER_NR_PAGES);
>>   #endif
>>           /*
>>            * If we had a previous bank, and there is a space
>>            * between the current bank and the previous, free it.
>>            */
>> -        if (prev_bank_end && prev_bank_end < bank_start)
>> -            free_memmap(prev_bank_end, bank_start);
>> +        if (prev_end && prev_end < start)
>> +            free_memmap(prev_end, start);
>>
>>           /*
>>            * Align up here since the VM subsystem insists that the
>>            * memmap entries are valid from the bank end aligned to
>>            * MAX_ORDER_NR_PAGES.
>>            */
>> -        prev_bank_end = ALIGN(bank_pfn_end(bank), MAX_ORDER_NR_PAGES);
>> +        prev_end = ALIGN(start + __phys_to_pfn(reg->size),
>> +                 MAX_ORDER_NR_PAGES);
>>       }
>>
>>   #ifdef CONFIG_SPARSEMEM
>> @@ -589,7 +572,7 @@ void __init mem_init(void)
>>       max_mapnr   = pfn_to_page(max_pfn + PHYS_PFN_OFFSET) - mem_map;
>>
>>       /* this will put all unused low memory onto the freelists */
>> -    free_unused_memmap(&meminfo);
>> +    free_unused_memmap();
>>       free_all_bootmem();
>>
>>   #ifdef CONFIG_SA1111
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 4f08c13..394701c 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -1043,77 +1043,54 @@ early_param("vmalloc", early_vmalloc);
>>
>>   phys_addr_t arm_lowmem_limit __initdata = 0;
>>
>> +static void remove_memblock(phys_addr_t base, phys_addr_t size)
>> +{
>> +        memblock_reserve(base, size);
>> +        memblock_free(base, size);
>> +        memblock_remove(base, size);
>> +}
>
> I think it'll be ok to use just memblock_remove(base, size); below.
>

This was my concern about reserved but I think you are correct that we 
should be able to just remove without worrying about reserved areas.

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
