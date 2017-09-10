From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Sep 2017 00:08:01 +0200
Subject: [PATCH v2] drm/tve200: Clean up panel bridging
Message-ID: <20170910220801.28588-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes use of the drm_simple_display_pipe_attach_bridge()
call and removes the two calls removing the bridge, which were
erroneous: they unregister the bridge which is not what
we want, we just want to unreference it and that is already
handled by the core.

Reviewed-by: Eric Anholt <eric@anholt.net>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Dropped the encoder field from private data.
---
 drivers/gpu/drm/tve200/tve200_display.c |  3 ---
 drivers/gpu/drm/tve200/tve200_drm.h     |  1 -
 drivers/gpu/drm/tve200/tve200_drv.c     | 30 +++++++++++++-----------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index cfdffc15a2ce..fd193377c3c0 100644
--- a/drivers/gpu/drm/tve200/tve200_display.c
+++ b/drivers/gpu/drm/tve200/tve200_display.c
@@ -332,8 +332,5 @@ int tve200_display_init(struct drm_device *drm)
 	if (ret)
 		return ret;
 
-	/* We need the encoder to attach the bridge */
-	priv->encoder = &priv->pipe.encoder;
-
 	return 0;
 }
diff --git a/drivers/gpu/drm/tve200/tve200_drm.h b/drivers/gpu/drm/tve200/tve200_drm.h
index b463624c1f29..628b79324c48 100644
--- a/drivers/gpu/drm/tve200/tve200_drm.h
+++ b/drivers/gpu/drm/tve200/tve200_drm.h
@@ -100,7 +100,6 @@ struct tve200_drm_dev_private {
 	struct drm_device *drm;
 
 	struct drm_connector *connector;
-	struct drm_encoder *encoder;
 	struct drm_panel *panel;
 	struct drm_bridge *bridge;
 	struct drm_simple_display_pipe pipe;
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index c22644692a88..eae38b669f0a 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -87,6 +87,14 @@ static int tve200_modeset_init(struct drm_device *dev)
 			ret = PTR_ERR(bridge);
 			goto out_bridge;
 		}
+	} else {
+		/*
+		 * TODO: when we are using a different bridge than a panel
+		 * (such as a dumb VGA connector) we need to devise a different
+		 * method to get the connector out of the bridge.
+		 */
+		dev_err(dev->dev, "the bridge is not a panel\n");
+		goto out_bridge;
 	}
 
 	ret = tve200_display_init(dev);
@@ -95,21 +103,13 @@ static int tve200_modeset_init(struct drm_device *dev)
 		goto out_bridge;
 	}
 
-	if (bridge) {
-		ret = drm_bridge_attach(priv->encoder, bridge, NULL);
-		if (ret)
-			goto out_bridge;
-	}
-
-	/*
-	 * TODO: when we are using a different bridge than a panel
-	 * (such as a dumb VGA connector) we need to devise a different
-	 * method to get the connector out of the bridge.
-	 */
-	if (!panel) {
-		dev_err(dev->dev, "the bridge is not a panel\n");
+	ret = drm_simple_display_pipe_attach_bridge(&priv->pipe,
+						    bridge);
+	if (ret) {
+		dev_err(dev->dev, "failed to attach bridge\n");
 		goto out_bridge;
 	}
+
 	priv->panel = panel;
 	priv->connector = panel->connector;
 	priv->bridge = bridge;
@@ -138,8 +138,6 @@ static int tve200_modeset_init(struct drm_device *dev)
 out_bridge:
 	if (panel)
 		drm_panel_bridge_remove(bridge);
-	else
-		drm_bridge_remove(bridge);
 	drm_mode_config_cleanup(dev);
 finish:
 	return ret;
@@ -275,8 +273,6 @@ static int tve200_remove(struct platform_device *pdev)
 		drm_fbdev_cma_fini(priv->fbdev);
 	if (priv->panel)
 		drm_panel_bridge_remove(priv->bridge);
-	else
-		drm_bridge_remove(priv->bridge);
 	drm_mode_config_cleanup(drm);
 	clk_disable_unprepare(priv->pclk);
 	drm_dev_unref(drm);
-- 
2.13.5
