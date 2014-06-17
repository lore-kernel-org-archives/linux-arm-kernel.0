From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:03 -0300
Subject: [PATCH/RESEND 1/9] drm/i2c: tda998x: move drm_i2c_encoder_destroy call
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-2-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently tda998x_encoder_destroy() calls cec_write() and reg_clear(),
as part of the release procedure. Such calls need to access the I2C bus
and therefore, we need to call them before drm_i2c_encoder_destroy()
which unregisters the I2C device.

This commit moves the latter so it's done afterwards.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
Signed-off-by: Ezequiel Garc?a <ezequiel@vanguardiasur.com.ar>
Cc: <stable@vger.kernel.org> #v3.9+
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 240c331..db9515f 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1183,7 +1183,6 @@ static void
 tda998x_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-	drm_i2c_encoder_destroy(encoder);
 
 	/* disable all IRQs and free the IRQ handler */
 	cec_write(priv, REG_CEC_RXSHPDINTENA, 0);
@@ -1193,6 +1192,7 @@ tda998x_encoder_destroy(struct drm_encoder *encoder)
 
 	if (priv->cec)
 		i2c_unregister_device(priv->cec);
+	drm_i2c_encoder_destroy(encoder);
 	kfree(priv);
 }
 
-- 
2.0.0
