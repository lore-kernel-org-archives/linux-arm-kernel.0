From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Oct 2014 09:41:00 +0200
Subject: [PATCH] iommu: exynos: make driver multiarch friendly
In-Reply-To: <1987006.J2W7PED0yz@wuerfel>
References: <1987006.J2W7PED0yz@wuerfel>
Message-ID: <1414136460-31374-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize all structures and register to iommu subsystem only on Exynos
compatible platforms.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/exynos-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7423318..a77350e 100644
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
@@ -1188,6 +1189,11 @@ static int __init exynos_iommu_init(void)
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
