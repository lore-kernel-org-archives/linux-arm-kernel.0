From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:50:01 +0100
Subject: [PATCH 3/7] iommu/arm-smmu: put iommu_domain pointer in
 dev->archdata.iommu
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for nested translation support, stick a pointer to the
iommu_domain in dev->archdata.iommu. This makes it much easier to grab
hold of the physical group configuration (e.g. cbndx) when dealing with
vSMMU accesses from a guest.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ef6623dbba9a..7ab3cc4ffbb3 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1206,6 +1206,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -ENXIO;
 	}
 
+	if (dev->archdata.iommu) {
+		dev_err(dev, "already attached to IOMMU domain\n");
+		return -EEXIST;
+	}
+
 	/*
 	 * Sanity check the domain. We don't support domains across
 	 * different SMMUs.
@@ -1232,7 +1237,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!cfg)
 		return -ENODEV;
 
-	return arm_smmu_domain_add_master(smmu_domain, cfg);
+	ret = arm_smmu_domain_add_master(smmu_domain, cfg);
+	if (!ret)
+		dev->archdata.iommu = domain;
+	return ret;
 }
 
 static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
@@ -1241,8 +1249,11 @@ static void arm_smmu_detach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_master_cfg *cfg;
 
 	cfg = find_smmu_master_cfg(dev);
-	if (cfg)
-		arm_smmu_domain_remove_master(smmu_domain, cfg);
+	if (!cfg)
+		return;
+
+	dev->archdata.iommu = NULL;
+	arm_smmu_domain_remove_master(smmu_domain, cfg);
 }
 
 static bool arm_smmu_pte_is_contiguous_range(unsigned long addr,
-- 
2.1.0
