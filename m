From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 25 Jan 2014 18:14:38 +0100
Subject: [PATCH v5 13/23] drm/i2c: tda998x: always enable EDID read IRQ
In-Reply-To: <cover.1390986082.git.moinejf@free.fr>
References: <cover.1390986082.git.moinejf@free.fr>
Message-ID: <18175607f28a923a0f2f01633a1202bc5805d7a0.1390986083.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to enable/disable EDID read IRQ at each EDID block
read. This patch enables the IRQ at init time.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d4074e0..5b0b6ca 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -977,9 +977,6 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 	uint8_t offset, segptr;
 	int ret, i;
 
-	/* enable EDID read irq: */
-	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
-
 	offset = (blk & 1) ? 128 : 0;
 	segptr = blk / 2;
 
@@ -1014,8 +1011,6 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 		return ret;
 	}
 
-	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
-
 	return 0;
 }
 
@@ -1234,6 +1229,9 @@ tda998x_encoder_init(struct i2c_client *client,
 	cec_write(priv, REG_CEC_FRO_IM_CLK_CTRL,
 			CEC_FRO_IM_CLK_CTRL_GHOST_DIS | CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
 
+	/* enable EDID read irq: */
+	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
+
 	if (!np)
 		return 0;		/* non-DT */
 
-- 
1.9.rc1
