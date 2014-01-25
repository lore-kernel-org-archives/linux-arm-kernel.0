From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:42 +0100
Subject: [PATCH v5 10/23] drm/i2c: tda998x: free the CEC device on
 encoder_destroy
In-Reply-To: <cover.1390986082.git.moinejf@free.fr>
References: <cover.1390986082.git.moinejf@free.fr>
Message-ID: <90b017f1731d86562af90fd3416197261d193cd1.1390986083.git.moinejf@free.fr>
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
index d6d0e80..7d8bc22 100644
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
1.9.rc1
