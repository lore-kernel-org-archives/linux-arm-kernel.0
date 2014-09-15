From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Sep 2014 19:36:24 +0100
Subject: [PATCH 2/7] iommu/arm-smmu: add support for multi-master iommu
 groups
In-Reply-To: <20140915152257.GX28786@8bytes.org>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
 <1409849405-17347-3-git-send-email-will.deacon@arm.com>
 <20140915152257.GX28786@8bytes.org>
Message-ID: <20140915183624.GB30737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Mon, Sep 15, 2014 at 04:22:57PM +0100, Joerg Roedel wrote:
> On Thu, Sep 04, 2014 at 05:50:00PM +0100, Will Deacon wrote:
> >  static struct arm_smmu_master_cfg *
> > -find_smmu_master_cfg(struct arm_smmu_device *smmu, struct device *dev)
> > +find_smmu_master_cfg(struct device *dev)
> >  {
> > -	struct arm_smmu_master *master;
> > -
> > -	if (dev_is_pci(dev))
> > -		return dev->archdata.iommu;
> > -
> > -	master = find_smmu_master(smmu, dev->of_node);
> > -	return master ? &master->cfg : NULL;
> > +	struct iommu_group *group = iommu_group_get(dev);
> > +	return group ? iommu_group_get_iommudata(group) : NULL;
> 
> Using iommu_group_get requires the call-sites to do an iommu_group_put
> in the end, but I don't see the call-sites updated.

Well spotted, thanks. Given that we have a reference on the group thanks to
iommu_group_alloc, I think it's better just having the put in this helper.

diff below. Unfortunately, I'm at a conference this week and so testing is
going to be difficult. I'll test early next week and try to get you a pull
request later that week for 3.18.

Will

--->8

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d2d8cdaf..939242c 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -474,8 +474,15 @@ static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
 static struct arm_smmu_master_cfg *
 find_smmu_master_cfg(struct device *dev)
 {
+       struct arm_smmu_master_cfg *cfg = NULL;
        struct iommu_group *group = iommu_group_get(dev);
-       return group ? iommu_group_get_iommudata(group) : NULL;
+
+       if (group) {
+               cfg = iommu_group_get_iommudata(group);
+               iommu_group_put(group);
+       }
+
+       return cfg;
 }
 
