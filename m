From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 14 Dec 2017 16:25:55 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Don't free page table ops twice
In-Reply-To: <20171214110301.2998-1-jean-philippe.brucker@arm.com>
References: <20171214110301.2998-1-jean-philippe.brucker@arm.com>
Message-ID: <561ac686-641d-3f7e-b624-d6edf6291eb7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/17 11:03, Jean-Philippe Brucker wrote:
> Kasan reports a double free when finalise_stage_fn fails: the io_pgtable
> ops are freed by arm_smmu_domain_finalise and then again by
> arm_smmu_domain_free. Prevent this by leaving pgtbl_ops empty on failure.

It might be a tiny bit more consistent to simply clear the domain ops 
again upon failure (cf. how arm_smmu_attach_dev() treats 
smmu_domain->smmu), but I'm sure nobody really cares that much:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index f122071688fd..db4281d0e269 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1698,13 +1698,15 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
>   	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
>   	domain->geometry.aperture_end = (1UL << ias) - 1;
>   	domain->geometry.force_aperture = true;
> -	smmu_domain->pgtbl_ops = pgtbl_ops;
>   
>   	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
> -	if (ret < 0)
> +	if (ret < 0) {
>   		free_io_pgtable_ops(pgtbl_ops);
> +		return ret;
> +	}
>   
> -	return ret;
> +	smmu_domain->pgtbl_ops = pgtbl_ops;
> +	return 0;
>   }
>   
>   static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
> 
