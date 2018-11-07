From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed,  7 Nov 2018 19:18:38 +0100
Subject: [PATCH v3 3/8] drm/sun4i: tcon: Support an active-low DE signal with
 RGB interface
In-Reply-To: <20181107181843.27628-1-contact@paulk.fr>
References: <20181107181843.27628-1-contact@paulk.fr>
Message-ID: <20181107181843.27628-4-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some panels need an active-low data enable (DE) signal for the RGB
interface. This requires flipping a bit in the TCON0 polarity register
when setting up the mode for the RGB interface.

Match the associated bus flag and use it to set the polarity inversion
bit for the DE signal when required.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 7 ++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 262ffb6b0f82..0420f5c978b9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -543,6 +543,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
 
+	if (display_info.bus_flags & DRM_BUS_FLAG_DE_LOW)
+		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
+
 	/*
 	 * On A20 and similar SoCs, the only way to achieve Positive Edge
 	 * (Rising Edge), is setting dclk clock phase to 2/3(240?).
@@ -565,7 +568,9 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
 		clk_set_phase(tcon->dclk, 0);
 
 	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
-			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
+			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
+			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
 			   val);
 
 	/* Map output pins to channel 0 */
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 3d492c8be1fc..b5214d71610f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -116,6 +116,7 @@
 
 #define SUN4I_TCON0_IO_POL_REG			0x88
 #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
+#define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
 #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
 #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
 
-- 
2.19.1
