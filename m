From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:41:20 +0200
Subject: [PATCH 7/10] drm/i2c: tda998x: get a better status of the connexion
Message-ID: <20131023094120.29602529@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch refines the connexion status testing both bits RXSENS and
HPD of the CEC register giving the connexion level.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 4fbc1f8..dcf6102 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1012,7 +1012,10 @@ tda998x_encoder_detect(struct drm_encoder *encoder,
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	uint8_t val = cec_read(priv, REG_CEC_RXSHPDLEV);
-	return (val & CEC_RXSHPDLEV_HPD) ? connector_status_connected :
+
+	return (val & (CEC_RXSHPDLEV_RXSENS | CEC_RXSHPDLEV_HPD)) ==
+				(CEC_RXSHPDLEV_RXSENS | CEC_RXSHPDLEV_HPD) ?
+			connector_status_connected :
 			connector_status_disconnected;
 }
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
