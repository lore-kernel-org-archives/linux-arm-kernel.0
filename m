From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Mar 2018 16:00:47 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Set GBPA to abort all transactions
In-Reply-To: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
References: <1522247980-31892-1-git-send-email-timur@codeaurora.org>
Message-ID: <3350f0eb84c8c621cf43aa06ed117cfb@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-28 15:39, Timur Tabi wrote:
> From: Sameer Goel <sgoel@codeaurora.org>
>
> Set SMMU_GBPA to abort all incoming translations during the SMMU 
> reset
> when SMMUEN==0.
>
> This prevents a race condition where a stray DMA from the crashed 
> primary
> kernel can try to access an IOVA address as an invalid PA when SMMU 
> is
> disabled during reset in the crash kernel.
>
> Signed-off-by: Sameer Goel <sgoel@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c 
> b/drivers/iommu/arm-smmu-v3.c
> index 3f2f1fc68b52..c04a89310c59 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2458,6 +2458,18 @@ static int arm_smmu_device_reset(struct
> arm_smmu_device *smmu, bool bypass)
>  	if (reg & CR0_SMMUEN)
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
>
> +	/*
> +	 * Abort all incoming translations. This can happen in a kdump case
> +	 * where SMMU is initialized when a prior DMA is pending. Just
> +	 * disabling the SMMU in this case might result in writes to 
> invalid
> +	 * PAs.
> +	 */
> +	ret = arm_smmu_update_gbpa(smmu, 1, GBPA_ABORT);
> +	if (ret) {
> +		dev_err(smmu->dev, "GBPA not responding to update\n");
> +		return ret;
> +	}
> +
>  	ret = arm_smmu_device_disable(smmu);
>  	if (ret)
>  		return ret;

A tangential question: can we reliably detect that the SMMU already has 
valid mappings, which would indicate that we're in a pretty bad shape 
already by the time we set that bit? For all we know, memory could have 
been corrupted long before we hit this point, and this patch barely 
narrows the window of opportunity.

At the very least, we should emit a warning and taint the kernel (we've 
recently added such measures to the GICv3 driver).

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
