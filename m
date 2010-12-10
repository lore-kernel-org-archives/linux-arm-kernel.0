From: vbarshak@mvista.com (Valentine Barshak)
Date: Fri, 10 Dec 2010 15:29:09 +0300
Subject: [PATCH] ARM: V6 MPCore v6_dma_inv_range and v6_dma_flush_range
	RWFO fix
In-Reply-To: <1291974616.13511.1.camel@e102109-lin.cambridge.arm.com>
References: <1290622059.3056.41.camel@e102109-lin.cambridge.arm.com>	
	<20101124183936.GA18796@mvista.com>
	<20101210052604.GA13313@mvista.com>
	<1291974616.13511.1.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4D021D15.5070300@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Fri, 2010-12-10 at 05:26 +0000, George G. Davis wrote:
>   
>> On Wed, Nov 24, 2010 at 09:39:36PM +0300, Valentine Barshak wrote:
>>     
>>> Updated according to the comments to avoid r/w outside the buffer and
>>> used byte r/w for the possible unaligned data. Seems to work fine.
>>>
>>> Cache ownership must be acqired by reading/writing data from the
>>> cache line to make cache operation have the desired effect on the
>>> SMP MPCore CPU. However, the ownership is never aquired in the
>>> v6_dma_inv_range function when cleaning the first line and
>>> flushing the last one, in case the address is not aligned
>>> to D_CACHE_LINE_SIZE boundary.
>>> Fix this by reading/writing data if needed, before performing
>>> cache operations.
>>> While at it, fix v6_dma_flush_range to prevent RWFO outside
>>> the buffer.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@mvista.com>
>>> Signed-off-by: George G. Davis <gdavis@mvista.com>
>>> ---
>>>  arch/arm/mm/cache-v6.S |   40 ++++++++++++++++++++++++++--------------
>>>  1 files changed, 26 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
>>> index 99fa688..622f8a1 100644
>>> --- a/arch/arm/mm/cache-v6.S
>>> +++ b/arch/arm/mm/cache-v6.S
>>> @@ -203,25 +203,29 @@ ENTRY(v6_flush_kern_dcache_area)
>>>   *   - end     - virtual end address of region
>>>   */
>>>  v6_dma_inv_range:
>>> -     tst     r0, #D_CACHE_LINE_SIZE - 1
>>> -     bic     r0, r0, #D_CACHE_LINE_SIZE - 1
>>> -#ifdef HARVARD_CACHE
>>> -     mcrne   p15, 0, r0, c7, c10, 1          @ clean D line
>>> -#else
>>> -     mcrne   p15, 0, r0, c7, c11, 1          @ clean unified line
>>> -#endif
>>>       tst     r1, #D_CACHE_LINE_SIZE - 1
>>> +#ifdef CONFIG_DMA_CACHE_RWFO
>>> +     ldrneb  r2, [r1, #-1]                   @ read for ownership
>>> +     strneb  r2, [r1, #-1]                   @ write for ownership
>>> +#endif
>>>       bic     r1, r1, #D_CACHE_LINE_SIZE - 1
>>>  #ifdef HARVARD_CACHE
>>>       mcrne   p15, 0, r1, c7, c14, 1          @ clean & invalidate D line
>>>  #else
>>>       mcrne   p15, 0, r1, c7, c15, 1          @ clean & invalidate unified line
>>>  #endif
>>> -1:
>>>  #ifdef CONFIG_DMA_CACHE_RWFO
>>> -     ldr     r2, [r0]                        @ read for ownership
>>> -     str     r2, [r0]                        @ write for ownership
>>> +     ldrb    r2, [r0]                        @ read for ownership
>>> +     strb    r2, [r0]                        @ write for ownership
>>> +#endif
>>> +     tst     r0, #D_CACHE_LINE_SIZE - 1
>>> +     bic     r0, r0, #D_CACHE_LINE_SIZE - 1
>>> +#ifdef HARVARD_CACHE
>>> +     mcrne   p15, 0, r0, c7, c10, 1          @ clean D line
>>> +#else
>>> +     mcrne   p15, 0, r0, c7, c11, 1          @ clean unified line
>>>  #endif
>>> +1:
>>>  #ifdef HARVARD_CACHE
>>>       mcr     p15, 0, r0, c7, c6, 1           @ invalidate D line
>>>  #else
>>> @@ -229,6 +233,10 @@ v6_dma_inv_range:
>>>  #endif
>>>       add     r0, r0, #D_CACHE_LINE_SIZE
>>>       cmp     r0, r1
>>> +#ifdef CONFIG_DMA_CACHE_RWFO
>>> +     ldrlo   r2, [r0]                        @ read for ownership
>>> +     strlo   r2, [r0]                        @ write for ownership
>>> +#endif
>>>       blo     1b
>>>       mov     r0, #0
>>>       mcr     p15, 0, r0, c7, c10, 4          @ drain write buffer
>>>       
>> Just a minor nit...
>>
>> Any reason for rearranging the order of 'start'/'end' parameters in the
>> above changes?  It's not clear that there is any performance benefit by
>> rearranging those parameters and it obfuscates the changes, e.g. this
>> is equivalent to your change above and also much clearer:
>>     
>
>   
It probably obfuscates the change, but I thought it made the code a bit 
cleaner and easier to read.
So that first the end (r1) is flushed and then we do all the operations 
needed on the first cache line (r0) in a row.
I'll resubmit the change and add "Cc: stable at kernel.org" to the header.

Thanks,
Val.
> I've been wondering about this as well. But I was too lazy to rewrite it
> and see whether there is a performance benefit in the original patch. I
> agree that yours looks cleaner.
>
>   
