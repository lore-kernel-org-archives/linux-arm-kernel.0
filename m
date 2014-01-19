From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 Jan 2014 19:58:41 +0100
Subject: [PATCH v3 11/24] drm/i2c: tda998x: free the CEC device on
 encoder_destroy
In-Reply-To: <cover.1390153344.git.moinejf@free.fr>
References: <cover.1390153344.git.moinejf@free.fr>
Message-ID: <20140119195841.3c02770d@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cec i2c device is created in tda998x_encoder_init() when the DRM
driver starts.
This patch frees it when the DRM driver is unloaded.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b6fdeb7..1adc794 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1124,6 +1124,8 @@ tda998x_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	drm_i2c_encoder_destroy(encoder);
+	if (priv->cec)
+		i2c_unregister_device(priv->cec);
 	kfree(priv);
 }
 
-- 
1.8.5.3
