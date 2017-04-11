From: julien.grall@arm.com (Julien Grall)
Date: Tue, 11 Apr 2017 13:43:28 +0100
Subject: "Consolidate get_dma_ops" breaks Xen on ARM
In-Reply-To: <CY1PR0401MB1536C1FF3C069BC88D1DB14581000@CY1PR0401MB1536.namprd04.prod.outlook.com>
References: <alpine.DEB.2.10.1704101713080.2759@sstabellini-ThinkPad-X260>
 <CY1PR0401MB1536C1FF3C069BC88D1DB14581000@CY1PR0401MB1536.namprd04.prod.outlook.com>
Message-ID: <a758dfc6-2b00-e279-303c-ba1e27380e35@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bart,

On 11/04/17 02:14, Bart Van Assche wrote:
> On 04/10/17 17:31, Stefano Stabellini wrote:
>> I think the reason is that, as you can see, if (dev && dev->dma_ops),
>> dev->dma_ops is returned, while before this changes, xen_dma_ops was
>> returned on Xen on ARM.
>>
>> Unfortunately DMA cannot work properly without using the appropriate
>> xen_dma_ops. See drivers/xen/swiotlb-xen.c and arch/arm/xen/mm.c for
>> more details. (The problem is easy to spot, but I wasn't CC'ed on the
>> patch.)
>>
>> I don't know how to solve this problem without introducing some sort of
>> if (xen()) in include/linux/dma-mapping.h.
> 
> Sorry but I don't have access to an ARM development system. Does your 
> comment apply to dev == NULL only, dev != NULL only or perhaps to both? 
> If your comment applies to dev != NULL only, can you check whether 
> adding something like set_dma_ops(dev, get_arch_dma_ops(NULL)) to the 
> appropriate ARM arch_setup_dma_ops() function is sufficient?

If I understand correctly, set_dma_ops will replace dev->dma_ops with
Xen DMA ops.

However, Xen DMA ops will need in some places to call the device 
specific DMA ops (see __generic_dma_ops(...)). So I think replacing
dev->dma_ops is not a solution here.

The hackish patch below is fixing the problem for both ARM64 and ARM32.

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 0977317c6835..43a73ddeec7a 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -174,6 +174,8 @@ int dma_mmap_from_coherent(struct device *dev, struct vm_area_struct *vma,
 #include <asm/dma-mapping.h>
 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
+       if (xen_initial_domain())
+              return xen_dma_ops;
        if (dev && dev->dma_ops)
                return dev->dma_ops;
        return get_arch_dma_ops(dev ? dev->bus : NULL);

It is not nice as this is common code, but I can't find a better solution
so far. Any opinions?

Cheers,

-- 
Julien Grall
