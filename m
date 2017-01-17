From: tnowicki@caviumnetworks.com (Tomasz Nowicki)
Date: Tue, 17 Jan 2017 14:20:56 +0100
Subject: [PATCH v8 10/18] iommu/arm-smmu: Implement reserved region
 get/put callbacks
In-Reply-To: <1484127714-3263-11-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
 <1484127714-3263-11-git-send-email-eric.auger@redhat.com>
Message-ID: <e45ab455-4a34-cad1-74de-9db395e0dea7@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.01.2017 10:41, Eric Auger wrote:
> The get() populates the list with the MSI IOVA reserved window.
>
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB. This will allow to report those info in iommu-group
> sysfs.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>

Thanks,
Tomasz

>
> ---
>
> v3 -> v4:
> - do not handle PCI host bridge windows anymore
> - encode prot
>
> RFC v2 -> v3:
> - use existing get/put_resv_regions
>
> RFC v1 -> v2:
> - use defines for MSI IOVA base and length
> ---
>  drivers/iommu/arm-smmu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index a60cded..a354572 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -281,6 +281,9 @@ enum arm_smmu_s2cr_privcfg {
>
>  #define FSYNR0_WNR			(1 << 4)
>
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000
> +
>  static int force_stage;
>  module_param(force_stage, int, S_IRUGO);
>  MODULE_PARM_DESC(force_stage,
> @@ -1549,6 +1552,29 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, &fwid, 1);
>  }
>
> +static void arm_smmu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +					 prot, IOMMU_RESV_MSI);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void arm_smmu_put_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -1564,6 +1590,8 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>  	.domain_set_attr	= arm_smmu_domain_set_attr,
>  	.of_xlate		= arm_smmu_of_xlate,
> +	.get_resv_regions	= arm_smmu_get_resv_regions,
> +	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>
>
