From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Thu, 14 Apr 2016 14:57:45 +0800
Subject: [PATCH] arm64: mm: Enhance Virtual kernel memory layout
In-Reply-To: <570E10BE.3050107@arm.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
 <570E10BE.3050107@arm.com>
Message-ID: <570F3F69.3060702@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/13 17:26, James Morse wrote:
> Hi,
> 
> On 13/04/16 08:49, Kefeng Wang wrote:
>> 1) Show kernel excetion vector region and bss segment information.
> 
> Nit: exception
> 
> 
>> 2) Only show modules and PCI I/O with corresponding config enabled.
>> 3) Each line with single pr_cont, or lead to anomalous print in dmesg.
> 
> This commit message is a little confusing, it doesn't mention that this is to do
> with the dump of the kernel memory layout during boot. I presume the motivation
> is the missing time stamps when built with CONFIG_PRINTK_TIME.

Right, the dmesg is not aligned when PRINTK_TIME enabled, due to the missing time stamps.

> 
> Why add an entry for the vectors? They live in the text section, so this memory
> is already covered. Adding it like this means the list is out of order.

Ok, the arm64 vectors don't have a fixed address, and it is in text section, seem
like it is not needed, not like in arm.

> 
> It is probably better to put the splitting of pr_cont() into one per line in a
> separate patch to adding new rows.

OK.

> 
> 
>> ---
>> With this patch,
>>
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]      vector : 0xffffff8008084800 - 0xffffff8008084f80   (     1 KB)
>> [    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
>> [    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
>> [    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008753000   (  6988 KB)
>> [    0.000000]     .rodata : 0xffffff8008753000 - 0xffffff8008a3a000   (  2972 KB)
>> [    0.000000]       .init : 0xffffff8008a3a000 - 0xffffff8008b06000   (   816 KB)
>> [    0.000000]       .data : 0xffffff8008b06000 - 0xffffff8008ba2400   (   625 KB)
>> [    0.000000]        .bss : 0xffffff8008ba2400 - 0xffffff8008bdf738   (   245 KB)
>> [    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>> [    0.000000]               0xffffffbdc0000000 - 0xffffffbdc8000000   (   128 MB actual)
>> [    0.000000]     fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
>> [    0.000000]     PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
>> [    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc200000000   (  8192 MB)
>>
>> Before,
>>
>> [    0.000000] Virtual kernel memory layout:
>> [    0.000000]     modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
>> [    0.000000]     vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
>> [    0.000000]       .text : 0xffffff8008080000 - 0xffffff8008753000   (  6988 KB)
>>     .rodata : 0xffffff8008753000 - 0xffffff8008a3a000   (  2972 KB)
>>       .init : 0xffffff8008a3a000 - 0xffffff8008b06000   (   816 KB)
>>       .data : 0xffffff8008b06000 - 0xffffff8008ba2400   (   625 KB)
>> [    0.000000]     vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
>>               0xffffffbdc0000000 - 0xffffffbdc8000000   (   128 MB actual)
>> [    0.000000]     fixed   : 0xffffffbffe7fd000 - 0xffffffbffec00000   (  4108 KB)
>> [    0.000000]     PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
>> [    0.000000]     memory  : 0xffffffc000000000 - 0xffffffc200000000   (  8192 MB)
>>
>>  arch/arm64/mm/init.c | 32 +++++++++++++++++++++-----------
>>  1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index ea989d8..c6bcaa7 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -345,6 +345,9 @@ static void __init free_unused_memmap(void)
>>   */
>>  void __init mem_init(void)
>>  {
>> +	/* kernel exception vectors, 16 entries and each one with 128bytes */
>> +	extern char vectors[];
>> +
>>  	swiotlb_init(1);
>>  
>>  	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
>> @@ -363,34 +366,41 @@ void __init mem_init(void)
>>  #define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
>>  
>>  	pr_notice("Virtual kernel memory layout:\n");
>> +	pr_cont("     vector : 0x%p - 0x%p   (%6ld KB)\n",
>> +		MLK(vectors, vectors + 0x780));
> 
> 0x780? Shouldn't this be 0x800, or better SZ_2K?

Oh, my mistake, it should be SZ_2K.

> 
> 
>>  #ifdef CONFIG_KASAN
>>  	pr_cont("    kasan   : 0x%16lx - 0x%16lx   (%6ld GB)\n",
>>  		MLG(KASAN_SHADOW_START, KASAN_SHADOW_END));
>>  #endif
>> +#ifdef CONFIG_MODULES
>>  	pr_cont("    modules : 0x%16lx - 0x%16lx   (%6ld MB)\n",
>>  		MLM(MODULES_VADDR, MODULES_END));
>> +#endif
>>  	pr_cont("    vmalloc : 0x%16lx - 0x%16lx   (%6ld GB)\n",
>>  		MLG(VMALLOC_START, VMALLOC_END));
>> -	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>> -		"    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>> -		"      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n"
>> -		"      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>> -		MLK_ROUNDUP(_text, __start_rodata),
>> -		MLK_ROUNDUP(__start_rodata, _etext),
>> -		MLK_ROUNDUP(__init_begin, __init_end),
>> +	pr_cont("      .text : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>> +		MLK_ROUNDUP(_text, __start_rodata));
>> +	pr_cont("    .rodata : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>> +		MLK_ROUNDUP(__start_rodata, _etext));
>> +	pr_cont("      .init : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>> +		MLK_ROUNDUP(__init_begin, __init_end));
>> +	pr_cont("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>>  		MLK_ROUNDUP(_sdata, _edata));
>> +	pr_cont("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>> +		MLK_ROUNDUP(__bss_start, __bss_stop));
>>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> -	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n"
>> -		"              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
>> -		MLG(VMEMMAP_START,
>> -		    VMEMMAP_START + VMEMMAP_SIZE),
>> +	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
>> +		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
>> +	pr_cont("              0x%16lx - 0x%16lx   (%6ld MB actual)\n",
>>  		MLM((unsigned long)phys_to_page(memblock_start_of_DRAM()),
>>  		    (unsigned long)virt_to_page(high_memory)));
>>  #endif
>>  	pr_cont("    fixed   : 0x%16lx - 0x%16lx   (%6ld KB)\n",
>>  		MLK(FIXADDR_START, FIXADDR_TOP));
>> +#ifdef CONFIG_PCI
>>  	pr_cont("    PCI I/O : 0x%16lx - 0x%16lx   (%6ld MB)\n",
>>  		MLM(PCI_IO_START, PCI_IO_END));
>> +#endif
>>  	pr_cont("    memory  : 0x%16lx - 0x%16lx   (%6ld MB)\n",
>>  		MLM(__phys_to_virt(memblock_start_of_DRAM()),
>>  		    (unsigned long)high_memory));
>>
> 
> 
> Thanks,
> 
> James
> 
> 
> .
> 
