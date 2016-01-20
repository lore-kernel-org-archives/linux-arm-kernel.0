From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jan 2016 11:33:37 +0100
Subject: [PATCH] drm: exynos: make PM functions as __maybe_unused
Message-ID: <12427702.1DA55iFFLW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added runtime-pm support for exynos-drm encloses the
pm functions in an #ifdef, but not the functions that are called
from them and nowhere else, which produces warnings:

drm/exynos/exynos_drm_dsi.c:733:13: warning: 'exynos_dsi_disable_clock' defined but not used [-Wunused-function]
 static void exynos_dsi_disable_clock(struct exynos_dsi *dsi)
             ^
drm/exynos/exynos_drm_dsi.c:1291:13: warning: 'exynos_dsi_disable_irq' defined but not used [-Wunused-function]
 static void exynos_dsi_disable_irq(struct exynos_dsi *dsi)
             ^

This removes the #ifdef and instead marks the functions as
__maybe_unused, so gcc can silently discard them and all called
functions when CONFIG_PM is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ba6e47795d83 ("drm/exynos: dsi: add runtime pm support")
---
This is a regression against 4.4, found on ARM randconfig testing

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index d84a498ef099..e977a81af2e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1906,8 +1906,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int exynos_dsi_suspend(struct device *dev)
+static int __maybe_unused exynos_dsi_suspend(struct device *dev)
 {
 	struct drm_encoder *encoder = dev_get_drvdata(dev);
 	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
@@ -1938,7 +1937,7 @@ static int exynos_dsi_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_dsi_resume(struct device *dev)
+static int __maybe_unused exynos_dsi_resume(struct device *dev)
 {
 	struct drm_encoder *encoder = dev_get_drvdata(dev);
 	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
@@ -1972,7 +1971,6 @@ err_clk:
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops exynos_dsi_pm_ops = {
 	SET_RUNTIME_PM_OPS(exynos_dsi_suspend, exynos_dsi_resume, NULL)
