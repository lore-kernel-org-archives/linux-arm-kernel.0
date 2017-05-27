From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 May 2017 18:09:30 +0200
Subject: [PATCH v4 05/11] drm/sun4i: tcon: Change vertical total size
 computation inconsistency
In-Reply-To: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
References: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
Message-ID: <dac0200c3e29f866e2e9bfd5d0b29afdc01657c8.1495900658.git-series.maxime.ripard@free-electrons.com>
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
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 6993ef3888dd..61e1de77831d 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -194,7 +194,7 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
 
 	/* Set vertical display timings */
 	regmap_write(tcon->regs, SUN4I_TCON0_BASIC2_REG,
-		     SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal) |
+		     SUN4I_TCON0_BASIC2_V_TOTAL(mode->crtc_vtotal * 2) |
 		     SUN4I_TCON0_BASIC2_V_BACKPORCH(bp));
 
 	/* Set Hsync and Vsync length */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f60e0b4c6db8..e3c50ecdcd04 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -52,7 +52,7 @@
 #define SUN4I_TCON0_BASIC1_H_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
 
 #define SUN4I_TCON0_BASIC2_REG			0x50
-#define SUN4I_TCON0_BASIC2_V_TOTAL(total)		((((total) * 2) & 0x1fff) << 16)
+#define SUN4I_TCON0_BASIC2_V_TOTAL(total)		(((total) & 0x1fff) << 16)
 #define SUN4I_TCON0_BASIC2_V_BACKPORCH(bp)		(((bp) - 1) & 0xfff)
 
 #define SUN4I_TCON0_BASIC3_REG			0x54
-- 
git-series 0.9.1
