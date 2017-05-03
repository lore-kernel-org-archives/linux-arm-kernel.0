From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  3 May 2017 13:59:50 +0200
Subject: [PATCH v2 13/20] drm/sun4i: tcon: Change vertical total size
 computation inconsistency
In-Reply-To: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <745b9fc450798635d50f449473e9263ab3ace48e.1493812478.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both TCON channels need to have the resolution doubled, since the size the
hardware is going to use is whatever we put in the register divided by two.

However, we handle it differently for the two channels: in the channel 0,
our register access macro does the multiplication of the value passed as
paremeter, while in the channel 1, the macro doesn't do this, and we need
to do it before calling it.

Make this consistent by aligning the channel 0 with the channel 1
behaviour.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 86a806fae9fb..0f91ec8a4b26 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -190,7 +190,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 
 	/* Set vertical display timings */
 	regmap_write(tcon->regs, SUN4I_TCON0_BASIC2_REG,
-		     SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal) |
+		     SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal * 2) |
 		     SUN4I_TCON0_BASIC2_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 0350936b413c..3517122ee679 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -51,7 +51,7 @@
 #define SUN4I_TCON0_BASIC1_H_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
 
 #define SUN4I_TCON0_BASIC2_REG			0x50
-#define SUN4I_TCON0_BASIC2_V_TOTAL(total)		((((total) * 2) & 0x1fff) << 16)
+#define SUN4I_TCON0_BASIC2_V_TOTAL(total)		(((total) & 0x1fff) << 16)
 #define SUN4I_TCON0_BASIC2_V_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
 
 #define SUN4I_TCON0_BASIC3_REG			0x54
-- 
git-series 0.8.11
