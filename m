From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 17 Oct 2016 14:21:46 +0100
Subject: [PATCH 1/2] iommu/arm-smmu: Don't inadvertently reject multiple
 SMMUv3s
In-Reply-To: <5cf1acbf9c42cc99e5cc0dacb50b7a92c3bd0feb.1476702234.git.robin.murphy@arm.com>
References: <5cf1acbf9c42cc99e5cc0dacb50b7a92c3bd0feb.1476702234.git.robin.murphy@arm.com>
Message-ID: <20161017132146.GA26341@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 12:06:20PM +0100, Robin Murphy wrote:
> We now delay installing our per-bus iommu_ops until we know an SMMU has
> successfully probed, as they don't serve much purpose beforehand, and
> doing so also avoids fights between multiple IOMMU drivers in a single
> kernel. However, the upshot of passing the return value of bus_set_iommu()
> back from our probe function is that if there happens to be more than
> one SMMUv3 device in a system, the second and subsequent probes will
> wind up returning -EBUSY to the driver core and getting torn down again.
> 
> There are essentially 3 cases in which bus_set_iommu() returns nonzero:
> 1. The bus already has iommu_ops installed
> 2. One of the add_device callbacks from the initial notifier failed
> 3. Allocating or installing the notifier itself failed
> 
> The first two are down to devices other than the SMMU in question, so
> shouldn't abort an otherwise-successful SMMU probe, whilst the third is
> indicative of the kind of catastrophic system failure which isn't going
> to get much further anyway. Consequently, there is little harm in
> ignoring the return value either way.
> 
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 15c01c3cd540..74fbef384deb 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2637,16 +2637,13 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
>  #ifdef CONFIG_PCI
>  	pci_request_acs();
> -	ret = bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
> -	if (ret)
> -		return ret;
> +	bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>  #endif
>  #ifdef CONFIG_ARM_AMBA
> -	ret = bus_set_iommu(&amba_bustype, &arm_smmu_ops);
> -	if (ret)
> -		return ret;
> +	bus_set_iommu(&amba_bustype, &arm_smmu_ops);
>  #endif
> -	return bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
> +	bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
> +	return 0;

Nit: I do not see why you would not take the same approach as
the ARM SMMUv1/v2, namely checking if ops are already set and
skip the call if that's the case.

Anyway:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

>  }
>  
>  static int arm_smmu_device_remove(struct platform_device *pdev)
> -- 
> 1.9.1
> 
