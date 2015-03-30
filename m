From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 30 Mar 2015 20:49:21 +0100
Subject: [PATCH] drm/i2c: tda998x: use
 drm_hdmi_avi_infoframe_from_display_mode()
Message-ID: <E1YcfgX-00036O-B0@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the DRM HDMI AVI infoframe helper to construct the AVI
infoframe, rather than coding this up ourselves.  This allows DRM
to supply proper aspect ratio information derived from the DRM
display mode structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I noticed this helper in the kernel over the last weekend, and thought
it would be a good idea to update the TDA998x driver to it.  It changes
the info frame slightly, eg:

old: 00000000: 82 02 0d 4d 02 08 08 10 00 00 00 00 00 00 00 00
old: 00000010: 00
new: 00000000: 82 02 0d 1d 12 28 08 10 00 00 00 00 00 00 00 00
new: 00000010: 00

Differences are that we now include the picture aspect ratio, which is
set according to the data in the drm_display_mode, or appropriately for
the CEA mode.  We also were not setting the active aspect present bit
despite setting the field.  Technically, this could be viewed as a bug
fix, but I haven't seen any evidence to show any bad behaviour, neither
before nor after this change.

 drivers/gpu/drm/i2c/tda998x_drv.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 43d5d91fe880..fbc9c1facdfe 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -610,19 +610,21 @@ tda998x_write_aif(struct tda998x_priv *priv, struct tda998x_encoder_params *p)
 static void
 tda998x_write_avi(struct tda998x_priv *priv, struct drm_display_mode *mode)
 {
-	u8 buf[PB(HDMI_AVI_INFOFRAME_SIZE) + 1];
+	struct hdmi_avi_infoframe frame;
+	u8 buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AVI_INFOFRAME_SIZE];
+	ssize_t len;
 
-	memset(buf, 0, sizeof(buf));
-	buf[HB(0)] = HDMI_INFOFRAME_TYPE_AVI;
-	buf[HB(1)] = 0x02;
-	buf[HB(2)] = HDMI_AVI_INFOFRAME_SIZE;
-	buf[PB(1)] = HDMI_SCAN_MODE_UNDERSCAN;
-	buf[PB(2)] = HDMI_ACTIVE_ASPECT_PICTURE;
-	buf[PB(3)] = HDMI_QUANTIZATION_RANGE_FULL << 2;
-	buf[PB(4)] = drm_match_cea_mode(mode);
-
-	tda998x_write_if(priv, DIP_IF_FLAGS_IF2, REG_IF2_HB0, buf,
-			 sizeof(buf));
+	drm_hdmi_avi_infoframe_from_display_mode(&frame, mode);
+
+	frame.quantization_range = HDMI_QUANTIZATION_RANGE_FULL;
+
+	len = hdmi_avi_infoframe_pack(&frame, buf, sizeof(buf));
+	if (len < 0) {
+		dev_err(&priv->hdmi->dev, "hdmi_avi_infoframe_pack() failed: %d\n", len);
+		return;
+	}
+
+	tda998x_write_if(priv, DIP_IF_FLAGS_IF2, REG_IF2_HB0, buf, len);
 }
 
 static void tda998x_audio_mute(struct tda998x_priv *priv, bool on)
-- 
1.8.3.1
