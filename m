From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 11 Aug 2015 17:39:47 +0200
Subject: [PATCH v4 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1438597279-2937-6-git-send-email-yong.wu@mediatek.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
 <1438597279-2937-6-git-send-email-yong.wu@mediatek.com>
Message-ID: <20150811153947.GF14980@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 03, 2015 at 06:21:18PM +0800, Yong Wu wrote:
> +/*
> + * There is only one iommu domain called the m4u domain that
> + * all Multimedia modules share.
> + */
> +static struct mtk_iommu_domain	*m4udom;

What is the reason you only implement one domain? Can't the IOMMU
isolate different devices from each other?


> +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> +{
> +	struct mtk_iommu_domain *priv;
> +
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +		return NULL;
> +
> +	if (m4udom)/* The m4u domain exist. */
> +		return &m4udom->domain;

This is not going to work. If you always return the same domain the
iommu core might re-initialize domain state (and overwrite changed
state). At the moment this is only the domain-type which will change
every time this function is called, but there might be more.

> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	if (!dev->archdata.iommu) /* Not a iommu client device */
> +		return -ENODEV;
> +
> +	group = iommu_group_get(dev);
> +	if (!group) {
> +		group = iommu_group_alloc();
> +		if (IS_ERR(group)) {
> +			dev_err(dev, "Failed to allocate IOMMU group\n");
> +			return PTR_ERR(group);
> +		}
> +	}
> +
> +	ret = iommu_group_add_device(group, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add IOMMU group\n");
> +		goto err_group_put;
> +	}
> +
> +	ret = iommu_attach_group(&m4udom->domain, group);
> +	if (ret)
> +		dev_err(dev, "Failed to attach IOMMU group\n");
> +
> +err_group_put:
> +	iommu_group_put(group);
> +	return ret;
> +}

Putting every device into its own group indicates that the IOMMU can
isolate between single devices on the bus, which makes it even more
questionable that you only allow one domain for the whole driver.


	Joerg
