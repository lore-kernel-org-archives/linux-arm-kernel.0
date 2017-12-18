From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:53 +0100
Subject: [PATCH v2 06/12] drm/sun4i: engine: Create an atomic_begin callback
In-Reply-To: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b8981ab657f83b0e8ac690b28e99203250036922.1513609024.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have to implement some display engine specific behaviours in
atomic_begin. Let's add a function for that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c   |  6 +++++-
 drivers/gpu/drm/sun4i/sunxi_engine.h | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 2a565325714f..f549f2874353 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -64,6 +64,7 @@ static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
 {
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
+	struct sunxi_engine *engine = scrtc->engine;
 	unsigned long flags;
 
 	if (crtc->state->event) {
@@ -73,7 +74,10 @@ static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
 		scrtc->event = crtc->state->event;
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 		crtc->state->event = NULL;
-	 }
+	}
+
+	if (engine->ops->atomic_begin)
+		engine->ops->atomic_begin(engine, old_state);
 }
 
 static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index b810c26d78bb..ec4d54f596d4 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -33,6 +33,19 @@ struct sunxi_engine_ops {
 	void (*apply_color_correction)(struct sunxi_engine *engine);
 
 	/**
+	 * @atomic_begin:
+	 *
+	 * This callback allows to prepare our backend for an atomic
+	 * update. This is mirroring the
+	 * &drm_crtc_helper_funcs.atomic_begin callback, so any
+	 * documentation there applies.
+	 *
+	 * This function is optional.
+	 */
+	void (*atomic_begin)(struct sunxi_engine *engine,
+			     struct drm_crtc_state *old_state);
+
+	/**
 	 * @atomic_check:
 	 *
 	 * This callback allows to validate plane-update related CRTC
-- 
git-series 0.9.1
