From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 14 Oct 2015 14:53:09 +0200
Subject: [PATCH v5 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1444357388-30257-6-git-send-email-yong.wu@mediatek.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
 <1444357388-30257-6-git-send-email-yong.wu@mediatek.com>
Message-ID: <20151014125309.GO27420@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:23:07AM +0800, Yong Wu wrote:
> +	/*
> +	 * There is a domain for each a iommu device in normal case.
> +	 * But MTK only has one iommu domain called the m4u domain which all
> +	 * the multimedia HW share. Here we reserve one as the m4u domain and
> +	 * free the others.
> +	 *
> +	 * And the attach_device that from __iommu_setup_dma_ops
> +	 * will be called earlier than probe.
> +	 */

Okay, with this being the case, you need to put all devices behind one
IOMMU into the same iommu-group, because the IOMMU can't really isolate
the devices from each other.

> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	struct mtk_iommu_client_priv *priv;
> +	struct mtk_iommu_domain *m4udom;
> +	struct iommu_domain *domain;
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
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain) {
> +		/*
> +		 * Get the m4u iommu domain from the m4u device.
> +		 * Attach all the client devices into the m4u domain.
> +		 */
> +		priv = dev->archdata.iommu;
> +		m4udom = dev_get_drvdata(priv->m4udev);
> +		ret = iommu_attach_group(&m4udom->domain, group);
> +		if (ret)
> +			dev_err(dev, "Failed to attach IOMMU group\n");
> +	}
> +
> +err_group_put:
> +	iommu_group_put(group);
> +	return ret;
> +}

Here it looks like you are allocating one group for each device. As I
said, all devices need to be in one group.



	Joerg
