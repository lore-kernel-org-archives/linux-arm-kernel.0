From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 9 Aug 2018 12:06:29 +0100
Subject: [PATCH v4 4/5] iommu/arm-smmu-v3: add support for non-strict mode
In-Reply-To: <1533558424-16748-5-git-send-email-thunder.leizhen@huawei.com>
References: <1533558424-16748-1-git-send-email-thunder.leizhen@huawei.com>
 <1533558424-16748-5-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <94c88d9e-818e-f893-9ee2-7a0cf425bd9a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/18 13:27, Zhen Lei wrote:
> Dynamically choose strict or non-strict mode for page table config based
> on the iommu domain type.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 2f1304b..904bc1e 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1622,6 +1622,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   	if (smmu->features & ARM_SMMU_FEAT_COHERENCY)
>   		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
> 
> +	if (domain->type == IOMMU_DOMAIN_DMA) {
> +		domain->non_strict = 1;
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +	}
> +
>   	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>   	if (!pgtbl_ops)
>   		return -ENOMEM;
> @@ -1782,7 +1787,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
> 
> -	if (smmu)
> +	if (smmu && !domain->non_strict)

That doesn't smell right - even in non-strict domains we still need 
stuff like walk cache invalidations for non-leaf unmaps to be 
synchronous, so we can't just ignore all sync operations at the driver 
level. I think the right thing to do to elide the "normal" sync on unmap 
is to first convert __iommu_dma_unmap to use 
iommu_unmap_fast()/iommu_tlb_sync(), then make it not issue that sync at 
all for non-strict domains.

Robin.

>   		__arm_smmu_tlb_sync(smmu);
>   }
> 
> --
> 1.8.3
> 
> 
