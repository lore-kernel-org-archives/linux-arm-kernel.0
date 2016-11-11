From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Nov 2016 17:59:22 +0000
Subject: [PATCH v2 2/5] iommu/arm-smmu: Fix group refcounting
In-Reply-To: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
References: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
Message-ID: <5db22e1fb00595444a4ca593335c4675b09804de.1478886974.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When arm_smmu_device_group() finds an existing group due to Stream ID
aliasing, it should be taking an additional reference on that group.
Otherwise, the caller of iommu_group_get_for_dev() will inadvertently
remove the reference taken by iommu_group_add_device(), and the group
will be freed prematurely if any device is removed.

Reported-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8f7281444551..b8cd5579a953 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1478,7 +1478,7 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
 	}
 
 	if (group)
-		return group;
+		return iommu_group_ref_get(group);
 
 	if (dev_is_pci(dev))
 		group = pci_device_group(dev);
-- 
2.10.2.dirty
