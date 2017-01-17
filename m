From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 17 Jan 2017 13:44:33 +0100
Subject: [PATCH v2 02/13] soc: samsung: pmu: Use of_device_get_match_data
 helper
In-Reply-To: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124457eucas1p120dac823e1cd08421cb8d7411a9eebbd@eucas1p1.samsung.com>
Message-ID: <1484657084-26227-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace custom code with generic helper to retrieve driver data.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 5c269bf23210..1f914e63dcc6 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -11,6 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
@@ -105,7 +106,6 @@ struct regmap *exynos_get_pmu_regmap(void)
 
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 
@@ -122,10 +122,7 @@ static int exynos_pmu_probe(struct platform_device *pdev)
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
