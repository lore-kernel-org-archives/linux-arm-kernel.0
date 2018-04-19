From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Thu, 19 Apr 2018 16:05:36 +0200
Subject: [PATCH 06/61] crypto: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180419140641.27926-7-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/crypto/exynos-rng.c       | 6 ++----
 drivers/crypto/picoxcell_crypto.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/exynos-rng.c b/drivers/crypto/exynos-rng.c
index 86f5f459762e..2cfabb99cb6e 100644
--- a/drivers/crypto/exynos-rng.c
+++ b/drivers/crypto/exynos-rng.c
@@ -319,8 +319,7 @@ static int exynos_rng_remove(struct platform_device *pdev)
 
 static int __maybe_unused exynos_rng_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos_rng_dev *rng = platform_get_drvdata(pdev);
+	struct exynos_rng_dev *rng = dev_get_drvdata(dev);
 	int ret;
 
 	/* If we were never seeded then after resume it will be the same */
@@ -350,8 +349,7 @@ static int __maybe_unused exynos_rng_suspend(struct device *dev)
 
 static int __maybe_unused exynos_rng_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos_rng_dev *rng = platform_get_drvdata(pdev);
+	struct exynos_rng_dev *rng = dev_get_drvdata(dev);
 	int ret;
 
 	/* Never seeded so nothing to do */
diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index a4df966adbf6..321d5e2ac833 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1169,8 +1169,7 @@ static void spacc_spacc_complete(unsigned long data)
 #ifdef CONFIG_PM
 static int spacc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spacc_engine *engine = platform_get_drvdata(pdev);
+	struct spacc_engine *engine = dev_get_drvdata(dev);
 
 	/*
 	 * We only support standby mode. All we have to do is gate the clock to
@@ -1184,8 +1183,7 @@ static int spacc_suspend(struct device *dev)
 
 static int spacc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spacc_engine *engine = platform_get_drvdata(pdev);
+	struct spacc_engine *engine = dev_get_drvdata(dev);
 
 	return clk_enable(engine->clk);
 }
-- 
2.11.0
