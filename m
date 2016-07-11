From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 23:51:54 +0200
Subject: [PATCH] drm: exynos: avoid unused function warning
Message-ID: <20160711215258.2725710-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PM is not set, we get a warning about an unused function:

drivers/gpu/drm/exynos/exynos_drm_gsc.c:1219:12: error: 'gsc_clk_ctrl' defined but not used [-Werror=unused-function]
 static int gsc_clk_ctrl(struct gsc_context *ctx, bool enable)
            ^~~~~~~~~~~~

This removes the two #ifdef checks in this file and instead marks the
functions as __maybe_unused, which is a more reliable way of doing the
same, allowing better build coverage and avoiding the warning above.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 5d20da8f957e..b0a773790f85 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1760,8 +1760,7 @@ static int gsc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int gsc_suspend(struct device *dev)
+static int __maybe_unused gsc_suspend(struct device *dev)
 {
 	struct gsc_context *ctx = get_gsc_context(dev);
 
@@ -1773,7 +1772,7 @@ static int gsc_suspend(struct device *dev)
 	return gsc_clk_ctrl(ctx, false);
 }
 
-static int gsc_resume(struct device *dev)
+static int __maybe_unused gsc_resume(struct device *dev)
 {
 	struct gsc_context *ctx = get_gsc_context(dev);
 
@@ -1784,10 +1783,8 @@ static int gsc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM
-static int gsc_runtime_suspend(struct device *dev)
+static int __maybe_unused gsc_runtime_suspend(struct device *dev)
 {
 	struct gsc_context *ctx = get_gsc_context(dev);
 
@@ -1796,7 +1793,7 @@ static int gsc_runtime_suspend(struct device *dev)
 	return  gsc_clk_ctrl(ctx, false);
 }
 
-static int gsc_runtime_resume(struct device *dev)
+static int __maybe_unused gsc_runtime_resume(struct device *dev)
 {
 	struct gsc_context *ctx = get_gsc_context(dev);
 
@@ -1804,7 +1801,6 @@ static int gsc_runtime_resume(struct device *dev)
 
 	return  gsc_clk_ctrl(ctx, true);
 }
-#endif
 
 static const struct dev_pm_ops gsc_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(gsc_suspend, gsc_resume)
-- 
2.9.0
