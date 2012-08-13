From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Aug 2012 17:35:45 -0500
Subject: [RFC PATCH] ARM: add coherent dma ops
In-Reply-To: <007b01cd791b$07adc900$17095b00$%szyprowski@samsung.com>
References: <1344490622-20029-1-git-send-email-robherring2@gmail.com>
 <007b01cd791b$07adc900$17095b00$%szyprowski@samsung.com>
Message-ID: <50298141.2090606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2012 01:15 AM, Marek Szyprowski wrote:
> Hi Rob,
> 
> On Thursday, August 09, 2012 7:37 AM Rob Herring wrote:
> 
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> arch_is_coherent is problematic as it is a global symbol. This
>> doesn't work for multi-platform kernels or platforms which can support
>> per device coherent DMA.
>>
>> This adds arm_coherent_dma_ops to be used for devices which connected
>> coherently (i.e. to the ACP port on Cortex-A9 or A15). The arm_dma_ops
>> are modified at boot when arch_is_coherent is true.
> 
> Thanks for the patch. I had something similar on my TODO list, but had not enough time for
> it. I like this patch but I have some comments.
>  
>> This does not address arch_is_coherent used in iommu dma ops.
> 
> In the initial version we might get rid of arch_is_coherent() usage in iommu dma ops and
> implement it when a real coherent hw with iommu will be available.

Well, if you are fine with the overall approach, then I can update iommu
functions too.


>> +static int __init dma_map_init(void)
>> +{
>> +	if (!arch_is_coherent())
>> +		return 0;
>> +
>> +	arm_dma_ops.map_page = arm_coherent_dma_map_page;
>> +	arm_dma_ops.unmap_page = NULL;
>> +	arm_dma_ops.map_sg = NULL;
>> +	arm_dma_ops.unmap_sg = NULL;
>> +	arm_dma_ops.sync_single_for_cpu = NULL;
>> +	arm_dma_ops.sync_single_for_device = NULL;
>> +	arm_dma_ops.sync_sg_for_cpu = NULL;
>> +	arm_dma_ops.sync_sg_for_device = NULL;
>> +	arm_dma_ops.alloc = arm_coherent_dma_alloc;
>> +	arm_dma_ops.free = arm_coherent_dma_free;
>> +}
>> +core_initcall(dma_map_init);
> 
> I would implement it in a bit different way. Overwriting structure entries is not the 
> cleanest approach and might lead to some misunderstandings. I would rather change 
> get_dma_ops() function in arch/arm/include/asm/dma-mapping.h to something like this:
> 
> static inline struct dma_map_ops *get_dma_ops(struct device *dev)
> {
>         if (dev && dev->archdata.dma_ops)
>                 return dev->archdata.dma_ops;
>         return !arch_is_coherent() ? &arm_dma_ops : &arm_coherent_dma_ops;
> }
> 
> This way the code is easy to understand and compiler can easily optimize out the above 
> check for 99% of architectures which are either coherent or not. In case of partially 
> coherent architectures, arch_is_coherent() will probably return false and coherent 
> devices will get their dma_map_ops initialized by platform code.

Yes, that's much better.

Rob
