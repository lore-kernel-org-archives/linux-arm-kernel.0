From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:41:05 +0200
Subject: [PATCH 6/10] drm/i2c: tda998x: use irq for connexion status and
 EDID read
Message-ID: <20131023094105.19d8e8d2@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the treatment of the tda998x IRQ.

The interrupt function is used to know the display plug/unplug status
without polling and to read the EDID.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 112 +++++++++++++++++++--
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 8765bae..4fbc1f8 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -18,6 +18,7 @@
 
 
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/hdmi.h>
 
 #include <drm/drmP.h>
@@ -42,6 +43,11 @@ struct tda998x_priv {
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
 	struct tda998x_encoder_params params;
+
+	int int_irq;
+	wait_queue_head_t wq_edid;
+	volatile int wq_edid_wait;
+
 	u32 audio_ports;
 	u8 audio;			/* no audio when 0 */
 #define AUDIO_I2S 1
@@ -314,11 +320,16 @@ struct tda998x_priv {
 
 /* CEC registers: (not paged)
  */
+#define REG_CEC_INTSTATUS         0xee                /* read */
+# define CEC_INTSTATUS_CEC        (1 << 0)
+# define CEC_INTSTATUS_HDMI       (1 << 1)
 #define REG_CEC_FRO_IM_CLK_CTRL   0xfb                /* read/write */
 # define CEC_FRO_IM_CLK_CTRL_GHOST_DIS (1 << 7)
 # define CEC_FRO_IM_CLK_CTRL_ENA_OTP   (1 << 6)
 # define CEC_FRO_IM_CLK_CTRL_IMCLK_SEL (1 << 1)
 # define CEC_FRO_IM_CLK_CTRL_FRO_DIV   (1 << 0)
+#define REG_CEC_RXSHPDINTENA      0xfc                /* read/write */
+#define REG_CEC_RXSHPDINT         0xfd                /* read */
 #define REG_CEC_RXSHPDLEV         0xfe                /* read */
 # define CEC_RXSHPDLEV_RXSENS     (1 << 0)
 # define CEC_RXSHPDLEV_HPD        (1 << 1)
@@ -524,6 +535,34 @@ tda998x_reset(struct tda998x_priv *priv)
 	reg_write(priv, REG_MUX_VP_VIP_OUT, 0x24);
 }
 
+/*
+ * only 2 interrupts may occur: screen plug/unplug and EDID read
+ */
+static irqreturn_t tda998x_irq_thread(int irq, void *data)
+{
+	struct tda998x_priv *priv = data;
+	u8 sta, cec, lvl, flag0, flag1, flag2;
+
+	if (!priv)
+		return IRQ_HANDLED;
+	sta = cec_read(priv, REG_CEC_INTSTATUS);
+	cec = cec_read(priv, REG_CEC_RXSHPDINT);
+	lvl = cec_read(priv, REG_CEC_RXSHPDLEV);
+	flag0 = reg_read(priv, REG_INT_FLAGS_0);
+	flag1 = reg_read(priv, REG_INT_FLAGS_1);
+	flag2 = reg_read(priv, REG_INT_FLAGS_2);
+	DRM_DEBUG("tda irq sta %02x cec %02x lvl %02x f0 %02x f1 %02x f2 %02x\n",
+			sta, cec, lvl, flag0, flag1, flag2);
+	if ((flag2 & INT_FLAGS_2_EDID_BLK_RD) && priv->wq_edid_wait) {
+		priv->wq_edid_wait = 0;
+		wake_up(&priv->wq_edid);
+	} else if (cec != 0) {			/* level change */
+		if (priv->encoder && priv->encoder->dev)
+			drm_helper_hpd_irq_event(priv->encoder->dev);
+	}
+	return IRQ_HANDLED;
+}
+
 static uint8_t tda998x_cksum(uint8_t *buf, size_t bytes)
 {
 	uint8_t sum = 0;
@@ -985,7 +1024,8 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 	int ret, i;
 
 	/* enable EDID read irq: */
-	reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
+	if (blk == 0)
+		reg_set(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
 
 	offset = (blk & 1) ? 128 : 0;
 	segptr = blk / 2;
@@ -1002,15 +1042,30 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 	reg_write(priv, REG_EDID_CTRL, 0x0);
 
 	/* wait for block read to complete: */
-	for (i = 100; i > 0; i--) {
-		uint8_t val = reg_read(priv, REG_INT_FLAGS_2);
-		if (val & INT_FLAGS_2_EDID_BLK_RD)
-			break;
-		msleep(1);
+	if (priv->int_irq != NO_IRQ) {
+		priv->wq_edid_wait = 1;
+		i = wait_event_timeout(priv->wq_edid,
+					!priv->wq_edid_wait,
+					msecs_to_jiffies(100));
+		if (i < 0) {
+			dev_err(encoder->dev->dev, "read edid wait err %d\n", i);
+			return i;
+		}
+	} else {
+		for (i = 10; i > 0; i--) {
+			msleep(10);
+			ret = reg_read(priv, REG_INT_FLAGS_2);
+			if (ret < 0)
+				return ret;
+			if (ret & INT_FLAGS_2_EDID_BLK_RD)
+				break;
+		}
 	}
 
-	if (i == 0)
+	if (i == 0) {
+		dev_err(encoder->dev->dev, "read edid timeout\n");
 		return -ETIMEDOUT;
+	}
 
 	ret = reg_read_range(priv, REG_EDID_DATA_0, buf, EDID_LENGTH);
 	if (ret != EDID_LENGTH) {
@@ -1019,8 +1074,6 @@ read_edid_block(struct drm_encoder *encoder, uint8_t *buf, int blk)
 		return ret;
 	}
 
-	reg_clear(priv, REG_INT_FLAGS_2, INT_FLAGS_2_EDID_BLK_RD);
-
 	return 0;
 }
 
@@ -1110,7 +1163,14 @@ static int
 tda998x_encoder_create_resources(struct drm_encoder *encoder,
 				struct drm_connector *connector)
 {
+	struct tda998x_priv *priv = to_tda998x_priv(encoder);
+
 	DBG("");
+	if (priv->int_irq != NO_IRQ)
+		connector->polled = DRM_CONNECTOR_POLL_HPD;
+	else
+		connector->polled = DRM_CONNECTOR_POLL_CONNECT |
+			DRM_CONNECTOR_POLL_DISCONNECT;
 	return 0;
 }
 
@@ -1129,6 +1189,8 @@ tda998x_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	drm_i2c_encoder_destroy(encoder);
+	if (priv->int_irq != NO_IRQ)
+		free_irq(priv->int_irq, priv);
 	if (priv->cec)
 		i2c_unregister_device(priv->cec);
 	kfree(priv);
@@ -1275,6 +1337,38 @@ tda998x_encoder_init(struct i2c_client *client,
 		}
 	}
 
+	/* install the optional HDMI connect IRQ */
+	priv->int_irq = irq_of_parse_and_map(np, 0);
+	if (priv->int_irq < 0)
+		priv->int_irq = NO_IRQ;
+	if (priv->int_irq != NO_IRQ) {
+
+		/* init read EDID waitqueue */
+		init_waitqueue_head(&priv->wq_edid);
+/*		priv->wq_edid_wait = 0;	*/
+
+		/* clear pending interrupts */
+		reg_read(priv, REG_INT_FLAGS_0);
+		reg_read(priv, REG_INT_FLAGS_1);
+		reg_read(priv, REG_INT_FLAGS_2);
+
+		ret = request_threaded_irq(priv->int_irq, NULL,
+					   tda998x_irq_thread,
+					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					   "tda998x-int", priv);
+		if (ret) {
+			dev_err(&client->dev, "failed to request IRQ#%u: %d\n",
+				priv->int_irq, ret);
+			goto fail;
+		}
+
+		/* enable HPD irq */
+		cec_write(priv, REG_CEC_RXSHPDINTENA,
+				CEC_RXSHPDLEV_HPD | CEC_RXSHPDLEV_RXSENS);
+
+		/* treat the first irq if any */
+		msleep(10);
+	}
 	return 0;
 
 fail:


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
