From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 18 Aug 2011 11:01:57 +0200
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
In-Reply-To: <1313622608-30397-2-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-2-git-send-email-ohad@wizery.com>
Message-ID: <201108181101.57882.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

Thanks for the patch.

Just one small comment in case you resubmit the whole series for another 
reason.

On Thursday 18 August 2011 01:10:02 Ohad Ben-Cohen wrote:
> Migrate OMAP's iommu driver to the generic IOMMU API, so users can stay
> generic, and any generic IOMMU functionality can be developed once
> in the generic framework.
> 
> Migrate omap's iovmm (virtual memory manager) to the generic IOMMU API,
> and adapt omap3isp as needed, so the latter won't break.
> 
> The plan is to eventually remove iovmm completely by replacing it
> with the (upcoming) IOMMU-based DMA-API.
> 
> Tested on OMAP3 (with omap3isp) and OMAP4 (with rpmsg/remoteproc).
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

[snip]

> +static void omap_iommu_detach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct omap_iommu_domain *omap_domain = domain->priv;
> +	struct iommu *oiommu = to_iommu(dev);
> +
> +	mutex_lock(&omap_domain->lock);
> +
> +	/* only a single device is supported per domain for now */
> +	if (omap_domain->iommu_dev != oiommu) {
> +		dev_err(dev, "invalid iommu device\n");
> +		goto out;
> +	}
> +
> +	iopgtable_clear_entry_all(oiommu);
> +
> +	omap_iommu_detach(oiommu);
> +
> +	omap_domain->iommu_dev = NULL;
> +
> +out:
> +	mutex_unlock(&omap_domain->lock);
> +}
> +
> +static int omap_iommu_domain_init(struct iommu_domain *domain)
> +{
> +	struct omap_iommu_domain *omap_domain;
> +
> +	omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
> +	if (!omap_domain) {
> +		pr_err("kzalloc failed\n");
> +		goto out;

You can directly return -ENOMEM here, and remove the "out:" label.

> +	}
> +
> +	omap_domain->pgtable = kzalloc(IOPGD_TABLE_SIZE, GFP_KERNEL);
> +	if (!omap_domain->pgtable) {
> +		pr_err("kzalloc failed\n");
> +		goto fail_nomem;
> +	}
> +
> +	/*
> +	 * should never fail, but please keep this around to ensure
> +	 * we keep the hardware happy
> +	 */
> +	BUG_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE));
> +
> +	clean_dcache_area(omap_domain->pgtable, IOPGD_TABLE_SIZE);
> +	mutex_init(&omap_domain->lock);
> +
> +	domain->priv = omap_domain;
> +
> +	return 0;
> +
> +fail_nomem:
> +	kfree(omap_domain);
> +out:
> +	return -ENOMEM;
> +}

-- 
Regards,

Laurent Pinchart
