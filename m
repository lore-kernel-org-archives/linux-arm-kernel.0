From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  2 Jun 2016 16:31:28 +0200
Subject: [PATCH 01/20] drm/atomic: Fix remaining places where
 !funcs->best_encoder is valid
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1464877907-27723-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adapt drm_pick_crtcs() and update_connector_routing() to fallback to
drm_atomic_helper_best_encoder() if funcs->best_encoder() is NULL so
that DRM drivers can leave this hook unassigned if they know they want
to use drm_atomic_helper_best_encoder().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++-
 drivers/gpu/drm/drm_fb_helper.c     | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index f6a3350..849d029 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -300,8 +300,10 @@ update_connector_routing(struct drm_atomic_state *state,
 	if (funcs->atomic_best_encoder)
 		new_encoder = funcs->atomic_best_encoder(connector,
 							 connector_state);
-	else
+	else if (funcs->best_encoder)
 		new_encoder = funcs->best_encoder(connector);
+	else
+		new_encoder = drm_atomic_helper_best_encoder(connector);
 
 	if (!new_encoder) {
 		DRM_DEBUG_ATOMIC("No suitable encoder found for [CONNECTOR:%d:%s]\n",
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 7c2eb75..d44389a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2000,7 +2000,18 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_helper,
 		my_score++;
 
 	connector_funcs = connector->helper_private;
-	encoder = connector_funcs->best_encoder(connector);
+
+	/*
+	 * If the DRM device implements atomic hooks and ->best_encoder() is
+	 * NULL we fallback to the default drm_atomic_helper_best_encoder()
+	 * helper.
+	 */
+	if (fb_helper->dev->mode_config.funcs->atomic_commit &&
+	    !connector_funcs->best_encoder)
+		encoder = drm_atomic_helper_best_encoder(connector);
+	else
+		encoder = connector_funcs->best_encoder(connector);
+
 	if (!encoder)
 		goto out;
 
-- 
2.7.4
