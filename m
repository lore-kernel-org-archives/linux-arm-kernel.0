From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  9 Nov 2016 12:47:27 +0000
Subject: [PATCH 4/5] iommu/mediatek: Fix M4Uv2 group refcounting
In-Reply-To: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
References: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
Message-ID: <9d6ca90751dd6876c52706fc4982dd9f4f7b6333.1478695557.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For each subsequent device assigned to the m4u_group after its initial
allocation, we need to take an additional reference.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/mtk_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b12c12d74c33..f5591f6aef49 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -410,6 +410,8 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 		data->m4u_group = iommu_group_alloc();
 		if (IS_ERR(data->m4u_group))
 			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
+	} else {
+		__iommu_group_get(data->m4u_group);
 	}
 	return data->m4u_group;
 }
-- 
2.10.2.dirty
