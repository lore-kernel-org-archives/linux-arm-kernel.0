From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Jan 2018 11:45:14 +0000
Subject: [PATCH v2] iommu/arm-smmu-v3: limit reporting of MSI allocation
 failures
In-Reply-To: <1516471684-25052-1-git-send-email-nwatters@codeaurora.org>
References: <1516471684-25052-1-git-send-email-nwatters@codeaurora.org>
Message-ID: <39eee30e-1298-24d5-926b-9cd7fe532e59@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/18 18:08, Nate Watterson wrote:
> Currently, the arm-smmu-v3 driver expects to allocate MSIs for all SMMUs
> with FEAT_MSI set. This results in unwarranted "failed to allocate MSIs"
> warnings being printed on systems where FW was either deliberately
> configured to force the use of SMMU wired interrupts -or- is altogether
> incapable of describing SMMU MSI topology (ACPI IORT prior to rev.C).
> 
> Remedy this by checking msi_domain before attempting to allocate SMMU
> MSIs.
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 744592d..00de028 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2328,10 +2328,15 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
>  		return;
>  
> +	if (!dev->msi_domain) {
> +		dev_info(smmu->dev, "msi_domain absent - falling back to wired irqs\n");
> +		return;
> +	}
> +
>  	/* Allocate MSIs for evtq, gerror and priq. Ignore cmdq */
>  	ret = platform_msi_domain_alloc_irqs(dev, nvec, arm_smmu_write_msi_msg);
>  	if (ret) {
> -		dev_warn(dev, "failed to allocate MSIs\n");
> +		dev_warn(dev, "failed to allocate MSIs - falling back to wired irqs\n");
>  		return;
>  	}
>  
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
