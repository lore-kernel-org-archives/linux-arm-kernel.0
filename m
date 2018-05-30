From: m.purski@samsung.com (Maciej Purski)
Date: Wed, 30 May 2018 14:15:53 +0200
Subject: [PATCH v2 02/10] drm/exynos: move pm_runtime_get_sync() to
 exynos_dsi_init()
In-Reply-To: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
 <CGME20180530121623eucas1p1309b2c054ccd7a52a611b46346709af9@eucas1p1.samsung.com>
Message-ID: <1527682561-1386-3-git-send-email-m.purski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to allow bridge drivers to use DSI transfers in their
pre_enable callbacks, pm_runtime_get_sync() should be performed before
exynos_dsi_enable(). DSIM_STATE_ENABLED flag now should not guard
from calling dsi_host_transfer() before enabling.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 9599e6b..85eb2262 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1312,6 +1312,7 @@ static int exynos_dsi_init(struct exynos_dsi *dsi)
 {
 	const struct exynos_dsi_driver_data *driver_data = dsi->driver_data;
 
+	pm_runtime_get_sync(dsi->dev);
 	exynos_dsi_reset(dsi);
 	exynos_dsi_enable_irq(dsi);
 
@@ -1388,7 +1389,6 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 	ret = drm_panel_prepare(dsi->panel);
 	if (ret < 0) {
 		dsi->state &= ~DSIM_STATE_ENABLED;
-		pm_runtime_put_sync(dsi->dev);
 		return;
 	}
 
@@ -1400,7 +1400,6 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 		dsi->state &= ~DSIM_STATE_ENABLED;
 		exynos_dsi_set_display_enable(dsi, false);
 		drm_panel_unprepare(dsi->panel);
-		pm_runtime_put_sync(dsi->dev);
 		return;
 	}
 
@@ -1422,7 +1421,10 @@ static void exynos_dsi_disable(struct drm_encoder *encoder)
 
 	dsi->state &= ~DSIM_STATE_ENABLED;
 
-	pm_runtime_put_sync(dsi->dev);
+	if (dsi->state & DSIM_STATE_INITIALIZED) {
+		pm_runtime_put_sync(dsi->dev);
+		dsi->state &= ~DSIM_STATE_INITIALIZED;
+	}
 }
 
 static enum drm_connector_status
@@ -1566,9 +1568,6 @@ static ssize_t exynos_dsi_host_transfer(struct mipi_dsi_host *host,
 	struct exynos_dsi_transfer xfer;
 	int ret;
 
-	if (!(dsi->state & DSIM_STATE_ENABLED))
-		return -EINVAL;
-
 	if (!(dsi->state & DSIM_STATE_INITIALIZED)) {
 		ret = exynos_dsi_init(dsi);
 		if (ret)
-- 
2.7.4
