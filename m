From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 29 May 2017 16:15:52 +0200
Subject: [PATCH] drm/meson: Fix driver bind when only CVBS is available
Message-ID: <1496067352-8733-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While introducing HDMI support, component matching on connectors node
were bypassed since no driver would actually bind on the DT node.
But when only a CVBS connector is present, only a single node is found
in the graph, but ignored and a NULL match table is given to the
component code.

This code permits bypassing the components framework by binding directly
the DRM driver when no components needs to be loaded.

Fixes: a41e82e6c457 ("drm/meson: Add support for components")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 75382f5..10b227d 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -152,7 +152,7 @@ static bool meson_vpu_has_available_connectors(struct device *dev)
 	.max_register   = 0x1000,
 };
 
-static int meson_drv_bind(struct device *dev)
+static int meson_drv_bind_master(struct device *dev, bool has_components)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct meson_drm *priv;
@@ -233,10 +233,12 @@ static int meson_drv_bind(struct device *dev)
 	if (ret)
 		goto free_drm;
 
-	ret = component_bind_all(drm->dev, drm);
-	if (ret) {
-		dev_err(drm->dev, "Couldn't bind all components\n");
-		goto free_drm;
+	if (has_components) {
+		ret = component_bind_all(drm->dev, drm);
+		if (ret) {
+			dev_err(drm->dev, "Couldn't bind all components\n");
+			goto free_drm;
+		}
 	}
 
 	ret = meson_plane_create(priv);
@@ -276,6 +278,11 @@ static int meson_drv_bind(struct device *dev)
 	return ret;
 }
 
+static int meson_drv_bind(struct device *dev)
+{
+	return meson_drv_bind_master(dev, true);
+}
+
 static void meson_drv_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
@@ -357,6 +364,9 @@ static int meson_drv_probe(struct platform_device *pdev)
 		count += meson_probe_remote(pdev, &match, np, remote);
 	}
 
+	if (count && !match)
+		return meson_drv_bind_master(&pdev->dev, false);
+
 	/* If some endpoints were found, initialize the nodes */
 	if (count) {
 		dev_info(&pdev->dev, "Queued %d outputs on vpu\n", count);
-- 
1.9.1
