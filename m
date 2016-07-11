From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 11 Jul 2016 15:20:11 +0100
Subject: [PATCH v2 3/6] Revert "iommu/arm-smmu: Treat all device
 transactions as unprivileged"
In-Reply-To: <20160709020919.6760-4-mitchelh@codeaurora.org>
References: <20160709020919.6760-1-mitchelh@codeaurora.org>
 <20160709020919.6760-4-mitchelh@codeaurora.org>
Message-ID: <5783AB1B.8000806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/16 03:09, Mitchel Humpherys wrote:
> This reverts commit d346180e70b9 ("iommu/arm-smmu: Treat all device
> transactions as unprivileged") since some platforms actually make use of
> privileged transactions.

Super-nit: I know it makes bog-all difference in reality, but logically
it would be nicer to order this revert _after_ the alternative
functionality is fully in place. I'll tentatively retire the SMMUv3
equivalent[1] I currently have, too.

Robin.

[1]:http://article.gmane.org/gmane.linux.drivers.devicetree/175417

> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 9345a3fcb706..d0627ef26b05 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -178,9 +178,6 @@
>  #define S2CR_TYPE_BYPASS		(1 << S2CR_TYPE_SHIFT)
>  #define S2CR_TYPE_FAULT			(2 << S2CR_TYPE_SHIFT)
>  
> -#define S2CR_PRIVCFG_SHIFT		24
> -#define S2CR_PRIVCFG_UNPRIV		(2 << S2CR_PRIVCFG_SHIFT)
> -
>  /* Context bank attribute registers */
>  #define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))
>  #define CBAR_VMID_SHIFT			0
> @@ -1175,7 +1172,7 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>  		u32 idx, s2cr;
>  
>  		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
> -		s2cr = S2CR_TYPE_TRANS | S2CR_PRIVCFG_UNPRIV |
> +		s2cr = S2CR_TYPE_TRANS |
>  		       (smmu_domain->cfg.cbndx << S2CR_CBNDX_SHIFT);
>  		writel_relaxed(s2cr, gr0_base + ARM_SMMU_GR0_S2CR(idx));
>  	}
> 
