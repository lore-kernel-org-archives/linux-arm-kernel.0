From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed,  4 Apr 2018 11:57:09 +0200
Subject: [PATCH v4 1/8] drm/sun4i: tcon: Add TRI finish interrupt for vblank
In-Reply-To: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
References: <cover.a3617c4362eac8783f412525e52cf5552d19095d.1522835818.git-series.maxime.ripard@bootlin.com>
Message-ID: <de6d6ad8959da77ea3a974a31a4c0c8391178748.1522835818.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "CPU" (or Intel 8080) interface uses a different interrupt called
TRI_FINISH (most likely TRI being for trigger) to notify the end of frames,
and hence the VBLANK period.

And that interrupt to the possible VBLANK interrupts source.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  9 ++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c3d92d537240..5f423ed2f01b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -201,7 +201,8 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
 	DRM_DEBUG_DRIVER("%sabling VBLANK interrupt\n", enable ? "En" : "Dis");
 
 	mask = SUN4I_TCON_GINT0_VBLANK_ENABLE(0) |
-	       SUN4I_TCON_GINT0_VBLANK_ENABLE(1);
+		SUN4I_TCON_GINT0_VBLANK_ENABLE(1) |
+		SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE;
 
 	if (enable)
 		val = mask;
@@ -582,7 +583,8 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
 
 	if (!(status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
-			SUN4I_TCON_GINT0_VBLANK_INT(1))))
+			SUN4I_TCON_GINT0_VBLANK_INT(1) |
+			SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT)))
 		return IRQ_NONE;
 
 	drm_crtc_handle_vblank(&scrtc->crtc);
@@ -591,7 +593,8 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	/* Acknowledge the interrupt */
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
 			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
-			   SUN4I_TCON_GINT0_VBLANK_INT(1),
+			   SUN4I_TCON_GINT0_VBLANK_INT(1) |
+			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT,
 			   0);
 
 	if (engine->ops->vblank_quirk)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 161e09427124..2e0fb9640ed9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -28,7 +28,11 @@
 
 #define SUN4I_TCON_GINT0_REG			0x4
 #define SUN4I_TCON_GINT0_VBLANK_ENABLE(pipe)		BIT(31 - (pipe))
+#define SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE	BIT(27)
+#define SUN4I_TCON_GINT0_TCON0_TRI_COUNTER_ENABLE	BIT(26)
 #define SUN4I_TCON_GINT0_VBLANK_INT(pipe)		BIT(15 - (pipe))
+#define SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT		BIT(11)
+#define SUN4I_TCON_GINT0_TCON0_TRI_COUNTER_INT		BIT(10)
 
 #define SUN4I_TCON_GINT1_REG			0x8
 #define SUN4I_TCON_FRM_CTL_REG			0x10
-- 
git-series 0.9.1
