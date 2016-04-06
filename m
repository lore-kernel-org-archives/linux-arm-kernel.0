From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 6 Apr 2016 17:58:19 +0200
Subject: [PATCH 2/3] iommu/io-pgtable-arm: Support IOMMU_MMIO flag
In-Reply-To: <1e6ddedc0bb08b6581f6e0e80710c2ed03830647.1459854346.git.robin.murphy@arm.com>
References: <d80a42ceae3a39ef7c593a5181a1742a84c65533.1459854346.git.robin.murphy@arm.com>
 <1e6ddedc0bb08b6581f6e0e80710c2ed03830647.1459854346.git.robin.murphy@arm.com>
Message-ID: <5705321B.3040200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
On 04/05/2016 01:39 PM, Robin Murphy wrote:
> Teach the LPAE format to create Device mappings when asked.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
don't know if it helps in any way but I tested that with my KVM PCIe/MSI
passthrough series for mapping the GICv2m doorbell.

Tested-by: Eric Auger <eric.auger@linaro.org>

Best Regards

Eric

> ---
>  drivers/iommu/io-pgtable-arm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f433b51..a1ed1b7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -355,7 +355,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>  			pte |= ARM_LPAE_PTE_AP_RDONLY;
>  
> -		if (prot & IOMMU_CACHE)
> +		if (prot & IOMMU_MMIO)
> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +		else if (prot & IOMMU_CACHE)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>  	} else {
> @@ -364,7 +367,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  			pte |= ARM_LPAE_PTE_HAP_READ;
>  		if (prot & IOMMU_WRITE)
>  			pte |= ARM_LPAE_PTE_HAP_WRITE;
> -		if (prot & IOMMU_CACHE)
> +		if (prot & IOMMU_MMIO)
> +			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
> +		else if (prot & IOMMU_CACHE)
>  			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>  		else
>  			pte |= ARM_LPAE_PTE_MEMATTR_NC;
> 
