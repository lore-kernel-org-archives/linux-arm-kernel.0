From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 4 Apr 2017 12:04:39 +0100
Subject: [PATCH V10 05/12] ACPI/IORT: Add function to check SMMUs drivers
 presence
In-Reply-To: <1491301105-5274-6-git-send-email-sricharan@codeaurora.org>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <e2713b7b-718d-c059-2e14-cc6ab7636a22@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/17 11:18, Sricharan R wrote:
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> The IOMMU probe deferral implementation requires a mechanism to detect
> if drivers for SMMU components are built-in in the kernel to detect
> whether IOMMU configuration for a given device should be deferred (ie
> SMMU drivers present but still not probed) or not (drivers not present).
> 
> Add a simple function to IORT to detect if SMMU drivers for SMMU
> components managed by IORT are built-in in the kernel.

Ah, if only DT could be this neat and tidy :D

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/acpi/arm64/iort.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 4a5bb96..3dd9ec3 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -523,6 +523,19 @@ static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
>  	return ret;
>  }
>  
> +static inline bool iort_iommu_driver_enabled(u8 type)
> +{
> +	switch (type) {
> +	case ACPI_IORT_NODE_SMMU_V3:
> +		return IS_BUILTIN(CONFIG_ARM_SMMU_V3);
> +	case ACPI_IORT_NODE_SMMU:
> +		return IS_BUILTIN(CONFIG_ARM_SMMU);
> +	default:
> +		pr_warn("IORT node type %u does not describe an SMMU\n", type);
> +		return false;
> +	}
> +}
> +
>  static const struct iommu_ops *iort_iommu_xlate(struct device *dev,
>  					struct acpi_iort_node *node,
>  					u32 streamid)
> 
