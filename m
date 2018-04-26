From: peda@axentia.se (Peter Rosin)
Date: Fri, 27 Apr 2018 00:31:39 +0200
Subject: [PATCH 24/24] drm/bridge: establish a link between the bridge
 supplier and consumer
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
Message-ID: <20180426223139.16740-25-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the bridge supplier is unbound, this will bring the bridge consumer
down along with the bridge. Thus, there will no longer linger any
dangling pointers from the bridge consumer (the drm_device) to some
non-existent bridge supplier.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 18 ++++++++++++++++++
 include/drm/drm_bridge.h     |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index a038da696802..f0c79043ec43 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 
 #include <drm/drm_bridge.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder.h>
 
 #include "drm_crtc_internal.h"
@@ -124,12 +125,25 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (bridge->dev)
 		return -EBUSY;
 
+	if (encoder->dev->dev != bridge->owner) {
+		bridge->link = device_link_add(encoder->dev->dev,
+					       bridge->owner, 0);
+		if (!bridge->link) {
+			dev_err(bridge->owner, "failed to link bridge to %s\n",
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
@@ -156,6 +170,10 @@ void drm_bridge_detach(struct drm_bridge *bridge)
 	if (bridge->funcs->detach)
 		bridge->funcs->detach(bridge);
 
+	if (bridge->link)
+		device_link_del(bridge->link);
+	bridge->link = NULL;
+
 	bridge->dev = NULL;
 }
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 3bc659f3e7d2..9a386559a41a 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -261,6 +261,7 @@ struct drm_bridge_timings {
  * @list: to keep track of all added bridges
  * @timings: the timing specification for the bridge, if any (may
  * be NULL)
+ * @link: drm consumer <-> bridge supplier
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
