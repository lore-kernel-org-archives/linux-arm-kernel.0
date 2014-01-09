From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:07:02 +0100
Subject: [PATCH v2 24/28] drm/i2c: tda998x: adjust the audio CTS to the mode
 clock
Message-ID: <20140109120702.492c58d8@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 68630b8..c2163f4 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -723,7 +723,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		struct drm_display_mode *mode)
 {
 	uint8_t buf[6], clksel_aip, clksel_fs, cts_n, adiv;
-	uint32_t n;
+	uint32_t n, cts;
 
 	/* Enable audio ports */
 	reg_write(priv, REG_ENA_AP, priv->audio_port);
@@ -777,9 +777,10 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	n = 128 * AUDIO_SAMPLE;		/* acr_n = 128 * sample_rate / 1000 */
 
 	/* Write the CTS and N values */
-	buf[0] = 0x44;
-	buf[1] = 0x42;
-	buf[2] = 0x01;
+	cts = mode->clock;
+	buf[0] = cts;
+	buf[1] = cts >> 8;
+	buf[2] = cts >> 16;
 	buf[3] = n;
 	buf[4] = n >> 8;
 	buf[5] = n >> 16;
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
