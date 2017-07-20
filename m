From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 15:01:19 +0200
Subject: [PATCH v2 4/4] drm/sun4i: make sure we don't have a commit pending
In-Reply-To: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8763c55f9d77b270b3e6ae8a812c16fe79b5874c.1500555652.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the earlier display engine designs, any register access while a commit
is pending is forbidden.

One of the symptoms is that reading a register will return another, random,
register value which can lead to register corruptions if we ever do a
read/modify/write cycle.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_crtc.c    |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index cf480218daa5..ce1f40f7511e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -67,6 +67,19 @@ static void sun4i_backend_commit(struct sunxi_engine *engine)
 		     SUN4I_BACKEND_REGBUFFCTL_LOADCTL);
 }
 
+static int sun4i_backend_commit_poll(struct sunxi_engine *engine)
+{
+	u32 val;
+
+	DRM_DEBUG_DRIVER("Polling for the commit to end\n");
+
+	return regmap_read_poll_timeout(engine->regs,
+					SUN4I_BACKEND_REGBUFFCTL_REG,
+					val,
+					!(val & SUN4I_BACKEND_REGBUFFCTL_LOADCTL),
+					100, 50000);
+}
+
 void sun4i_backend_layer_enable(struct sun4i_backend *backend,
 				int layer, bool enable)
 {
@@ -330,6 +343,7 @@ static int sun4i_backend_of_get_id(struct device_node *node)
 
 static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
 	.commit				= sun4i_backend_commit,
+	.commit_poll			= sun4i_backend_commit_poll,
 	.layers_init			= sun4i_layers_init,
 	.apply_color_correction		= sun4i_backend_apply_color_correction,
 	.disable_color_correction	= sun4i_backend_disable_color_correction,
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 2eba1d8639d8..31550493fa1d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -34,6 +34,7 @@ static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
 				    struct drm_crtc_state *old_state)
 {
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
+	struct sunxi_engine *engine = scrtc->engine;
 	struct drm_device *dev = crtc->dev;
 	unsigned long flags;
 
-- 
git-series 0.9.1
