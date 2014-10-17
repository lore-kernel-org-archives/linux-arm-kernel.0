From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 17 Oct 2014 13:21:58 +0300
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <5440DD02.9020103@codeaurora.org>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk> <54400123.7040806@ti.com>
 <5440DD02.9020103@codeaurora.org>
Message-ID: <5440EDC6.70300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On 10/17/2014 12:10 PM, Laura Abbott wrote:
> On 10/16/2014 10:32 AM, Grygorii Strashko wrote:
>> Hi Russell,
>> On 10/15/2014 08:50 PM, Russell King - ARM Linux wrote:
>>> On Wed, Oct 15, 2014 at 08:18:18PM +0300, Grygorii Strashko wrote:
>>>> 3) If I apply below change - I can boot:
>>>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>>>> index c031063..85ad92b 100644
>>>> --- a/arch/arm/kernel/setup.c
>>>> +++ b/arch/arm/kernel/setup.c
>>>> @@ -917,8 +917,8 @@ void __init setup_arch(char **cmdline_p)
>>>>
>>>>           early_paging_init(mdesc, 
>>>> lookup_processor_type(read_cpuid_id()));
>>>>           setup_dma_zone(mdesc);
>>>> -       sanity_check_meminfo();
>>>>           arm_memblock_init(mdesc);
>>>> +       sanity_check_meminfo();
>>>>
>>>>           paging_init(mdesc);
>>>>           request_standard_resources(mdesc);
>>>>
>>>> ^^ not sure if it totally safe, because 
>>>> dma_contiguous_reserve(arm_dma_limit);
>>>> is called from inside arm_memblock_init() and it does bootmem 
>>>> allocations.
>>>
>>> It isn't.  sanity_check_meminfo() _must_ be called before 
>>> arm_memblock_init()
>>> so that sanity_check_meminfo() can adjust the passed memory 
>>> description to
>>> remove stuff which is inappropriate for the configuration, before it is
>>> passed to memblock.
>>>
>>>> Sort Summary:
>>>> It looks like all static memory reservation and memory stealing's
>>>> (calling of memblock_remove()) have to be done before any other
>>>> operations and before calculating ARM memory limits.
>>>
>>> No, that should not be the case.  The way it is /supposed/ to work is:
>>>
>>> - We obtain the memory information and pass it into memblock
>>> - We sanity check the memory in memblock, removing memory which we
>>>     deem to be unacceptable for the kernel configuration via
>>>     memblock_remove().  Also calculate the highest address we are
>>>     prepared to allocate, which is set to the top of the first chunk
>>>     of memory, or the top of lowmem.
>>> - We then see about reserving memory from memblock.  This marks memory
>>>     as reserved, or in certain cases where we actually want to prevent
>>>     the kernel taking control of the memory, we completely remove the
>>>     memory from memblock (via memblock_remove).
>>
>> In my case amount of removed memory is so high that there is no room
>> for Highmem anymore.
>>
>> memblock.memory.regions[0].base + size < arm_lowmem_limit
>> and arm_lowmem_limit == memblock.current_limit
>>
>>>
>>> Memory removed via memblock_remove() is then not available for any
>>> allocations, and should not be touched by the kernel in any way from
>>> that point on.
>>>
>>> It doesn't matter that the memblock limit is still set higher, because
>>> the memory has been removed from the available memory pool, it should
>>> not be allocated.
>>>
>>
>> You are right in general, but seems problem is not in memblock itself :(
>> The problem is with  memory control variables like:
>>   - arm_lowmem_limit
>>   - max_low_pfn
>>   - max_pfn
>>
>> The last thing I've found that issue happens when in
>> bootmem_init()->find_limits() the max_low variable got value greater than
>> max_high: max_low_pfn > max_pfn.
>>
>> Then kernel crashes somewhere inside free_all_bootmem();
>>
>> Below hack allows to boot:
>> +++ b/arch/arm/mm/init.c
>> @@ -140,6 +140,8 @@ static void __init find_limits(unsigned long *min, 
>> unsigned long *max_low,
>>          *max_low = PFN_DOWN(memblock_get_current_limit());
>>          *min = PFN_UP(memblock_start_of_DRAM());
>>          *max_high = PFN_DOWN(memblock_end_of_DRAM());
>> +       if (*max_low > *max_high)
>> +               *max_low = *max_high;
>>   }
> 
> Can you print out the values of max_low, min, max_high and call
> __memblock_dump_all() at this point in time? It would also
> be helpful to get the pr_debug print outs in
> drivers/of/of_reserved_mem.c to see what's being reserved there.

As I mentioned in first e-mail I've 1G Mem node initially:
  reg = <0x8 0x00000000 0x0 0x40000000>;

and have memory reservation of 512M in the upper part of memory:
  reserved-memory {
	reg = <0x8 0x20000000 0x0 0x20000000>;

then in sanity_check_meminfo() initial mem configuration calculated as following:

[    0.000000] ======= memblock_limit=0x000000082f800000 arm_lowmem_limit=0x000000082f800000 vmalloc_limit=ef800000 high_memory=0x000000082f800000
and memblock.current_limit == arm_lowmem_limit=0x000000082f800000

then in arm_memblock_init()->early_init_fdt_scan_reserved_mem() 512M of memory removed
(not reserved!, because "no-map;" is defined).

After that Kernel will have only 512M of accessible memory
 memory[0x0]	[0x00000800000000-0x0000081fffffff]

I've checked of_reserved_mem.c and saw no issues there :(

Bad case:
[    0.000000] ======= min_low_pfn=800000 max_low_pfn=82F800 max_pfn=820000

[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x20000000 reserved size = 0x273f08c
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000800000000-0x0000081fffffff], 0x20000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x15
[    0.000000]  reserved[0x0]	[0x00000800003000-0x00000800007fff], 0x5000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000800008300-0x000008007771df], 0x76eee0 bytes flags: 0x0
[    0.000000]  reserved[0x2]	[0x00000802000000-0x000008028fffff], 0x900000 bytes flags: 0x0
[    0.000000]  reserved[0x3]	[0x00000807000000-0x00000807008ebd], 0x8ebe bytes flags: 0x0
[    0.000000]  reserved[0x4]	[0x0000081e93d000-0x0000081e9ccfff], 0x90000 bytes flags: 0x0
[    0.000000]  reserved[0x5]	[0x0000081e9cd080-0x0000081e9cf07f], 0x2000 bytes flags: 0x0
[    0.000000]  reserved[0x6]	[0x0000081e9cf0bc-0x0000081ebecfe3], 0x21df28 bytes flags: 0x0
[    0.000000]  reserved[0x7]	[0x0000081ebed000-0x0000081effefff], 0x412000 bytes flags: 0x0
[    0.000000]  reserved[0x8]	[0x0000081efffa40-0x0000081efffa83], 0x44 bytes flags: 0x0
[    0.000000]  reserved[0x9]	[0x0000081efffac0-0x0000081efffb03], 0x44 bytes flags: 0x0
[    0.000000]  reserved[0xa]	[0x0000081efffb40-0x0000081efffbb7], 0x78 bytes flags: 0x0
[    0.000000]  reserved[0xb]	[0x0000081efffbc0-0x0000081efffbcf], 0x10 bytes flags: 0x0
[    0.000000]  reserved[0xc]	[0x0000081efffc00-0x0000081efffc0f], 0x10 bytes flags: 0x0
[    0.000000]  reserved[0xd]	[0x0000081efffc40-0x0000081efffc43], 0x4 bytes flags: 0x0
[    0.000000]  reserved[0xe]	[0x0000081efffc80-0x0000081efffc83], 0x4 bytes flags: 0x0
[    0.000000]  reserved[0xf]	[0x0000081efffcc0-0x0000081efffd48], 0x89 bytes flags: 0x0
[    0.000000]  reserved[0x10]	[0x0000081efffd80-0x0000081efffe08], 0x89 bytes flags: 0x0
[    0.000000]  reserved[0x11]	[0x0000081efffe40-0x0000081efffec8], 0x89 bytes flags: 0x0
[    0.000000]  reserved[0x12]	[0x0000081efffee4-0x0000081efffefe], 0x1b bytes flags: 0x0
[    0.000000]  reserved[0x13]	[0x0000081effff00-0x0000081effff27], 0x28 bytes flags: 0x0
[    0.000000]  reserved[0x14]	[0x0000081effff40-0x0000081fffffff], 0x10000c0 bytes flags: 0x0
[    0.000000] =====================================free_all_bootmem

  and system stuck in free_all_bootmem:
[...]
[    0.000000] =====================================__free_memory_core 0x0000000802900000 0x0000000807000000
[    0.000000] =====================================__free_pages_memory 802900 807000
[    0.000000] =====================================__free_pages_bootmem dec42000 8
[    0.000000] =====================================__free_pages_memory 802A00 807000
[    0.000000] =====================================__free_pages_bootmem dec44000 9
[    0.000000] =====================================__free_pages_memory 802C00 807000
[    0.000000] =====================================__free_pages_bootmem dec48000 10
[    0.000000] =====================================__free_pages_memory 803000 807000
[    0.000000] =====================================__free_pages_bootmem dec50000 10
[    0.000000] =====================================__free_pages_memory 803400 807000
[    0.000000] =====================================__free_pages_bootmem dec58000 10
[    0.000000] =====================================__free_pages_memory 803800 807000
[    0.000000] =====================================__free_pages_bootmem dec60000 10
[    0.000000] =====================================__free_pages_memory 803C00 807000
[    0.000000] =====================================__free_pages_bootmem dec68000 10
[    0.000000] =====================================__free_pages_memory 804000 807000
[    0.000000] =====================================__free_pages_bootmem dec70000 10
[    0.000000] =====================================__free_pages_memory 804400 807000
[    0.000000] =====================================__free_pages_bootmem dec78000 10
[    0.000000] =====================================__free_pages_memory 804800 807000
[    0.000000] =====================================__free_pages_bootmem dec80000 10
[    0.000000] =====================================__free_pages_memory 804C00 807000
[    0.000000] =====================================__free_pages_bootmem dec88000 10
[    0.000000] =====================================__free_pages_memory 805000 807000
[    0.000000] =====================================__free_pages_bootmem dec90000 10
[    0.000000] =====================================__free_pages_memory 805400 807000
[    0.000000] =====================================__free_pages_bootmem dec98000 10
[    0.000000] =====================================__free_pages_memory 805800 807000
[    0.000000] =====================================__free_pages_bootmem deca0000 10
[    0.000000] =====================================__free_pages_memory 805C00 807000
[    0.000000] =====================================__free_pages_bootmem deca8000 10
[    0.000000] =====================================__free_pages_memory 806000 807000
[    0.000000] =====================================__free_pages_bootmem decb0000 10
^^


Good case:
[    0.000000] ======= min_low_pfn=800000 max_low_pfn=820000 max_pfn=820000


[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x20000000 reserved size = 0x2531888
[    0.000000]  memory.cnt  = 0x1
[    0.000000]  memory[0x0]	[0x00000800000000-0x0000081fffffff], 0x20000000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x13
[    0.000000]  reserved[0x0]	[0x00000800003000-0x00000800007fff], 0x5000 bytes flags: 0x0
[    0.000000]  reserved[0x1]	[0x00000800008300-0x000008007771df], 0x76eee0 bytes flags: 0x0
[    0.000000]  reserved[0x2]	[0x00000802000000-0x000008028fffff], 0x900000 bytes flags: 0x0
[    0.000000]  reserved[0x3]	[0x00000807000000-0x00000807008ebd], 0x8ebe bytes flags: 0x0
[    0.000000]  reserved[0x4]	[0x0000081eb4a000-0x0000081ebd9fff], 0x90000 bytes flags: 0x0
[    0.000000]  reserved[0x5]	[0x0000081ebda880-0x0000081ebdc87f], 0x2000 bytes flags: 0x0
[    0.000000]  reserved[0x6]	[0x0000081ebdc8bc-0x0000081effefff], 0x422744 bytes flags: 0x0
[    0.000000]  reserved[0x7]	[0x0000081efffa80-0x0000081efffac3], 0x44 bytes flags: 0x0
[    0.000000]  reserved[0x8]	[0x0000081efffb00-0x0000081efffb43], 0x44 bytes flags: 0x0
[    0.000000]  reserved[0x9]	[0x0000081efffb80-0x0000081efffbf7], 0x78 bytes flags: 0x0
[    0.000000]  reserved[0xa]	[0x0000081efffc00-0x0000081efffc0f], 0x10 bytes flags: 0x0
[    0.000000]  reserved[0xb]	[0x0000081efffc40-0x0000081efffc4f], 0x10 bytes flags: 0x0
[    0.000000]  reserved[0xc]	[0x0000081efffc80-0x0000081efffc83], 0x4 bytes flags: 0x0
[    0.000000]  reserved[0xd]	[0x0000081efffcc0-0x0000081efffd48], 0x89 bytes flags: 0x0
[    0.000000]  reserved[0xe]	[0x0000081efffd80-0x0000081efffe08], 0x89 bytes flags: 0x0
[    0.000000]  reserved[0xf]	[0x0000081efffe40-0x0000081efffec8], 0x89 bytes flags: 0x0
[    0.000000]  reserved[0x10]	[0x0000081effff00-0x0000081effff27], 0x28 bytes flags: 0x0
[    0.000000]  reserved[0x11]	[0x0000081effff40-0x0000081effff9e], 0x5f bytes flags: 0x0
[    0.000000]  reserved[0x12]	[0x0000081effffa0-0x0000081fffffff], 0x1000060 bytes flags: 0x0
[    0.000000] =====================================free_all_bootmem


Also, there is additional log message in bad case:
[    0.000000]   HighMem zone: 1048080 pages exceeds freesize 0

> 
> FWIW, I've tested something similar and it worked correctly but
> there are at least two big differences in the case here
> 1) Removing the top of memory instead of just a block in the middle
> 2) Working above 32 bit ranges.
> 
> Eliminating #2 here may be difficult but can you try just removing
> 256MB instead of  512MB? (reg = <0x8 0x20000000 0x0 0x10000000>)

I think, that this issue can be reproduced on any ARM platform with one membank -
all you need is to just truncate memory from DT using "reserved-memory" + "no-map;" node
in the way that memblock.memory.regions[0].base + size < arm_lowmem_limit and there
will be no room for Highmem.



Regards,
-grygorii
