From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 17 Feb 2016 08:06:14 +0100
Subject: [PATCH] ARM64: dma-mapping: fix handling of devices registered
 before arch_initcall
In-Reply-To: <56C37317.9020104@arm.com>
References: <1455632084-14666-1-git-send-email-m.szyprowski@samsung.com>
 <56C37317.9020104@arm.com>
Message-ID: <56C41BE6.5000203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2016-02-16 20:05, Robin Murphy wrote:
> On 16/02/16 14:14, Marek Szyprowski wrote:
>> This patch ensures that devices, which got registered before 
>> arch_initcall
>> will be handled correctly by IOMMU-based DMA-mapping code.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   arch/arm64/mm/dma-mapping.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 573b1e6..ce6019f 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -928,6 +928,10 @@ static int __init __iommu_dma_init(void)
>>           ret = register_iommu_dma_ops_notifier(&platform_bus_type);
>>       if (!ret)
>>           ret = register_iommu_dma_ops_notifier(&amba_bustype);
>> +
>> +    /* handle devices queued before this arch_initcall */
>> +    if (!ret)
>> +        __iommu_attach_notifier(NULL, BUS_NOTIFY_ADD_DEVICE, NULL);
>
> Hmm, surely unless *all* the devices on the relevant buses are created 
> before arch_initcall level, then the next one is going to kick off the 
> notifier to walk the whole list anyway. Have you seen this being a 
> problem in practice?

Yes, I've observed such situation, that's why I've posted this patch. I was
really surprised that this code doesn't handle all cases.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
