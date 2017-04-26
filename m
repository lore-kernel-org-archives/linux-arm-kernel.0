From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Apr 2017 11:01:50 +0100
Subject: [PATCH v2] iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU
 is bypassed
In-Reply-To: <1493114272-30093-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1493114272-30093-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20170426100150.GE21744@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sunil,

On Tue, Apr 25, 2017 at 03:27:52PM +0530, sunil.kovvuri at gmail.com wrote:
> From: Sunil Goutham <sgoutham@cavium.com>
> 
> For software initiated address translation, when domain type is
> IOMMU_DOMAIN_IDENTITY i.e SMMU is bypassed, mimic HW behavior
> i.e return the same IOVA as translated address.
> 
> This patch is an extension to Will Deacon's patchset
> "Implement SMMU passthrough using the default domain".
> 
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> ---
> 
> V2
> - As per Will's suggestion applied fix to SMMUv3 driver as well.

This follows what the AMD driver does, so:

Acked-by: Will Deacon <will.deacon@arm.com>

but I still think that having drivers/net/ethernet/cavium/thunder/nicvf_queues.c
poke around with the physical address to get at the struct pages underlying
a DMA buffer is really dodgy. Is there no way this can be avoided, perhaps
by tracking the pages some other way (although I don't understand why you're
having to mess with the page reference counts to start with)?

At least, I think you should be checking the domain type in
nicvf_iova_to_phys, which clearly expects a DMA domain if one exists at all.

Joerg: sorry, this is another one for you to pick up if possible.

Cheers,

Will

>  drivers/iommu/arm-smmu-v3.c | 3 +++
>  drivers/iommu/arm-smmu.c    | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 05b4592..d412bdd 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1714,6 +1714,9 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>  
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return iova;
> +
>  	if (!ops)
>  		return 0;
>  
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index bfab4f7..81088cd 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1459,6 +1459,9 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
>  
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return iova;
> +
>  	if (!ops)
>  		return 0;
>  
> -- 
> 2.7.4
> 
