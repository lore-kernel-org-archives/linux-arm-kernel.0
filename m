From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 May 2015 18:09:26 +0100
Subject: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
 SMMUv3 devices
In-Reply-To: <20150519152435.GL20611@8bytes.org>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
 <1431108046-9675-3-git-send-email-will.deacon@arm.com>
 <20150519152435.GL20611@8bytes.org>
Message-ID: <20150520170926.GI11498@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 04:24:35PM +0100, Joerg Roedel wrote:
> Hi Will,

Hi Joerg,

> the code looks good overall, I just have some questions below.

Great, thanks for having a look. I'll still need to post a v2 to address
some of the other comments I've had.

> On Fri, May 08, 2015 at 07:00:45PM +0100, Will Deacon wrote:
> > +static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > +{
> > +	int ret = 0;
> > +	struct arm_smmu_device *smmu;
> > +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > +	struct arm_smmu_group *smmu_group = arm_smmu_group_get(dev);
> > +
> > +	if (!smmu_group)
> > +		return -ENOENT;
> > +
> > +	/* Already attached to a different domain? */
> > +	if (smmu_group->domain && smmu_group->domain != smmu_domain)
> > +		return -EEXIST;
> > +
> > +	smmu = smmu_group->smmu;
> > +	mutex_lock(&smmu_domain->init_mutex);
> > +
> > +	if (!smmu_domain->smmu) {
> > +		smmu_domain->smmu = smmu;
> > +		ret = arm_smmu_domain_finalise(domain);
> > +		if (ret) {
> > +			smmu_domain->smmu = NULL;
> > +			goto out_unlock;
> > +		}
> > +	} else if (smmu_domain->smmu != smmu) {
> > +		dev_err(dev,
> > +			"cannot attach to SMMU %s (upstream of %s)\n",
> > +			dev_name(smmu_domain->smmu->dev),
> > +			dev_name(smmu->dev));
> > +		ret = -ENXIO;
> > +		goto out_unlock;
> > +	}
> 
> This looks like all devices in a domain need to be behind the same SMMU
> device, right?

Yes, that's correct. This matches what we do for the arm-smmu driver
already and is mainly brought about by the potential for hardware
differences between different SMMU instances in the same SoC.

> > +	/* Page sizes */
> > +	if (reg & IDR5_GRAN64K)
> > +		pgsize_bitmap |= SZ_64K | SZ_512M;
> > +	if (reg & IDR5_GRAN16K)
> > +		pgsize_bitmap |= SZ_16K | SZ_32M;
> > +	if (reg & IDR5_GRAN4K)
> > +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> > +
> > +	arm_smmu_ops.pgsize_bitmap &= pgsize_bitmap;
> 
> So this could effictivly lead to a zero pgsize_bitmap when there are
> SMMUs in the system with support for different page sizes, no?

Indeed, if there is no common page size then we end up not being able to
support any. I tried to resolve this by moving the bitmap out of the
iommu_ops and into the iommu_domain, but you weren't fond of that idea ;)

Will
