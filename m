From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:40:29 +0200
Subject: [PATCH 5/10] drm/i2c: tda998x: add DT support
Message-ID: <20131023094029.77e4dd3a@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT support to the tda998x.

It also reorders the initialization sequence so that all resources are
correctly freed in case of error.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 105 ++++++++++++++++-----
 1 file changed, 83 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index d26d521..167df67 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -28,9 +28,12 @@
 
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 
+#define AUDIO_SAMPLE 48		/* 48 kHz */
+
 struct tda998x_priv {
 	struct i2c_client *cec;
 	struct i2c_client *hdmi;
+	struct drm_encoder *encoder;
 	uint16_t rev;
 	uint8_t current_page;
 	int dpms;
@@ -39,6 +42,10 @@ struct tda998x_priv {
 	u8 vip_cntrl_1;
 	u8 vip_cntrl_2;
 	struct tda998x_encoder_params params;
+	u32 audio_ports;
+	u8 audio;			/* no audio when 0 */
+#define AUDIO_I2S 1
+#define AUDIO_SPDIF 2
 };
 
 #define to_tda998x_priv(x)  ((struct tda998x_priv *)to_encoder_slave(x)->slave_priv)
@@ -121,6 +128,8 @@ struct tda998x_priv {
 # define VIP_CNTRL_5_CKCASE       (1 << 0)
 # define VIP_CNTRL_5_SP_CNT(x)    (((x) & 3) << 1)
 #define REG_MUX_AP                REG(0x00, 0x26)     /* read/write */
+# define MUX_AP_SELECT_I2S	  0x64
+# define MUX_AP_SELECT_SPDIF	  0x40
 #define REG_MUX_VP_VIP_OUT        REG(0x00, 0x27)     /* read/write */
 #define REG_MAT_CONTRL            REG(0x00, 0x80)     /* write */
 # define MAT_CONTRL_MAT_SC(x)     (((x) & 3) << 0)
@@ -547,10 +556,14 @@ tda998x_write_aif(struct tda998x_priv *priv, struct tda998x_encoder_params *p)
 	buf[HB(0)] = HDMI_INFOFRAME_TYPE_AUDIO;
 	buf[HB(1)] = 0x01;
 	buf[HB(2)] = HDMI_AUDIO_INFOFRAME_SIZE;
-	buf[PB(1)] = p->audio_frame[1] & 0x07; /* CC */
-	buf[PB(2)] = p->audio_frame[2] & 0x1c; /* SF */
-	buf[PB(4)] = p->audio_frame[4];
-	buf[PB(5)] = p->audio_frame[5] & 0xf8; /* DM_INH + LSV */
+	if (p) {
+		buf[PB(1)] = p->audio_frame[1] & 0x07; /* CC */
+		buf[PB(2)] = p->audio_frame[2] & 0x1c; /* SF */
+		buf[PB(4)] = p->audio_frame[4];
+		buf[PB(5)] = p->audio_frame[5] & 0xf8; /* DM_INH + LSV */
+	} else {
+		buf[PB(1)] = 1;	/* (coding type << 4) + (channel count - 1) */
+	}
 
 	tda998x_write_if(priv, DIP_IF_FLAGS_IF4, REG_IF4_HB0, buf,
 			 sizeof(buf));
@@ -587,38 +600,32 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
 {
 	uint8_t buf[6], clksel_aip, clksel_fs, ca_i2s, cts_n, adiv;
-	uint32_t n;
+	int aclk, n;
 
 	/* Enable audio ports */
-	reg_write(priv, REG_ENA_AP, p->audio_cfg);
-	reg_write(priv, REG_ENA_ACLK, p->audio_clk_cfg);
+	reg_write(priv, REG_ENA_AP, priv->audio_ports);
 
 	/* Set audio input source */
-	switch (p->audio_format) {
-	case AFMT_SPDIF:
-		reg_write(priv, REG_MUX_AP, 0x40);
+	if (priv->audio == AUDIO_SPDIF) {
+		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
 		clksel_aip = AIP_CLKSEL_AIP(0);
 		/* FS64SPDIF */
 		clksel_fs = AIP_CLKSEL_FS(2);
+		aclk = 0x00;				/* no clock */
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		ca_i2s = 0;
-		break;
-
-	case AFMT_I2S:
-		reg_write(priv, REG_MUX_AP, 0x64);
+	} else {
+		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
 		clksel_aip = AIP_CLKSEL_AIP(1);
 		/* ACLK */
 		clksel_fs = AIP_CLKSEL_FS(0);
+		aclk = 0x01;				/* clock enable */
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		ca_i2s = CA_I2S_CA_I2S(0);
-		break;
-
-	default:
-		BUG();
-		return;
 	}
 
 	reg_write(priv, REG_AIP_CLKSEL, clksel_aip);
+	reg_write(priv, REG_ENA_ACLK, aclk);
 	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT);
 
 	/* Enable automatic CTS generation */
@@ -642,7 +649,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	 * This is the approximate value of N, which happens to be
 	 * the recommended values for non-coherent clocks.
 	 */
-	n = 128 * p->audio_sample_rate / 1000;
+	n = 128 * AUDIO_SAMPLE;		/* acr_n = 128 * sample_rate / 1000 */
 
 	/* Write the CTS and N values */
 	buf[0] = 0x44;
@@ -677,6 +684,7 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 
 /* DRM encoder functions */
 
+/* this function is not called when no info->platform (DT support) */
 static void
 tda998x_encoder_set_config(struct drm_encoder *encoder, void *params)
 {
@@ -697,6 +705,17 @@ tda998x_encoder_set_config(struct drm_encoder *encoder, void *params)
 			    (p->mirr_f ? VIP_CNTRL_2_MIRR_F : 0);
 
 	priv->params = *p;
+	if (p->audio_cfg) {
+		priv->audio_ports = p->audio_cfg;
+		switch (p->audio_format) {
+		case AFMT_I2S:
+			priv->audio = AUDIO_I2S;
+			break;
+		case AFMT_SPDIF:
+			priv->audio = AUDIO_SPDIF;
+			break;
+		}
+	}
 }
 
 static void
@@ -943,7 +962,7 @@ tda998x_encoder_mode_set(struct drm_encoder *encoder,
 
 		tda998x_write_avi(priv, mode);
 
-		if (priv->params.audio_cfg)
+		if (priv->audio)
 			tda998x_configure_audio(priv, mode, &priv->params);
 	}
 }
@@ -1110,6 +1129,8 @@ tda998x_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct tda998x_priv *priv = to_tda998x_priv(encoder);
 	drm_i2c_encoder_destroy(encoder);
+	if (priv->cec)
+		i2c_unregister_device(priv->cec);
 	kfree(priv);
 }
 
@@ -1148,24 +1169,35 @@ tda998x_encoder_init(struct i2c_client *client,
 		    struct drm_encoder_slave *encoder_slave)
 {
 	struct tda998x_priv *priv;
+	struct device_node *np = client->dev.of_node;
+	u32 video;
+	const char *audio;
 	int ret;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	i2c_set_clientdata(client, priv);
+
 	priv->vip_cntrl_0 = VIP_CNTRL_0_SWAP_A(2) | VIP_CNTRL_0_SWAP_B(3);
 	priv->vip_cntrl_1 = VIP_CNTRL_1_SWAP_C(0) | VIP_CNTRL_1_SWAP_D(1);
 	priv->vip_cntrl_2 = VIP_CNTRL_2_SWAP_E(4) | VIP_CNTRL_2_SWAP_F(5);
 
 	priv->current_page = 0xff;
 	priv->hdmi = client;
-	priv->cec = i2c_new_dummy(client->adapter, 0x34);
+	priv->encoder = &encoder_slave->base;
 	priv->dpms = DRM_MODE_DPMS_OFF;
 
 	encoder_slave->slave_priv = priv;
 	encoder_slave->slave_funcs = &tda998x_encoder_funcs;
 
+	priv->cec = i2c_new_dummy(client->adapter, 0x34);
+	if (!priv->cec) {
+		dev_err(&client->dev, "unable to probe cec slave\n");
+		return -ENODEV;
+	}
+
 	/* wake up the device: */
 	cec_write(priv, REG_CEC_ENAMODS,
 			CEC_ENAMODS_EN_RXSENS | CEC_ENAMODS_EN_HDMI);
@@ -1214,6 +1246,35 @@ tda998x_encoder_init(struct i2c_client *client,
 	cec_write(priv, REG_CEC_FRO_IM_CLK_CTRL, CEC_FRO_IM_CLK_CTRL_GHOST_DIS |
 						 CEC_FRO_IM_CLK_CTRL_IMCLK_SEL);
 
+	if (!np)
+		return 0;		/* non-DT */
+
+	/* get the optional video properties */
+	ret = of_property_read_u32(np, "video-ports", &video);
+	if (ret == 0) {
+		priv->vip_cntrl_0 = video >> 16;
+		priv->vip_cntrl_1 = video >> 8;
+		priv->vip_cntrl_2 = video;
+	}
+
+	/* get the optional audio properties */
+	ret = of_property_read_string(np, "audio-input", &audio);
+	if (ret == 0) {
+		if (strcmp(audio, "i2s") == 0)
+			priv->audio = AUDIO_I2S;
+		else if (strcmp(audio, "spdif") == 0)
+			priv->audio = AUDIO_SPDIF;
+		else
+			dev_err(&client->dev, "bad audio-input\n");
+
+		ret = of_property_read_u32(np, "audio-ports",
+					&priv->audio_ports);
+		if (ret) {
+			dev_err(&client->dev, "bad/lacking audio-ports\n");
+			priv->audio = 0;
+		}
+	}
+
 	return 0;
 
 fail:

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
