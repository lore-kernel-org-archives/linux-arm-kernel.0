From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 13 Jun 2016 16:26:38 +0800
Subject: [PATCH] arm64: Implement arch_setup_pdev_archdata hook
In-Reply-To: <3369300.0KEI34cGsj@wuerfel>
References: <b4645ade4a4d4150e76594f5bf04a3ad5e7d5221.1465287808.git.baolin.wang@linaro.org>
 <3369300.0KEI34cGsj@wuerfel>
Message-ID: <CAMz4kuLH22JZRt3Tds2YrFYSnBhdG5T297zaB8wvtzsPnFVS1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 June 2016 at 16:43, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, June 7, 2016 4:29:21 PM CEST Baolin Wang wrote:
>> Now on ARM64 platform, it will set 'dummy_dma_ops' for device dma_ops if
>> it did not call 'arch_setup_dma_ops' at device creation time by issuing
>> platform_device_alloc() function, that will cause failure when setting
>> the dma mask for device.
>>
>> Hence We need to hook the archdata to setup proper dma_ops for these devices.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  arch/arm64/mm/dma-mapping.c |   21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index c566ec8..04e057b 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/dma-contiguous.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/swiotlb.h>
>> +#include <linux/platform_device.h>
>>
>>  #include <asm/cacheflush.h>
>>
>> @@ -961,3 +962,23 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>       dev->archdata.dma_coherent = coherent;
>>       __iommu_setup_dma_ops(dev, dma_base, size, iommu);
>>  }
>> +
>> +void arch_setup_pdev_archdata(struct platform_device *pdev)
>> +{
>> +     if (!pdev->dev.archdata.dma_ops)
>> +             pdev->dev.archdata.dma_ops = &swiotlb_dma_ops;
>
> You need to check the DT here to see if these are the right ops,
> or if you have to go through an IOMMU. Also, you have to set up the
> other fields that are controlled by arch_setup_dma_ops: whether
> it's coherent and what the offset is.

That's right. This is just set the platform device arch data, after
that the dma ops will be re-setup by issuing arch_setup_dma_ops(). But
some platform devices created by platform_device_alloc() will not
issue the arch_setup_dma_ops() function to setup the dma ops. So I
want to set the default dma ops by arch_setup_pdev_archdata(), but
that is not reasonable according to Robin's explanation.

>
>> +     /*
>> +      * Set default coherent_dma_mask to 32 bit. Drivers are expected to
>> +      * setup the correct supported mask.
>> +      */
>> +     if (!pdev->dev.coherent_dma_mask)
>> +             pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>> +
>> +     /*
>> +      * Set it to coherent_dma_mask by default if the architecture
>> +      * code has not set it.
>> +      */
>> +     if (!pdev->dev.dma_mask)
>> +             pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
>> +}
>
> We still have an open bug about the dma_set_mask() function on ARM64:
> we have to check the dma-ranges property to ensure that no device can
> set a mask wider than what its parent bus can support.
>
> What is your plan for this in case of these devices?

I think these are just default setup for dma mask. I suppose the
checking you mentioned should be added in of_dma_configure()?

-- 
Baolin.wang
Best Regards
