From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 11 Nov 2016 17:59:24 +0000
Subject: [PATCH v2 4/5] iommu/mediatek: Fix M4Uv2 group refcounting
In-Reply-To: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
References: <37029eb869380edb0d5ce8cc6601ce7e69c80458.1478886974.git.robin.murphy@arm.com>
Message-ID: <969e51c6457c539715db85d7951d7d1061d5866a.1478886974.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For each subsequent device assigned to the m4u_group after its initial
allocation, we need to take an additional reference. Otherwise, the
caller of iommu_group_get_for_dev() will inadvertently remove the
reference taken by iommu_group_add_device(), and the group will be
freed prematurely if any device is removed.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b12c12d74c33..9799daeaacde 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -410,6 +410,8 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 		data->m4u_group = iommu_group_alloc();
 		if (IS_ERR(data->m4u_group))
 			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+	} else {
+		iommu_group_ref_get(data->m4u_group);
 	}
 	return data->m4u_group;
 }
-- 
2.10.2.dirty
