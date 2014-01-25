From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:36 +0100
Subject: [PATCH v5 17/23] drm/i2c: tda998x: set the PLL division factor in
 range 0..3
In-Reply-To: <cover.1390986082.git.moinejf@free.fr>
References: <cover.1390986082.git.moinejf@free.fr>
Message-ID: <d4ba259762605793aee726b5e33dcad6a8bd4777.1390986083.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The predivider division factor of the register PLL_SERIAL_2 is in the
range 0..3, the value 0 being used for a division by 1.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 36e95b2..873e1e9 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -214,7 +214,7 @@ struct tda998x_priv {
 # define PLL_SERIAL_1_SRL_IZ(x)   (((x) & 3) << 1)
 # define PLL_SERIAL_1_SRL_MAN_IZ  (1 << 6)
 #define REG_PLL_SERIAL_2          REG(0x02, 0x01)     /* read/write */
-# define PLL_SERIAL_2_SRL_NOSC(x) (((x) & 3) << 0)
+# define PLL_SERIAL_2_SRL_NOSC(x) ((x) << 0)
 # define PLL_SERIAL_2_SRL_PR(x)   (((x) & 0xf) << 4)
 #define REG_PLL_SERIAL_3          REG(0x02, 0x02)     /* read/write */
 # define PLL_SERIAL_3_SRL_CCIR    (1 << 0)
@@ -886,6 +886,11 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
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
1.9.rc1
