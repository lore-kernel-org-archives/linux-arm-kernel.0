From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Thu, 12 Jan 2017 08:53:35 +0300
Subject: [PATCH 2/2] arm64: avoid increasing DMA masks above what hardware
 supports
In-Reply-To: <2489599.dXme8sRkvp@wuerfel>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <1484159512-28515-1-git-send-email-nikita.yoush@cogentembedded.com>
 <1484159512-28515-3-git-send-email-nikita.yoush@cogentembedded.com>
 <2489599.dXme8sRkvp@wuerfel>
Message-ID: <f1c64dcd-5567-8164-86d1-e3bc42831e7d@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> @@ -959,6 +990,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>>         if (!dev->archdata.dma_ops)
>>                 dev->archdata.dma_ops = &swiotlb_dma_ops;
>>  
>> +       /*
>> +        * Whatever the parent bus can set. A device must not set
>> +        * a DMA mask larger than this.
>> +        */
>> +       if (enforce_range)
>> +               dev->archdata.parent_dma_mask = size - 1;
>> +       else
>> +               dev->archdata.parent_dma_mask = DMA_BIT_MASK(64);
>> +
>>         dev->archdata.dma_coherent = coherent;
>>         __iommu_setup_dma_ops(dev, dma_base, size, iommu);
>>
> 
> Could we just pass the mask instead of the size here?

We don't want to change API now.

Nikita
