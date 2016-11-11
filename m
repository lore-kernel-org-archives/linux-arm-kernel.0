From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Nov 2016 17:59:23 +0000
Subject: [PATCH v2 3/5] iommu/amd: Fix group refcounting
In-Reply-To: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
References: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
Message-ID: <aee017c7d014c9c27201e2b8e1439d42b66e9fec.1478886974.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If acpihid_device_group() finds an existing group for the relevant
devid, it should be taking an additional reference on that group.
Otherwise, the caller of iommu_group_get_for_dev() will inadvertently
remove the reference taken by iommu_group_add_device(), and the group
will be freed prematurely if any device is removed.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 754595ee11b6..019e02707cd5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -373,6 +373,8 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 
 	if (!entry->group)
 		entry->group = generic_device_group(dev);
+	else
+		iommu_group_ref_get(entry->group);
 
 	return entry->group;
 }
-- 
2.10.2.dirty
