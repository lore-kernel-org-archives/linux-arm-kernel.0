From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 11:59:23 +0100
Subject: [PATCH v2 8/28] drm/i2c: tda998x: use HDMI constants
Message-ID: <20140109115923.666c063a@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replaces hard coded values by hdmi constants.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 1abf404..99c3796 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -541,12 +541,12 @@ tda998x_write_if(struct tda998x_priv *priv, uint8_t bit, uint16_t addr,
 static void
 tda998x_write_aif(struct tda998x_priv *priv, struct tda998x_encoder_params *p)
 {
-	uint8_t buf[PB(5) + 1];
+	u8 buf[PB(HDMI_AUDIO_INFOFRAME_SIZE) + 1];
 
-	buf[HB(0)] = 0x84;
+	memset(buf, 0, sizeof buf);
+	buf[HB(0)] = HDMI_INFOFRAME_TYPE_AUDIO;
 	buf[HB(1)] = 0x01;
-	buf[HB(2)] = 10;
-	buf[PB(0)] = 0;
+	buf[HB(2)] = HDMI_AUDIO_INFOFRAME_SIZE;
 	buf[PB(1)] = p->audio_frame[1] & 0x07; /* CC */
 	buf[PB(2)] = p->audio_frame[2] & 0x1c; /* SF */
 	buf[PB(4)] = p->audio_frame[4];
@@ -559,12 +559,12 @@ tda998x_write_aif(struct tda998x_priv *priv, struct tda998x_encoder_params *p)
 static void
 tda998x_write_avi(struct tda998x_priv *priv, struct drm_display_mode *mode)
 {
-	uint8_t buf[PB(13) + 1];
+	u8 buf[PB(HDMI_AVI_INFOFRAME_SIZE) + 1];
 
 	memset(buf, 0, sizeof(buf));
-	buf[HB(0)] = 0x82;
+	buf[HB(0)] = HDMI_INFOFRAME_TYPE_AVI;
 	buf[HB(1)] = 0x02;
-	buf[HB(2)] = 13;
+	buf[HB(2)] = HDMI_AVI_INFOFRAME_SIZE;
 	buf[PB(1)] = HDMI_SCAN_MODE_UNDERSCAN;
 	buf[PB(3)] = HDMI_QUANTIZATION_RANGE_FULL << 2;
 	buf[PB(4)] = drm_match_cea_mode(mode);

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
