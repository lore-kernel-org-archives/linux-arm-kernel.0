From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 7 Aug 2015 10:55:17 +0200
Subject: [PATCH v5 3/3] arm64: Hook up IOMMU dma_ops
In-Reply-To: <caecbce93dd4870995a000bebc8f58d1ca7e551e.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <caecbce93dd4870995a000bebc8f58d1ca7e551e.1438362603.git.robin.murphy@arm.com>
Message-ID: <20150807085516.GW14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 06:18:29PM +0100, Robin Murphy wrote:
> +void arch_teardown_dma_ops(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	if (domain) {
> +		iommu_detach_device(domain, dev);
> +		if (domain->type & __IOMMU_DOMAIN_ARM64_IOVA)
> +			iommu_put_dma_cookie(domain);
> +		if (domain->type & __IOMMU_DOMAIN_ARM64)
> +			iommu_domain_free(domain);
> +		dev->archdata.dma_ops = NULL;
> +	}
> +}

When is this called? In case a device gets removed the IOMMU core and
driver should take care of destroying the domain, at least when its a
default-domain. This is part of the iommu-group handling.


	Joerg
