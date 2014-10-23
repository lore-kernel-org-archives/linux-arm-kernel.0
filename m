From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 23 Oct 2014 15:48:10 +0200
Subject: [RFC 2/2] drm/exynos/dsi: Add runtime PM so LCD power domain could be
 turned off
In-Reply-To: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414072090-11293-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add runtime Power Management to the Exynos DSI driver so the LCD power
domain could be turned off.

This slightly reduces the energy consumption when screen is completely
turned off. On Trats2 board when the system was idle the energy
consumption dropped by 1% (from 92.2 mA to 91.1 mA).

Before the patch:
$ cat cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
lcd0-power-domain               on
    /devices/11c00000.fimd                              suspended
    /devices/11c80000.dsi                               unsupported
After applying the patch:
lcd0-power-domain               off
    /devices/11c00000.fimd                              suspended
    /devices/11c80000.dsi                               suspended

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 24741d8758e8..19ed36d2d557 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/component.h>
 
@@ -1356,6 +1357,8 @@ static int exynos_dsi_enable(struct exynos_dsi *dsi)
 	if (dsi->state & DSIM_STATE_ENABLED)
 		return 0;
 
+	pm_runtime_get_sync(dsi->dev);
+
 	ret = exynos_dsi_poweron(dsi);
 	if (ret < 0)
 		return ret;
@@ -1392,6 +1395,8 @@ static void exynos_dsi_disable(struct exynos_dsi *dsi)
 	drm_panel_unprepare(dsi->panel);
 	exynos_dsi_poweroff(dsi);
 
+	pm_runtime_put_sync(dsi->dev);
+
 	dsi->state &= ~DSIM_STATE_ENABLED;
 }
 
@@ -1772,6 +1777,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_del_component;
 
+	pm_runtime_enable(&pdev->dev);
+
 	return ret;
 
 err_del_component:
@@ -1781,6 +1788,8 @@ err_del_component:
 
 static int exynos_dsi_remove(struct platform_device *pdev)
 {
+	pm_runtime_disable(&pdev->dev);
+
 	component_del(&pdev->dev, &exynos_dsi_component_ops);
 	exynos_drm_component_del(&pdev->dev, EXYNOS_DEVICE_TYPE_CONNECTOR);
 
-- 
1.9.1
