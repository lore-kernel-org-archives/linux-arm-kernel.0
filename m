From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Mar 2016 16:49:18 +0900
Subject: [PATCH 1/5] hwrng: exynos - Hide PM functions with __maybe_unused
Message-ID: <1457682562-21219-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace ifdef with __maybe_unused to silence compiler warning on when
SUSPEND=n and PM=y:

drivers/char/hw_random/exynos-rng.c:166:12: warning: ?exynos_rng_suspend? defined but not used [-Wunused-function]
 static int exynos_rng_suspend(struct device *dev)
            ^
drivers/char/hw_random/exynos-rng.c:171:12: warning: ?exynos_rng_resume? defined but not used [-Wunused-function]
 static int exynos_rng_resume(struct device *dev)

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/char/hw_random/exynos-rng.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index 30cf4623184f..ada081232528 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -144,8 +144,7 @@ static int exynos_rng_probe(struct platform_device *pdev)
 	return devm_hwrng_register(&pdev->dev, &exynos_rng->rng);
 }
 
-#ifdef CONFIG_PM
-static int exynos_rng_runtime_suspend(struct device *dev)
+static int __maybe_unused exynos_rng_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
@@ -155,7 +154,7 @@ static int exynos_rng_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_rng_runtime_resume(struct device *dev)
+static int __maybe_unused exynos_rng_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
@@ -163,12 +162,12 @@ static int exynos_rng_runtime_resume(struct device *dev)
 	return clk_prepare_enable(exynos_rng->clk);
 }
 
-static int exynos_rng_suspend(struct device *dev)
+static int __maybe_unused exynos_rng_suspend(struct device *dev)
 {
 	return pm_runtime_force_suspend(dev);
 }
 
-static int exynos_rng_resume(struct device *dev)
+static int __maybe_unused exynos_rng_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct exynos_rng *exynos_rng = platform_get_drvdata(pdev);
@@ -180,7 +179,6 @@ static int exynos_rng_resume(struct device *dev)
 
 	return exynos_rng_configure(exynos_rng);
 }
-#endif
 
 static const struct dev_pm_ops exynos_rng_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(exynos_rng_suspend, exynos_rng_resume)
-- 
2.5.0
