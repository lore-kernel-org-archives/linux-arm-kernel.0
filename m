From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 May 2015 10:16:12 +0200
Subject: [PATCH v6 17/25] iommu: exynos: init from dt-specific callback instead
 of initcall
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1430727380-10912-18-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces IOMMU_OF_DECLARE-based initialization to the
driver, which replaces subsys_initcall-based procedure.
exynos_iommu_of_setup ensures that each sysmmu controller is probed
before its master device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 5429e75b120c..94fbd870ede6 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -13,16 +13,21 @@
 #endif
 
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/of.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #include <asm/cacheflush.h>
+#include <asm/dma-iommu.h>
 #include <asm/pgtable.h>
 
 typedef u32 sysmmu_iova_t;
@@ -1077,7 +1082,7 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	return phys;
 }
 
-static const struct iommu_ops exynos_iommu_ops = {
+static struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.domain_free = exynos_iommu_domain_free,
 	.attach_dev = exynos_iommu_attach_device,
@@ -1089,6 +1094,8 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 };
 
+static bool init_done;
+
 static int __init exynos_iommu_init(void)
 {
 	struct device_node *np;
@@ -1128,6 +1135,8 @@ static int __init exynos_iommu_init(void)
 		goto err_set_iommu;
 	}
 
+	init_done = true;
+
 	return 0;
 err_set_iommu:
 	kmem_cache_free(lv2table_kmem_cache, zero_lv2_table);
@@ -1137,4 +1146,21 @@ err_reg_driver:
 	kmem_cache_destroy(lv2table_kmem_cache);
 	return ret;
 }
-subsys_initcall(exynos_iommu_init);
+
+static int __init exynos_iommu_of_setup(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	if (!init_done)
+		exynos_iommu_init();
+
+	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	of_iommu_set_ops(np, &exynos_iommu_ops);
+	return 0;
+}
+
+IOMMU_OF_DECLARE(exynos_iommu_of, "samsung,exynos-sysmmu",
+		 exynos_iommu_of_setup);
-- 
1.9.2
