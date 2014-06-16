From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jun 2014 16:04:03 +0100
Subject: [RFC PATCH v6 01/20] iommu/arm-smmu: change IOMMU_EXEC to
 IOMMU_NOEXEC
In-Reply-To: <1401987808-23596-2-git-send-email-a.motakis@virtualopensystems.com>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-2-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <20140616150403.GO16758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 06:03:09PM +0100, Antonios Motakis wrote:
> Exposing the XN flag of the SMMU driver as IOMMU_NOEXEC instead of
> IOMMU_EXEC makes it enforceable, since for IOMMUs that don't support
> the XN flag pages will always be executable.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  include/linux/iommu.h    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 647c3c7..d5a2200 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1294,7 +1294,7 @@ static int arm_smmu_alloc_init_pte(struct arm_smmu_device *smmu, pmd_t *pmd,
>  	}
>  
>  	/* If no access, create a faulting entry to avoid TLB fills */
> -	if (prot & IOMMU_EXEC)
> +	if (!(prot & IOMMU_NOEXEC))
>  		pteval &= ~ARM_SMMU_PTE_XN;

It's probably simpler to change the logic so that we initialise pteval
without XN set, then set it if IOMMU_NOEXEC is set (rather than set it
by default, then clear it if NOEXEC is not set).

Will
