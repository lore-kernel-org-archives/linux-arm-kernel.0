From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 10:25:26 +0100
Subject: [PATCH v4 12/13] drm/sun4i: backend: Make sure we don't have a commit
 pending
In-Reply-To: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
References: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
Message-ID: <35604307e5bde2b85c674de79fa7c4d55700f085.1516613040.git-series.maxime.ripard@free-electrons.com>
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

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 1b8e3dcbe47a..5d4a49e9ccc3 100644
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
@@ -479,6 +490,7 @@ static struct sun4i_frontend *sun4i_backend_find_frontend(struct sun4i_drv *drv,
 }
 
 static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
+	.atomic_begin			= sun4i_backend_atomic_begin,
 	.atomic_check			= sun4i_backend_atomic_check,
 	.commit				= sun4i_backend_commit,
 	.layers_init			= sun4i_layers_init,
-- 
git-series 0.9.1
