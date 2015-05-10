From: pullip.cho@samsung.com (Cho KyongHo)
Date: Sun, 10 May 2015 22:01:36 +0900
Subject: [PATCH v6 06/25] iommu: exynos: remove unused functions
In-Reply-To: <1430727380-10912-7-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
 <1430727380-10912-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150510220136.b2f9fe9268d98eceb1e76b6e@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 04 May 2015 10:16:01 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> This patch removes two unneeded functions, which are not a part of
> generic IOMMU API and were never used by any other driver.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/iommu/exynos-iommu.c | 31 -------------------------------
>  1 file changed, 31 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 3861485f0689..98aa7e9c2507 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -496,13 +496,6 @@ static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
>  	return ret;
>  }
>  
> -int exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable)
> -{
> -	BUG_ON(!memblock_is_memory(pgtable));
> -
> -	return __exynos_sysmmu_enable(dev, pgtable, NULL);
> -}
> -
>  static bool exynos_sysmmu_disable(struct device *dev)
>  {
>  	unsigned long flags;
> @@ -594,30 +587,6 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, sysmmu_iova_t iova,
>  	spin_unlock_irqrestore(&data->lock, flags);
>  }
>  
> -void exynos_sysmmu_tlb_invalidate(struct device *dev)
> -{
> -	struct exynos_iommu_owner *owner = dev->archdata.iommu;
> -	unsigned long flags;
> -	struct sysmmu_drvdata *data;
> -
> -	data = dev_get_drvdata(owner->sysmmu);
> -
> -	spin_lock_irqsave(&data->lock, flags);
> -	if (is_sysmmu_active(data)) {
> -		if (!IS_ERR(data->clk_master))
> -			clk_enable(data->clk_master);
> -		if (sysmmu_block(data->sfrbase)) {
> -			__sysmmu_tlb_invalidate(data->sfrbase);
> -			sysmmu_unblock(data->sfrbase);
> -		}
> -		if (!IS_ERR(data->clk_master))
> -			clk_disable(data->clk_master);
> -	} else {
> -		dev_dbg(dev, "disabled. Skipping TLB invalidation\n");
> -	}
> -	spin_unlock_irqrestore(&data->lock, flags);
> -}
> -
>  static int __init exynos_sysmmu_probe(struct platform_device *pdev)
>  {
>  	int irq, ret;


Actually they are for some drivers that are not upstreamed.
But I agree removing them.

Regards,

KyongHo
