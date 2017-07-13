From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 16:13:03 +0200
Subject: [PATCH 08/18] drm/sun4i: tcon: Add TRI finish interrupt for vblank
In-Reply-To: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <8114707d8063d0c9e67694528925baf4f4ee2f7c.1499955058.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "CPU" (or Intel 8080) interface uses a different interrupt called
TRI_FINISH (most likely TRI being for trigger) to notify the end of frames,
and hence the VBLANK period.

And that interrupt to the possible VBLANK interrupts source.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |  9 ++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c4407910dfaf..a3bbf9994cfa 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -97,7 +97,8 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
 	DRM_DEBUG_DRIVER("%sabling VBLANK interrupt\n", enable ? "En" : "Dis");
 
 	mask = SUN4I_TCON_GINT0_VBLANK_ENABLE(0) |
-	       SUN4I_TCON_GINT0_VBLANK_ENABLE(1);
+		SUN4I_TCON_GINT0_VBLANK_ENABLE(1) |
+		SUN4I_TCON_GINT0_TCON0_TRI_FINISH_ENABLE;
 
 	if (enable)
 		val = mask;
@@ -336,7 +337,8 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	regmap_read(tcon->regs, SUN4I_TCON_GINT0_REG, &status);
 
 	if (!(status & (SUN4I_TCON_GINT0_VBLANK_INT(0) |
-			SUN4I_TCON_GINT0_VBLANK_INT(1))))
+			SUN4I_TCON_GINT0_VBLANK_INT(1) |
+			SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT)))
 		return IRQ_NONE;
 
 	drm_crtc_handle_vblank(&scrtc->crtc);
@@ -345,7 +347,8 @@ static irqreturn_t sun4i_tcon_handler(int irq, void *private)
 	/* Acknowledge the interrupt */
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GINT0_REG,
 			   SUN4I_TCON_GINT0_VBLANK_INT(0) |
-			   SUN4I_TCON_GINT0_VBLANK_INT(1),
+			   SUN4I_TCON_GINT0_VBLANK_INT(1) |
+			   SUN4I_TCON_GINT0_TCON0_TRI_FINISH_INT,
 			   0);
 
 	return IRQ_HANDLED;
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index a318e5ccb612..b3582ee82855 100644
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
