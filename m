From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 18 Mar 2016 09:55:21 -0400
Subject: [PATCH 3/3] dma-mapping: move swiotlb dma-phys functions to
 common header
In-Reply-To: <56EBE71F.2080203@arm.com>
References: <1458252137-24497-1-git-send-email-okaya@codeaurora.org>
 <1458252137-24497-3-git-send-email-okaya@codeaurora.org>
 <56EBE71F.2080203@arm.com>
Message-ID: <56EC08C9.3080809@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/18/2016 7:31 AM, Robin Murphy wrote:
> On 17/03/16 22:02, Sinan Kaya wrote:
>> Moving the default implementation of swiotlb_dma_to_phys and
>> swiotlb_phys_to_dma functions to dma-mapping.h so that we can get
>> rid of the duplicate code in multiple ARCH.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>   arch/arm64/include/asm/dma-mapping.h               | 14 --------------
>>   arch/ia64/include/asm/dma-mapping.h                | 14 --------------
>>   arch/mips/include/asm/mach-generic/dma-coherence.h | 16 ----------------
>>   arch/tile/include/asm/dma-mapping.h                | 14 --------------
>>   arch/unicore32/include/asm/dma-mapping.h           | 14 --------------
>>   arch/x86/include/asm/dma-mapping.h                 | 13 -------------
>>   arch/xtensa/include/asm/dma-mapping.h              | 14 --------------
>>   include/linux/dma-mapping.h                        | 14 ++++++++++++++
>>   8 files changed, 14 insertions(+), 99 deletions(-)
> 
> [...]
> 
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 728ef07..871d620 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -683,4 +683,18 @@ static inline int dma_mmap_writecombine(struct device *dev,
>>   #define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
>>   #endif
>>
>> +#ifndef swiotlb_phys_to_dma
>> +static inline dma_addr_t swiotlb_phys_to_dma(struct device *dev, phys_addr_t paddr)
>> +{
>> +         return paddr;
>> +}
>> +#endif
>> +
>> +#ifndef swiotlb_dma_to_phys
>> +static inline phys_addr_t swiotlb_dma_to_phys(struct device *dev, dma_addr_t daddr)
>> +{
>> +        return daddr;
>> +}
>> +#endif
>> +
>>   #endif
>>
> 
> Could the default definition not be pushed all the way down into swiotlb.c (or at least swiotlb.h)?

I can do that but then we lose the inlining capability of the compiler. This could cost
performance penalty on architectures using it.

I tried moving it to swiotlb.h. swiotlb.h seems to be only used by swiotlb.c file. I could try 
including it into dma-mapping.h and then moving the definitions into swiotlb.h file. 

Let me give this a try.

> 
> Robin.
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
