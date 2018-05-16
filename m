From: peda@axentia.se (Peter Rosin)
Date: Wed, 16 May 2018 12:15:08 +0200
Subject: [PATCH v3 24/26] drm/bridge: remove the .of_node member
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
Message-ID: <20180516101510.13215-25-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is unused.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c             | 3 +--
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 --
 include/drm/drm_bridge.h                 | 4 ----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 3872f5379998..df084db33494 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,8 +365,7 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if ((bridge->odev && bridge->odev->of_node == np) ||
-		    bridge->of_node == np) {
+		if (bridge->odev->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 557e0079c98d..e77d4c909582 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -377,8 +377,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 	}
 	if (lvds->panel)
 		remote = lvds->panel->dev->of_node;
-	else if (lvds->bridge->of_node)
-		remote = lvds->bridge->of_node;
 	else
 		remote = lvds->bridge->odev->of_node;
 	if (of_property_read_string(dev->of_node, "rockchip,output", &name))
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 7c17977c3537..b656e505d11e 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -258,7 +258,6 @@ struct drm_bridge_timings {
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
- * @of_node: device node pointer to the bridge
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
@@ -270,9 +269,6 @@ struct drm_bridge {
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-#ifdef CONFIG_OF
-	struct device_node *of_node;
-#endif
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
 
-- 
2.11.0
