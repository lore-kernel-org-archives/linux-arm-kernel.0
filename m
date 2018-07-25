From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 16:11:19 +0100
Subject: [PATCH v2 1/1] iommu/arm-smmu-v3: Set GBPA to abort all
 transactions
In-Reply-To: <20180725142737.GA6866@arm.com>
References: <1529980239-1950-1-git-send-email-sgoel@codeaurora.org>
 <20180725142737.GA6866@arm.com>
Message-ID: <20180725151119.GB6866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 03:27:37PM +0100, Will Deacon wrote:
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 7fb5230cd145..3ce841c5cae3 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -24,6 +24,7 @@
>  #include <linux/acpi_iort.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/crash_dump.h>
>  #include <linux/delay.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/err.h>
> @@ -2212,8 +2213,12 @@ static int arm_smmu_update_gbpa(struct arm_smmu_device *smmu, u32 set, u32 clr)
>  	reg &= ~clr;
>  	reg |= set;
>  	writel_relaxed(reg | GBPA_UPDATE, gbpa);
> -	return readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
> -					  1, ARM_SMMU_POLL_TIMEOUT_US);
> +	ret = readl_relaxed_poll_timeout(gbpa, reg, !(reg & GBPA_UPDATE),
> +					 1, ARM_SMMU_POLL_TIMEOUT_US);
> +
> +	if (ret)
> +		dev_err(smmu->dev, "GBPA not responding to update\n");
> +	return ret;
>  }
>  
>  static void arm_smmu_free_msis(void *data)
> @@ -2393,8 +2398,14 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  
>  	/* Clear CR0 and sync (disables SMMU and queue processing) */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
> -	if (reg & CR0_SMMUEN)
> +	if (reg & CR0_SMMUEN) {
> +		if (is_kdump_kernel()) {
> +			arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);

Oops, I forgot to call arm_smmu_device_disable(smmu); here after updating
the GBPA register.

Anyway, I'd be interested in your thoughts on this approach.

Will
