From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 15 Sep 2014 17:22:57 +0200
Subject: [PATCH 2/7] iommu/arm-smmu: add support for multi-master iommu
 groups
In-Reply-To: <1409849405-17347-3-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
 <1409849405-17347-3-git-send-email-will.deacon@arm.com>
Message-ID: <20140915152257.GX28786@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 05:50:00PM +0100, Will Deacon wrote:
>  static struct arm_smmu_master_cfg *
> -find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
> +find_smmu_master_cfg(struct device *dev)
>  {
> -	struct arm_smmu_master *master;
> -
> -	if (dev_is_pci(dev))
> -		return dev->archdata.iommu;
> -
> -	master = find_smmu_master(smmu, dev->of_node);
> -	return master ? &master->cfg : NULL;
> +	struct iommu_group *group = iommu_group_get(dev);
> +	return group ? iommu_group_get_iommudata(group) : NULL;

Using iommu_group_get requires the call-sites to do an iommu_group_put
in the end, but I don't see the call-sites updated.


	Joerg
