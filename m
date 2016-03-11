From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Mar 2016 16:49:21 +0900
Subject: [PATCH 4/5] hwrng: exynos - Disable runtime PM on probe failure
In-Reply-To: <1457682562-21219-1-git-send-email-k.kozlowski@samsung.com>
References: <1457682562-21219-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1457682562-21219-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add proper error path (for disabling runtime PM) when registering of
hwrng fails.

Fixes: b329669ea0b5 ("hwrng: exynos - Add support for Exynos random number generator")
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/char/hw_random/exynos-rng.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/exynos-rng.c b/drivers/char/hw_random/exynos-rng.c
index 38b80f82ddd2..68c349bf66a0 100644
--- a/drivers/char/hw_random/exynos-rng.c
+++ b/drivers/char/hw_random/exynos-rng.c
@@ -119,6 +119,7 @@ static int exynos_rng_probe(struct platform_device *pdev)
 {
 	struct exynos_rng *exynos_rng;
 	struct resource *res;
+	int ret;
 
 	exynos_rng = devm_kzalloc(&pdev->dev, sizeof(struct exynos_rng),
 					GFP_KERNEL);
@@ -146,7 +147,11 @@ static int exynos_rng_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	return devm_hwrng_register(&pdev->dev, &exynos_rng->rng);
+	ret = devm_hwrng_register(&pdev->dev, &exynos_rng->rng);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
 }
 
 static int __maybe_unused exynos_rng_runtime_suspend(struct device *dev)
-- 
2.5.0
