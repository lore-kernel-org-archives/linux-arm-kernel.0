From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 15 Jul 2016 14:55:06 +0100
Subject: [PATCH v4 6/8] iommu/arm-smmu: Implement of_xlate() for SMMUv3
In-Reply-To: <925b054b1e96dc83c0b1dc9607785d0346187366.1467388950.git.robin.murphy@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <925b054b1e96dc83c0b1dc9607785d0346187366.1467388950.git.robin.murphy@arm.com>
Message-ID: <20160715135506.GA4687@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 05:50:15PM +0100, Robin Murphy wrote:

[...]

> +static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	int ret;
> +
> +	/* We only support PCI, for now */
> +	if (!dev_is_pci(dev))
> +		return -ENODEV;

Given that a) the check above is removed in a later patch and b)
code below does not depend on SMMU v3, I think the aim should
be to make this a core function (ie I am asking this since I will
need it in IORT based translation and I do not want to add yet another
*_xlate hook to iommu_op), iommu_fwspec_xlate() ?

What I will do with my next RFC is move the iommu_fwspec out of
OF_IOMMU code in a separate compilation unit and we will take the
discussion from there.

[...]

> +
> +	ret = iommu_fwspec_init(dev, args->np);
> +	if (!ret)
> +		ret = iommu_fwspec_add_ids(dev, &args->args[0], 1);
> +
> +	return ret;
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -1947,6 +1894,7 @@ static struct iommu_ops arm_smmu_ops = {
>  	.device_group		= pci_device_group,
>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>  	.domain_set_attr	= arm_smmu_domain_set_attr,
> +	.of_xlate		= arm_smmu_of_xlate,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>  
> @@ -2697,6 +2645,22 @@ static void __exit arm_smmu_exit(void)
>  subsys_initcall(arm_smmu_init);
>  module_exit(arm_smmu_exit);
>  
> +static int __init arm_smmu_of_init(struct device_node *np)
> +{
> +	static bool registered;
> +
> +	if (!registered)
> +		registered = !arm_smmu_init();

We also need a static variable in arm_smmu_init() to make sure
we do not try to execute it multiple times :( (here and
subsys_initcall).

Thanks,
Lorenzo

> +
> +	if (!of_platform_device_create(np, NULL, platform_bus_type.dev_root))
> +		return -ENODEV;
> +
> +	of_iommu_set_ops(np, &arm_smmu_ops);
> +
> +	return 0;
> +}
> +IOMMU_OF_DECLARE(arm_smmuv3, "arm,smmu-v3", arm_smmu_of_init);
> +
>  MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>  MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.8.1.dirty
> 
