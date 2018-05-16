From: peda@axentia.se (Peter Rosin)
Date: Wed, 16 May 2018 12:15:09 +0200
Subject: [PATCH v3 25/26] drm/bridge: require the owner .odev to be filled in
 on drm_bridge_add/attach
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
Message-ID: <20180516101510.13215-26-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The .odev owner device will be handy to have around.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/drm_bridge.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index df084db33494..78d186b6831b 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -70,6 +70,9 @@ static LIST_HEAD(bridge_list);
  */
 void drm_bridge_add(struct drm_bridge *bridge)
 {
+	if (WARN_ON(!bridge->odev))
+		return;
+
 	mutex_lock(&bridge_lock);
 	list_add_tail(&bridge->list, &bridge_list);
 	mutex_unlock(&bridge_lock);
@@ -115,6 +118,9 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	if (!encoder || !bridge)
 		return -EINVAL;
 
+	if (WARN_ON(!bridge->odev))
+		return -EINVAL;
+
 	if (previous && (!previous->dev || previous->encoder != encoder))
 		return -EINVAL;
 
-- 
2.11.0
