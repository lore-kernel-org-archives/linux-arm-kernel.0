From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 16 Jan 2015 20:12:29 +0000
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <1421392892.19175.6.camel@mhfsdcap03>
References: <cover.1421086706.git.robin.murphy@arm.com>	
 <1421136128.27675.58.camel@mtksdaap41> <54B80857.7060407@arm.com>
 <1421392892.19175.6.camel@mhfsdcap03>
Message-ID: <54B970AD.7020407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/15 07:21, Yong Wu wrote:
[...]
>> Now that the server seems to be properly accessible again, I've made a
>> branch with both series available here:
>>
>>     git://linux-arm.org/linux-rm iommu/dma
>>
>> Note that in the current state it also depends on having the ARM SMMU
>> driver selected in the config, due to an oversight on my part :(
>>
>> Robin.
>>
> Dear Robin,
>
>       We have test this patch on our SOC(mt8173),which have our own iommu
> HW(it is not ARM SMMU), the patch could work well.
> Tested-by:Yong Wu <yong.wu@mediatek.com>
>

Thanks!

>   And I have some questiones about the usage:
>
> 1) If we create a iommu domain by ?arch_setup_dma_ops", then we would
> like to call the standard iommu interface, like
> ?iommu_set_fault_handle?,
> How can we get the "struct iommu_domain *"? (the ?dev_domain? is
> static.)
>
> 2) If a device A call ?arch_setup_dma_ops? to create a iommu domain, and
> a client device B would like to join this iommu domain,
> so it call ?iommu_dma_attach_device?. then the device B want to alloc
> the iommu memory, it call ?dma_alloc_attrs? whose first parameter should
> be the ?struct device *?of device A. Is it designed like this in this
> patch?
>      (In arch/arm, ?dev->archdata.dma_ops = &iommu_dma_ops? is in
> ?arm_iommu_attach_devce?;
>       In this patch, this sentence is in ?arch_setup_dma_ops?).
>

At this point there's not really any support for devices managing their 
own IOMMUs - initially I've only been focusing on the case where 
dma-mapping handles everything transparently, with legacy 32-bit 
peripherals in mind. There's already been quite a lot of discussion over 
the shortcomings of the current arch_setup_dma_ops model (most recently, 
[1]), but it just-about-works on Juno where we have a single device 
behind each IOMMU (with the exception of the USB OHCI which falls foul 
of the domain-per-device approach and falls over because it can't 
understand addresses from the EHCI). We really need to get IOMMU groups 
working in order to manage domains properly, which for one thing 
requires fixing the current situation of devices getting attached to a 
domain before they've even been added to the bus. I've started looking 
into that, but I suspect it's going to be long and complicated.

> 3)  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> struct iommu_ops *iommu, bool coherent)
>      In this function, the second and third parameter are the dma address
> base and size, can they work currently?
> (take a example, I set the dma_base is 0, size is 0x40000000 while
> calling arch_setup_dma_ops,
>   then I alloc a range iova whose size is 50*SZ_4K, the return iova is
> 0xfffce000, it is over 0x40000000.)
>

That'll be coming from __alloc_iova using the device's dma_mask as an 
upper limit. Whilst I'm not sure if having fixed translations per 
dma-ranges makes sense with an IOMMU present, there does seem to be a 
valid case for having a size smaller than the driver's dma_mask - e.g. a 
device that just happens to have some upper address lines tied off in a 
particular implementation - so I'll change that to properly respect the 
dma-ranges values.

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/7556/focus=8237
