From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 17 Jan 2018 12:31:05 +0000
Subject: [PATCH v2 09/13] iommu/rockchip: Use iommu_group_get_for_dev()
 for add_device
In-Reply-To: <20180116132540.18939-10-jeffy.chen@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
 <20180116132540.18939-10-jeffy.chen@rock-chips.com>
Message-ID: <4c1b2469-9a32-c6ca-522f-73143b0fa618@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/18 13:25, Jeffy Chen wrote:
> IOMMU drivers are supposed to call this function instead of manually
> creating a group in their .add_device callback. This behavior is not
> strictly required by ARM DMA mapping implementation, but ARM64 already
> relies on it. This patch fixes the rockchip-iommu driver to comply with
> this requirement.

FWIW that's not 100% true: what arm64 relies on is the group having a 
default DMA ops domain. Technically, you *could* open-code that in the 
driver's group allocation, but obviously using the appropriate existing 
API is nicer :)

[...]
> @@ -1182,6 +1164,29 @@ static void rk_iommu_remove_device(struct device *dev)
>   	iommu_group_remove_device(dev);
>   }
>   
> +static struct iommu_group *rk_iommu_device_group(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	group = iommu_group_get(dev);
> +	if (!group) {

This check is pointless - if dev->iommu_group were non-NULL you wouldn't 
have been called in the first place.

Robin.

> +		group = iommu_group_alloc();
> +		if (IS_ERR(group))
> +			return group;
> +	}
> +
> +	ret = rk_iommu_group_set_iommudata(group, dev);
> +	if (ret)
> +		goto err_put_group;
> +
> +	return group;
> +
> +err_put_group:
> +	iommu_group_put(group);
> +	return ERR_PTR(ret);
> +}
> +
>   static const struct iommu_ops rk_iommu_ops = {
>   	.domain_alloc = rk_iommu_domain_alloc,
>   	.domain_free = rk_iommu_domain_free,
> @@ -1193,6 +1198,7 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.add_device = rk_iommu_add_device,
>   	.remove_device = rk_iommu_remove_device,
>   	.iova_to_phys = rk_iommu_iova_to_phys,
> +	.device_group = rk_iommu_device_group,
>   	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
>   };
>   
> 
