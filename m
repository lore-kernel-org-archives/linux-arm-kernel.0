From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 7 Feb 2017 16:03:02 +0800
Subject: [PATCH 1/4] drm/rockchip: Do not use DMA mapping API if attached
 to IOMMU domain
In-Reply-To: <CAAFQd5AJRg3LXWuiv_bB+q+JXcgq5phOzjR=zcadc7tb4ewboA@mail.gmail.com>
References: <1486447776-30543-1-git-send-email-mark.yao@rock-chips.com>
 <1486447776-30543-2-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5AJRg3LXWuiv_bB+q+JXcgq5phOzjR=zcadc7tb4ewboA@mail.gmail.com>
Message-ID: <58997F36.50007@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?02?07? 14:53, Tomasz Figa wrote:
> Hi Mark,
>
> Thanks for reviving this series and sorry for not taking care of it
> myself. Please see some comments inline.

Hi Tomasz

Thanks for review,

I will add the patches you mentioned  into v2 version.

>
> On Tue, Feb 7, 2017 at 3:09 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
>> From: Tomasz Figa <tfiga@chromium.org>
>>
>> The API is not suitable for subsystems consisting of multiple devices
>> and requires severe hacks to use it. To mitigate this, this patch
>> implements allocation and address space management locally by using
>> helpers provided by DRM framework, like other DRM drivers do, e.g.
>> Tegra.
>>
>> This patch should not introduce any functional changes until the driver
>> is made to attach subdevices into an IOMMU domain with the generic IOMMU
>> API, which will happen in following patch. Based heavily on GEM
>> implementation of Tegra DRM driver.
>>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
>> Acked-by: Mark Yao <mark.yao@rock-chips.com>
> I believe you need your Signed-off-by here.
>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |   4 +-
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 217 ++++++++++++++++++++++++++--
>>   drivers/gpu/drm/rockchip/rockchip_drm_gem.h |   8 +
>>   3 files changed, 219 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> index fb6226c..7c123d9 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
>> @@ -30,6 +30,7 @@
>>
>>   struct drm_device;
>>   struct drm_connector;
>> +struct iommu_domain;
>>
>>   /*
>>    * Rockchip drm private crtc funcs.
>> @@ -60,7 +61,8 @@ struct rockchip_drm_private {
>>          struct drm_gem_object *fbdev_bo;
>>          const struct rockchip_crtc_funcs *crtc_funcs[ROCKCHIP_MAX_CRTC];
>>          struct drm_atomic_state *state;
>> -
>> +       struct iommu_domain *domain;
>> +       struct drm_mm mm;
>>          struct list_head psr_list;
>>          spinlock_t psr_list_lock;
>>   };
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>> index b70f942..5209392 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
>> @@ -16,11 +16,135 @@
>>   #include <drm/drmP.h>
>>   #include <drm/drm_gem.h>
>>   #include <drm/drm_vma_manager.h>
>> +#include <linux/iommu.h>
>>
>>   #include "rockchip_drm_drv.h"
>>   #include "rockchip_drm_gem.h"
>>
>> -static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
>> +static int rockchip_gem_iommu_map(struct rockchip_gem_object *rk_obj)
>> +{
>> +       struct drm_device *drm = rk_obj->base.dev;
>> +       struct rockchip_drm_private *private = drm->dev_private;
>> +       int prot = IOMMU_READ | IOMMU_WRITE;
>> +       ssize_t ret;
>> +
>> +       ret = drm_mm_insert_node_generic(&private->mm, &rk_obj->mm,
>> +                                        rk_obj->base.size, PAGE_SIZE,
>> +                                        0, 0);
>> +       if (ret < 0) {
>> +               DRM_ERROR("out of I/O virtual memory: %zd\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       rk_obj->dma_addr = rk_obj->mm.start;
>> +
>> +       ret = iommu_map_sg(private->domain, rk_obj->dma_addr, rk_obj->sgt->sgl,
>> +                          rk_obj->sgt->nents, prot);
>> +       if (ret < 0) {
>> +               DRM_ERROR("failed to map buffer: %zd\n", ret);
>> +               goto err_remove_node;
>> +       }
>> +
>> +       rk_obj->size = ret;
>> +
>> +       return 0;
>> +
>> +err_remove_node:
>> +       drm_mm_remove_node(&rk_obj->mm);
>> +
>> +       return ret;
>> +}
>> +
>> +static int rockchip_gem_iommu_unmap(struct rockchip_gem_object *rk_obj)
>> +{
>> +       struct drm_device *drm = rk_obj->base.dev;
>> +       struct rockchip_drm_private *private = drm->dev_private;
>> +
>> +       iommu_unmap(private->domain, rk_obj->dma_addr, rk_obj->size);
>> +       drm_mm_remove_node(&rk_obj->mm);
>> +
>> +       return 0;
>> +}
>> +
>> +static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
>> +{
>> +       struct drm_device *drm = rk_obj->base.dev;
>> +       int ret, i;
>> +       struct scatterlist *s;
>> +
>> +       rk_obj->pages = drm_gem_get_pages(&rk_obj->base);
>> +       if (IS_ERR(rk_obj->pages))
>> +               return PTR_ERR(rk_obj->pages);
>> +
>> +       rk_obj->num_pages = rk_obj->base.size >> PAGE_SHIFT;
>> +
>> +       rk_obj->sgt = drm_prime_pages_to_sg(rk_obj->pages, rk_obj->num_pages);
>> +       if (IS_ERR(rk_obj->sgt)) {
>> +               ret = PTR_ERR(rk_obj->sgt);
>> +               goto err_put_pages;
>> +       }
>> +
>> +       /*
>> +        * Fake up the SG table so that dma_sync_sg_for_device() can be used
>> +        * to flush the pages associated with it.
>> +        *
>> +        * TODO: Replace this by drm_clflush_sg() once it can be implemented
>> +        * without relying on symbols that are not exported.
>> +        */
>> +       for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
>> +               sg_dma_address(s) = sg_phys(s);
>> +
>> +       dma_sync_sg_for_device(drm->dev, rk_obj->sgt->sgl, rk_obj->sgt->nents,
>> +                              DMA_TO_DEVICE);
>> +
>> +       return 0;
>> +
>> +err_put_pages:
>> +       drm_gem_put_pages(&rk_obj->base, rk_obj->pages, false, false);
>> +       return ret;
>> +}
>> +
>> +static void rockchip_gem_put_pages(struct rockchip_gem_object *rk_obj)
>> +{
>> +       sg_free_table(rk_obj->sgt);
>> +       kfree(rk_obj->sgt);
>> +       drm_gem_put_pages(&rk_obj->base, rk_obj->pages, false, false);
> We need to call drm_gem_put_pages with two last arguments true, not
> false, because we don't have any way of tracking the accesses, so we
> need to assume the page was both accessed and dirty. See
> https://chromium-review.googlesource.com/382934.
>
>> +}
>> +
>> +static int rockchip_gem_alloc_iommu(struct rockchip_gem_object *rk_obj,
>> +                                   bool alloc_kmap)
>> +{
>> +       int ret;
>> +
>> +       ret = rockchip_gem_get_pages(rk_obj);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       ret = rockchip_gem_iommu_map(rk_obj);
>> +       if (ret < 0)
>> +               goto err_free;
>> +
>> +       if (alloc_kmap) {
>> +               rk_obj->kvaddr = vmap(rk_obj->pages, rk_obj->num_pages, VM_MAP,
>> +                                     pgprot_writecombine(PAGE_KERNEL));
>> +               if (!rk_obj->kvaddr) {
>> +                       DRM_ERROR("failed to vmap() buffer\n");
>> +                       ret = -ENOMEM;
>> +                       goto err_unmap;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +err_unmap:
>> +       rockchip_gem_iommu_unmap(rk_obj);
>> +err_free:
>> +       rockchip_gem_put_pages(rk_obj);
>> +
>> +       return ret;
>> +}
>> +
>> +static int rockchip_gem_alloc_dma(struct rockchip_gem_object *rk_obj,
>>                                    bool alloc_kmap)
>>   {
>>          struct drm_gem_object *obj = &rk_obj->base;
>> @@ -42,7 +166,27 @@ static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
>>          return 0;
>>   }
>>
>> -static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
>> +static int rockchip_gem_alloc_buf(struct rockchip_gem_object *rk_obj,
>> +                                 bool alloc_kmap)
>> +{
>> +       struct drm_gem_object *obj = &rk_obj->base;
>> +       struct drm_device *drm = obj->dev;
>> +       struct rockchip_drm_private *private = drm->dev_private;
>> +
>> +       if (private->domain)
>> +               return rockchip_gem_alloc_iommu(rk_obj, alloc_kmap);
>> +       else
>> +               return rockchip_gem_alloc_dma(rk_obj, alloc_kmap);
>> +}
>> +
>> +static void rockchip_gem_free_iommu(struct rockchip_gem_object *rk_obj)
>> +{
>> +       vunmap(rk_obj->kvaddr);
>> +       rockchip_gem_iommu_unmap(rk_obj);
>> +       rockchip_gem_put_pages(rk_obj);
>> +}
>> +
>> +static void rockchip_gem_free_dma(struct rockchip_gem_object *rk_obj)
>>   {
>>          struct drm_gem_object *obj = &rk_obj->base;
>>          struct drm_device *drm = obj->dev;
>> @@ -51,23 +195,64 @@ static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
>>                         rk_obj->dma_attrs);
>>   }
>>
>> -static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
>> -                                       struct vm_area_struct *vma)
>> +static void rockchip_gem_free_buf(struct rockchip_gem_object *rk_obj)
>> +{
>> +       if (rk_obj->pages)
>> +               rockchip_gem_free_iommu(rk_obj);
>> +       else
>> +               rockchip_gem_free_dma(rk_obj);
>> +}
>>
>> +static int rockchip_drm_gem_object_mmap_iommu(struct drm_gem_object *obj,
>> +                                             struct vm_area_struct *vma)
>>   {
>> +       struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
>> +       unsigned int i, count = obj->size >> PAGE_SHIFT;
>> +       unsigned long user_count = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +       unsigned long uaddr = vma->vm_start;
>>          int ret;
>> +
>> +       if (user_count == 0 || user_count > count)
>> +               return -ENXIO;
>> +
>> +       for (i = 0; i < user_count; i++) {
> Even though DRM mmap doesn't support page offset, we need to respect
> it here for PRIME/DMA-buf mmap. See
> https://chromium-review.googlesource.com/386477.
>
>> +               ret = vm_insert_page(vma, uaddr, rk_obj->pages[i]);
>> +               if (ret)
>> +                       return ret;
>> +               uaddr += PAGE_SIZE;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int rockchip_drm_gem_object_mmap_dma(struct drm_gem_object *obj,
>> +                                           struct vm_area_struct *vma)
>> +{
>>          struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
>>          struct drm_device *drm = obj->dev;
>>
>> +       return dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
>> +                             obj->size, rk_obj->dma_attrs);
>> +}
>> +
>> +static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
>> +                                       struct vm_area_struct *vma)
>> +{
>> +       int ret;
>> +       struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
>> +
>>          /*
>> -        * dma_alloc_attrs() allocated a struct page table for rk_obj, so clear
>> +        * We allocated a struct page table for rk_obj, so clear
>>           * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
>>           */
>>          vma->vm_flags &= ~VM_PFNMAP;
>>          vma->vm_pgoff = 0;
>>
>> -       ret = dma_mmap_attrs(drm->dev, vma, rk_obj->kvaddr, rk_obj->dma_addr,
>> -                            obj->size, rk_obj->dma_attrs);
>> +       if (rk_obj->pages)
>> +               ret = rockchip_drm_gem_object_mmap_iommu(obj, vma);
>> +       else
>> +               ret = rockchip_drm_gem_object_mmap_dma(obj, vma);
>> +
>>          if (ret)
>>                  drm_gem_vm_close(vma);
>>
>> @@ -117,7 +302,7 @@ struct rockchip_gem_object *
>>
>>          obj = &rk_obj->base;
>>
>> -       drm_gem_private_object_init(drm, obj, size);
>> +       drm_gem_object_init(drm, obj, size);
> In error path of this function and in all functions that destroy the
> GEM we need to call drm_gem_object_release(), as it's the counterpart
> to drm_gem_object_init(). See
> https://chromium-review.googlesource.com/385456.
>
> Best regards,
> Tomasz
>
>
>


-- 
?ark Yao
