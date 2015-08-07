From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 7 Aug 2015 10:52:34 +0200
Subject: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
In-Reply-To: <8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
Message-ID: <20150807085233.GV14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:18:28PM +0100, Robin Murphy wrote:
> +/*
> + * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
> + * everything it needs to - the device isn't yet fully created, and the
> + * IOMMU driver hasn't seen it yet, so we need this delayed attachment
> + * dance. Once IOMMU probe ordering is sorted to move the
> + * arch_setup_dma_ops() call later, all the notifier bits below become
> + * unnecessary, and will go away.
> + */
> +struct iommu_dma_notifier_data {
> +	struct list_head list;
> +	struct device *dev;
> +	struct iommu_domain *dma_domain;
> +};
> +static LIST_HEAD(iommu_dma_masters);
> +static DEFINE_MUTEX(iommu_dma_notifier_lock);

Ugh, thats incredibly ugly. Why can't you do the setup work then the
iommu driver sees the device? Just call the dma-api setup functions
there (like the x86 iommu drivers do it too) and be done without any
notifiers.

> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> +				  const struct iommu_ops *ops)
> +{
> +	struct iommu_domain *domain;
> +	int err;
> +
> +	if (!ops)
> +		return;
> +	/*
> +	 * In a perfect world, everything happened in the right order up to
> +	 * here, and the IOMMU core has already attached the device to an
> +	 * appropriate default domain for us to set up...
> +	 */
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain) {
> +		/*
> +		 * Urgh. Reliable default domains for platform devices can't
> +		 * happen anyway without some sensible way of handling
> +		 * non-trivial groups. So until then, HORRIBLE HACKS!
> +		 */

I don't get this, what is preventing to rely on default domains here?

> +		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);

The IOMMU core should already tried to allocate an IOMMU_DOMAIN_DMA type
domain. No need to try this again here.



	Joerg
