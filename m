From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Mon, 1 Aug 2016 11:48:38 +0530
Subject: [PATCH] iommu/exynos: Modify error handling
Message-ID: <20160801061838.GA17805@amitoj-Inspiron-3542>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_platform_device_create returns NULL on error so an IS_ERR test is
incorrect here and a NULL check is required.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e;
@@

  e = of_platform_device_create(...);
if(
-    IS_ERR(e)
+    !e
    )
    {
  <+...
  return
- PTR_ERR(e)
+ -ENODEV
  ;
  ...+>
  }

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 97c41b8..2888bbf 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1242,8 +1242,8 @@ static int __init exynos_iommu_of_setup(struct device_node *np)
 		exynos_iommu_init();
 
 	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	if (!pdev)
+		return -ENODEV;
 
 	of_iommu_set_ops(np, &exynos_iommu_ops);
 	return 0;
-- 
1.9.1
