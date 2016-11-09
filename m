From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  9 Nov 2016 12:47:26 +0000
Subject: [PATCH 3/5] iommu/amd: Fix group refcounting
In-Reply-To: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
References: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
Message-ID: <afa2d74af82b161db0de3eb550b91519f0ad535f.1478695557.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If acpihid_device_group() finds an existing group for the relevant
devid, it should be taking an additional reference on that group.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 754595ee11b6..4ef05691ceb1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -373,6 +373,8 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 
 	if (!entry->group)
 		entry->group = generic_device_group(dev);
+	else
+		__iommu_group_get(entry->group);
 
 	return entry->group;
 }
-- 
2.10.2.dirty
