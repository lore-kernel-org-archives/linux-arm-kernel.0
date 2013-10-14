From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Oct 2013 13:48:37 +0100
Subject: [PATCH 2/2] ARM: SMMU: return NULL on error in
 arm_smmu_iova_to_phys
In-Reply-To: <1381497887-14586-2-git-send-email-a.motakis@virtualopensystems.com>
References: <1381497887-14586-1-git-send-email-a.motakis@virtualopensystems.com>
 <1381497887-14586-2-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <20131014124837.GD10491@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 02:24:47PM +0100, Antonios Motakis wrote:
> The return value of arm_smmu_iova_to_phys is directly passed to the
> user of the IOMMU API via iommu_iova_to_phys; however the ARM SMMU
> driver returns -EINVAL on error, which is not consistent with the
> rest of the drivers implementing the IOMMU API. VFIO also relies on
> the call returning NULL when a page has not been mapped already.
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> ---
>  drivers/iommu/arm-smmu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 8b71332..fe81b20 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1480,10 +1480,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>  
>  err_unlock:
>  	spin_unlock(&smmu_domain->lock);
> -	dev_warn(smmu->dev,
> -		 "invalid (corrupt?) page tables detected for iova 0x%llx\n",
> -		 (unsigned long long)iova);
> -	return -EINVAL;
> +	return NULL;

Why are you removing the warning message?

Will
