From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Aug 2015 18:01:14 +0200
Subject: [PATCH v2 2/2] ARM: dma-mapping: Fix the coherent case when iommu
 is used
In-Reply-To: <20150814175505.GB21966@e104818-lin.cambridge.arm.com>
References: <1439568776-17864-1-git-send-email-gregory.clement@free-electrons.com>
 <1439568776-17864-3-git-send-email-gregory.clement@free-electrons.com>
 <20150814175505.GB21966@e104818-lin.cambridge.arm.com>
Message-ID: <55D74B4A.4000800@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Sorry to answer only today, I xas busy on other task until now.

On 14/08/2015 19:55, Catalin Marinas wrote:
> On Fri, Aug 14, 2015 at 06:12:56PM +0200, Gregory CLEMENT wrote:
>> When doing dma allocation with IOMMU the __iommu_alloc_atomic() was
>> used even when the system was coherent. However, this function
>> allocates from a non-cacheable pool, which is fine when the device is
>> not cache coherent but won't work as expected in the device is cache
>> coherent. Indeed, the CPU and device must access the memory using the
>> same cacheability attributes.
>>
>> Tested-by: We need someone here
> 
> And at least a build on your side ;).

It build but I forgot to set the CONFIG_ARM_DMA_USE_IOMMU config!

> 
> Rob Herring added the coherent IOMMU ops in commit 0fa478df444f ("ARM:
> add coherent iommu dma ops"). But it doesn't look like he needed the
> coherent DMA API, only the streaming one.
> 
>> @@ -1885,7 +1903,7 @@ struct dma_map_ops iommu_ops = {
>>  };
>>  
>>  struct dma_map_ops iommu_coherent_ops = {
>> -	.alloc		= arm_iommu_alloc_attrs,
>> +	.alloc		= arm_coherent_iommu_alloc_attrs,
>>  	.free		= arm_iommu_free_attrs,
> 
> Does this compile? You renamed arm_iommu_free_attrs to
> __arm_iommu_alloc_attrs but I don't see arm_iommu_free_attrs
> and arm_coherent_iommu_free_attrs functions.
> 
>>  	.mmap		= arm_iommu_mmap_attrs,
> 
> And we need an arm_coherent_iommu_mmap_attrs (similar to
> arm_iommu_mmap_attrs but without __get_dma_pgprot. Use
> arm_(coherent_)dma_mmap as an example.
> 
I am going to take care of it

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
