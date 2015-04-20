From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 20 Apr 2015 12:13:34 +0800
Subject: [PATCH 2/2] ARM: DMA: Use vm_pgoff for IOMMU mmap
In-Reply-To: <1429195312-25898-2-git-send-email-orjan.eide@arm.com>
References: <1429195312-25898-1-git-send-email-orjan.eide@arm.com>
 <1429195312-25898-2-git-send-email-orjan.eide@arm.com>
Message-ID: <CAGS+omCONjvt-QJ1ZHQcydAPBT7vUr1TUyXjZG+25BK-j8XMyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ?rjan,

On Thu, Apr 16, 2015 at 10:41 PM, ?rjan Eide <orjan.eide@arm.com> wrote:
> arm_iommu_mmap_attrs() ignores the page offset in vma->vm_pgoff that was
> specified in the mmap call. Any user of dma_mmap_* will get an
> unexpected result when the device uses the IOMMU DMA ops.
>
> Some DRM driver that use dma_mmap_* seems to depend on it ignoring
> vma->vm_pgoff.  Both the Samsung Exynos DRM driver before v3.18, and the
> current Rockchip DRM driver, use the page offset to pass GEM cookies
> that are used to look up the GEM buffers and then call dma_mmap_attrs()
> with the cookie value still in vma->vm_pgoff.
>
> rockchip_gem_mmap_buf() in drivers/gpu/drm/rockchip/rockchip_drm_gem.c
> still does this. It should be fixed before fixing
> arm_iommu_mmap_attrs().
>
> Signed-off-by: ?rjan Eide <orjan.eide@arm.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

I tested this patch on my RK3288 board with the corresponding
rockchip_drm patch [0], and it works.  So, also:
Tested-by: Daniel Kurtz <djkurtz@chromium.org>

[0] https://patchwork.kernel.org/patch/6226591/



> ---
>  arch/arm/mm/dma-mapping.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c274476..07d571b 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1364,6 +1364,9 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>  {
>         unsigned long uaddr = vma->vm_start;
>         unsigned long usize = vma->vm_end - vma->vm_start;
> +       unsigned long nr_vma_pages = usize >> PAGE_SHIFT;
> +       unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
> +       unsigned long off = vma->vm_pgoff;
>         struct page **pages = __iommu_get_pages(cpu_addr, attrs);
>
>         vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
> @@ -1371,6 +1374,11 @@ static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>         if (!pages)
>                 return -ENXIO;
>
> +       if (off >= nr_pages || nr_vma_pages > (nr_pages - off))
> +               return -ENXIO;
> +
> +       pages += off;
> +
>         do {
>                 int ret = vm_insert_page(vma, uaddr, *pages++);
>                 if (ret) {
> --
> 1.9.1
>
