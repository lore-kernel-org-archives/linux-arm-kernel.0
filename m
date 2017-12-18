From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:51 +0100
Subject: [PATCH v2 04/12] drm/sun4i: engine: Add a custom crtc atomic_check
In-Reply-To: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4f7f9c265cbef5f06e3d97d30c1c5f3b3f9aae33.1513609024.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have some restrictions on what the planes and CRTC can provide that are
tied to only one generation of display engines.

For example, on the first generation, we can only have one YUV plane or one
plane that uses the frontend output.

Let's allow our engines to provide an atomic_check callback to validate the
current configuration.

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c   | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sunxi_engine.h | 17 +++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 5decae0069d0..2a565325714f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -46,6 +46,19 @@ static struct drm_encoder *sun4i_crtc_get_encoder(struct drm_crtc *crtc)
 	return NULL;
 }
 
+static int sun4i_crtc_atomic_check(struct drm_crtc *crtc,
+				    struct drm_crtc_state *state)
+{
+	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct sunxi_engine *engine = scrtc->engine;
+	int ret = 0;
+
+	if (engine && engine->ops && engine->ops->atomic_check)
+		ret = engine->ops->atomic_check(engine, state);
+
+	return ret;
+}
+
 static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
@@ -125,6 +138,7 @@ static void sun4i_crtc_mode_set_nofb(struct drm_crtc *crtc)
 }
 
 static const struct drm_crtc_helper_funcs sun4i_crtc_helper_funcs = {
+	.atomic_check	= sun4i_crtc_atomic_check,
 	.atomic_begin	= sun4i_crtc_atomic_begin,
 	.atomic_flush	= sun4i_crtc_atomic_flush,
 	.atomic_enable	= sun4i_crtc_atomic_enable,
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 36c8388b1646..da2dd36dfbb6 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -33,6 +33,23 @@ struct sunxi_engine_ops {
 	void (*apply_color_correction)(struct sunxi_engine *engine);
 
 	/**
+	 * @atomic_check:
+	 *
+	 * This callback allows to validate plane-update related CRTC
+	 * constraints specific to backends. This is mirroring the
+	 * &drm_crtc_helper_funcs.atomic_check callback, so any
+	 * documentation there applies.
+	 *
+	 * This function is optional.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on success or a negative error code.
+	 */
+	int (*atomic_check)(struct sunxi_engine *engine,
+			    struct drm_crtc_state *state);
+
+	/**
 	 * @commit:
 	 *
 	 * This callback will trigger the hardware switch to commit
-- 
git-series 0.9.1
