From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 Mar 2016 12:36:28 -0400
Subject: [PATCH] arm64: dma-mapping: fix dma_to_phys API for IOMMU
 attached devices
In-Reply-To: <3165610.Gdh8F6ejPI@wuerfel>
References: <1458229833-4886-1-git-send-email-okaya@codeaurora.org>
 <56EAD3E2.5070109@arm.com> <56EAD63E.2010103@codeaurora.org>
 <3165610.Gdh8F6ejPI@wuerfel>
Message-ID: <56EADD0C.4040201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 12:14 PM, Arnd Bergmann wrote:
> On Thursday 17 March 2016 12:07:26 Sinan Kaya wrote:
>> On 3/17/2016 11:57 AM, Robin Murphy wrote:
>>
>> Let me know which direction I should go. 
>>
>> 1. Fix phys_to_dma and keep dma_to_phys as in the patch.
>> 2. Remove both of the API from header file, move it to where it is needed. Rename them as swio_phys_to_dma etc.
> 
> Use 2.
> 
> It has been a long way to remove all virt_to_bus/bus_to_virt users
> from the common architectures, we are not putting them back under
> a different name.
> 
> Drivers already know the physical address because that is what they
> put into dma_map_*() in the first place.
> 
> 	Arnd
> 

The first solution that comes to my mind is to implement a weak function in
swiotlb.c with these contents

dma_addr_t __weak swio_phys_to_dma(struct device *dev, phys_addr_t paddr)
{
        return paddr;
}

 
phys_addr_t __weak  swio_dma_to_phys(struct device *dev, dma_addr_t daddr)
{
        return daddr;
}

then clean up all the duplicates in dma-mapping.h for all ARCHs that have
identical code. 

For others move the implementation to some source file.


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
