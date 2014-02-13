From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 13 Feb 2014 09:13:34 +0100
Subject: [PATCH] drm/i2c: tda998x: fix memory leak in case of i2c error
Message-ID: <20140213083316.38D7D822BD@smtp6-g21.free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the creation of the second i2c client was failing, the private
buffer was not freed.

This bug was introduced by the commit 6ae668cc19e8
'drm/i2c: tda998x: check the CEC device creation'

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index fa18cf3..faa77f5 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1151,8 +1151,10 @@ tda998x_encoder_init(struct i2c_client *client,
 
 	priv->current_page = 0xff;
 	priv->cec = i2c_new_dummy(client->adapter, 0x34);
-	if (!priv->cec)
+	if (!priv->cec) {
+		kfree(priv);
 		return -ENODEV;
+	}
 	priv->dpms = DRM_MODE_DPMS_OFF;
 
 	encoder_slave->slave_priv = priv;
-- 
1.9.0.rc3
