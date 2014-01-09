From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:05:13 +0100
Subject: [PATCH v2 17/28] drm/i2c: tda998x: set the repeat PLL value in
 range 0..3
Message-ID: <20140109120513.0965ddad@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index f60aef9..8a7d8a2 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -220,7 +220,7 @@ struct tda998x_priv {
 # define PLL_SERIAL_1_SRL_IZ(x)   (((x) & 3) << 1)
 # define PLL_SERIAL_1_SRL_MAN_IZ  (1 << 6)
 #define REG_PLL_SERIAL_2          REG(0x02, 0x01)     /* read/write */
-# define PLL_SERIAL_2_SRL_NOSC(x) (((x) & 3) << 0)
+# define PLL_SERIAL_2_SRL_NOSC(x) ((x) << 0)
 # define PLL_SERIAL_2_SRL_PR(x)   (((x) & 0xf) << 4)
 #define REG_PLL_SERIAL_3          REG(0x02, 0x02)     /* read/write */
 # define PLL_SERIAL_3_SRL_CCIR    (1 << 0)
@@ -972,6 +972,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 	}
 
 	div = 148500 / mode->clock;
+	if (div != 0) {
+		div--;
+		if (div > 3)
+			div = 3;
+	}
 
 	/* mute the audio FIFO: */
 	reg_set(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_FIFO);
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
