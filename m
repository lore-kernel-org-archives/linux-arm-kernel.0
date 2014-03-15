From: grundler@chromium.org (Grant Grundler)
Date: Fri, 14 Mar 2014 23:35:59 -0700
Subject: [PATCH v11 02/27] iommu/exynos: add missing cache flush for
 removed page table entries
In-Reply-To: <20140314140234.c972b52a96a4fe39acd09fe0@samsung.com>
References: <20140314140234.c972b52a96a4fe39acd09fe0@samsung.com>
Message-ID: <CANEJEGvkoUEWoJ4Y5sXwAr2KHW0MESj-1cHQ31AVRasG0P8pzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please apply this. It's way overdue.  It fixes customer kernel crashes
we've seen in the field.

I'd also advocate for seeing this be applied to stable kernels.

thanks,
grant

On Thu, Mar 13, 2014 at 10:02 PM, Cho KyongHo <pullip.cho@samsung.com> wrote:
> This commit adds cache flush for removed small and large page entries
> in exynos_iommu_unmap(). Missing cache flush of removed page table
> entries can cause missing page fault interrupt when a master IP
> accesses an unmapped area.
>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> Tested-by: Grant Grundler <grundler@chromium.org>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 4876d35..1c3a397 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -958,6 +958,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
>         if (lv2ent_small(ent)) {
>                 *ent = 0;
>                 size = SPAGE_SIZE;
> +               pgtable_flush(ent, ent + 1);
>                 priv->lv2entcnt[lv1ent_offset(iova)] += 1;
>                 goto done;
>         }
> @@ -966,6 +967,7 @@ static size_t exynos_iommu_unmap(struct iommu_domain *domain,
>         BUG_ON(size < LPAGE_SIZE);
>
>         memset(ent, 0, sizeof(*ent) * SPAGES_PER_LPAGE);
> +       pgtable_flush(ent, ent + SPAGES_PER_LPAGE);
>
>         size = LPAGE_SIZE;
>         priv->lv2entcnt[lv1ent_offset(iova)] += SPAGES_PER_LPAGE;
> --
> 1.7.9.5
>
