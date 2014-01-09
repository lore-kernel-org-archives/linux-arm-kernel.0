From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:07:35 +0100
Subject: [PATCH v2 27/28] drm/i2c: tda998x: adjust the audio clock divider
 for S/PDIF
Message-ID: <20140109120735.7ee3d672@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S/PDIF input asks for a greater audio clock divider.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d3b3f3a..67d7450 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -757,6 +757,10 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 					AIP_CNTRL_0_ACR_MAN);
 	reg_write(priv, REG_CTS_N, cts_n);
 
+	/* S/PDIF asks for a large divider */
+	if (priv->audio_type == (AFMT_SPDIF | AUDIO_ACTIVE))
+		adiv = AUDIO_DIV_SERCLK_32;
+
 	/*
 	 * Audio input somehow depends on HDMI line rate which is
 	 * related to pixclk. Testing showed that modes with pixclk
@@ -764,7 +768,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * There is no detailed info in the datasheet, so we just
 	 * assume 100MHz requires larger divider.
 	 */
-	if (mode->clock > 100000)
+	else if (mode->clock > 100000)
 		adiv = AUDIO_DIV_SERCLK_16;
 	else
 		adiv = AUDIO_DIV_SERCLK_8;
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
