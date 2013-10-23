From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:39:59 +0200
Subject: [PATCH 2/10] drm/i2c: tda998x: fix some small errors
Message-ID: <20131023093959.17b3ddd0@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some small errors:
- code cleanup
- use msleep instead of mdelay
- use mode instead of adjusted_mode
- force page register initialization

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 41 +++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 99d483d..a896afa 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -334,7 +334,7 @@ cec_write(struct tda998x_priv *priv, uint16_t addr, uint8_t val)
 	uint8_t buf[] = {addr, val};
 	int ret;
 
-	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
+	ret = i2c_master_send(client, buf, sizeof buf);
 	if (ret < 0)
 		dev_err(&client->dev, "Error %d writing to cec:0x%x\n", ret, addr);
 }
@@ -371,7 +371,8 @@ set_page(struct tda998x_priv *priv, uint16_t reg)
 		};
 		int ret = i2c_master_send(client, buf, sizeof(buf));
 		if (ret < 0) {
-			dev_err(&client->dev, "Error %d writing to REG_CURPAGE\n", ret);
+			dev_err(&client->dev, "setpage %04x err %d\n",
+					reg, ret);
 			return ret;
 		}
 
@@ -448,7 +449,7 @@ reg_write(struct tda998x_priv *priv, uint16_t reg, uint8_t val)
 	if (ret < 0)
 		return;
 
-	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
+	ret = i2c_master_send(client, buf, sizeof buf);
 	if (ret < 0)
 		dev_err(&client->dev, "Error %d writing to 0x%x\n", ret, reg);
 }
@@ -464,7 +465,7 @@ reg_write16(struct tda998x_priv *priv, uint16_t reg, uint16_t val)
 	if (ret < 0)
 		return;
 
-	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
+	ret = i2c_master_send(client, buf, sizeof buf);
 	if (ret < 0)
 		dev_err(&client->dev, "Error %d writing to 0x%x\n", ret, reg);
 }
@@ -666,7 +667,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
 
 	tda998x_audio_mute(priv, true);
-	mdelay(20);
+	msleep(20);
 	tda998x_audio_mute(priv, false);
 
 	/* Write the audio information packet */
@@ -937,11 +938,10 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 		reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(1));
 		reg_set(priv, REG_TX33, TX33_HDMI);
 
-		tda998x_write_avi(priv, adjusted_mode);
+		tda998x_write_avi(priv, mode);
 
 		if (priv->params.audio_cfg)
-			tda998x_configure_audio(priv, adjusted_mode,
-						&priv->params);
+			tda998x_configure_audio(priv, mode, &priv->params);
 	}
 }
 
@@ -992,7 +992,7 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 
 	ret = reg_read_range(priv, REG_EDID_DATA_0, buf, EDID_LENGTH);
 	if (ret != EDID_LENGTH) {
-		dev_err(encoder->dev->dev, "failed to read edid block %d: %d",
+		dev_err(encoder->dev->dev, "failed to read edid block %d: %d\n",
 				blk, ret);
 		return ret;
 	}
@@ -1006,7 +1006,7 @@ static uint8_t *
 do_get_edid(struct drm_encoder *encoder)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
-	int j = 0, valid_extensions = 0;
+	int j, valid_extensions = 0;
 	uint8_t *block, *new;
 	bool print_bad_edid = drm_debug & DRM_UT_KMS;
 
@@ -1155,7 +1155,7 @@ tda998x_encoder_init(struct i2c_client *client,
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
-	priv->current_page = 0;
+	priv->current_page = 0xff;
 	priv->hdmi = client;
 	priv->cec = i2c_new_dummy(client->adapter, 0x34);
 	priv->dpms = DRM_MODE_DPMS_OFF;
@@ -1180,12 +1180,21 @@ tda998x_encoder_init(struct i2c_client *client,
 	priv->rev &= ~0x30; /* not-hdcp and not-scalar bit */
 
 	switch (priv->rev) {
-	case TDA9989N2:  dev_info(dev->dev, "found TDA9989 n2");  break;
-	case TDA19989:   dev_info(dev->dev, "found TDA19989");    break;
-	case TDA19989N2: dev_info(dev->dev, "found TDA19989 n2"); break;
-	case TDA19988:   dev_info(dev->dev, "found TDA19988");    break;
+	case TDA9989N2:
+		dev_info(&client->dev, "found TDA9989 n2");
+		break;
+	case TDA19989:
+		dev_info(&client->dev, "found TDA19989");
+		break;
+	case TDA19989N2:
+		dev_info(&client->dev, "found TDA19989 n2");
+		break;
+	case TDA19988:
+		dev_info(&client->dev, "found TDA19988");
+		break;
 	default:
-		DBG("found unsupported device: %04x", priv->rev);
+		dev_err(&client->dev, "found unsupported device: %04x\n",
+			priv->rev);
 		goto fail;
 	}
 

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
