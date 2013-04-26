From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 26 Apr 2013 09:58:59 -0700
Subject: [PATCH] of: Set the DMA mask to 64 bits on ARM LPAE systems
In-Reply-To: <20130426100001.GB5007@localhost.cambridge.arm.com>
References: <1366764649-10342-1-git-send-email-lauraa@codeaurora.org>
 <20130425133315.GA7157@localhost.cambridge.arm.com>
 <51796365.5030405@codeaurora.org>
 <20130426100001.GB5007@localhost.cambridge.arm.com>
Message-ID: <517AB253.1090607@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/26/2013 3:00 AM, Catalin Marinas wrote:
> On Thu, Apr 25, 2013 at 06:09:57PM +0100, Laura Abbott wrote:
>> On 4/25/2013 6:33 AM, Catalin Marinas wrote:
>>> On Wed, Apr 24, 2013 at 01:50:49AM +0100, Laura Abbott wrote:
>>>> By default on ARM systems, the coherent DMA mask (lowest
>>>> address) is set to ~0 or 0xFFFFFFFFFFFFFFFF. Currently,
>>>> of_platform_device_create_pdata sets the coherent DMA mask to
>>>> 32 bits. This prevents coherent dma allocations from working by default
>>>> without clients setting the DMA mask. Rather than make every client
>>>> on an LPAE system set the mask, set the mask to a 64 bit value on
>>>> ARM LPAE systems.
>>>>
>>>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>>>> ---
>>>>    drivers/of/platform.c |    4 ++++
>>>>    1 files changed, 4 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>> index 0970505..18b69c1 100644
>>>> --- a/drivers/of/platform.c
>>>> +++ b/drivers/of/platform.c
>>>> @@ -214,7 +214,11 @@ struct platform_device *of_platform_device_create_pdata(
>>>>    #if defined(CONFIG_MICROBLAZE)
>>>>    	dev->archdata.dma_mask = 0xffffffffUL;
>>>>    #endif
>>>> +#ifdef CONFIG_ARM_LPAE
>>>> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
>>>> +#else
>>>>    	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>>> +#endif
>>>
>>> I wouldn't add CONFIG_ARM_LPAE checks in here, you can use
>>> CONFIG_ARCH_DMA_ADDR_T_64BIT (types.h uses this for the dma_addr_t
>>> definition).
>>>
>>
>> I thought about this as well but in arch/arm/mm/mm.h:
>>
>> #ifdef CONFIG_ZONE_DMA
>> extern phys_addr_t arm_dma_limit;
>> #else
>> #define arm_dma_limit ((phys_addr_t)~0)
>> #endif
>
> Russell replied already on the meaning of this variable, so I don't
> think its type is relevant here. It is also used when calling
> dma_contiguous_reserve() which takes a phys_addr_t.
>
>> arm_dma_limit is explicitly cast to phys_addr_t, which means that
>> arm_dma_limit will be always be sizeof(phys_addr_t) regardless of
>> sizeof(dma_addr_t). Is it safe to assume that
>> CONFIG_ARCH_DMA_ADDR_T_64BIT will always be selected if
>> sizeof(phys_addr_t) == 8? If not, we've defeated the point of the patch.
>
> sizeof(dma_addr_t) <= sizeof(phys_addr_t). I had this discussion with
> Russell when upstreaming the LPAE patches and the conclusion was that
> while the phys_addr_t is 64-bit with LPAE, the dma_addr_t size is a
> feature of the SoC and must be selected independently. However, I think
> with multi-platform support and LPAE enabled, we should probably set the
> dma_addr_t to 64-bit.
>
>> Alternatively, should the type of arm_dma_limit be dma_addr_t instead of
>> phys_addr_t?
>
> arm_dma_limit should be phys_addr_t since this is an address as seen by
> the CPU. dma_addr_t OTOH is a bus address as seen by the device. You can
> in theory have a DMA buffer with physical address beyond 32-bit (from a
> CPU perspective) but with a bus address withing 32-bit as seen by the
> device.
>
> There is some confusion in the kernel (you can google for past
> discussions) around the meaning of the DMA mask. If your RAM starts at
> 0, it doesn't matter much and there are several such assumptions in the
> kernel.
>
> So I still consider that you should use #ifdef
> CONFIG_ARCH_DMA_ADDR_T_64BIT and select this option on your platform.
>

Thanks for the clarification on all this. It's non-obvious but I see why 
things are set up the way they are. I'll re-submit with 
CONFIG_ARCH_DMA_ADDR_T_64BIT.

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
