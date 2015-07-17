From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 Jul 2015 13:07:35 +0200
Subject: [PATCH] drm/i2c: tda998x: Fix bad checksum of the HDMI AVI infoframe
Message-ID: <mailman.5.1437133216.1755.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 8c7a075da9f7980cc95ffcd7e6621d4a87f20f40
 "use drm_hdmi_avi_infoframe_from_display_mode()"
also uses hdmi_avi_infoframe_pack() to create the AVI infoframe.
This function sets the checksum of the frame and this breks
the second calculation of the checksum done in tda998x_write_if().

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index fe1599d..424228b 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -606,8 +606,6 @@ static void
 tda998x_write_if(struct tda998x_priv *priv, uint8_t bit, uint16_t addr,
 		 uint8_t *buf, size_t size)
 {
-	buf[PB(0)] = tda998x_cksum(buf, size);
-
 	reg_clear(priv, REG_DIP_IF_FLAGS, bit);
 	reg_write_range(priv, addr, buf, size);
 	reg_set(priv, REG_DIP_IF_FLAGS, bit);
@@ -627,6 +625,8 @@ tda998x_write_aif(struct tda998x_priv *priv, struct tda998x_encoder_params *p)
 	buf[PB(4)] = p->audio_frame[4];
 	buf[PB(5)] = p->audio_frame[5] & 0xf8; /* DM_INH + LSV */
 
+	buf[PB(0)] = tda998x_cksum(buf, sizeof(buf));
+
 	tda998x_write_if(priv, DIP_IF_FLAGS_IF4, REG_IF4_HB0, buf,
 			 sizeof(buf));
 }
-- 
2.1.4
