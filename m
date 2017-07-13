From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:41:15 +0200
Subject: [PATCH 3/4] drm/sun4i: engine: Add commit_poll function
In-Reply-To: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
References: <cover.75b0c7f741ed33015a7ad44941bed1f6152a48a9.1499956639.git-series.maxime.ripard@free-electrons.com>
Message-ID: <b483c2c05704615957dc6d96bbd06f2e3b117bf5.1499956639.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the earlier Allwinner chips, with the first iteration of the display
engine, the backend commit bit needs to be polled before making any
register access to the backend.

Add an operation for that, that will be called in atomic_begin in order to
be sure to have that bit cleared before we do any modifications.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_crtc.c   |  2 ++
 drivers/gpu/drm/sun4i/sunxi_engine.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index f8c70439d1e2..2eba1d8639d8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -45,6 +45,8 @@ static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 		crtc->state->event = NULL;
 	 }
+
+	WARN_ON(sunxi_engine_commit_poll(engine));
 }
 
 static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index 4cb70ae65c79..6618e182613c 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -17,6 +17,7 @@ struct sunxi_engine;
 
 struct sunxi_engine_ops {
 	void (*commit)(struct sunxi_engine *engine);
+	int (*commit_poll)(struct sunxi_engine *engine);
 	struct drm_plane **(*layers_init)(struct drm_device *drm,
 					  struct sunxi_engine *engine);
 
@@ -55,6 +56,19 @@ sunxi_engine_commit(struct sunxi_engine *engine)
 }
 
 /**
+ * sunxi_engine_commit_poll() - wait for all changes to be committed
+ * @engine:	pointer to the engine
+ */
+static inline int
+sunxi_engine_commit_poll(struct sunxi_engine *engine)
+{
+	if (engine->ops && engine->ops->commit_poll)
+		return engine->ops->commit_poll(engine);
+
+	return 0;
+}
+
+/**
  * sunxi_engine_layers_init() - Create planes (layers) for the engine
  * @drm:	pointer to the drm_device for which planes will be created
  * @engine:	pointer to the engine
-- 
git-series 0.9.1
