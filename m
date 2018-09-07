From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  7 Sep 2018 12:19:43 +0800
Subject: [PATCH v2 1/6] drm/sun4i: tcon: Pass drm_encoder * into
 sun4i_tcon0_mode_set_cpu
In-Reply-To: <20180907041948.19913-1-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
Message-ID: <20180907041948.19913-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_tcon0_mode_set_cpu() currently accepts struct mipi_dsi_device *
as its second parameter. This is derived from drm_encoder.

The DSI encoder is tied to the CPU interface mode of the TCON as a
special case. In theory, if hardware were available, we could also
support normal CPU interface modes. It is better to pass the generic
encoder instead of the specialized mipi_dsi_device, and handle the
differences inside the function.

Passing the encoder would also enable the function to pass it, or any
other data structures related to it, to other functions expecting it.
One such example would be dithering support that will be added in a
later patch, which looks at properties tied to the connector to
determine whether dithering should be enabled or not.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 0cebb2db5b99..d6f9d5f3b15b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -278,9 +278,12 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
 }
 
 static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
-				     struct mipi_dsi_device *device,
+				     const struct drm_encoder *encoder,
 				     const struct drm_display_mode *mode)
 {
+	/* TODO support normal CPU interface modes */
+	struct sun6i_dsi *dsi = encoder_to_sun6i_dsi(encoder);
+	struct mipi_dsi_device *device = dsi->device;
 	u8 bpp = mipi_dsi_pixel_format_to_bpp(device->format);
 	u8 lanes = device->lanes;
 	u32 block_space, start_delay;
@@ -610,16 +613,10 @@ void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
 			 const struct drm_display_mode *mode)
 {
-	struct sun6i_dsi *dsi;
-
 	switch (encoder->encoder_type) {
 	case DRM_MODE_ENCODER_DSI:
-		/*
-		 * This is not really elegant, but it's the "cleaner"
-		 * way I could think of...
-		 */
-		dsi = encoder_to_sun6i_dsi(encoder);
-		sun4i_tcon0_mode_set_cpu(tcon, dsi->device, mode);
+		/* DSI is tied to special case of CPU interface */
+		sun4i_tcon0_mode_set_cpu(tcon, encoder, mode);
 		break;
 	case DRM_MODE_ENCODER_LVDS:
 		sun4i_tcon0_mode_set_lvds(tcon, encoder, mode);
-- 
2.19.0.rc1
