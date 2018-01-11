From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 11 Jan 2018 16:22:24 +0800
Subject: [PATCH 4/9] iommu/rockchip: Fix error handling in init
In-Reply-To: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Message-ID: <20180111082229.24011-5-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's hard to undo bus_set_iommu() in the error path, so move it to the
end of init call.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/iommu/rockchip-iommu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index a05844cabb45..5f141390b4d7 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1247,17 +1247,25 @@ static int __init rk_iommu_init(void)
 
 	of_node_put(np);
 
-	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
-	if (ret)
-		return ret;
-
 	ret = platform_driver_register(&rk_iommu_domain_driver);
 	if (ret)
 		return ret;
 
 	ret = platform_driver_register(&rk_iommu_driver);
 	if (ret)
-		platform_driver_unregister(&rk_iommu_domain_driver);
+		goto err_unreg_domain_drv;
+
+	ret = bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
+	if (ret)
+		goto err_unreg_iommu_drv;
+
+	return 0;
+
+err_unreg_iommu_drv:
+	platform_driver_unregister(&rk_iommu_driver);
+err_unreg_domain_drv:
+	platform_driver_unregister(&rk_iommu_domain_driver);
+
 	return ret;
 }
 static void __exit rk_iommu_exit(void)
-- 
2.11.0
