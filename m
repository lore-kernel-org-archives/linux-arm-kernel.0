From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 20 Jun 2017 10:19:43 +0200
Subject: [PATCH v7 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
In-Reply-To: <1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
References: <1496145821-3411-1-git-send-email-gakula@caviumnetworks.com>
 <1496145821-3411-2-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170620081943.GT658@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.05.17 17:33:39, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..bba2b59 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -833,12 +833,20 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>  {
>  	struct acpi_iort_smmu_v3 *smmu;
>  	int num_res = 0;
> +	unsigned long size = SZ_128K;
>  
>  	/* Retrieve SMMUv3 specific data */
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  
> +	/*
> +	 * Override the size, for Cavium ThunderX2 implementation
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	if (smmu->model == ACPI_IORT_SMMU_CAVIUM_CN99XX)

Geetha,

please resubmit the series since the macro changed to
ACPI_IORT_SMMU_V3_CAVIUM_CN99XX:

 https://github.com/acpica/acpica/commit/d00a4eb86e64bb4fa70f57ab5e5ca0a4ca2ad8ef#diff-a572aac2ccc26fe4a901616d7fdba859R1053

-Robert

> +		size = SZ_64K;
> +
>  	res[num_res].start = smmu->base_address;
> -	res[num_res].end = smmu->base_address + SZ_128K - 1;
> +	res[num_res].end = smmu->base_address + size - 1;
>  	res[num_res].flags = IORESOURCE_MEM;
>  
>  	num_res++;
> -- 
> 1.7.1
> 
