From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 6 Oct 2015 19:00:03 +0800
Subject: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
In-Reply-To: <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
 <80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
Message-ID: <1444129203.6621.46.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-01 at 20:13 +0100, Robin Murphy wrote:
> Taking some inspiration from the arch/arm code, implement the
> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
> 
> Since there is still work to do elsewhere to make DMA configuration happen
> in a more appropriate order and properly support platform devices in the
> IOMMU core, the device setup code unfortunately starts out carrying some
> workarounds to ensure it works correctly in the current state of things.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 435 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 435 insertions(+)
> 
[...]
> +/*
> + * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
> + * everything it needs to - the device is only partially created and the
> + * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
> + * need this delayed attachment dance. Once IOMMU probe ordering is sorted
> + * to move the arch_setup_dma_ops() call later, all the notifier bits below
> + * become unnecessary, and will go away.
> + */

Hi Robin,
      Could I ask a question about the plan in the future:
      How to move arch_setup_dma_ops() call later than IOMMU probe?
      
      arch_setup_dma_ops is from of_dma_configure which is from
arm64_device_init, and IOMMU probe is subsys_init. So
arch_setup_dma_ops will run before IOMMU probe normally, is it right?
      Does Laurent's probe-deferral series could help do this? what's
the state of this series.

> +struct iommu_dma_notifier_data {
> +	struct list_head list;
> +	struct device *dev;
> +	const struct iommu_ops *ops;
> +	u64 dma_base;
> +	u64 size;
> +};
> +static LIST_HEAD(iommu_dma_masters);
> +static DEFINE_MUTEX(iommu_dma_notifier_lock);
> +
> +/*
> + * Temporarily "borrow" a domain feature flag to to tell if we had to resort
> + * to creating our own domain here, in case we need to clean it up again.
> + */
> +#define __IOMMU_DOMAIN_FAKE_DEFAULT		(1U << 31)
> +
> +static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
> +			   u64 dma_base, u64 size)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	/*
> +	 * Best case: The device is either part of a group which was
> +	 * already attached to a domain in a previous call, or it's
> +	 * been put in a default DMA domain by the IOMMU core.
> +	 */
> +	if (!domain) {
> +		/*
> +		 * Urgh. The IOMMU core isn't going to do default domains
> +		 * for non-PCI devices anyway, until it has some means of
> +		 * abstracting the entirely implementation-specific
> +		 * sideband data/SoC topology/unicorn dust that may or
> +		 * may not differentiate upstream masters.
> +		 * So until then, HORRIBLE HACKS!
> +		 */
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
> +		if (!domain)
> +			goto out_no_domain;
> +
> +		domain->ops = ops;
> +		domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;
> +
> +		if (iommu_attach_device(domain, dev))
> +			goto out_put_domain;
> +	}
> +
> +	if (iommu_dma_init_domain(domain, dma_base, size))
> +		goto out_detach;
> +
> +	dev->archdata.dma_ops = &iommu_dma_ops;
> +	return true;
> +
> +out_detach:
> +	iommu_detach_device(domain, dev);
> +out_put_domain:
> +	if (domain->type & __IOMMU_DOMAIN_FAKE_DEFAULT)
> +		iommu_domain_free(domain);
> +out_no_domain:
> +	pr_warn("Failed to set up IOMMU for device %s; retaining platform DMA ops\n",
> +		dev_name(dev));
> +	return false;
> +}
[...]
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  const struct iommu_ops *ops)
> +{
> +	struct iommu_group *group;
> +
> +	if (!ops)
> +		return;
> +	/*
> +	 * TODO: As a concession to the future, we're ready to handle being
> +	 * called both early and late (i.e. after bus_add_device). Once all
> +	 * the platform bus code is reworked to call us late and the notifier
> +	 * junk above goes away, move the body of do_iommu_attach here.
> +	 */
> +	group = iommu_group_get(dev);

   If iommu_setup_dma_ops run after bus_add_device, then the device has
its group here. It will enter do_iommu_attach which will alloc a default
iommu domain and attach this device to the new iommu domain.
   But mtk-iommu don't expect like this, we would like to attach to the
same domain. So we should alloc a default iommu domain(if there is no
iommu domain at that time) and attach the device to the same domain in
our xx_add_device, is it right?

> +	if (group) {
> +		do_iommu_attach(dev, ops, dma_base, size);
> +		iommu_group_put(group);
> +	} else {
> +		queue_iommu_attach(dev, ops, dma_base, size);
> +	}
> +}
> +
> +#else
> +
> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  struct iommu_ops *iommu)
> +{ }
> +
> +#endif  /* CONFIG_IOMMU_DMA */
> +
