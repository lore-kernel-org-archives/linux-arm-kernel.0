From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 28 Aug 2012 23:58:48 +0200
Subject: [PATCH 4/4] ARM: dma-mapping: Skip cache maint for invalid page
In-Reply-To: <1346154232-13299-4-git-send-email-hdoyu@nvidia.com>
References: <1346154232-13299-1-git-send-email-hdoyu@nvidia.com>
 <1346154232-13299-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <503D3F18.7070507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 8/28/2012 1:43 PM, Hiroshi Doyu wrote:

> Skip cache maint for invalid page but warn it.
>
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>   arch/arm/mm/dma-mapping.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 2621282..0368702 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1589,6 +1589,9 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
>   	if (!iova)
>   		return;
>
> +	if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> +		return;
> +
>   	if (!dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
>   		__dma_page_dev_to_cpu(page, offset, size, dir);
>
> @@ -1607,6 +1610,9 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
>   	if (!iova)
>   		return;
>
> +	if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> +		return;
> +
>   	__dma_page_dev_to_cpu(page, offset, size, dir);
>   }
>
> @@ -1621,6 +1627,9 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
>   	if (!iova)
>   		return;
>
> +	if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> +		return;
> +
>   	__dma_page_cpu_to_dev(page, offset, size, dir);
>   }

I really wonder what has happened in your system that you require
such paranoid checks. All of the above functions are called on the
scatter-list which has been first passed to dma_map_sg(). IMHO it
makes much more sense to add a pfn_valid() check in dma_map_sg()
and return error if the provided scatter list is not valid instead
of these WARN_ONs.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
