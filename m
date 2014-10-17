From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Fri, 17 Oct 2014 04:36:52 -0700
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <54400123.7040806@ti.com>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk> <54400123.7040806@ti.com>
Message-ID: <5440FF54.5080905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2014 10:32 AM, Grygorii Strashko wrote:
> Hi Russell,
> On 10/15/2014 08:50 PM, Russell King - ARM Linux wrote:
>> On Wed, Oct 15, 2014 at 08:18:18PM +0300, Grygorii Strashko wrote:
>>> 3) If I apply below change - I can boot:
>>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>>> index c031063..85ad92b 100644
>>> --- a/arch/arm/kernel/setup.c
>>> +++ b/arch/arm/kernel/setup.c
>>> @@ -917,8 +917,8 @@ void __init setup_arch(char **cmdline_p)
>>>
>>>           early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
>>>           setup_dma_zone(mdesc);
>>> -       sanity_check_meminfo();
>>>           arm_memblock_init(mdesc);
>>> +       sanity_check_meminfo();
>>>
>>>           paging_init(mdesc);
>>>           request_standard_resources(mdesc);
>>>
>>> ^^ not sure if it totally safe, because dma_contiguous_reserve(arm_dma_limit);
>>> is called from inside arm_memblock_init() and it does bootmem allocations.
>>
>> It isn't.  sanity_check_meminfo() _must_ be called before arm_memblock_init()
>> so that sanity_check_meminfo() can adjust the passed memory description to
>> remove stuff which is inappropriate for the configuration, before it is
>> passed to memblock.
>>
>>> Sort Summary:
>>> It looks like all static memory reservation and memory stealing's
>>> (calling of memblock_remove()) have to be done before any other
>>> operations and before calculating ARM memory limits.
>>
>> No, that should not be the case.  The way it is /supposed/ to work is:
>>
>> - We obtain the memory information and pass it into memblock
>> - We sanity check the memory in memblock, removing memory which we
>>     deem to be unacceptable for the kernel configuration via
>>     memblock_remove().  Also calculate the highest address we are
>>     prepared to allocate, which is set to the top of the first chunk
>>     of memory, or the top of lowmem.
>> - We then see about reserving memory from memblock.  This marks memory
>>     as reserved, or in certain cases where we actually want to prevent
>>     the kernel taking control of the memory, we completely remove the
>>     memory from memblock (via memblock_remove).
>
> In my case amount of removed memory is so high that there is no room
> for Highmem anymore.
>
> memblock.memory.regions[0].base + size < arm_lowmem_limit
> and arm_lowmem_limit == memblock.current_limit
>
>>
>> Memory removed via memblock_remove() is then not available for any
>> allocations, and should not be touched by the kernel in any way from
>> that point on.
>>
>> It doesn't matter that the memblock limit is still set higher, because
>> the memory has been removed from the available memory pool, it should
>> not be allocated.
>>
>
> You are right in general, but seems problem is not in memblock itself :(
> The problem is with  memory control variables like:
>   - arm_lowmem_limit
>   - max_low_pfn
>   - max_pfn
>
> The last thing I've found that issue happens when in
> bootmem_init()->find_limits() the max_low variable got value greater than
> max_high: max_low_pfn > max_pfn.
>
Without getting too much into details, I don't see much point to let
kernel know about memory and then just to remove a huge block of it
which is it never gonna see it. It creates hole in Linear memory
which you can avoid by doing that memory partition and letting kernel
know about memory which it needs to deal with it.

If you are just playing around then its fine.

Regards,
Santosh
