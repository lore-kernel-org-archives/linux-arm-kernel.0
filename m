From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 14 Dec 2015 15:16:57 +0100
Subject: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <20151214141656.GG18805@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 05:49:12PM +0800, Yong Wu wrote:
> +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
> +	struct mtk_iommu_data *data;
> +	int ret;
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	data = dev_get_drvdata(priv->m4udev);
> +	if (!data) {
> +		/*
> +		 * The DMA core will run earlier than this probe, and it will
> +		 * create a default iommu domain for each a iommu device.
> +		 * But here there is only one domain called the m4u domain
> +		 * which all the multimedia HW share.
> +		 * The default domain isn't needed here.
> +		 */

The iommu core creates one domain per iommu-group. In your case this
means one default domain per iommu in the system.

> +		iommu_domain_free(domain);

This function is not supposed to free the domain passed to it.

> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	if (!dev->archdata.iommu) /* Not a iommu client device */
> +		return -ENODEV;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	iommu_group_put(group);
> +	return 0;
> +}

[...]

> +static struct iommu_group *mtk_iommu_device_group(struct device *dev)
> +{
> +	struct mtk_iommu_data *data;
> +	struct mtk_iommu_client_priv *priv;
> +
> +	priv = dev->archdata.iommu;
> +	if (!priv)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* All the client devices are in the same m4u iommu-group */
> +	data = dev_get_drvdata(priv->m4udev);
> +	if (!data->m4u_group) {
> +		data->m4u_group = iommu_group_alloc();
> +		if (IS_ERR(data->m4u_group))
> +			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
> +	}
> +	return data->m4u_group;
> +}

This looks much better than before, thanks.
