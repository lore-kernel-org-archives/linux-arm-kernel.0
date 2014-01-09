From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:04:28 +0100
Subject: [PATCH v2 14/28] drm/i2c: tda998x: get a better status of the
 connexion
Message-ID: <20140109120428.1ea7ec3a@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch refines the connexion status testing both bits RXSENS and
HPD of the CEC register giving the connexion level.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 2187d63..0cae820 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1009,7 +1009,9 @@ tda998x_encoder_detect(struct drm_encoder *encoder,
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	uint8_t val = cec_read(priv, REG_CEC_RXSHPDLEV);
 
-	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
+	return (val & (CEC_RXSHPDLEV_RXSENS | CEC_RXSHPDLEV_HPD)) ==
+				(CEC_RXSHPDLEV_RXSENS | CEC_RXSHPDLEV_HPD) ?
+			connector_status_connected :
 			connector_status_disconnected;
 }
 
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
