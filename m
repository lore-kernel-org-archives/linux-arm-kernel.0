From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 31 May 2018 14:03:42 +0100
Subject: [PATCH 1/7] iommu/dma: fix trival coding style mistake
In-Reply-To: <1527752569-18020-2-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <1527752569-18020-2-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <b473059d-fee6-1627-4749-192771038741@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/18 08:42, Zhen Lei wrote:
> The static function iova_reserve_iommu_regions is only called by function
> iommu_dma_init_domain, and the 'if (!dev)' check in iommu_dma_init_domain
> affect it only, so we can safely move the check into it. I think it looks
> more natural.

As before, I disagree - the logic of iommu_dma_init_domain() is "we 
expect to have a valid device, but stop here if we don't", and moving 
the check just needlessly obfuscates that. It is not a coincidence that 
the arguments of both functions are in effective order of importance.

> In addition, the local variable 'ret' is only assigned in the branch of
> 'if (region->type == IOMMU_RESV_MSI)', so the 'if (ret)' should also only
> take effect in the branch, add a brace to enclose it.

'ret' is clearly also assigned at its declaration, to cover the (very 
likely) case where we don't enter the loop at all. Thus testing it in 
the loop is harmless, and cluttering that up with extra tabs and braces 
is just noise.

Robin.

> No functional changes.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/dma-iommu.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index ddcbbdb..4e885f7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -231,6 +231,9 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	LIST_HEAD(resv_regions);
>   	int ret = 0;
>   
> +	if (!dev)
> +		return 0;
> +
>   	if (dev_is_pci(dev))
>   		iova_reserve_pci_windows(to_pci_dev(dev), iovad);
>   
> @@ -246,11 +249,12 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   		hi = iova_pfn(iovad, region->start + region->length - 1);
>   		reserve_iova(iovad, lo, hi);
>   
> -		if (region->type == IOMMU_RESV_MSI)
> +		if (region->type == IOMMU_RESV_MSI) {
>   			ret = cookie_init_hw_msi_region(cookie, region->start,
>   					region->start + region->length);
> -		if (ret)
> -			break;
> +			if (ret)
> +				break;
> +		}
>   	}
>   	iommu_put_resv_regions(dev, &resv_regions);
>   
> @@ -308,8 +312,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> -	if (!dev)
> -		return 0;
>   
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
> 
