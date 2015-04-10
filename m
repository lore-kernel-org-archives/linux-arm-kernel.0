From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Apr 2015 23:58:24 +0200
Subject: [PATCH] iommu: rockchip: fix build without CONFIG_OF
Message-ID: <3138014.xYAj3FssJ8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip iommu driver references its of_device_id table
from the init function, which fails to build when the table
is undefined:

iommu/rockchip-iommu.c: In function 'rk_iommu_init':
iommu/rockchip-iommu.c:1029:35: error: 'rk_iommu_dt_ids' undeclared (first use in this function)
  np = of_find_matching_node(NULL, rk_iommu_dt_ids);

This removes the #ifdef and the corresponding of_match_ptr wrapper
to make it build both with CONFIG_OF enabled or disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 425061b0f5074 ("iommu/rockchip: Play nice in multi-platform builds")

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4015560bf486..cab214544237 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1004,20 +1004,18 @@ static int rk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{ .compatible = "rockchip,iommu" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rk_iommu_dt_ids);
-#endif
 
 static struct platform_driver rk_iommu_driver = {
 	.probe = rk_iommu_probe,
 	.remove = rk_iommu_remove,
 	.driver = {
 		   .name = "rk_iommu",
-		   .of_match_table = of_match_ptr(rk_iommu_dt_ids),
+		   .of_match_table = rk_iommu_dt_ids,
 	},
 };
 
