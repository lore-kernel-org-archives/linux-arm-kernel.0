From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 25 Apr 2013 10:09:57 -0700
Subject: [PATCH] of: Set the DMA mask to 64 bits on ARM LPAE systems
In-Reply-To: <20130425133315.GA7157@localhost.cambridge.arm.com>
References: <1366764649-10342-1-git-send-email-lauraa@codeaurora.org>
 <20130425133315.GA7157@localhost.cambridge.arm.com>
Message-ID: <51796365.5030405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2013 6:33 AM, Catalin Marinas wrote:
> On Wed, Apr 24, 2013 at 01:50:49AM +0100, Laura Abbott wrote:
>> By default on ARM systems, the coherent DMA mask (lowest
>> address) is set to ~0 or 0xFFFFFFFFFFFFFFFF. Currently,
>> of_platform_device_create_pdata sets the coherent DMA mask to
>> 32 bits. This prevents coherent dma allocations from working by default
>> without clients setting the DMA mask. Rather than make every client
>> on an LPAE system set the mask, set the mask to a 64 bit value on
>> ARM LPAE systems.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>   drivers/of/platform.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 0970505..18b69c1 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -214,7 +214,11 @@ struct platform_device *of_platform_device_create_pdata(
>>   #if defined(CONFIG_MICROBLAZE)
>>   	dev->archdata.dma_mask = 0xffffffffUL;
>>   #endif
>> +#ifdef CONFIG_ARM_LPAE
>> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
>> +#else
>>   	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +#endif
>
> I wouldn't add CONFIG_ARM_LPAE checks in here, you can use
> CONFIG_ARCH_DMA_ADDR_T_64BIT (types.h uses this for the dma_addr_t
> definition).
>

I thought about this as well but in arch/arm/mm/mm.h:

#ifdef CONFIG_ZONE_DMA
extern phys_addr_t arm_dma_limit;
#else
#define arm_dma_limit ((phys_addr_t)~0)
#endif

arm_dma_limit is explicitly cast to phys_addr_t, which means that 
arm_dma_limit will be always be sizeof(phys_addr_t) regardless of 
sizeof(dma_addr_t). Is it safe to assume that 
CONFIG_ARCH_DMA_ADDR_T_64BIT will always be selected if 
sizeof(phys_addr_t) == 8? If not, we've defeated the point of the patch.

Alternatively, should the type of arm_dma_limit be dma_addr_t instead of 
phys_addr_t?

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
