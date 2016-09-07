From: sricharan@codeaurora.org (Sricharan)
Date: Wed, 7 Sep 2016 11:54:00 +0530
Subject: [PATCH 1/8] arm: dma-mapping: Don't override dma_ops in
 arch_setup_dma_ops()
In-Reply-To: <16c9743e-e531-25aa-76f1-8746a6b8ef11@samsung.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
 <1470696550-3416-2-git-send-email-sricharan@codeaurora.org>
 <16c9743e-e531-25aa-76f1-8746a6b8ef11@samsung.com>
Message-ID: <002e01d208d0$70263e60$5072bb20$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

>Hi Sricharan and Laurent,
>
>
>On 2016-08-09 00:49, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> The arch_setup_dma_ops() function is in charge of setting dma_ops with a
>> call to set_dma_ops(). set_dma_ops() is also called from
>>
>> - highbank and mvebu bus notifiers
>> - dmabounce (to be replaced with swiotlb)
>> - arm_iommu_attach_device
>>
>> (arm_iommu_attach_device is itself called from IOMMU and bus master
>> device drivers)
>>
>> To allow the arch_setup_dma_ops() call to be moved from device add time
>> to device probe time we must ensure that dma_ops already setup by any of
>> the above callers will not be overridden.
>>
>> Aftering replacing dmabounce with swiotlb, converting IOMMU drivers to
>> of_xlate and taking care of highbank and mvebu, the workaround should be
>> removed.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> ---
>>   arch/arm/mm/dma-mapping.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index ff7ed56..4686d66 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -2259,6 +2259,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>   	struct dma_map_ops *dma_ops;
>>
>>   	dev->archdata.dma_coherent = coherent;
>> +
>> +	/*
>> +	 * Don't override the dma_ops if they have already been set. Ideally
>> +	 * this should be the only location where dma_ops are set, remove this
>> +	 * check when all other callers of set_dma_ops will have disappeared.
>> +	 */
>> +	if (dev->archdata.dma_ops)
>> +		return;
>> +
>>   	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
>>   		dma_ops = arm_get_iommu_dma_map_ops(coherent);
>>   	else
>
>Please add also set_dma_ops(dev, NULL) to arm_teardown_iommu_dma_ops()
>function
>to this patch, because otherwise dma_ops won't be configured properly if
>deferred
>probe of the given device happens: iommu dma ops will be set for the
>first probe
>try, then iommu structures will be teared down after EPROBEDEFER error,
>and then
>before next probe ties dma_ops will be already set, but no iommu
>structures are
>available.
>
>For a convenience, this a fixup patch:
>https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/commitdiff/55adefd43cee9d4beb15cb1bbd805c5059b56b4f
>
 Right, this and will also add the remove_device during deconfigure as well.

Regards,
 Sricharan
