From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 31 May 2018 14:04:32 +0100
Subject: [PATCH 4/7] iommu/amd: make sure TLB to be flushed before IOVA
 freed
In-Reply-To: <1527752569-18020-5-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
 <1527752569-18020-5-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <ccc47903-d946-13ed-3c68-b264bc44b216@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/18 08:42, Zhen Lei wrote:
> Although the mapping has already been removed in the page table, it maybe
> still exist in TLB. Suppose the freed IOVAs is reused by others before the
> flush operation completed, the new user can not correctly access to its
> meomory.

This change seems reasonable in isolation, but why is it right in the 
middle of a series which has nothing to do with x86?

Robin.

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/amd_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8fb8c73..93aa389 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2402,9 +2402,9 @@ static void __unmap_single(struct dma_ops_domain *dma_dom,
>   	}
>   
>   	if (amd_iommu_unmap_flush) {
> -		dma_ops_free_iova(dma_dom, dma_addr, pages);
>   		domain_flush_tlb(&dma_dom->domain);
>   		domain_flush_complete(&dma_dom->domain);
> +		dma_ops_free_iova(dma_dom, dma_addr, pages);
>   	} else {
>   		pages = __roundup_pow_of_two(pages);
>   		queue_iova(&dma_dom->iovad, dma_addr >> PAGE_SHIFT, pages, 0);
> 
