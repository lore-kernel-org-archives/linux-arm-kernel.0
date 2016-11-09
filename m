From: robin.murphy@arm.com (Robin Murphy)
Date: Wed,  9 Nov 2016 12:47:28 +0000
Subject: [PATCH 5/5] iommu/mediatek: Fix M4Uv1 group refcounting
In-Reply-To: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
References: <3922e1f14d8ecb50440b2d9b0d1123f3c9307fc5.1478695557.git.robin.murphy@arm.com>
Message-ID: <d549615167d20bc7449d28f7b770f88858191d21.1478695557.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For each subsequent device assigned to the m4u_group after its initial
allocation, we need to take an additional reference.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/mtk_iommu_v1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index b8aeb0768483..1b736990373f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -502,6 +502,8 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
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
