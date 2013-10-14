From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 14 Oct 2013 10:41:50 -0400
Subject: [RFC 08/23] mm/memblock: debug: don't free reserved array if
 !ARCH_DISCARD_MEMBLOCK
In-Reply-To: <20131013195111.GB18075@htj.dyndns.org>
References: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
 <1381615146-20342-9-git-send-email-santosh.shilimkar@ti.com>
 <20131013195111.GB18075@htj.dyndns.org>
Message-ID: <525C02AE.8040507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 October 2013 03:51 PM, Tejun Heo wrote:
> On Sat, Oct 12, 2013 at 05:58:51PM -0400, Santosh Shilimkar wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> Now the Nobootmem allocator will always try to free memory allocated for
>> reserved memory regions (free_low_memory_core_early()) without taking
>> into to account current memblock debugging configuration
>> (CONFIG_ARCH_DISCARD_MEMBLOCK and CONFIG_DEBUG_FS state).
>> As result if:
>>  - CONFIG_DEBUG_FS defined
>>  - CONFIG_ARCH_DISCARD_MEMBLOCK not defined;
>> -  reserved memory regions array have been resized during boot
>>
>> then:
>> - memory allocated for reserved memory regions array will be freed to
>> buddy allocator;
>> - debug_fs entry "sys/kernel/debug/memblock/reserved" will show garbage
>> instead of state of memory reservations. like:
>>    0: 0x98393bc0..0x9a393bbf
>>    1: 0xff120000..0xff11ffff
>>    2: 0x00000000..0xffffffff
>>
>> Hence, do not free memory allocated for reserved memory regions if
>> defined(CONFIG_DEBUG_FS) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK).
>>
>> Cc: Yinghai Lu <yinghai@kernel.org>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  mm/memblock.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index d903138..1bb2cc0 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -169,6 +169,10 @@ phys_addr_t __init_memblock get_allocated_memblock_reserved_regions_info(
>>  	if (memblock.reserved.regions == memblock_reserved_init_regions)
>>  		return 0;
>>  
> 
> Please add comment explaining why the following test exists.  It's
> pretty difficult to deduce the reason only from the code.
> 
ok.

>> +	if (IS_ENABLED(CONFIG_DEBUG_FS) &&
>> +	    !IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
>> +		return 0;
>> +
> 
> Also, as this is another fix patch, can you please move this to the
> head of the series?
> 
Sure
