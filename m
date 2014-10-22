From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 22 Oct 2014 17:12:54 +0200
Subject: [PATCH v5 1/3] iommu/rockchip: rk3288 iommu driver
In-Reply-To: <1413273762-32489-2-git-send-email-djkurtz@chromium.org>
References: <1413273762-32489-1-git-send-email-djkurtz@chromium.org>
 <1413273762-32489-2-git-send-email-djkurtz@chromium.org>
Message-ID: <20141022151254.GJ10074@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 04:02:40PM +0800, Daniel Kurtz wrote:
> +static void rk_iommu_detach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct rk_iommu *iommu = dev_get_drvdata(dev->archdata.iommu);
> +	struct rk_iommu_domain *rk_domain = domain->priv;
> +	unsigned long flags;
> +
> +	/* Allow 'virtual devices' (eg drm) to detach from domain */
> +	if (!iommu)
> +		return;
> +
> +	iommu->domain = NULL;

I guess this line is a left-over? Setting iommu->domain to NULL here
before you disabled the IOMMU interrupt is racy. To be fully secure, you
should make sure that no interrupt handler is still running after you
disabled the IOMMU irq and before setting iommu->domain = NULL.

Other than that the code looks good.


	Joerg
