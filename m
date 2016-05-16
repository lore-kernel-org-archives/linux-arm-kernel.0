From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 16 May 2016 14:47:09 +0200
Subject: [PATCH 09/20] drm/sun4i: defer only if we didn't find our panel
In-Reply-To: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1463402840-17062-10-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our code currently defers our probe on any error, even if we were not
expecting to have one at all.

Make sure we return -EPROBE_DEFER only when we were supposed to have a
panel, but it's not probed yet.

Fixes: 29e57fab97fc ("drm: sun4i: Add RGB output")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9f19b0e08560..eed6a9e8d9a6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -429,7 +429,7 @@ static struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
 		return ERR_PTR(-EINVAL);
 	}
 
-	return of_drm_find_panel(remote);
+	return of_drm_find_panel(remote) ?: ERR_PTR(-EPROBE_DEFER);
 }
 
 static int sun4i_tcon_bind(struct device *dev, struct device *master,
@@ -522,12 +522,13 @@ static int sun4i_tcon_probe(struct platform_device *pdev)
 	 * Defer the probe.
 	 */
 	panel = sun4i_tcon_find_panel(node);
-	if (IS_ERR(panel)) {
-		/*
-		 * If we don't have a panel endpoint, just go on
-		 */
-		if (PTR_ERR(panel) != -ENODEV)
-			return -EPROBE_DEFER;
+
+	/*
+	 * If we don't have a panel endpoint, just go on
+	 */
+	if (PTR_ERR(panel) == -EPROBE_DEFER) {
+		DRM_DEBUG_DRIVER("Still waiting for our panel. Deferring...\n");
+		return -EPROBE_DEFER;
 	}
 
 	return component_add(&pdev->dev, &sun4i_tcon_ops);
-- 
2.8.2
