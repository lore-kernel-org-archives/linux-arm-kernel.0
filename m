From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 12:55:56 +0100
Subject: [PATCH] drm: exynos: mark pm functions __maybe_unused
Message-ID: <1456487773-3963404-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos drm driver implements power management functions that
are hidden inside of #ifdef, but when they are all disabled,
we get a warning about another unused function that is not
called from elsewhere:

drivers/gpu/drm/exynos/exynos_drm_gsc.c:1219:12: error: 'gsc_clk_ctrl' defined but not used [-Werror=unused-function]

This removes the #ifdef and instead uses a __maybe_unused annotation
that avoids the problem because now gcc can see how the function is
(not) used and silently drop it.

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
2.7.0
