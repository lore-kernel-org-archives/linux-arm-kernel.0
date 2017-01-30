From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 30 Jan 2017 13:38:28 +0100
Subject: [PATCH v3 7/7] mfd: exynos-lpass: Add runtime PM support
In-Reply-To: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
References: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130123840eucas1p20025e600860b43b2da81d9063f96e442@eucas1p2.samsung.com>
Message-ID: <1485779908-32147-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert exisitng lpass-suspend/resume callbacks into runtime PM callbacks.
This way Exynos LPASS driver will be ready for use with power domains
enabled. LPASS will be runtime resumed/suspended as a result of its child
devices runtime PM transitions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/mfd/exynos-lpass.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 9dbbedad916f..6d735e22acda 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
 
@@ -132,6 +133,8 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, lpass);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
 	exynos_lpass_enable(lpass);
 
 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
@@ -141,7 +144,9 @@ static int exynos_lpass_remove(struct platform_device *pdev)
 {
 	struct exynos_lpass *lpass = platform_get_drvdata(pdev);
 
-	exynos_lpass_disable(lpass);
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		exynos_lpass_disable(lpass);
 	regmap_exit(lpass->top);
 
 	return 0;
@@ -165,8 +170,11 @@ static int __maybe_unused exynos_lpass_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(lpass_pm_ops, exynos_lpass_suspend,
-					exynos_lpass_resume);
+static const struct dev_pm_ops lpass_pm_ops = {
+	SET_RUNTIME_PM_OPS(exynos_lpass_suspend, exynos_lpass_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
+};
 
 static const struct of_device_id exynos_lpass_of_match[] = {
 	{ .compatible = "samsung,exynos5433-lpass" },
-- 
1.9.1
