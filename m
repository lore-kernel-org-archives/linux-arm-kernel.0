From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Mar 2017 16:45:27 +0100
Subject: [PATCH v2 5/5] iommu: Allow default domain type to be set on the
 kernel command line
In-Reply-To: <1489178976-15353-6-git-send-email-will.deacon@arm.com>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
 <1489178976-15353-6-git-send-email-will.deacon@arm.com>
Message-ID: <20170321154527.GB29659@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Fri, Mar 10, 2017 at 08:49:36PM +0000, Will Deacon wrote:
> @@ -1014,8 +1027,8 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
>  	 * IOMMU driver.
>  	 */
>  	if (!group->default_domain) {
> -		group->default_domain = __iommu_domain_alloc(dev->bus,
> -							     IOMMU_DOMAIN_DMA);
> +		group->default_domain =
> +			__iommu_domain_alloc(dev->bus, iommu_def_domain_type);

It would be good to have a fall-back here if we are talking to an IOMMU
driver that uses default domains, but does not support identity-mapped
domains (yet). Exynos and Rockchip IOMMU drivers seem to fall into this
category. A dev_warn() also makes sense in case allocating a identity
domain fails.


	Joerg
