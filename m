From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 9 Jan 2014 12:06:18 +0100
Subject: [PATCH v2 21/28] drm/i2c: tda998x: use global constants
Message-ID: <20140109120618.4955853c@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/gpu/drm/i2c/tda998x_drv.c   | 23 +++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 864b9f5..efd29d1 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -132,6 +132,8 @@ struct tda998x_priv {
 # define VIP_CNTRL_5_CKCASE       (1 << 0)
 # define VIP_CNTRL_5_SP_CNT(x)    (((x) & 3) << 1)
 #define REG_MUX_AP                REG(0x00, 0x26)     /* read/write */
+# define MUX_AP_SELECT_I2S	  0x64
+# define MUX_AP_SELECT_SPDIF	  0x40
 #define REG_MUX_VP_VIP_OUT        REG(0x00, 0x27)     /* read/write */
 #define REG_MAT_CONTRL            REG(0x00, 0x80)     /* write */
 # define MAT_CONTRL_MAT_SC(x)     (((x) & 3) << 0)
@@ -212,7 +214,12 @@ struct tda998x_priv {
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
@@ -721,19 +728,17 @@ tda998x_configure_audio(struct tda998x_priv *priv,
 	/* Set audio input source */
 	switch (priv->audio_type) {
 	case AFMT_SPDIF:
-		reg_write(priv, REG_MUX_AP, 0x40);
-		clksel_aip = AIP_CLKSEL_AIP(0);
-		/* FS64SPDIF */
-		clksel_fs = AIP_CLKSEL_FS(2);
+		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_SPDIF);
+		clksel_aip = AIP_CLKSEL_AIP(SEL_AIP_SPDIF);
+		clksel_fs = AIP_CLKSEL_FS(CTSREF_FS64SPDIF);
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		ca_i2s = 0;
 		break;
 
 	case AFMT_I2S:
-		reg_write(priv, REG_MUX_AP, 0x64);
-		clksel_aip = AIP_CLKSEL_AIP(1);
-		/* ACLK */
-		clksel_fs = AIP_CLKSEL_FS(0);
+		reg_write(priv, REG_MUX_AP, MUX_AP_SELECT_I2S);
+		clksel_aip = AIP_CLKSEL_AIP(SEL_AIP_I2S);
+		clksel_fs = AIP_CLKSEL_FS(CTSREF_ACLK);
 		cts_n = CTS_N_M(3) | CTS_N_K(3);
 		ca_i2s = CA_I2S_CA_I2S(0);
 		break;
-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
