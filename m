From: puck.chen@hisilicon.com (Chen Feng)
Date: Wed, 29 Nov 2017 16:57:45 +0800
Subject: [PATCH] arm64: kaslr: Fix kaslr end boundary of virt addr
In-Reply-To: <CAKv+Gu_Vr9jP5avwLcR0-cB=0SJiMaxmi8REnBfVF98-u+XzYQ@mail.gmail.com>
References: <1511235853-8407-1-git-send-email-puck.chen@hisilicon.com>
 <CAKv+Gu_Vr9jP5avwLcR0-cB=0SJiMaxmi8REnBfVF98-u+XzYQ@mail.gmail.com>
Message-ID: <5A1E7689.5070405@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/11/29 4:41, Ard Biesheuvel wrote:
> On 21 November 2017 at 03:44, Chen Feng <puck.chen@hisilicon.com> wrote:
>> With kaslr and kasan enable both, I got the follow issue.
>>
>> [   16.130523s]kasan: reg->base = 100000000, phys_end =1c0000000,start = ffffffff40000000, end = ffffffc000000000
>> [   16.142517s]___alloc_bootmem_nopanic:257
>> [   16.148284s]__alloc_memory_core_early:63, addr = 197fc7fc0
>> [   16.155670s]__alloc_memory_core_early:65, virt = ffffffffd7fc7fc0
>> [   16.163635s]__alloc_memory_core_early:67, toshow = ffffff8ffaff8ff8
>> [   16.171783s]__alloc_memory_core_early:69, show_phy = ffffffe2649f8ff8
>> [   16.180145s]Unable to handle kernel paging request at virtual address ffffff8ffaff8ff8
>> [   16.189971s]pgd = ffffffad9c507000
>> [   16.195220s][ffffff8ffaff8ff8] *pgd=0000000197fc8003, *pud=0000000197fc8003
>>
>> *reg->base = 100000000, phys_end =1c0000000,start = ffffffff40000000, end = ffffffc000000000*
>>
>> memstart_addr 0
>> ARM64_MEMSTART_ALIGN 0x40000000
>> memstart_offset_seed 0xffc7
>> PHYS_OFFSET = 0 - memstart_addr = 0 - 3E40000000 = FFFFFFC1C0000000
>>
>> reg->base = 0x100000000  -> 0xffffffff40000000
>> phys_end  = 0x1c0000000  -> 0xffffffc000000000  This is confused, end less than start.
>>
> 
> This looks a bit weird because we add the PAGE_OFFSET, but it simply
> wraps at the top of the address space.
> 
> So this code in kasan_init()
> 
> void *start = (void *)__phys_to_virt(reg->base);
> void *end = (void *)__phys_to_virt(reg->base + reg->size);
> 
> if (start >= end)
>      break;
> 
> is essentially incorrect, because it translates an address that is
> strictly outside of the current memblock region. If the KASLR code
> happens to map DRAM all the way at the top of the linear region (which
> is what occurs in your case), end - 1 is the last valid address.
> 
> So I think the minimal correct fix would be
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index acba49fb5aac..3214aa9d90be 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -216,7 +216,7 @@ void __init kasan_init(void)
> 
>         for_each_memblock(memory, reg) {
>                 void *start = (void *)__phys_to_virt(reg->base);
> -               void *end = (void *)__phys_to_virt(reg->base + reg->size);
> +               void *end = start + reg->size;
> 
>                 if (start >= end)
>                         break;
> 
> given that mappings in the linear region are congruent with the
> underlying physical regions (unless I am missing something wrt special
> start/end values in memblock, but in that case, they should not be p2v
> translated before the evaluation)
> 
> However, since having DRAM at the very top appears to break other things as well
> 
> vmemmap : 0xffffffbf00000000 - 0xffffffc000000000   (     4 GB maximum)
>           0xffffffbfff000000 - 0xffffffbf00000000   (17592186040336 MB actual)
> memory  : 0xffffffffc0000000 - 0x               0   (  1024 MB)
> 

Yes. I also think kasan code is actually incorrect.
But the memory will never reach the top before. So not only kasan, the p2v all has this
limit. Like the message you post above.
Thinking from this, I modify the logic of kaslr to keep it as it is.


> I will leave it to Will and/or Catalin to decide whether they prefer
> to follow your approach instead, and prevent KASLR from mapping DRAM
> all the way at the top of the address space. Otherwise, we'll need to
> track down all problematic uses of __phys_to_virt() et al, because
> there will surely be more.
> 
> Thanks,
> Ard.
> 
> 
> 
>> And In memblock it use "start_addr + size" as the end addr. So in function kasan_init,
>> if the start >= end, it will not map the hole block address. But the memory in this
>> block is valid. And it can be allocated as well.
>>
>> So donot use the last memory region. Changing "range = range / ARM64_MEMSTART_ALIGN + 1" to
>> range = range / ARM64_MEMSTART_ALIGN;
>>
>> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
>> Signed-off-by: Chen Xiang <chenxiang9@huawei.com>
>> ---
>>  arch/arm64/mm/init.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 716d122..60112c0 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -267,11 +267,8 @@ void __init arm64_memblock_init(void)
>>                  * margin, the size of the region that the available physical
>>                  * memory spans, randomize the linear region as well.
>>                  */
>> -               if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN) {
>> -                       range = range / ARM64_MEMSTART_ALIGN + 1;
>> -                       memstart_addr -= ARM64_MEMSTART_ALIGN *
>> -                                        ((range * memstart_offset_seed) >> 16);
>> -               }
>> +               if (memstart_offset_seed > 0 && range >= ARM64_MEMSTART_ALIGN)
>> +                       memstart_addr -= (range * memstart_offset_seed) >> 16;
>>         }
>>
>>         /*
>> --
>> 1.9.1
>>
> 
> .
> 
