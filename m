From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:36 +0100
Subject: [PATCH v4 24/24] drm/i2c: tda998x: adjust the audio clock divider
 for S/PDIF
In-Reply-To: <cover.1390646891.git.moinejf@free.fr>
References: <cover.1390646891.git.moinejf@free.fr>
Message-ID: <20140125181436.5c443251@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to some tests on the Cubox (Marvell Armada 510 + TDA19988),
the S/PDIF input asks for a greater audio clock divider.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b4827c0..e4dfcb4 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -679,10 +679,14 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * There is no detailed info in the datasheet, so we just
 	 * assume 100MHz requires larger divider.
 	 */
+	adiv = AUDIO_DIV_SERCLK_8;
 	if (mode->clock > 100000)
-		adiv = AUDIO_DIV_SERCLK_16;
-	else
-		adiv = AUDIO_DIV_SERCLK_8;
+		adiv++;			/* AUDIO_DIV_SERCLK_8 */
+
+	/* S/PDIF asks for a larger divider */
+	if (p->audio_format == AFMT_SPDIF)
+		adiv++;			/* AUDIO_DIV_SERCLK_16 or _32 */
+
 	reg_write(priv, REG_AUDIO_DIV, adiv);
 
 	/*
-- 
1.8.5.3
