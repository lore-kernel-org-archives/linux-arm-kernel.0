From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 Mar 2016 12:07:26 -0400
Subject: [PATCH] arm64: dma-mapping: fix dma_to_phys API for IOMMU
 attached devices
In-Reply-To: <56EAD3E2.5070109@arm.com>
References: <1458229833-4886-1-git-send-email-okaya@codeaurora.org>
 <56EAD3E2.5070109@arm.com>
Message-ID: <56EAD63E.2010103@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/17/2016 11:57 AM, Robin Murphy wrote:
>> This patch modifies dma_to_phys to call iommu_iova_to_phys to perform dma
>> to phys conversions for IOMMU attached devices where dma and physical
>> addresses often have distinct values.
> 
> What's this for? dma_to_phys() is only used by SWIOTLB, and that's mutually exclusive with IOMMU ops.

If it is SWIOTLB only, then it needs to disappear from common header file as 
it is doing the wrong thing when IOMMU is enabled for a device. 

I have some device driver (HIDMA) that used dma_to_phys during DMA self test.
I needed this patch to get it working properly. I removed the self test from
my code but I still don't feel right about this dma_to_phys API returning physical
addresses.

> 
> Also, what about phys_to_dma()?

Agreed, need to fix phys_to_dma too.

> 
> Robin.

Let me know which direction I should go. 

1. Fix phys_to_dma and keep dma_to_phys as in the patch.
2. Remove both of the API from header file, move it to where it is needed. Rename them as swio_phys_to_dma etc.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
