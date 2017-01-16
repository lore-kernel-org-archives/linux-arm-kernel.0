From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Jan 2017 07:44:57 +0100
Subject: [PATCH 02/12] soc: samsung: pmu: Use of_device_get_match_data helper
In-Reply-To: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064524eucas1p1fb1b3d080298b895d95bed106879255e@eucas1p1.samsung.com>
Message-ID: <1484549107-5957-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace custom code with generic helper to retrieve driver data.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 63bb471845cb..0f4b4fce9d90 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -11,6 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 
@@ -94,7 +95,6 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 
@@ -111,10 +111,7 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	pmu_context->dev = dev;
-
-	match = of_match_node(exynos_pmu_of_device_ids, dev->of_node);
-
-	pmu_context->pmu_data = match->data;
+	pmu_context->pmu_data = of_device_get_match_data(dev);
 
 	if (pmu_context->pmu_data->pmu_init)
 		pmu_context->pmu_data->pmu_init();
-- 
1.9.1
