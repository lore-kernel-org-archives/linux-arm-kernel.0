From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 19 May 2015 17:24:35 +0200
Subject: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
 SMMUv3 devices
In-Reply-To: <1431108046-9675-3-git-send-email-will.deacon@arm.com>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
 <1431108046-9675-3-git-send-email-will.deacon@arm.com>
Message-ID: <20150519152435.GL20611@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

the code looks good overall, I just have some questions below.

On Fri, May 08, 2015 at 07:00:45PM +0100, Will Deacon wrote:
> +static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> +{
> +	int ret = 0;
> +	struct arm_smmu_device *smmu;
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
> +
> +	if (!smmu_group)
> +		return -ENOENT;
> +
> +	/* Already attached to a different domain? */
> +	if (smmu_group->domain && smmu_group->domain != smmu_domain)
> +		return -EEXIST;
> +
> +	smmu = smmu_group->smmu;
> +	mutex_lock(&smmu_domain->init_mutex);
> +
> +	if (!smmu_domain->smmu) {
> +		smmu_domain->smmu = smmu;
> +		ret = arm_smmu_domain_finalise(domain);
> +		if (ret) {
> +			smmu_domain->smmu = NULL;
> +			goto out_unlock;
> +		}
> +	} else if (smmu_domain->smmu != smmu) {
> +		dev_err(dev,
> +			"cannot attach to SMMU %s (upstream of %s)\n",
> +			dev_name(smmu_domain->smmu->dev),
> +			dev_name(smmu->dev));
> +		ret = -ENXIO;
> +		goto out_unlock;
> +	}

This looks like all devices in a domain need to be behind the same SMMU
device, right?


> +	/* Page sizes */
> +	if (reg & IDR5_GRAN64K)
> +		pgsize_bitmap |= SZ_64K | SZ_512M;
> +	if (reg & IDR5_GRAN16K)
> +		pgsize_bitmap |= SZ_16K | SZ_32M;
> +	if (reg & IDR5_GRAN4K)
> +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> +
> +	arm_smmu_ops.pgsize_bitmap &= pgsize_bitmap;

So this could effictivly lead to a zero pgsize_bitmap when there are
SMMUs in the system with support for different page sizes, no?


	Joerg
