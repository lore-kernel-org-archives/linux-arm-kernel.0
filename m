From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Tue, 18 Nov 2014 17:39:30 +0000
Subject: [PATCH] drm/i2c: tda998x: Allow for different audio sample rates
Message-ID: <546B8452.6030701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On HDMI, the audio data are carried across the HDMI link which is
driven by the TDMS clock. The TDMS clock is dependent on the video pixel
rate.

This patch sets the denominator (Cycle Time Stamp) appropriately
allowing the driver to send audio to a wider range of HDMI sinks
(i.e. monitors).

Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
---
 drivers/gpu/drm/i2c/tda998x_drv.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d476279..da0d504 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -640,7 +640,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
 {
 	uint8_t buf[6], clksel_aip, clksel_fs, cts_n, adiv;
-	uint32_t n;
+	uint32_t n, cts;
 
 	/* Enable audio ports */
 	reg_write(priv, REG_ENA_AP, p->audio_cfg);
@@ -696,9 +696,23 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	n = 128 * p->audio_sample_rate / 1000;
 
 	/* Write the CTS and N values */
-	buf[0] = 0x44;
-	buf[1] = 0x42;
-	buf[2] = 0x01;
+	if ((n > 0) && (mode->clock > 0)) {
+		/*
+		 * For non-coherent clocks, the average CTS value is
+		 * calculated as:
+		 *      fTMDS * n / (128 * fs)
+		 * which simplifies to:
+		 * 	fTMDS / 1000
+		 * (See sections 7.2.2 and 7.2.3 of the HDMI specification.)
+		 * NB mode->clock is in kHz.
+		 */
+		cts = mode->clock;
+	} else {
+		cts = 82500;
+	}
+	buf[0] = cts;
+	buf[1] = cts >> 8;
+	buf[2] = cts >> 16;
 	buf[3] = n;
 	buf[4] = n >> 8;
 	buf[5] = n >> 16;
-- 
1.7.1
