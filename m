From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue,  6 Mar 2018 11:27:57 +0800
Subject: [PATCH v7 12/14] iommu/rockchip: Fix error handling in init
In-Reply-To: <20180306032759.29069-1-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com>
Message-ID: <20180306032759.29069-3-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's hard to undo bus_set_iommu() in the error path, so move it to the
end of rk_iommu_probe().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
Move bus_set_iommu() to rk_iommu_probe().

 drivers/iommu/rockchip-iommu.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 1346bbb8a3e7..2448a0528e39 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1133,6 +1133,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
+	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
@@ -1158,19 +1160,6 @@ static struct platform_driver rk_iommu_driver = {
 
 static int __init rk_iommu_init(void)
 {
-	struct device_node *np;
-	int ret;
-
-	np = of_find_matching_node(NULL, rk_iommu_dt_ids);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
-	if (ret)
-		return ret;
-
 	return platform_driver_register(&rk_iommu_driver);
 }
 subsys_initcall(rk_iommu_init);
-- 
2.11.0
