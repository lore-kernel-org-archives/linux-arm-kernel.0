From: peda@axentia.se (Peter Rosin)
Date: Fri, 27 Apr 2018 00:31:16 +0200
Subject: [PATCH 01/24] drm/bridge: allow optionally specifying an .owner device
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
Message-ID: <20180426223139.16740-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bridge drivers can now (temporarily, in a transition phase) select if
they want to provide a full owner or keep just providing an of_node.

By providing a full owner device, the bridge drivers no longer need
to provide an of_node since that node is available via the owner
device.

When all bridge drivers provide an owner device, that will become
mandatory and the .of_node member will be removed.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 3 ++-
 include/drm/drm_bridge.h     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..67147673fdeb 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -365,7 +365,8 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
 	mutex_lock(&bridge_lock);
 
 	list_for_each_entry(bridge, &bridge_list, list) {
-		if (bridge->of_node == np) {
+		if ((bridge->owner && bridge->owner->of_node == np) ||
+		    bridge->of_node == np) {
 			mutex_unlock(&bridge_lock);
 			return bridge;
 		}
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3270fec46979..c28a75ad0ae2 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -254,6 +254,7 @@ struct drm_bridge_timings {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
+ * @owner: device that owns the bridge
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
@@ -265,6 +266,7 @@ struct drm_bridge_timings {
  * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	struct device *owner;
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
-- 
2.11.0
