From: yalin.wang2010@gmail.com (yalin wang)
Date: Fri, 15 May 2015 20:03:29 +0800
Subject: [PATCH] drm/ttm: dma: Don't crash on memory in the vmalloc range
In-Reply-To: <1431673794-16169-1-git-send-email-acourbot@nvidia.com>
References: <1431673794-16169-1-git-send-email-acourbot@nvidia.com>
Message-ID: <CAFP4FLrdOj0vs5ufNNcmA-pio14VUO3z_w73Q-+QNCmOAdTrWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-15 15:09 GMT+08:00 Alexandre Courbot <acourbot@nvidia.com>:
> dma_alloc_coherent() can return memory in the vmalloc range.
> virt_to_page() cannot handle such addresses and crashes. This
> patch detects such cases and obtains the struct page * using
> vmalloc_to_page() instead.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> This patch is a follow-up of the following discussion:
>
> https://www.marc.info/?l=dri-devel&m=141579595431254&w=3
>
> It works for me on both 32-bit and 64-bit Tegra, so I am not convinced
> that Thierry's initial change from virt_to_page() to phys_to_page() is
> still required - Thierry, can you confirm whether your patch is still
> relevant after this one?
>
>  drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> index 01e1d27eb078..3077f1554099 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> @@ -342,9 +342,12 @@ static struct dma_page *__ttm_dma_alloc_page(struct dma_pool *pool)
>         d_page->vaddr = dma_alloc_coherent(pool->dev, pool->size,
>                                            &d_page->dma,
>                                            pool->gfp_flags);
> -       if (d_page->vaddr)
> -               d_page->p = virt_to_page(d_page->vaddr);
> -       else {
> +       if (d_page->vaddr) {
> +               if (is_vmalloc_addr(d_page->vaddr))
> +                       d_page->p = vmalloc_to_page(d_page->vaddr);
> +               else
> +                       d_page->p = virt_to_page(d_page->vaddr);
> +       } else {
>                 kfree(d_page);
>                 d_page = NULL;
>         }
> --
> 2.4.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

for  safe , i think we can add this patch:


diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45..3463f4f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -77,7 +77,8 @@
  * private definitions which should NOT be used outside memory.h
  * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
  */
-#define __virt_to_phys(x) (((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET))
+#define __virt_to_phys(x) ({BUG_ON(x < PAGE_OFFSET);\
+ (phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET;})
 #define __phys_to_virt(x) ((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))

 /*


BRs
Yalin
