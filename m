From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 20 Jun 2017 20:27:47 +0100
Subject: [PATCH v8 1/3] ACPI/IORT: Fixup SMMUv3 resource size for Cavium
 ThunderX2 SMMUv3 model
In-Reply-To: <1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
 <1497968259-16390-2-git-send-email-gakula@caviumnetworks.com>
Message-ID: <20170620192747.GA30990@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 07:47:37PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 implementation doesn't support second page in SMMU
> register space. Hence, resource size is set as 64k for this model.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  drivers/acpi/arm64/iort.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c5fecf9..c166f3e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -828,6 +828,18 @@ static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
>  	return num_res;
>  }
>  
> +static unsigned long arm_smmu_v3_resource_size(struct acpi_iort_smmu_v3 *smmu)
> +{
> +	/*
> +	 * Override the size, for Cavium ThunderX2 implementation
> +	 * which doesn't support the page 1 SMMU register space.
> +	 */
> +	if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
> +		return SZ_64K;
> +
> +	return SZ_128K;
> +}
> +
>  static void __init arm_smmu_v3_init_resources(struct resource *res,
>  					      struct acpi_iort_node *node)
>  {
> @@ -838,7 +850,8 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  
>  	res[num_res].start = smmu->base_address;
> -	res[num_res].end = smmu->base_address + SZ_128K - 1;
> +	res[num_res].end = smmu->base_address +
> +				arm_smmu_v3_resource_size(smmu) - 1;
>  	res[num_res].flags = IORESOURCE_MEM;
>  
>  	num_res++;
> -- 
> 1.7.1
> 
