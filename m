From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:48 +0100
Subject: [PATCH v3 24/24] drm/i2c: tda998x: adjust the audio clock divider
 for S/PDIF
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195848.0bede2c3@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S/PDIF input asks for a greater audio clock divider.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 0716a75..06c484d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -707,6 +707,10 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_write(priv, REG_CTS_N, cts_n);
 	reg_write(priv, REG_ENA_ACLK, aclk);
 
+	/* S/PDIF asks for a large divider */
+	if (priv->audio_format == AFMT_SPDIF)
+		adiv = AUDIO_DIV_SERCLK_32;
+
 	/*
 	 * Audio input somehow depends on HDMI line rate which is
 	 * related to pixclk. Testing showed that modes with pixclk
@@ -714,7 +718,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * There is no detailed info in the datasheet, so we just
 	 * assume 100MHz requires larger divider.
 	 */
-	if (mode->clock > 100000)
+	else if (mode->clock > 100000)
 		adiv = AUDIO_DIV_SERCLK_16;
 	else
 		adiv = AUDIO_DIV_SERCLK_8;
-- 
1.8.5.3
