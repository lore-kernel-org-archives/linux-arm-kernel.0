From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jul 2017 22:47:18 +0200
Subject: [PATCH] drm: exynos: mark pm functions as __maybe_unused
Message-ID: <20170721204751.3370881-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rework of the exynos DRM clock handling introduced
warnings for configurations that have CONFIG_PM disabled:

drivers/gpu/drm/exynos/exynos_hdmi.c:736:13: error: 'hdmi_clk_disable_gates' defined but not used [-Werror=unused-function]
 static void hdmi_clk_disable_gates(struct hdmi_context *hdata)
             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/exynos/exynos_hdmi.c:717:12: error: 'hdmi_clk_enable_gates' defined but not used [-Werror=unused-function]
 static int hdmi_clk_enable_gates(struct hdmi_context *hdata)

The problem is that the PM functions themselves are inside of
an #ifdef, but some functions they call are not.

This patch removes the #ifdef and instead marks the PM functions
as __maybe_unused, which is a more reliable way to get it right.

Link: https://patchwork.kernel.org/patch/8436281/
Fixes: 9be7e9898444 ("drm/exynos/hdmi: clock code re-factoring")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Sent originally in Feb 2016 without reply. Found the patch
again in my backlog now, it's still needed.
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 06bfbe400cf1..02a00f1c6d5b 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1934,8 +1934,7 @@ static int hdmi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int exynos_hdmi_suspend(struct device *dev)
+static int __maybe_unused exynos_hdmi_suspend(struct device *dev)
 {
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 
@@ -1944,7 +1943,7 @@ static int exynos_hdmi_suspend(struct device *dev)
 	return 0;
 }
 
-static int exynos_hdmi_resume(struct device *dev)
+static int __maybe_unused exynos_hdmi_resume(struct device *dev)
 {
 	struct hdmi_context *hdata = dev_get_drvdata(dev);
 	int ret;
@@ -1955,7 +1954,6 @@ static int exynos_hdmi_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops exynos_hdmi_pm_ops = {
 	SET_RUNTIME_PM_OPS(exynos_hdmi_suspend, exynos_hdmi_resume, NULL)
-- 
2.9.0
