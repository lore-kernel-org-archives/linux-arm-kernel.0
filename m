From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:09:19 +0100
Subject: [PATCH v3 06/13] drm/sun4i: engine: Add a VBLANK quirk callback
In-Reply-To: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
References: <cover.8538fc1191390239557a21e2b0444c81eef1c581.1515492513.git-series.maxime.ripard@free-electrons.com>
Message-ID: <7c298d43aa1500196aa5d15d7a7c0f228c7a6f3c.1515492513.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, the display engine needs to apply some quirks during the
VBLANK event. In the Display Engine 1.0 case for example, we can only
disable the frontend once the backend has been, which is at VBLANK.

Let's introduce a callback that can be implemented by the various engines.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c   |  4 ++++
 drivers/gpu/drm/sun4i/sunxi_engine.h | 13 +++++++++++++
 2 files changed, 17 insertions(+)

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
index b819d4f9f02f..54c029877531 100644
--- a/drivers/gpu/drm/sun4i/sunxi_engine.h
+++ b/drivers/gpu/drm/sun4i/sunxi_engine.h
@@ -85,6 +85,19 @@ struct sunxi_engine_ops {
 	 * This function is optional.
 	 */
 	void (*disable_color_correction)(struct sunxi_engine *engine);
+
+	/**
+	 * @vblank_quirk:
+	 *
+	 * This callback is used to implement engine-specific
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
