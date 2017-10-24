From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 24 Oct 2017 10:49:52 +0200
Subject: [PATCH 1/3] drm/exynos/dsi: Use common error handling code in
 exynos_dsi_enable()
In-Reply-To: <7d4cdb43-432c-c67a-5d3f-c37bd604f539@users.sourceforge.net>
References: <7d4cdb43-432c-c67a-5d3f-c37bd604f539@users.sourceforge.net>
Message-ID: <9028478a-a00d-6fcd-0286-b8daefa8c912@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Oct 2017 09:32:18 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 7904ffa9abfb..ba5fb49c5491 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1389,8 +1389,7 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 	ret = drm_panel_prepare(dsi->panel);
 	if (ret < 0) {
 		dsi->state &= ~DSIM_STATE_ENABLED;
-		pm_runtime_put_sync(dsi->dev);
-		return;
+		goto put_sync;
 	}
 
 	exynos_dsi_set_display_mode(dsi);
@@ -1401,11 +1400,14 @@ static void exynos_dsi_enable(struct drm_encoder *encoder)
 		dsi->state &= ~DSIM_STATE_ENABLED;
 		exynos_dsi_set_display_enable(dsi, false);
 		drm_panel_unprepare(dsi->panel);
-		pm_runtime_put_sync(dsi->dev);
-		return;
+		goto put_sync;
 	}
 
 	dsi->state |= DSIM_STATE_VIDOUT_AVAILABLE;
+	return;
+
+put_sync:
+	pm_runtime_put_sync(dsi->dev);
 }
 
 static void exynos_dsi_disable(struct drm_encoder *encoder)
-- 
2.14.2
