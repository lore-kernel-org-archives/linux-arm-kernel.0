From: pullip.cho@samsung.com (Cho KyongHo)
Date: Thu, 01 May 2014 23:08:56 +0900
Subject: [PATCH v12 15/31] iommu/exynos: handle 'mmu-masters' property of
 DT and improve handling sysmmu
In-Reply-To: <13595839.WFkdpM5auQ@wuerfel>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <1398584283-22846-16-git-send-email-shaik.ameer@samsung.com>
 <13595839.WFkdpM5auQ@wuerfel>
Message-ID: <20140501230856.3712721d928212c2fff11c43@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 27 Apr 2014 20:17:48 +0200, Arnd Bergmann wrote:
> On Sunday 27 April 2014 13:07:47 Shaik Ameer Basha wrote:
> > @@ -542,14 +592,41 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > +	/* Relation between master and System MMU is 1:1. */
> > +	node = of_parse_phandle(dev->of_node, "mmu-masters", 0);
> > +	if (node) {
> > +		struct platform_device *master = of_find_device_by_node(node);
> > +
> > +		if (!master) {
> > +			dev_err(dev, "%s: mmu-master '%s' not found\n",
> > +				__func__, node->name);
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (master->dev.archdata.iommu != NULL) {
> > +			dev_err(dev, "%s: '%s' is master of other MMU\n",
> > +				__func__, node->name);
> > +			return -EINVAL;
> > +		}
> > +
> > +		/*
> > +		 * archdata.iommu will be initialized with exynos_iommu_client
> > +		 * in sysmmu_hook_driver_register().
> > +		 */
> > +		master->dev.archdata.iommu = dev;
> > +	}
> 
> I think parsing of generic properties like this shouldn't be done
> by the individual driver. It belongs into core iommu code and should
> be done when the devices are probed.
> 
> > +
> > +static struct notifier_block sysmmu_notifier = {
> > +	.notifier_call = &sysmmu_hook_driver_register,
> > +};
> > +
> > +static int __init exynos_iommu_prepare(void)
> > +{
> > +	static bool registered = false;
> > +	int ret;
> > +
> > +	if (registered)
> > +		return 0;
> > +
> > +	ret = bus_register_notifier(&platform_bus_type, &sysmmu_notifier);
> > +	if (!ret)
> > +		registered = true;
> > +	else
> > +		pr_err("Failed to register sysmmu_notifier\n");
> > +
> > +	return ret;
> > +}
> 
> This also means we should not have notifiers. Put it into core code to
> make sure all IOMMUs are handled the same way.
> 

Ok.

Thank you for addressing that.
I am also very interested in the discussion about it in the different thread.

KyongHo
