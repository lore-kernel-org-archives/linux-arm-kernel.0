From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:44 +0200
Subject: [PATCH 16/29] iommu: exynos: make driver multiarch friendly
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-17-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize all structures and register to iommu subsystem only on Exynos
compatible platforms.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d037e87..64b3bc8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/of.h>
 #include <linux/iommu.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -1187,6 +1188,11 @@ static int __init exynos_iommu_init(void)
 {
 	int ret;
 
+	if (!of_machine_is_compatible("samsung,exynos3") &&
+	    !of_machine_is_compatible("samsung,exynos4") &&
+	    !of_machine_is_compatible("samsung,exynos5"))
+		return -ENODEV;
+
 	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
 				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
 	if (!lv2table_kmem_cache) {
-- 
1.9.2
