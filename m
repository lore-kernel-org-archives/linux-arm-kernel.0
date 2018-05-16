From: peda@axentia.se (Peter Rosin)
Date: Wed, 16 May 2018 12:15:10 +0200
Subject: [PATCH v3 26/26] drm/bridge: establish a link between the bridge
 supplier and consumer
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
Message-ID: <20180516101510.13215-27-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the bridge supplier is unbound, this will bring the bridge consumer
down along with the bridge. Thus, there will no longer linger any
dangling pointers from the bridge consumer (the drm_device) to some
non-existent bridge supplier.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 78d186b6831b..0259f0a3ff27 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
 
 #include "drm_crtc_internal.h"
@@ -127,12 +128,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (bridge->dev)
 		return -EBUSY;
 
+	if (encoder->dev->dev != bridge->odev) {
+		bridge->link = device_link_add(encoder->dev->dev,
+					       bridge->odev, 0);
+		if (!bridge->link) {
+			dev_err(bridge->odev, "failed to link bridge to %s\n",
+				dev_name(encoder->dev->dev));
+			return -EINVAL;
+		}
+	}
+
 	bridge->dev = encoder->dev;
 	bridge->encoder = encoder;
 
 	if (bridge->funcs->attach) {
 		ret = bridge->funcs->attach(bridge);
 		if (ret < 0) {
+			if (bridge->link)
+				device_link_del(bridge->link);
+			bridge->link = NULL;
 			bridge->dev = NULL;
 			bridge->encoder = NULL;
 			return ret;
@@ -159,6 +173,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	if (bridge->link)
+		device_link_del(bridge->link);
+	bridge->link = NULL;
+
 	bridge->dev = NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index b656e505d11e..bd1265c5a0bc 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -261,6 +261,7 @@ struct drm_bridge_timings {
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
+ * @link: device link between the drm consumer and the bridge supplier
  * @funcs: control functions
  * @driver_private: pointer to the bridge driver's internal context
  */
@@ -271,6 +272,7 @@ struct drm_bridge {
 	struct drm_bridge *next;
 	struct list_head list;
 	const struct drm_bridge_timings *timings;
+	struct device_link *link;
 
 	const struct drm_bridge_funcs *funcs;
 	void *driver_private;
-- 
2.11.0
