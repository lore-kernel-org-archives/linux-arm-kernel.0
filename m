From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Dec 2016 18:55:53 +0000
Subject: [RFC v3 09/10] iommu/arm-smmu: Implement reserved region get/put
 callbacks
In-Reply-To: <1479215363-2898-10-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
 <1479215363-2898-10-git-send-email-eric.auger@redhat.com>
Message-ID: <02c0ce15-fa67-e65f-3a4e-f543cc9fd3b8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/16 13:09, Eric Auger wrote:
> The get() populates the list with the PCI host bridge windows
> and the MSI IOVA range.
> 
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB. This will allow to report those info in iommu-group
> sysfs?
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> RFC v2 -> v3:
> - use existing get/put_resv_regions
> 
> RFC v1 -> v2:
> - use defines for MSI IOVA base and length
> ---
>  drivers/iommu/arm-smmu.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 8f72814..81f1a83 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -278,6 +278,9 @@ enum arm_smmu_s2cr_privcfg {
>  
>  #define FSYNR0_WNR			(1 << 4)
>  
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000
> +
>  static int force_stage;
>  module_param(force_stage, int, S_IRUGO);
>  MODULE_PARM_DESC(force_stage,
> @@ -1545,6 +1548,53 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, &fwid, 1);
>  }
>  
> +static void arm_smmu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +	struct pci_host_bridge *bridge;
> +	struct resource_entry *window;
> +
> +	/* MSI region */
> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +					 IOMMU_RESV_MSI);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	bridge = pci_find_host_bridge(to_pci_dev(dev)->bus);
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		phys_addr_t start;
> +		size_t length;
> +
> +		if (resource_type(window->res) != IORESOURCE_MEM &&
> +		    resource_type(window->res) != IORESOURCE_IO)

As Joerg commented elsewhere, considering anything other than memory
resources isn't right (I appreciate you've merely copied my own mistake
here). We need some other way to handle root complexes where the CPU
MMIO views of PCI windows appear in PCI memory space - using the I/O
address of I/O resources only works by chance on Juno, and it still
doesn't account for config space. I suggest we just leave that out for
the time being to make life easier (does it even apply to anything other
than Juno?) and figure it out later.

> +			continue;
> +
> +		start = window->res->start - window->offset;
> +		length = window->res->end - window->res->start + 1;
> +		region = iommu_alloc_resv_region(start, length,
> +						 IOMMU_RESV_NOMAP);
> +		if (!region)
> +			return;
> +		list_add_tail(&region->list, head);
> +	}
> +}

Either way, there's nothing SMMU-specific about PCI windows. The fact
that we'd have to copy-paste all of this into the SMMUv3 driver
unchanged suggests it should go somewhere common (although I would be
inclined to leave the insertion of the fake MSI region to driver-private
wrappers). As I said before, the current iova_reserve_pci_windows()
simply wants splitting into appropriate public callbacks for
get_resv_regions and apply_resv_regions.

Robin.

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
> @@ -1560,6 +1610,8 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>  	.domain_set_attr	= arm_smmu_domain_set_attr,
>  	.of_xlate		= arm_smmu_of_xlate,
> +	.get_resv_regions	= arm_smmu_get_resv_regions,
> +	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>  
> 
