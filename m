From: thunder.leizhen@huawei.com (leizhen)
Date: Wed, 9 Jul 2014 14:36:39 +0800
Subject: [PATCH 5/5] iommu/arm-smmu: prefer stage-1 mappings where we
 have a choice
In-Reply-To: <1404125530-17984-6-git-send-email-will.deacon@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
 <1404125530-17984-6-git-send-email-will.deacon@arm.com>
Message-ID: <53BCE2F7.2070407@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/6/30 18:52, Will Deacon wrote:
> For an SMMU that supports both Stage-1 and Stage-2 mappings (but not
> nested translation), then we should prefer stage-1 mappings as we
> otherwise rely on the memory attributes of the incoming transactions
> for IOMMU_CACHE mappings.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 60986de3ada8..a6e38982d09c 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -876,12 +876,12 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>  		 */
>  		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
>  		start = smmu->num_s2_context_banks;
> -	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S2) {
> -		cfg->cbar = CBAR_TYPE_S2_TRANS;
> -		start = 0;
> -	} else {
> +	} else if (smmu->features & ARM_SMMU_FEAT_TRANS_S1) {
>  		cfg->cbar = CBAR_TYPE_S1_TRANS_S2_BYPASS;
>  		start = smmu->num_s2_context_banks;
> +	} else {
> +		cfg->cbar = CBAR_TYPE_S2_TRANS;
> +		start = 0;
>  	}
>  
>  	ret = __arm_smmu_alloc_bitmap(smmu->context_map, start,
> 
Why not change ARM_SMMU_FEAT_TRANS_NESTED to ARM_SMMU_FEAT_TRANS_S1 in the
former if stagement? Then we can merge the two branches, actually it is the
same. NESTED means both S1 and S2.

thunder
