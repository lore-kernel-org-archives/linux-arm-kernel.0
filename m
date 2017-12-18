From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:58 +0100
Subject: [PATCH v2 11/12] drm/sun4i: backend: Make sure we don't have a commit
 pending
In-Reply-To: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b25003511097304444302ba56d26ee9e47966b33.1513609024.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we try to read the backend registers while it fetches the new values, we
end up with the value of some random register instead of the one we asked
for.

In order to prevent that, let's make sure that the very first thing we do
during our atomic modesetting is to let the commit bit come to a rest.

We don't have to worry about anything else since the only time we will
trigger a new transaction is during the atomic_commit which comes much
later.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 4642f933765e..a18c86a15748 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -297,6 +297,17 @@ static bool sun4i_backend_plane_uses_frontend(struct drm_plane_state *state)
 	return sun4i_backend_plane_uses_scaler(state);
 }
 
+static void sun4i_backend_atomic_begin(struct sunxi_engine *engine,
+				       struct drm_crtc_state *old_state)
+{
+	u32 val;
+
+	WARN_ON(regmap_read_poll_timeout(engine->regs,
+					 SUN4I_BACKEND_REGBUFFCTL_REG,
+					 val, !(val & SUN4I_BACKEND_REGBUFFCTL_LOADCTL),
+					 100, 50000));
+}
+
 static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 				      struct drm_crtc_state *crtc_state)
 {
@@ -478,6 +489,7 @@ static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
 }
 
 static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
+	.atomic_begin			= sun4i_backend_atomic_begin,
 	.atomic_check			= sun4i_backend_atomic_check,
 	.commit				= sun4i_backend_commit,
 	.layers_init			= sun4i_layers_init,
-- 
git-series 0.9.1
