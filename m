From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 23 Oct 2013 09:42:04 +0200
Subject: [PATCH 10/10] drm/i2c: tda998x: fix some audio errors
Message-ID: <20131023094204.3c92868b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some audio errors:
- use constants
- set audio FIFO read latency to 'current'
- set a large audio divider which works with all input sample rates
- compute a CTS from the video clock
- use any frequency in the channel status

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 57 ++++++++++------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b0eecee..1887108 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -216,7 +216,12 @@ struct tda998x_priv {
 # define AIP_CLKSEL_FS(x)         (((x) & 3) << 0)
 # define AIP_CLKSEL_CLK_POL(x)    (((x) & 1) << 2)
 # define AIP_CLKSEL_AIP(x)        (((x) & 7) << 3)
-
+#define  SEL_AIP_SPDIF		  0
+#define  SEL_AIP_I2S		  1
+#define  CLKPOLDSD_ACLK		  0			/* same pol as ACLK */
+#define  CLKPOLDSD_NACLK	  1			/* inverted */
+#define  CTSREF_ACLK		  0			/* I2S */
+#define  CTSREF_FS64SPDIF	  2			/* spdif */
 
 /* Page 02h: PLL settings */
 #define REG_PLL_SERIAL_1          REG(0x02, 0x00)     /* read/write */
@@ -281,6 +286,7 @@ struct tda998x_priv {
 # define CA_I2S_CA_I2S(x)         (((x) & 31) << 0)
 # define CA_I2S_HBR_CHSTAT        (1 << 6)
 #define REG_LATENCY_RD            REG(0x11, 0x04)     /* read/write */
+# define LATENCY_CURRENT	  0x80
 #define REG_ACR_CTS_0             REG(0x11, 0x05)     /* read/write */
 #define REG_ACR_CTS_1             REG(0x11, 0x06)     /* read/write */
 #define REG_ACR_CTS_2             REG(0x11, 0x07)     /* read/write */
@@ -717,8 +723,8 @@ static void
 tda998x_configure_audio(struct tda998x_priv *priv,
 		struct drm_display_mode *mode, struct tda998x_encoder_params *p)
 {
-	uint8_t buf[6], clksel_aip, clksel_fs, ca_i2s, cts_n, adiv;
-	int aclk, n;
+	uint8_t buf[6], clksel_aip, clksel_fs, cts_n;
+	int aclk, n, cts;
 
 	/* Enable audio ports */
 	reg_write(priv, REG_ENA_AP, priv->audio_ports);
@@ -726,42 +732,29 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	/* Set audio input source */
 	if (priv->audio == AUDIO_SPDIF) {
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
-		clksel_aip = AIP_CLKSEL_AIP(0);
-		/* FS64SPDIF */
-		clksel_fs = AIP_CLKSEL_FS(2);
+		clksel_aip = AIP_CLKSEL_AIP(SEL_AIP_SPDIF);
+		clksel_fs = AIP_CLKSEL_FS(CTSREF_FS64SPDIF);
 		aclk = 0x00;				/* no clock */
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
-		ca_i2s = 0;
 	} else {
 		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
-		clksel_aip = AIP_CLKSEL_AIP(1);
-		/* ACLK */
-		clksel_fs = AIP_CLKSEL_FS(0);
+		clksel_aip = AIP_CLKSEL_AIP(SEL_AIP_I2S);
+		clksel_fs = AIP_CLKSEL_FS(CTSREF_ACLK);
 		aclk = 0x01;				/* clock enable */
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
-		ca_i2s = CA_I2S_CA_I2S(0);
 	}
 
 	reg_write(priv, REG_AIP_CLKSEL, clksel_aip);
+	reg_write(priv, REG_LATENCY_RD, LATENCY_CURRENT);
 	reg_write(priv, REG_ENA_ACLK, aclk);
-	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT);
+	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_LAYOUT |
 
 	/* Enable automatic CTS generation */
-	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_ACR_MAN);
+					AIP_CNTRL_0_ACR_MAN);
 	reg_write(priv, REG_CTS_N, cts_n);
 
-	/*
-	 * Audio input somehow depends on HDMI line rate which is
-	 * related to pixclk. Testing showed that modes with pixclk
-	 * >100MHz need a larger divider while <40MHz need the default.
-	 * There is no detailed info in the datasheet, so we just
-	 * assume 100MHz requires larger divider.
-	 */
-	if (mode->clock > 100000)
-		adiv = AUDIO_DIV_SERCLK_16;
-	else
-		adiv = AUDIO_DIV_SERCLK_8;
-	reg_write(priv, REG_AUDIO_DIV, adiv);
+	/* a large divider works for all input sample rates */
+	reg_write(priv, REG_AUDIO_DIV, AUDIO_DIV_SERCLK_32);
 
 	/*
 	 * This is the approximate value of N, which happens to be
@@ -770,9 +763,10 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	n = 128 * AUDIO_SAMPLE;		/* acr_n = 128 * sample_rate / 1000 */
 
 	/* Write the CTS and N values */
-	buf[0] = 0x44;
-	buf[1] = 0x42;
-	buf[2] = 0x01;
+	cts = mode->clock;
+	buf[0] = cts;
+	buf[1] = cts >> 8;
+	buf[2] = cts >> 16;
 	buf[3] = n;
 	buf[4] = n >> 8;
 	buf[5] = n >> 16;
@@ -786,10 +780,11 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	reg_clear(priv, REG_AIP_CNTRL_0, AIP_CNTRL_0_RST_CTS);
 
 	/* Write the channel status */
-	buf[0] = 0x04;
+	buf[0] = (1 << 2);			/* copyright unprotected */
 	buf[1] = 0x00;
-	buf[2] = 0x00;
-	buf[3] = 0xf1;
+	buf[2] = 1;				/* freq not indicated */
+	buf[3] = (0 << 4) |			/* orig freq = not indicated */
+			1;			/* max word length 24 bits */
 	reg_write_range(priv, REG_CH_STAT_B(0), buf, 4);
 
 	tda998x_audio_mute(priv, true);


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
