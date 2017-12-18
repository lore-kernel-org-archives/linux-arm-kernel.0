From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 15:57:52 +0100
Subject: [PATCH v2 05/12] drm/sun4i: engine: Add a VBLANK quirk callback
In-Reply-To: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
References: <cover.baf97666d4bb722f2acfdc2c98c0461e58f31b9e.1513609024.git-series.maxime.ripard@free-electrons.com>
Message-ID: <63abbe22845c3332e032053a26948486a3514fa8.1513609024.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, the display engine needs to apply some quirks during the
VBLANK event. In the Display Engine 1.0 case for example, we can only
disable the frontend once the backend has been, which is at VBLANK.

Let's introduce a callback that can be implemented by the various engines.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c   |  4 ++++
 drivers/gpu/drm/sun4i/sunxi_engine.h | 12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index e122f5b2a395..55f54b54293c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -368,6 +368,7 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	struct sun4i_tcon *tcon = private;
 	struct drm_device *drm = tcon->drm;
 	struct sun4i_crtc *scrtc = tcon->crtc;
+	struct sunxi_engine *engine = scrtc->engine;
 	unsigned int status;
 
 	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
@@ -385,6 +386,9 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 			   SUN4I_TCON_GINT0_VBLANK_INT(1),
 			   0);
 
+	if (engine->ops->vblank_quirk)
+		engine->ops->vblank_quirk(engine);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/gpu/drm/sun4i/sunxi_engine.h b/drivers/gpu/drm/sun4i/sunxi_engine.h
index da2dd36dfbb6..b810c26d78bb 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -86,6 +86,18 @@ struct sunxi_engine_ops {
 	struct drm_plane **(*layers_init)(struct drm_device *drm,
 					  struct sunxi_engine *engine);
 
+	/**
+	 * @vblank_quirk:
+	 *
+	 * This callback is used to implement backend-specific
+	 * behaviour part of the VBLANK event. It is run with all the
+	 * constraints of an interrupt (can't sleep, all local
+	 * interrupts disabled) and therefore should be as fast as
+	 * possible.
+	 *
+	 * This function is optional.
+	 */
+	void (*vblank_quirk)(struct sunxi_engine *engine);
 };
 
 /**
-- 
git-series 0.9.1
