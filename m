From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 27 Apr 2016 17:14:12 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160427135859.GC20646@e104818-lin.cambridge.arm.com>
References: <1461612094-30939-1-git-send-email-grygorii.strashko@ti.com>
 <87d1pcrj0t.fsf@intel.com> <571F2357.9080509@ti.com>
 <878tzzpq19.fsf@intel.com>
 <20160427135859.GC20646@e104818-lin.cambridge.arm.com>
Message-ID: <5720C934.20106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2016 04:59 PM, Catalin Marinas wrote:
> On Wed, Apr 27, 2016 at 08:41:06AM +0300, Felipe Balbi wrote:
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>> On 04/26/2016 09:17 AM, Felipe Balbi wrote:
>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>> Now not all DMA paremters configured properly for "xhci-hcd" platform
>>>>> device which is created manually. For example: dma_pfn_offset, dam_ops
>>>>> and iommu configuration will not corresponds "dwc3" devices
>>>>> configuration. As result, this will cause problems like wrong DMA
>>>>> addresses translation on platforms with LPAE enabled like Keystone 2.
>>>>>
>>>>> When platform is using DT boot mode the DMA configuration will be
>>>>> parsed and applied from DT, so, to fix this issue, reuse
>>>>> of_dma_configure() API and retrieve DMA configuartion for "xhci-hcd"
>>>>> from DWC3 device node.
>>>>
>>>> patch is incomplete. You left out non-DT users which might suffer from
>>>> the same problem.
>>>
>>> Honestly, I don't know how to fix it gracefully for non-DT case.
>>> I can update commit message to mention that this is fix for DT case only.
>>
>> no, that won't do :-) There are other users for this driver and they are
>> all "out-of-compliance" when it comes to DMA usage. Apparently, the
>> desired behavior is to pass correct device to DMA API which the gadget
>> side is already doing (see below). For the host side, the fix has to be
>> more involved.
>>
>> Frankly, I'd prefer that DMA setup could be inherited from parent
>> device, then it wouldn't really matter and a bunch of this could be
>> simplified. Some sort of dma_inherit(struct device *dev, struct device
>> *parent) would go a long way, IMHO.
>
> I would be in favour of a dma_inherit() function as well. We could hack
> something up in the arch code (like below) but I would rather prefer an
> explicit dma_inherit() call by drivers creating such devices.
>
> diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
> index ba437f090a74..ea6fb9b0e8fa 100644
> --- a/arch/arm64/include/asm/dma-mapping.h
> +++ b/arch/arm64/include/asm/dma-mapping.h
> @@ -29,8 +29,11 @@ extern struct dma_map_ops dummy_dma_ops;
>
>   static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
>   {
> -	if (dev && dev->archdata.dma_ops)
> -		return dev->archdata.dma_ops;
> +	while (dev) {
> +		if (dev->archdata.dma_ops)
> +			return dev->archdata.dma_ops;
> +		dev = dev->parent;
> +	}
>
>   	/*
>   	 * We expect no ISA devices, and all other DMA masters are expected to
>

It's no enough to W/A just dma_ops :(

  dma_inherit()...
FYI: http://www.spinics.net/lists/arm-kernel/msg384012.html
Maybe you'll be able to find the way to make it acceptable.

-- 
regards,
-grygorii
