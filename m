From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Mar 2017 14:54:43 +0200
Subject: [PATCH] arm64/dma-mapping: fix DMA_ATTR_FORCE_CONTIGUOUS mmaping
 code
In-Reply-To: <1490781926-6209-1-git-send-email-a.hajda@samsung.com>
References: <CGME20170329100540eucas1p22d428e33aa678cbef0a24dd249820451@eucas1p2.samsung.com>
 <1490781926-6209-1-git-send-email-a.hajda@samsung.com>
Message-ID: <CAMuHMdXfSdD3EXsm4AgA0R0jE9563jSUxzm40yfjkeUc4rhaLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On Wed, Mar 29, 2017 at 12:05 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> In case of DMA_ATTR_FORCE_CONTIGUOUS allocations vm_area->pages
> is invalid. __iommu_mmap_attrs and __iommu_get_sgtable cannot use
> it. In first case temporary pages array is passed to iommu_dma_mmap,
> in 2nd case single entry sg table is created directly instead
> of calling helper.
>
> Fixes: 44176bb ("arm64: Add support for DMA_ATTR_FORCE_CONTIGUOUS to IOMMU")
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
> Hi,
>
> I am not familiar with this framework so please don't be too cruel ;)
> Alternative solution I see is to always create vm_area->pages,
> I do not know which approach is preferred.
>
> Regards
> Andrzej
> ---
>  arch/arm64/mm/dma-mapping.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index f7b5401..bba2bc8 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -704,7 +704,30 @@ static int __iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>                 return ret;
>
>         area = find_vm_area(cpu_addr);
> -       if (WARN_ON(!area || !area->pages))
> +       if (WARN_ON(!area))
> +               return -ENXIO;
> +
> +       if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +               struct page *page = vmalloc_to_page(cpu_addr);
> +               unsigned int count = size >> PAGE_SHIFT;
> +               struct page **pages;
> +               unsigned long pfn;
> +               int i;
> +
> +               pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL);
> +               if (!pages)
> +                       return -ENOMEM;
> +
> +               for (i = 0, pfn = page_to_pfn(page); i < count; i++)
> +                       pages[i] = pfn_to_page(pfn + i);

If we're gonna allocate and set up such an array over and over again
(dma_common_contiguous_remap() has already done the same), we may as well
just keep the initial array.

Hence replace the call to dma_common_contiguous_remap() in
__iommu_alloc_attrs() by an open coded version that doesn't free the pages,
and handle the other operations like the !DMA_ATTR_FORCE_CONTIGUOUS
case.

> +
> +               ret = iommu_dma_mmap(pages, size, vma);
> +               kfree(pages);
> +
> +               return ret;
> +       }
> +
> +       if (WARN_ON(!area->pages))
>                 return -ENXIO;
>
>         return iommu_dma_mmap(area->pages, size, vma);
> @@ -717,7 +740,20 @@ static int __iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
>         unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>         struct vm_struct *area = find_vm_area(cpu_addr);
>
> -       if (WARN_ON(!area || !area->pages))
> +       if (WARN_ON(!area))
> +               return -ENXIO;
> +
> +       if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
> +               int ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +
> +               if (!ret)
> +                       sg_set_page(sgt->sgl, vmalloc_to_page(cpu_addr),
> +                               PAGE_ALIGN(size), 0);
> +
> +               return ret;
> +       }
> +
> +       if (WARN_ON(!area->pages))
>                 return -ENXIO;
>
>         return sg_alloc_table_from_pages(sgt, area->pages, count, 0, size,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
