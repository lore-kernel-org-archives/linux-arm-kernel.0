From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 16 May 2017 14:27:50 +0100
Subject: [RFC v1 6/7] iommu/arm-smmu-v3: Rearrange msi resv alloc functions
In-Reply-To: <20170513094731.3676-7-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-7-shameerali.kolothum.thodi@huawei.com>
Message-ID: <d2d90929-6e79-70a3-5c82-a25e67931b4a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/05/17 10:47, shameer wrote:
> This moves the SW MSI reserve region allocation to probe fn.

Why?

> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 770cc9e..e7a8a50 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -619,6 +619,9 @@ struct arm_smmu_device {
>  
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
> +
> +	/* MSI Reserve region */
> +	struct iommu_resv_region        *msi_region;
>  };
>  
>  /* SMMU private data for each master */
> @@ -1960,15 +1963,12 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
> -	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> -
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI);
> -	if (!region)
> -		return;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;

There's never any need for the domain dance if you don't need the
domain, just pull the smmu out of the device's iommu_fwspec.

> -	list_add_tail(&region->list, head);
> +	if (smmu && smmu->msi_region)
> +		list_add_tail(&smmu->msi_region->list, head);

Have you considered what happens for the second and subsequent domains
allocated on this SMMU? I can't see that ending well.

Robin.

>  	iommu_dma_get_resv_regions(dev, head);
>  }
> @@ -1978,8 +1978,13 @@ static void arm_smmu_put_resv_regions(struct device *dev,
>  {
>  	struct iommu_resv_region *entry, *next;
>  
> -	list_for_each_entry_safe(entry, next, head, list)
> +	list_for_each_entry_safe(entry, next, head, list) {
> +		if (entry->type == IOMMU_RESV_SW_MSI ||
> +				entry->type == IOMMU_RESV_MSI)
> +			continue;
> +
>  		kfree(entry);
> +	}
>  }
>  
>  static struct iommu_ops arm_smmu_ops = {
> @@ -2711,6 +2716,17 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>  	return ret;
>  }
>  
> +static struct iommu_resv_region *arm_smmu_alloc_msi_region(
> +				struct arm_smmu_device *smmu)
> +{
> +	struct iommu_resv_region *region;
> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +					prot, IOMMU_RESV_SW_MSI);
> +	return region;
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>  	int irq, ret;
> @@ -2756,6 +2772,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	if (irq > 0)
>  		smmu->gerr_irq = irq;
>  
> +	smmu->msi_region = arm_smmu_alloc_msi_region(smmu);
> +
>  	if (dev->of_node) {
>  		ret = arm_smmu_device_dt_probe(pdev, smmu);
>  	} else {
> 
