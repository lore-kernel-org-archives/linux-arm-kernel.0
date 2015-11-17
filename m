From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 16:08:36 +0100
Subject: [PATCH] drm/exynos: fix building without CONFIG_PM_SLEEP
Message-ID: <9569056.LBRz4v8fSj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The runtime PM operations use the suspend/resume functions
even when CONFIG_PM_SLEEP is not set, but this now fails
for the exynos DRM driver:

exynos_mixer.c:1289:61: error: 'exynos_mixer_resume' undeclared here (not in a function)
  SET_RUNTIME_PM_OPS(exynos_mixer_suspend, exynos_mixer_resume, NULL)

This removes the #ifdef and instead marks the functions as
__maybe_unused, which does the right thing in all cases and
also looks nicer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 	 ("drm/exynos: add pm_runtime to Mixer")

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 7498c6e76a53..fcaf71df77c1 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1230,8 +1230,7 @@ static int mixer_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int exynos_mixer_suspend(struct device *dev)
+static int __maybe_unused exynos_mixer_suspend(struct device *dev)
 {
 	struct mixer_context *ctx = dev_get_drvdata(dev);
 	struct mixer_resources *res = &ctx->mixer_res;
@@ -1247,7 +1246,7 @@ static int exynos_mixer_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_mixer_resume(struct device *dev)
+static int __maybe_unused exynos_mixer_resume(struct device *dev)
 {
 	struct mixer_context *ctx = dev_get_drvdata(dev);
 	struct mixer_resources *res = &ctx->mixer_res;
@@ -1283,7 +1282,6 @@ static int exynos_mixer_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops exynos_mixer_pm_ops = {
 	SET_RUNTIME_PM_OPS(exynos_mixer_suspend, exynos_mixer_resume, NULL)
