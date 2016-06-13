From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 13 Jun 2016 11:39:26 +0100
Subject: [PATCH v2 6/7] iommu/rockchip: use DMA API to map, to flush cache
In-Reply-To: <575E834C.30305@gmail.com>
References: <1465392392-2003-1-git-send-email-zhengsq@rock-chips.com>
 <1465392392-2003-7-git-send-email-zhengsq@rock-chips.com>
 <CAAFQd5Da+Eg=eiRUgLSS_qPjGbG474KYWDC=GaAMS8A_CuQ3Mg@mail.gmail.com>
 <575E834C.30305@gmail.com>
Message-ID: <575E8D5E.9090400@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/16 10:56, Shunqian Zheng wrote:
> Hi
>
> On 2016?06?10? 17:10, Tomasz Figa wrote:
>> Hi,
>>
>> On Wed, Jun 8, 2016 at 10:26 PM, Shunqian Zheng
>> <zhengsq@rock-chips.com> wrote:
>>> Use DMA API instead of architecture internal functions like
>>> __cpuc_flush_dcache_area() etc.
>>>
>>> To support the virtual device like DRM the virtual slave iommu
>>> added in the previous patch, attaching to which the DRM can use
>>> it own domain->dev for dma_map_*(), dma_sync_*() even VOP is disabled.
>>>
>>> With this patch, this driver is available for ARM64 like RK3399.
>>>
>> Could we instead simply allocate coherent memory for page tables using
>> dma_alloc_coherent() and skip any flushing on CPU side completely? If
>> I'm looking correctly, the driver only reads back the page directory
>> when checking if there is a need to allocate new page table, so there
>> shouldn't be any significant penalty for disabling the cache.
> I try to use dma_alloc_coherent() to replace the dma_map_single(),
> but it doesn't work for me properly.
> Because the DRM uses the iommu_dma_ops instead the swiotlb_dma_ops after
> attaching
> to iommu, so when the iommu domain need to alloc a new page in
> rk_iommu_map(),
> it would call:
> rk_iommu_map()  --> dma_alloc_coherent()  --> ops->alloc()  -->
> iommu_map() --> rk_iommu_map()

That sounds more like you're passing the wrong device around somewhere, 
since this approach is working fine for other IOMMUs; specifically, the 
flow goes:

dma_alloc_coherent(DRM dev)   // for buffer
--> ops->alloc(DRM dev)
     --> iommu_dma_alloc(DRM dev)
         --> iommu_map()
             --> dma_alloc_coherent(IOMMU dev)  // for pagetable
                 --> ops->alloc(IOMMU dev)
                     --> swiotlb_alloc(IOMMU dev)

There shouldn't be any need for this "virtual IOMMU" at all. I think the 
Exynos DRM driver is in a similar situation of having multiple devices 
(involving multiple IOMMUs) backing the virtual DRM device, and that 
doesn't seem to be doing anything this crazy so it's probably worth 
taking a look at.

Robin.

> Then I try to reserve memory for coherent so that, dma_alloc_coherent()
> calls dma_alloc_from_coherent()
> but not ops->alloc(). But it doesn't work too because when DRM request
> buffer it never uses iommu.
>>
>> Other than that, please see some comments inline.
>>
>>> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
>>> ---
>>>   drivers/iommu/rockchip-iommu.c | 113
>>> ++++++++++++++++++++++++++---------------
>>>   1 file changed, 71 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/iommu/rockchip-iommu.c
>>> b/drivers/iommu/rockchip-iommu.c
>>> index d6c3051..aafea6e 100644
>>> --- a/drivers/iommu/rockchip-iommu.c
>>> +++ b/drivers/iommu/rockchip-iommu.c
>>> @@ -4,8 +4,6 @@
>>>    * published by the Free Software Foundation.
>>>    */
>>>
>>> -#include <asm/cacheflush.h>
>>> -#include <asm/pgtable.h>
>>>   #include <linux/compiler.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/device.h>
>>> @@ -61,8 +59,7 @@
>>>   #define RK_MMU_IRQ_BUS_ERROR     0x02  /* bus read error */
>>>   #define RK_MMU_IRQ_MASK          (RK_MMU_IRQ_PAGE_FAULT |
>>> RK_MMU_IRQ_BUS_ERROR)
>>>
>>> -#define NUM_DT_ENTRIES 1024
>>> -#define NUM_PT_ENTRIES 1024
>>> +#define NUM_TLB_ENTRIES 1024 /* for both DT and PT */
>> Is it necessary to change this in this patch? In general, it's not a
>> good idea to mix multiple logical changes together.
> Sure, will restore changes in v3.
>>
>>>   #define SPAGE_ORDER 12
>>>   #define SPAGE_SIZE (1 << SPAGE_ORDER)
>>> @@ -82,7 +79,9 @@
>>>
>>>   struct rk_iommu_domain {
>>>          struct list_head iommus;
>>> +       struct device *dev;
>>>          u32 *dt; /* page directory table */
>>> +       dma_addr_t dt_dma;
>>>          spinlock_t iommus_lock; /* lock for iommus list */
>>>          spinlock_t dt_lock; /* lock for modifying page directory
>>> table */
>>>
>>> @@ -98,14 +97,12 @@ struct rk_iommu {
>>>          struct iommu_domain *domain; /* domain to which iommu is
>>> attached */
>>>   };
>>>
>>> -static inline void rk_table_flush(u32 *va, unsigned int count)
>>> +static inline void rk_table_flush(struct device *dev, dma_addr_t dma,
>>> +                                 unsigned int count)
>>>   {
>>> -       phys_addr_t pa_start = virt_to_phys(va);
>>> -       phys_addr_t pa_end = virt_to_phys(va + count);
>>> -       size_t size = pa_end - pa_start;
>>> +       size_t size = count * 4;
>> It would be a good idea to specify what "count" is. I'm a bit confused
>> that before it meant bytes and now some multiple of 4?
> "count" means PT/DT entry count to flush here. I would add some more
> comment on it.
>
> Thank you very much,
> Shunqian
>>
>> Best regards,
>> Tomasz
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
