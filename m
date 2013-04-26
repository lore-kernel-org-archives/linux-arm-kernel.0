From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 26 Apr 2013 13:14:49 -0700
Subject: [PATCH v2] of: Set the DMA mask to 64 bits when dma_addr_t is
 64-bits
In-Reply-To: <517ADDA9.7020701@gmail.com>
References: <1366999565-19498-1-git-send-email-lauraa@codeaurora.org>
 <517ADDA9.7020701@gmail.com>
Message-ID: <517AE039.8070804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/26/2013 1:03 PM, Rob Herring wrote:
> On 04/26/2013 01:06 PM, Laura Abbott wrote:
>> Currently, of_platform_device_create_pdata always sets the
>> coherent DMA mask to 32 bits. On ARM systems without CONFIG_ZONE_DMA,
>> arm_dma_limit gets set to ~0 or 0xFFFFFFFFFFFFFFFF on LPAE based
>> systems. Since arm_dma_limit represents the smallest dma_mask
>> on the system, the default of 32 bits prevents any dma_coherent
>> allocation from succeeding unless clients manually set the
>> dma mask first. Rather than make every client on an LPAE system set
>> the mask, set the mask to a 64 bit value on systems with 64-bit
>> dma addresses.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>   drivers/of/platform.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> index 0970505..c669ab4 100644
>> --- a/drivers/of/platform.c
>> +++ b/drivers/of/platform.c
>> @@ -214,7 +214,11 @@ struct platform_device *of_platform_device_create_pdata(
>>   #if defined(CONFIG_MICROBLAZE)
>>   	dev->archdata.dma_mask = 0xffffffffUL;
>>   #endif
>> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
>> +	dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
>> +#else
>>   	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +#endif
>
> How about "DMA_BIT_MASK(sizeof(dma_addr_t) * 8))" and avoid the ifdef.
>

Sounds good.


> Rob
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
