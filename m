From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 18 Jun 2013 18:48:28 -0700
Subject: [RFC 2/3] arm: mm: Define set_memory_* functions for ARM
In-Reply-To: <20130618110959.GB5893@mudshark.cambridge.arm.com>
References: <1371057810-3189-1-git-send-email-lauraa@codeaurora.org>
 <1371057810-3189-3-git-send-email-lauraa@codeaurora.org>
 <20130618110959.GB5893@mudshark.cambridge.arm.com>
Message-ID: <51C10DEC.7030605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/18/2013 4:09 AM, Will Deacon wrote:
> On Wed, Jun 12, 2013 at 06:23:29PM +0100, Laura Abbott wrote:
>> Other architectures define various set_memory functions to allow
>> attributes to be changed (e.g. set_memory_x, set_memory_rw, etc.)
>> Currently, these functions are missing on ARM. Define these in an
>> appropriate manner for ARM.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>   arch/arm/include/asm/cacheflush.h |    5 ++
>>   arch/arm/mm/mmu.c                 |   86 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 91 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
>> index bff7138..55ed26b 100644
>> --- a/arch/arm/include/asm/cacheflush.h
>> +++ b/arch/arm/include/asm/cacheflush.h
>> @@ -438,4 +438,9 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
>>   #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
>>   #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
>>
>> +int set_memory_ro(unsigned long addr, int numpages);
>> +int set_memory_rw(unsigned long addr, int numpages);
>> +int set_memory_x(unsigned long addr, int numpages);
>> +int set_memory_nx(unsigned long addr, int numpages);
>
> This seems like a pretty clunky interface with a horribly generic name, but
> that seems to be what x86 and s390 are using. I wonder if there would be any
> interest in tidying it up a bit? It really looks like something that is
> x86-specific but has started to grow users in core code (set_memory_4k?!).
>

I think cleanup would be beneficial. Nothing else really uses the 
set_memory_* functions and s390 explicitly defined them so they could 
use CONFIG_DEBUG_SET_MODULE_RONX as well. Perhaps the work I did with 
apply_to_page_range could apply across all architectures?

Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
