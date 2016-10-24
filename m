From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 24 Oct 2016 12:01:50 +0100
Subject: [PATCH] iommu: arm-smmu-v2: Enable 16 bit ASID
In-Reply-To: <1477112524-13023-1-git-send-email-gakula@caviumnetworks.com>
References: <1477112524-13023-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <565784ce-a740-315d-e4db-5fdbb5a0316e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geetha,

On 22/10/16 06:02, Geetha sowjanya wrote:
>  Support up to 16 bit ASID. This patch enables
>  16 bit ASID when supported.

Why? "Because we can" is not a compelling rationale. I assume this is
actually related to the globally-unique ASID workaround for the TLB
sharing erratum, but if so that should be called out explicitly -
describe the problem being fixed.

> Signed-off-by: Geetha sowjanya <gakula@cavium.com>
> Acked-by: Tirumalesh Chalamarla <Tirumalesh.Chalamarla@cavium.com>
> ---
>  drivers/iommu/arm-smmu.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c841eb7..9740846 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -258,6 +258,9 @@ enum arm_smmu_s2cr_privcfg {
>  #define TTBCR2_SEP_SHIFT		15
>  #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
>  
> +#define TTBCR2_AS_SHIFT			4
> +#define TTBCR2_AS_ENABLE		(1 << TTBCR2_AS_SHIFT)
> +

The style here for single-bit fields is simply:

#define TTBCR2_AS			(1 << 4)

>  #define TTBRn_ASID_SHIFT		48
>  
>  #define FSR_MULTI			(1 << 31)
> @@ -773,6 +776,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>  			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>  			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
>  			reg2 |= TTBCR2_SEP_UPSTREAM;
> +		/* Enable 16 bit ASID if 16 bit VMID is supported */
> +			if (smmu->features & ARM_SMMU_FEAT_VMID16)

This should be a check for AArch64 context format - VMID16 has nothing
to do with it. 16-bit ASID support for stage 1 AArch64 contexts is
already implied by SMMUv2 (TCR2.AS is not optional).

Robin.

> +				reg |= TTBCR2_AS_ENABLE;
>  		}
>  		if (smmu->version > ARM_SMMU_V1)
>  			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
> 
